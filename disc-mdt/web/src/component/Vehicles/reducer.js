export const initialState = {
  vehicles: [],
  currentSearch: '',
};

const reducer = (state = initialState, action) => {

  switch (action.type) {
    case 'SET_VEHICLES':
      return {
        ...state,
        vehicles: action.payload.vehicles,
      };
    case 'SET_SEARCH':
      return {
        ...state,
        currentSearch: action.payload,
      };
    default: {
      return state;
    }
  }
};

export default reducer;
