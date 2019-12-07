export const initialState = {
  currentTab: 0,
};

const tabReducer = (state = initialState, action) => {
  if (action.type === 'SWITCH_TAB') {
    return {
      ...state,
      currentTab: action.tab,
    };
  } else {
    return state;
  }
};

export default tabReducer;
