import { combineReducers } from 'redux';

import appReducer from 'containers/App/reducer';
import tabReducer from './component/UI/AppBar/reducer';
import civReducer from './component/Civilians/reducer';
import vehReducer from './component/Vehicles/reducer';
import crimeReducer from './component/Crimes/reducer';
import userReducer from './component/User/reducer';
import jailReducer from './component/JailReport/reducer';

export default () =>
  combineReducers({
    app: appReducer,
    tab: tabReducer,
    civ: civReducer,
    veh: vehReducer,
    crime: crimeReducer,
    user: userReducer,
    jail: jailReducer,
  });
