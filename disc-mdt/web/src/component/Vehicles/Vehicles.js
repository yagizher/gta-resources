import SearchBar from '../UI/SearchBar/SearchBar';
import Grid from '@material-ui/core/Grid';
import EntityModal from '../UI/Modal/EntityModal';
import Screen from '../UI/Screen/Screen';
import React, { useEffect, useState } from 'react';
import { makeStyles, TextField, Typography } from '@material-ui/core';
import { connect, useSelector } from 'react-redux';
import VehicleCard from './Vehicle/VehicleCard';
import Fab from '@material-ui/core/Fab';
import AddIcon from '@material-ui/icons/Add';
import { green } from '@material-ui/core/colors';
import TitleBar from '../UI/TitleBar/TitleBar';
import Divider from '@material-ui/core/Divider';
import ImageCard from '../UI/ImageCard/ImageCard';
import PublishIcon from '@material-ui/icons/Publish';
import { setSearch, setVehicleImage } from './actions';

const useStyles = makeStyles(theme => ({
  grid: {
    width: '90%',
    marginBottom: theme.spacing(2),
  },
  fab: {
    position: 'absolute',
    bottom: theme.spacing(1),
    right: theme.spacing(1),
    color: green[500].contrastText,
    backgroundColor: green[500],
    '&:hover': {
      backgroundColor: green[300],
    },
  },
  fabPhoto: {
    position: 'absolute',
    bottom: theme.spacing(2),
    right: theme.spacing(2),
  },
  title: {
    textAlign: 'center',
    padding: theme.spacing(2),
  },
  gridItem: {
    width: '90%',
    marginBottom: theme.spacing(1),
  },
  root: {
    marginBottom: 50,
  },
  textField: {
    width: '100%',
  },
}));


export default connect()((props) => {
  const classes = useStyles();
  const vehicles = useSelector(state => state.veh.vehicles);
  const currentSearch = useSelector(state => state.veh.currentSearch);
  const [selectedVehicle, setSelectedVehicle] = useState(null);
  const [modalState, setModalState] = useState(false);
  const [photoModalState, setPhotoModalState] = useState(false);
  const [currentFilter, setFilter] = useState(null);
  const [filteredVehicles, setFilteredVehicles] = useState([]);
  const [url, setUrl] = useState('');

  const search = (search) => {
    props.dispatch(setSearch(search));
  };

  const setImage = () => {
    setVehicleImage(selectedVehicle.plate, url, currentSearch);
  };

  useEffect(() => {
    setFilteredVehicles(vehicles.filter((veh) => filterVehicle(veh, currentFilter)));
    if (selectedVehicle !== null) {
      setSelectedVehicle(vehicles.find((veh) => veh.plate === selectedVehicle.plate));
    }
  }, [vehicles]);

  useEffect(() => {
    if (selectedVehicle !== null && selectedVehicle.vehicle_image !== null) {
      setUrl(selectedVehicle.vehicle_image);
    } else setUrl('');
  }, [selectedVehicle]);

  const filter = (f) => {
    setFilter(f);
    setFilteredVehicles(vehicles.filter((veh) => filterVehicle(veh, f)));
  };

  const filterVehicle = (veh, filter) => {
    if (filter && filter !== '') {
      const f = filter.toLowerCase();
      const prim = veh.colorPrimary.toLowerCase().includes(f);
      const secondary = veh.colorSecondary.toLowerCase().includes(f);
      const ownerFirstName = veh.firstname.toLowerCase().includes(f);
      const ownerLastName = veh.lastname.toLowerCase().includes(f);
      const model = veh.model.toLowerCase().includes(f);
      return prim || secondary || ownerFirstName || ownerLastName || model;
    } else return true;
  };

  return (
    <Screen>
      <Grid container direction={'column'} alignItems={'center'} spacing={0} justify={'center'}
            className={classes.root}>
        <TitleBar title={'Vehicles'}/>
        <Grid spacing={3} className={classes.grid} container direction={'row'}>
          <Grid item xs={6}>
            <SearchBar search={search}/>
          </Grid>
          <Grid item xs={6}>
            <SearchBar search={filter} instant label={'Filter'}/>
          </Grid>
        </Grid>
        {filteredVehicles.map(civ =>
          <Grid item xs={12} className={classes.gridItem}>
            <VehicleCard data={civ} setModalState={setModalState} setSelectedVehicle={setSelectedVehicle}
                         setPhotoModalState={setPhotoModalState}/>
          </Grid>,
        )}
      </Grid>
      <EntityModal open={modalState} setModalState={setModalState}>
        <Grid spacing={0} justify={'center'} alignItems={'center'}>
          <Grid item xs={12}>
            <Typography variant={'h4'} className={classes.title}>Vehicle Data</Typography>
          </Grid>
          <Divider/>
          <VehicleCard data={selectedVehicle} hideFab={true}/>
        </Grid>
        <Fab aria-label="add" className={classes.fab}>
          <AddIcon/>
        </Fab>
      </EntityModal>
      <EntityModal open={photoModalState} setModalState={setPhotoModalState}>
        <Grid spacing={0} justify={'center'} alignItems={'center'}>
          <Grid item xs={12}>
            <Typography variant={'h4'} className={classes.title}>Vehicle Photo</Typography>
          </Grid>
          <Divider/>
          {selectedVehicle !== null && <ImageCard url={selectedVehicle.vehicle_image}/>}
          <Grid item xs={12}>
            <TextField variant={'outlined'} className={classes.textField} value={url}
                       onChange={(event) => setUrl(event.target.value)}/>
          </Grid>
          <Fab aria-label="add" className={classes.fabPhoto} onClick={setImage}>
            <PublishIcon/>
          </Fab>
        </Grid>
      </EntityModal>
    </Screen>
  );
});
