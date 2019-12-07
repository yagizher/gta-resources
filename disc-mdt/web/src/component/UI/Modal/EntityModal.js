import React from 'react';
import Modal from '@material-ui/core/Modal';
import Paper from '@material-ui/core/Paper';
import { makeStyles } from '@material-ui/core';
import { blue } from '@material-ui/core/colors';

const useStyles = makeStyles(theme => ({
  modal: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    padding: theme.spacing(2),
    '@media (max-width: 900px)': {
      margin: theme.spacing(5),
    },
  },
  paper: {
    width: 800,
    padding: theme.spacing(1),
    position: 'relative',
    paddingBottom: 90,
  },
}));

export default function EntityModal(props) {
  const classes = useStyles();

  return (
    <Modal open={props.open} onClose={() => props.setModalState(false)} className={classes.modal}>
      <Paper className={classes.paper}>
        {props.children}
      </Paper>
    </Modal>
  );
}
