dataConfirmModal.setDefaults({
  title: 'Delete Entry?',
  commit: 'Yes',
  cancel: 'No'
});

jQuery ->
  new CarrierWaveCropper()

class CarrierWaveCropper
  constructor: ->
    $('#user_profile_cropbox').Jcrop
      aspectRatio: 1
      setSelect: [0, 0, 200, 200]
      onSelect: @update
      onChange: @update

  update: (coords) =>
    $('#user_profile_crop_x').val(coords.x)
    $('#user_profile_crop_y').val(coords.y)
    $('#user_profile_crop_w').val(coords.w)
    $('#user_profile_crop_h').val(coords.h)
    @updatePreview(coords)

  updatePreview: (coords) =>
    $('#user_profile_previewbox').css
      width: Math.round(100/coords.w * $('#user_profile_cropbox').width()) + 'px'
      height: Math.round(100/coords.h * $('#user_profile_cropbox').height()) + 'px'
      marginLeft: '-' + Math.round(100/coords.w * coords.x) + 'px'
      marginTop: '-' + Math.round(100/coords.h * coords.y) + 'px'
