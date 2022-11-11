
#ifndef __ZEGO_EXPRESS_RANGE_SCENE_H__
#define __ZEGO_EXPRESS_RANGE_SCENE_H__

#include "zego-express-defines.h"

ZEGO_BEGIN_DECLS
/// Create a range scene instance object.
///
/// Available since: 3.0.0
/// Description: Create a range scene instance object.
/// Use case: Often used in meta world scenarios, users can use related functions by range scene instance objects.
/// When to call: After initializing the engine by [createEngine].
/// Restrictions: None.
///
/// @return range scene instance object.
ZEGOEXP_API int EXP_CALL zego_express_create_range_scene();

/// Destroy a range scene instance object.
///
/// Available since: 3.0.0
/// Description: Destroy a range scene instance.
/// When to call: After create the range scene by [createRangeScene].
/// Restrictions: None.
///
/// @param range_scene_handle range scene handle.
ZEGOEXP_API zego_error EXP_CALL zego_express_destroy_range_scene(int range_scene_handle);

/// Logs in to a scene.
///
/// Available: since 3.0.0
/// Description: SDK RangeScene uses the 'scene' to organize users.
/// Use cases: Users interact in the RangeScene within the same scene.
/// When to call: After creating the range scene via [createRangeScene], before destroying the range scene via [destroyRangeScene].
/// Caution:
///   1. Apps that use different appIDs cannot intercommunication with each other.
///   2. It is strongly recommended that userID corresponds to the user ID of the business APP, that is, a userID and a real user are fixed and unique, and should not be passed to the SDK in a random userID. Because the unique and fixed userID allows ZEGO technicians to quickly locate online problems.
/// Privacy reminder: Please do not fill in sensitive user information in this interface, including but not limited to mobile phone number, ID number, passport number, real name, etc.
/// Related callbacks:
///   1. When the user starts to log in to the scene, the scene is successfully logged in, or the scene fails to log in, the [onSceneStateUpdate] callback will be triggered to notify the developer of the status of the current user connected to the scene.
///   2. If the network is temporarily interrupted due to network quality reasons, the SDK will automatically reconnect internally. You can get the current connection status of the local scene by listening to the [onSceneStateUpdate] callback method.
/// Related APIs:
///   1. Users can call [logoutScene] to log out.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq The seq executed this time, the seq is valid when the call is successful.
/// @param config Scene param.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL zego_express_range_scene_login_scene(
    int range_scene_handle, zego_seq *seq, struct zego_scene_param config);

/// Logs out of a scene.
///
/// Available: since 3.0.0
/// Description: This API will log out the current user has logged in the scene.
/// When to call: After successfully logging in to the scene, if the scene is no longer used, the user can call the function [logoutScene].
/// Restrictions: None.
/// Caution: Exiting a scene stops all publishing and playing stream associated with the scene for that user.
/// Related callbacks: After calling this function, you will receive [onSceneStateUpdate] callback notification successfully exits the scene.
/// Related APIs: Users can use [loginScene] functions to log in scene.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq The seq executed this time, the seq is valid when the call is successful.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL zego_express_range_scene_logout_scene(int range_scene_handle,
                                                                      zego_seq *seq);

/// Update user status.
///
/// Available: since 3.0.0
/// Description: Developers can call this function to update the user status.
/// When to call: After [LoginScene], before [LogoutScene].
/// Restrictions: None.
/// Caution: None.
///
/// @param range_scene_handle Range scene instance handle.
/// @param position User's current location.
/// @param channel The channel to which the status belongs, starting from 0, cannot exceed the maximum channel number.
/// @param status Current status data.
/// @param status_length Current status data length.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL zego_express_range_scene_update_user_status(
    int range_scene_handle, struct zego_position position, unsigned int channel,
    const unsigned char *status, unsigned int status_length);

/// Update user status.
///
/// Available: since 3.0.0
/// Description: Developers can call this function to update the user command.
/// When to call: After [LoginScene], before [LogoutScene].
/// Restrictions: None.
/// Caution: None.
///
/// @param range_scene_handle Range scene instance handle.
/// @param position User's current location.
/// @param channel The channel to which the command belongs, starting from 0, cannot exceed the maximum channel number.
/// @param command Next command data.
/// @param command_length Next command data length.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL zego_express_range_scene_update_user_command(
    int range_scene_handle, struct zego_position position, unsigned int channel,
    const unsigned char *command, unsigned int command_length);

/// Update user position.
///
/// Available: since 3.0.0
/// Description: Developers can call this function to update the user position.
/// When to call: After [LoginScene], before [LogoutScene].
/// Restrictions: None.
/// Caution: None.
///
/// @param range_scene_handle Range scene instance handle.
/// @param position User's current location.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL zego_express_range_scene_update_user_position(
    int range_scene_handle, struct zego_position position);

/// Get user count in scene.
///
/// Available: since 3.0.0
/// Description: Developers can call this function to get user count in scene.
/// When to call: After [LoginScene], before [LogoutScene].
/// Default value: NULL.
/// Restrictions: None.
/// Caution: None.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq The seq executed this time, the seq is valid when the call is successful.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL zego_express_range_scene_get_user_count(int range_scene_handle,
                                                                        zego_seq *seq);

