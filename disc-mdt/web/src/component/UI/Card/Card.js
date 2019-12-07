import { makeStyles, Paper, Typography } from '@material-ui/core';
import Grid from '@material-ui/core/Grid';
import Divider from '@material-ui/core/Divider';
import React from 'react';

const useStyles = makeStyles(theme => ({
  paper: {
    position: 'relative',
    marginTop: theme.spacing(2),
    marginBottom: theme.spacing(2),
  },
  grid: {
    padding: theme.spacing(1),
  }
}));

export default (props) => {
  const classes = useStyles();

  return (
    <Paper className={classes.paper}>
      <Grid container justify={'left'} alignItems={'left'} spacing={3} className={classes.grid}>
        <Grid item xs={12}>
          <Typography variant={'h6'}>{props.title}</Typography>
        </Grid>
        <Grid item xs={12}>
          <Divider/>
        </Grid>
        {props.children}
      </Grid>
    </Paper>);

}
