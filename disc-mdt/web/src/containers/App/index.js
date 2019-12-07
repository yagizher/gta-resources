import React from 'react';
import { connect } from 'react-redux';
import PropTypes from 'prop-types';
import AppScreen from '../../component/UI/AppScreen/AppScreen';
import AppBar from '../../component/UI/AppBar/AppBar';
import { Route, Switch } from 'react-router-dom';
import Civilians from '../../component/Civilians/Civilians';
import Crimes from '../../component/Crimes/Crimes';
import Home from '../../component/Home/Home';
import { ThemeProvider } from '@material-ui/core/styles';
import Theme from './../../theme/Theme'
import Vehicles from '../../component/Vehicles/Vehicles';

const App = ({ hidden }) => {
  return (
    <ThemeProvider theme={Theme}>
      <AppScreen hidden={hidden}>
        <AppBar/>
        <Switch>
          <Route path={'/'} exact component={Home}/>
          <Route path={'/civilians'} exact component={Civilians}/>
          <Route path={'/vehicles'} exact component={Vehicles}/>
          <Route path={'/crimes'} exact component={Crimes}/>
        </Switch>
      </AppScreen>
    </ThemeProvider>

  );
};

App.propTypes = {
  hidden: PropTypes.bool.isRequired,
};

const mapStateToProps = state => ({ hidden: state.app.hidden });

export default connect(mapStateToProps)(App);
