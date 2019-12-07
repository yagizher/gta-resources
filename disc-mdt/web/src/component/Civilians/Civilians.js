import React, { useState } from 'react';
import { makeStyles, Typography } from '@material-ui/core';
import Screen from '../UI/Screen/Screen';
import SearchBar from '../UI/SearchBar/SearchBar';
import Nui from '../../util/Nui';
import { useSelector } from 'react-redux';
import CivilianCard from './Civilian/CivilianCard';
import Grid from '@material-ui/core/Grid';
import EntityModal from '../UI/Modal/EntityModal';
import Paper from '@material-ui/core/Paper';
import Fab from '@material-ui/core/Fab';
import AddIcon from '@material-ui/icons/Add';
import { green, red } from '@material-ui/core/colors';
import TitleBar from '../UI/TitleBar/TitleBar';
import MenuItem from '@material-ui/core/MenuItem';
import Menu from '@material-ui/core/Menu';
import JailReport from '../JailReport/JailReport';

const useStyles = makeStyles(theme => ({
  grid: {
    width: '90%',
    marginBottom: theme.spacing(2),
  },
  gridItem: {
    width: "90%"
  },
  fab: {
    position: 'absolute',
    bottom: theme.spacing(2),
    right: theme.spacing(2),
    color: green[500].contrastText,
    backgroundColor: red[500],
    '&:hover': {
      backgroundColor: red[300],
    },
  },
  title: {
    textAlign: 'center',
    padding: theme.spacing(1),
  },
  root: {
    marginBottom: 50
  }

}));

const searchForCivilians = (search) => {
  Nui.send('SearchCivilians', {
    search: search,
  });
};

export default function Civilians(props) {
  const classes = useStyles();
  const civilians = useSelector(state => state.civ.civilians);
  const [selectedCivilian, setSelectedCivilian] = useState({});
  const [modalState, setModalState] = useState(false);
  const [anchorEl, setAnchorEl] = React.useState(null);
  const [jailOpen, setJailOpen] = React.useState(null);

  const handleMenuSelect = (event) => {
    setAnchorEl(null);
    switch (event.target.id) {
      case 'jail':
        setJailOpen(true);
        break;
      default:
    }
  };

  return (
    <Screen>
      <Grid container direction={'column'} alignItems={'center'} spacing={3} justify={'center'} className={classes.root}>
        <TitleBar title={'Civilians'}/>
        <Grid spacing={3} className={classes.grid} container direction={'row'}>
          <Grid item xs={12}>
            <SearchBar search={searchForCivilians}/>
          </Grid>
        </Grid>
        {civilians.map(civ =>
          <Grid item xs={12} className={classes.gridItem}>
            <CivilianCard data={civ} setModalState={setModalState} setSelectedCivilian={setSelectedCivilian}/>
          </Grid>,
        )}
      </Grid>
      <EntityModal open={modalState} setModalState={setModalState}>
        <Paper className={classes.title}>
          <Typography variant={'h6'}>Civilian Data</Typography>
        </Paper>
        <CivilianCard data={selectedCivilian} hideFab={true}/>
        <Fab aria-label="add" className={classes.fab} onClick={(event) => setAnchorEl(event.currentTarget)}>
          <AddIcon/>
        </Fab>
        <Menu
          id="simple-menu"
          anchorEl={anchorEl}
          keepMounted
          open={Boolean(anchorEl)}
          onClose={() => setAnchorEl(null)}
        >
          <MenuItem onClick={handleMenuSelect} id={'jail'}>Jail Report</MenuItem>
        </Menu>
      </EntityModal>
      <JailReport open={jailOpen} setModalState={setJailOpen}/>
    </Screen>
  );
};
