import React from 'react';
import Modal from '@material-ui/core/Modal';
import Paper from '@material-ui/core/Paper';
import { Dialog, DialogContent, makeStyles } from '@material-ui/core';
import { blue } from '@material-ui/core/colors';

const useStyles = makeStyles(theme => ({
  form: {
    display: 'flex',
    flexDirection: 'column',
    margin: 'auto',
    width: 'fit-content',
  }
}));

export default function DialogModal(props) {
  const classes = useStyles();

  return (
    <Dialog open={props.open} onClose={() => props.setModalState(false)} fullWidth maxWidth={props.maxWidth ? props.maxWidth : "lg"}>
      <DialogContent>
        {props.children}
      </DialogContent>
    </Dialog>
  );
}
