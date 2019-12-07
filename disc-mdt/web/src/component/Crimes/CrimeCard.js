import { makeStyles, Paper, TableCell } from '@material-ui/core';
import React from 'react';
import Grid from '@material-ui/core/Grid';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableRow from '@material-ui/core/TableRow';
import Card from '../UI/Card/Card';

const useStyles = makeStyles(theme => ({
  table: {
    textAlign: 'left',
  },
  tablePaper: {
    marginTop: theme.spacing(3),
    overflowX: 'auto',
    marginBottom: theme.spacing(2),
  },
  infoFab: {
    position: 'absolute',
    margin: theme.spacing(1),
    bottom: theme.spacing(0),
    right: theme.spacing(1),
  },
  pictureFab: {
    position: 'absolute',
    margin: theme.spacing(1),
    top: theme.spacing(0),
    right: theme.spacing(1),
  },
  capitalize: {
    textTransform: 'capitalize',
  },
}));

export default (props) => {
  const classes = useStyles();

  return (
    <Card title={props.data.name}>
      <Grid item xs={6}>
        <Paper className={classes.tablePaper}>
          <Table className={classes.table} size="small" aria-label="a dense table">
            <TableBody>
              <TableRow><TableCell>Fine</TableCell><TableCell>{props.data.fine}</TableCell></TableRow>
              <TableRow><TableCell>JailTime</TableCell><TableCell>{props.data.jailtime}</TableCell></TableRow>
              <TableRow><TableCell>Type</TableCell><TableCell>{props.data.type}</TableCell></TableRow>
            </TableBody>
          </Table>
        </Paper>
      </Grid>
    </Card>
  );

}
