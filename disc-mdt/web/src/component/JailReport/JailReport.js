import { makeStyles } from '@material-ui/core';
import React from 'react';
import { connect, useSelector } from 'react-redux';
import Card from '../UI/Card/Card';
import Modal from '@material-ui/core/Modal';

const useStyles = makeStyles(theme => ({}));


export default connect()((props) => {
  const classes = useStyles();
  const player = useSelector(state => state.user.player);

  return (
    <Modal open={props.open} onClose={() => props.setModalState(false)}>
      <Card title={'Jail Report'}/>
    </Modal>
  );
});
