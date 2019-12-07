import { makeStyles, TextField } from '@material-ui/core';
import React, { useEffect } from 'react';
import EntityModal from '../UI/Modal/EntityModal';
import { connect, useSelector } from 'react-redux';
import Grid from '@material-ui/core/Grid';
const useStyles = makeStyles(theme => ({

}));


export default connect()((props) => {
  const classes = useStyles();
  const player = useSelector(state => state.user.player);
  console.log('Class' + JSON.stringify(player));
  const jailReport = useSelector(state => state.jail.jailReport);
  const setProperty = (event, property) => {
    const newReport = { ...jailReport };
    newReport[property] = event.target.value;
    props.dispatch({
      type: 'SET_JAIL_REPORT',
      payload: {
        jailReport: newReport,
      },
    });
  };


  return (
    <EntityModal open={props.open} setModalState={props.setModalState}>
      <Grid spacing={3} justify={'center'} alignItems={'center'} container>
        <TextField value={jailReport.arrestingOfficer} onChange={(event) => setProperty(event, 'arrestingOfficer')}
                   label={'Arresting Officer'}/>
      </Grid>
    </EntityModal>
  );
});
