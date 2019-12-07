import Nui from '../../util/Nui';
import { useSelector } from 'react-redux';

export const setSearch = (search) => {
  return dispatch => {
    Nui.send('SearchVehicles', {
      search: search,
    }).then(_ => {
      dispatch({
        type: 'SET_SEARCH',
        payload: search,
      });
    });
  };
};

export const setVehicleImage = (plate, url, search) => {
  Nui.send('SetImage', {
    plate: plate,
    url: url,
  }).then(_ => {
    Nui.send('SearchVehicles', {
      search: search,
    });
  }).error( error =>
    console.log(error)
  );
};
