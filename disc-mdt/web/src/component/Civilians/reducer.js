export const initialState = {
  civilians: [],
};

const reducer = (state = initialState, action) => {
  if (action.type === 'SET_CIVILIANS') {
    return {
      ...state,
      civilians: action.payload.civilians
    }
  } else {
    return state;
  }
};

export default reducer;
