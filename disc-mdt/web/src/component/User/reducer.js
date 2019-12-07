export const initialState = {
  player: {},
};

const reducer = (state = initialState, action) => {
  if (action.type === 'SET_USER') {
    return {
      ...state,
      player: action.payload.player
    }
  } else {
    return state;
  }
};

export default reducer;
