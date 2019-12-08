import React, { useEffect, useState } from 'react';
import { makeStyles } from '@material-ui/core';
import Screen from '../UI/Screen/Screen';
import { useSelector } from 'react-redux';
import Grid from '@material-ui/core/Grid';
import { green } from '@material-ui/core/colors';
import Nui from '../../util/Nui';
import TitleBar from '../UI/TitleBar/TitleBar';
import * as lodash from 'lodash';
import ExpansionPanel from '@material-ui/core/ExpansionPanel';
import ExpansionPanelSummary from '@material-ui/core/ExpansionPanelSummary';
import CrimeCard from './CrimeCard';
import ExpansionPanelDetails from '@material-ui/core/ExpansionPanelDetails';
import Typography from '@material-ui/core/Typography';

const useStyles = makeStyles(theme => ({
  grid: {
    width: '90%',
    marginBottom: theme.spacing(2),
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
  root: {
    width: '100%',
  },

}));

export default function Civilians(props) {

  const classes = useStyles();
  const crimes = useSelector(state => state.crime.crimes);
  const [types, setTypes] = useState({});
  useEffect(() => {
    Nui.send('GetCrimes');
  }, []);

  useEffect(() => {
    const types = lodash.keysIn(lodash.groupBy(crimes, (crime) => crime.type));
    setTypes(types);
  }, [crimes]);

  return (
    <Screen>
      <Grid container direction={'column'} alignItems={'center'} spacing={0} justify={'center'}
            className={classes.root}>
        <TitleBar title={'Crimes'}/>

        <Grid spacing={3} className={classes.grid}>
          {lodash.map(types, (value) =>
            <ExpansionPanel>
              <ExpansionPanelSummary>
                <Typography variant={'h6'}>
                  {value}
                </Typography>
              </ExpansionPanelSummary>
              <ExpansionPanelDetails>
                <Grid spacing={3} className={classes.grid}>
                  {lodash.filter(crimes, (crime) => crime.type === value).map(crime =>
                    <Grid item xs={12} className={classes.gridItem}>
                      <CrimeCard data={crime}/>
                    </Grid>,
                  )}
                </Grid>
              </ExpansionPanelDetails>
            </ExpansionPanel>,
          )}
        </Grid>
      </Grid>
    </Screen>
  );
};
