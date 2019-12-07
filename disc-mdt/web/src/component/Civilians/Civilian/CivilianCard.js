import { makeStyles, Paper, TableCell, Typography } from '@material-ui/core';
import React from 'react';
import Grid from '@material-ui/core/Grid';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableRow from '@material-ui/core/TableRow';
import Fab from '@material-ui/core/Fab';
import InfoIcon from '@material-ui/icons/Info';
import AddIcon from '@material-ui/icons/Add';
import Divider from '@material-ui/core/Divider';

const useStyles = makeStyles(theme => ({
  paper: {
    position: 'relative',
  },
  grid: {
    padding: theme.spacing(1),
  },
  table: {
    minWidth: 250,
  },
  tablePaper: {
    marginTop: theme.spacing(3),
    overflowX: 'auto',
    marginBottom: theme.spacing(2),
  },
  fab: {
    position: 'absolute',
    margin: theme.spacing(1),
    bottom: theme.spacing(1),
    right: theme.spacing(1),
  },
  extendedIcon: {
    marginRight: theme.spacing(1),
  },
}));

export default function CivilianCard(props) {
  const classes = useStyles();

  const onInfoClick = () => {
    props.setSelectedCivilian(props.data);
    props.setModalState(true)
  };

  return (
    <Paper className={classes.paper}>
      <Grid container justify={'left'} alignItems={'left'} spacing={2} className={classes.grid}>
        <Grid item xs={12}>
          <Typography variant={'h6'}>{props.data.firstname} {props.data.lastname}</Typography>
        </Grid>
        <Divider />
        <Grid item xs={6}>
          <Paper className={classes.tablePaper}>
            <Table className={classes.table} size="small" aria-label="a dense table">
              <TableBody>
                <TableRow><TableCell>Date of Birth</TableCell><TableCell>{props.data.dateofbirth}</TableCell></TableRow>
                <TableRow><TableCell>Height</TableCell><TableCell>{props.data.height} cm</TableCell></TableRow>
                <TableRow><TableCell>Sex</TableCell><TableCell>{props.data.sex === 'm' ? 'Male' : 'Female'}</TableCell></TableRow>
              </TableBody>
            </Table>
          </Paper>
        </Grid>
      </Grid>
      {!props.hideFab && (<Fab variant="extended" aria-label="like" className={classes.fab} onClick={onInfoClick}>
        <InfoIcon className={classes.extendedIcon}/>
        Info
      </Fab>)}
    </Paper>
  );

}
