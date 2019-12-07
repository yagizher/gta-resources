import Nui from '../../util/Nui';

export const setSearch = (search) => {
  return dispatch => {
    Nui.send('SearchCivilians', {
      search: search,
    }).then(_ => {
      dispatch({
        type: 'SET_CIV_SEARCH',
        payload: search,
      });
    });
  };
};

export const setCivilianImage = (identifier, url, search) => {
  Nui.send('SetCivilianImage', {
    identifier: identifier,
    url: url,
  }).then(_ => {
    Nui.send('SearchCivilians', {
      search: search,
    });
  })
};

export const setSelectedCivilian = (data) => {
  return {
    type: 'SET_SELECTED_CIVILIAN',
    payload: data,
  };
};