/// Get user list in view.
///
/// Available: since 3.0.0
/// Description: Developers can call this function to get user list in view.
/// When to call: After [LoginScene], before [LogoutScene].
/// Default value: NULL.
/// Restrictions: None.
/// Caution: None.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq The seq executed this time, the seq is valid when the call is successful.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL
zego_express_range_scene_get_user_list_in_view(int range_scene_handle, zego_seq *seq);

/// Send custom command.
///
/// Available: since 3.0.0
/// Description: Developers can call this function to send custom command.
/// When to call: After [LoginScene], before [LogoutScene].
/// Default value: NULL.
/// Restrictions: None.
/// Caution: None.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq The seq executed this time, the seq is valid when the call is successful.
/// @param command Custom command.
/// @param command_length Custom command data length.
/// @return Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
ZEGOEXP_API zego_error EXP_CALL zego_express_range_scene_send_custom_command(
    int range_scene_handle, zego_seq *seq, const unsigned char *command,
    unsigned int command_length);

/// The callback triggered when the scene connection state changes.
///
/// @param range_scene_handle Range scene instance handle.
/// @param state Current scene state.
/// @param error_code Error code, please refer to the error codes document https://doc-en.zego.im/en/5548.html for details.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_scene_state_update)(int range_scene_handle,
                                                       enum zego_scene_state state, int error_code,
                                                       void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_scene_state_update_callback(
    zego_on_range_scene_scene_state_update callback_func, void *user_context);

/// Callback notification when another user enters the current user's field of view.
///
/// @param range_scene_handle Range scene instance handle.
/// @param user User object.
/// @param position User position.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_enter_view)(int range_scene_handle, struct zego_user user,
                                               struct zego_position position, void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_enter_view_callback(
    zego_on_range_scene_enter_view callback_func, void *user_context);

/// Callback notification when other users leave the current user's field of view.
///
/// @param range_scene_handle Range scene instance handle.
/// @param userid User ID.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_leave_view)(int range_scene_handle, const char *userid,
                                               void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_leave_view_callback(
    zego_on_range_scene_leave_view callback_func, void *user_context);

/// User state update callback. Please do not perform time-consuming operations in this callback. Please do not call SDK function in this callback.
///
/// @param range_scene_handle Range scene instance handle.
/// @param userid User ID.
/// @param position User's current position.
/// @param channel The channel to which the status belongs.
/// @param status Current status data.
/// @param status_length Current status data length.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_user_status_update)(
    int range_scene_handle, const char *userid, struct zego_position position, unsigned int channel,
    const unsigned char *status, unsigned int status_length, void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_user_status_update_callback(
    zego_on_range_scene_user_status_update callback_func, void *user_context);

/// User command update callback. Please do not perform time-consuming operations in this callback. Please do not call SDK function in this callback.
///
/// @param range_scene_handle Range scene instance handle.
/// @param userid User ID.
/// @param position User's current position.
/// @param channel The channel to which the command belongs.
/// @param command Next command data.
/// @param command_length Next command data length.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_user_command_update)(
    int range_scene_handle, const char *userid, struct zego_position position, unsigned int channel,
    const unsigned char *command, unsigned int command_length, void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_user_command_update_callback(
    zego_on_range_scene_user_command_update callback_func, void *user_context);

/// Custom command update callback.
///
/// @param range_scene_handle Range scene instance handle.
/// @param command Custom command.
/// @param command_length Custom command data length.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_custom_command_update)(int range_scene_handle,
                                                          const unsigned char *command,
                                                          unsigned int command_length,
                                                          void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_custom_command_update_callback(
    zego_on_range_scene_custom_command_update callback_func, void *user_context);

/// Login scene result callback.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq Sequence.
/// @param error_code Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
/// @param config State channel count.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_login_scene)(int range_scene_handle, zego_seq seq,
                                                int error_code, struct zego_scene_config config,
                                                void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_login_scene_callback(
    zego_on_range_scene_login_scene callback_func, void *user_context);

/// Logout scene result callback.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq Sequence.
/// @param error_code Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_logout_scene)(int range_scene_handle, zego_seq seq,
                                                 int error_code, void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_logout_scene_callback(
    zego_on_range_scene_logout_scene callback_func, void *user_context);

/// The callback of getting user count in scene.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq Sequence.
/// @param error_code Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
/// @param count User count in scene.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_get_user_count)(int range_scene_handle, zego_seq seq,
                                                   int error_code, unsigned int count,
                                                   void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_get_user_count_callback(
    zego_on_range_scene_get_user_count callback_func, void *user_context);

/// The callback of getting user list in view.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq Sequence.
/// @param error_code Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
/// @param user_list User list in view.
/// @param user_list_size User list in view.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_get_user_list_in_view)(int range_scene_handle, zego_seq seq,
                                                          int error_code, const char **user_list,
                                                          unsigned int user_list_size,
                                                          void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_get_user_list_in_view_callback(
    zego_on_range_scene_get_user_list_in_view callback_func, void *user_context);

/// The callback of send custom command.
///
/// @param range_scene_handle Range scene instance handle.
/// @param seq Sequence.
/// @param error_code Error code, please refer to the error codes document https://docs.zegocloud.com/en/5548.html for details.
/// @param user_context Context of user.
typedef void (*zego_on_range_scene_send_custom_command)(int range_scene_handle, zego_seq seq,
                                                        int error_code, void *user_context);

ZEGOEXP_API void EXP_CALL zego_register_range_scene_send_custom_command_callback(
    zego_on_range_scene_send_custom_command callback_func, void *user_context);

ZEGO_END_DECLS

#endif
