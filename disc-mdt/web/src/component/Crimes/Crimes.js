import React, { useEffect, useState } from 'react';
import { makeStyles } from '@material-ui/core';
import Screen from '../UI/Screen/Screen';
import { useSelector } from 'react-redux';
import Grid from '@material-ui/core/Grid';
import { green } from '@material-ui/core/colors';
import Nui from '../../util/Nui';
import TitleBar from '../UI/TitleBar/TitleBar';

const useStyles = makeStyles(theme => ({
  grid: {
    padding: 20,
  },
  gridItem: {
    marginTop: theme.spacing(2),
    marginBottom: theme.spacing(2),
  },
  fab: {
    position: 'absolute',
    bottom: theme.spacing(2),
    right: theme.spacing(2),
    color: green[500].contrastText,
    backgroundColor: green[500],
    '&:hover': {
      backgroundColor: green[300],
    },
  },
  title: {
    textAlign: 'center',
    padding: theme.spacing(1),
  },

}));

export default function Civilians(props) {

  const classes = useStyles();
  const crimes = useSelector(state => state.crime.crimes);
  const [selectedCivilian, setSelectedCivilian] = useState({});
  const [modalState, setModalState] = useState(false);
  useEffect(() => {
    Nui.send('GetCrimes');
  }, []);
  return (
    <Screen>
      <TitleBar title={'Crimes'} />
      <Grid spacing={3} className={classes.grid}>
        {crimes.map(crime =>
          <Grid item xs={12} className={classes.gridItem}>
            {crime.name}
          </Grid>,
        )}
      </Grid>
    </Screen>
  );
};
