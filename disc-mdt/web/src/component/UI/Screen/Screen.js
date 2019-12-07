import { makeStyles } from '@material-ui/core';
import Paper from '@material-ui/core/Paper';
import React from 'react';
import { grey } from '@material-ui/core/colors';

const useStyles = makeStyles(theme => ({
  paper: {
    width: '100%',
    height: '100%',
    backgroundColor: theme.palette.background.paper,
    overflow: 'auto',
    position: 'relative',

  },
}));

export default function Screen(props) {
  const classes = useStyles();
  return (
    <Paper className={classes.paper}>
      {props.children}
    </Paper>
  );
}
