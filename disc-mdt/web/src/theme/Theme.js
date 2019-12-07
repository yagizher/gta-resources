import { createMuiTheme } from '@material-ui/core';
import { grey } from '@material-ui/core/colors';

const theme = createMuiTheme(
  {
    overrides: {
      MuiPaper: {
        root: {
          background: grey[500]
        }
      }
    }
  }
);

export default theme
