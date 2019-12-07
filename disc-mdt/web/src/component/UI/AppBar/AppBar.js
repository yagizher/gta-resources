import AppBar from '@material-ui/core/AppBar';
import React from 'react';
import { makeStyles, Toolbar } from '@material-ui/core';
import Grid from '@material-ui/core/Grid';
import { withRouter } from 'react-router-dom';
import { connect } from 'react-redux';
import NavButton from '../NavButton/NavButton';
import Button from '@material-ui/core/Button';
import Nui from '../../../util/Nui';

const useStyles = makeStyles(theme => ({
  grid: {
    flexGrow: 1,
  },
  button: {
    width: 100,
    margin: '10px, 0px',
    color: theme.palette.primary.contrastText,
  },
}));

export default withRouter(connect()(function MDTAppBar(props) {
  const classes = useStyles();

  const onExitClick = () => {
    props.dispatch({type: 'APP_HIDE'});
    Nui.send("CloseUI");
  };

  return (
    <AppBar position="static">
      <Toolbar>
        <Grid container className={classes.grid}>
          <NavButton name={'Home'} link={'/'}/>
          <NavButton name={'Civilians'} link={'/civilians'}/>
          <NavButton name={'Vehicles'} link={'/vehicles'}/>
          <NavButton name={'Crimes'} link={'/crimes'}/>
          <NavButton name={'Most Wanted'} link={'/mostwanted'}/>
        </Grid>
        <Button color="inherit" onClick={onExitClick}>Exit</Button>
      </Toolbar>
    </AppBar>
  );
}));
