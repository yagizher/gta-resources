import SearchBar from '../UI/SearchBar/SearchBar';
import Grid from '@material-ui/core/Grid';
import DialogModal from '../UI/Modal/DialogModal';
import Screen from '../UI/Screen/Screen';
import React, { useEffect, useState } from 'react';
import { DialogActions, makeStyles, Typography } from '@material-ui/core';
import { connect, useSelector } from 'react-redux';
import VehicleCard from './Vehicle/VehicleCard';
import Fab from '@material-ui/core/Fab';
import AddIcon from '@material-ui/icons/Add';
import TitleBar from '../UI/TitleBar/TitleBar';
import Divider from '@material-ui/core/Divider';
import { setSearch, setSelectedVehicle, setVehicleImage } from './actions';
import ImageModal from '../UI/ImageModal/ImageModal';

const useStyles = makeStyles(theme => ({
  grid: {
    width: '90%',
    marginBottom: theme.spacing(2),
  },
  fab: {
    right: theme.spacing(1),
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
  const selectedVehicle = useSelector(state => state.veh.selected);
  const selectedVehicleImage = useSelector(state => state.veh.selectedImage);
  const [modalState, setModalState] = useState(false);
  const [photoModalState, setPhotoModalState] = useState(false);
  const [currentFilter, setFilter] = useState(null);
  const [filteredVehicles, setFilteredVehicles] = useState([]);

  const search = (search) => {
    props.dispatch(setSearch(search));
  };

  const setImage = (url) => {
    setVehicleImage(selectedVehicle.plate, url, currentSearch);
  };

  useEffect(() => {
    setFilteredVehicles(vehicles.filter((veh) => filterVehicle(veh, currentFilter)));
    if (selectedVehicle !== null) {
      props.dispatch(setSelectedVehicle(vehicles.find((veh) => veh.plate === selectedVehicle.plate)));
    }
  }, [vehicles]);


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
        {filteredVehicles.map(veh =>
          <Grid item xs={12} className={classes.gridItem}>
            <VehicleCard data={veh} setModalState={setModalState}
                         setSelectedVehicle={(veh) => props.dispatch(setSelectedVehicle(veh))}
                         setPhotoModalState={setPhotoModalState}/>
          </Grid>,
        )}
      </Grid>
      <DialogModal open={modalState} setModalState={setModalState}>
        <Grid spacing={0} justify={'center'} alignItems={'center'}>
          <Grid item xs={12}>
            <Typography variant={'h4'} className={classes.title}>Vehicle Data</Typography>
          </Grid>
          <Divider/>
          <VehicleCard data={selectedVehicle} setModalState={setModalState}
                       setSelectedVehicle={(veh) => props.dispatch(setSelectedVehicle(veh))}
                       setPhotoModalState={setPhotoModalState} hideFab/>
        </Grid>
        <DialogActions>
          <Fab aria-label="add">
            <AddIcon/>
          </Fab>
        </DialogActions>
      </DialogModal>
      <ImageModal open={photoModalState} setModalState={setPhotoModalState} title={'Vehicle Photo'}
                  selectedImage={selectedVehicleImage} setImage={setImage}/>
    </Screen>
  );
});
