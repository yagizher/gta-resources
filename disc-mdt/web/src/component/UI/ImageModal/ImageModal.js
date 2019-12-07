import Grid from '@material-ui/core/Grid';
import { makeStyles, TextField, Typography } from '@material-ui/core';
import Divider from '@material-ui/core/Divider';
import ImageCard from '../ImageCard/ImageCard';
import Fab from '@material-ui/core/Fab';
import PublishIcon from '@material-ui/icons/Publish';
import EntityModal from '../Modal/EntityModal';
import React, { useEffect, useState } from 'react';

const useStyles = makeStyles(theme => ({
  title: {
    textAlign: 'center',
    padding: theme.spacing(1),
  },
  textField: {
    width: '100%',
  },
  fabPhoto: {
    position: 'absolute',
    bottom: theme.spacing(2),
    right: theme.spacing(2),
  },
}));

export default (props) => {
  const classes = useStyles();

  const [url, setUrl] = useState('');

  useEffect(() => {
    setUrl(props.selectedImage);
  }, [props.selectedImage]);

  return (
    <EntityModal open={props.open} setModalState={props.setModalState}>
      <Grid spacing={0} justify={'center'} alignItems={'center'}>
        <Grid item xs={12}>
          <Typography variant={'h4'} className={classes.title}>{props.title}</Typography>
        </Grid>
        <Divider/>
        <ImageCard url={props.selectedImage}/>
        <Grid item xs={12}>
          <TextField variant={'outlined'} className={classes.textField} value={url}
                     onChange={(event) => setUrl(event.target.value)}/>
        </Grid>
        <Fab aria-label="add" className={classes.fabPhoto} onClick={() => props.setImage(url)}>
          <PublishIcon/>
        </Fab>
      </Grid>
    </EntityModal>
  );
}
