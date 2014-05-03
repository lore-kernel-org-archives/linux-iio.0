Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54084 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbaECTg7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 15:36:59 -0400
Message-ID: <536545B8.9090101@kernel.org>
Date: Sat, 03 May 2014 20:38:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/16] iio: hid-sensors: Add API to power on/off
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1397863356-2470-9-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-9-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/14 00:22, Srinivas Pandruvada wrote:
> Added an API to allow client drivers to turn ON and OFF sensors for
> quick read. Added data_read as counting varaible instead of boolean,
> so that sensor is powered off only when last user released it.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/accel/hid-sensor-accel-3d.c             |  7 +++----
>   drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 17 +++++++++++++----
>   drivers/iio/common/hid-sensors/hid-sensor-trigger.h |  1 +
>   drivers/iio/gyro/hid-sensor-gyro-3d.c               |  7 +++----
>   drivers/iio/light/hid-sensor-als.c                  |  7 +++----
>   drivers/iio/light/hid-sensor-prox.c                 |  7 +++----
>   drivers/iio/magnetometer/hid-sensor-magn-3d.c       |  7 +++----
>   drivers/iio/orientation/hid-sensor-incl-3d.c        |  7 +++----
>   drivers/iio/orientation/hid-sensor-rotation.c       |  8 +++-----
>   drivers/iio/pressure/hid-sensor-press.c             |  7 +++----
>   include/linux/hid-sensor-hub.h                      |  2 +-
>   11 files changed, 39 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index ca50a91..cf61c87 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -201,9 +201,8 @@ static int accel_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct accel_3d_state *accel_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "accel_3d_proc_event [%d]\n",
> -				accel_state->common_attributes.data_ready);
> -	if (accel_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "accel_3d_proc_event\n");
> +	if (atomic_read(&accel_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				accel_state->accel_val,
>   				sizeof(accel_state->accel_val));
> @@ -342,7 +341,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		goto error_free_dev_mem;
>   	}
> -	accel_state->common_attributes.data_ready = false;
> +	atomic_set(&accel_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   					&accel_state->common_attributes);
>   	if (ret < 0) {
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index dbefbda..73282ce 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -28,16 +28,17 @@
>   #include <linux/iio/sysfs.h>
>   #include "hid-sensor-trigger.h"
>
> -static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> -						bool state)
> +int hid_sensor_power_state(struct hid_sensor_common *st, bool state)
>   {
> -	struct hid_sensor_common *st = iio_trigger_get_drvdata(trig);
>   	int state_val;
>   	int report_val;
>
>   	if (state) {
>   		if (sensor_hub_device_open(st->hsdev))
>   			return -EIO;
> +
> +		atomic_inc(&st->data_ready);
> +
>   		state_val = hid_sensor_get_usage_index(st->hsdev,
>   			st->power_state.report_id,
>   			st->power_state.index,
> @@ -47,6 +48,8 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>   			st->report_state.index,
>   			HID_USAGE_SENSOR_PROP_REPORTING_STATE_ALL_EVENTS_ENUM);
>   	} else {
> +		if (!atomic_dec_and_test(&st->data_ready))
> +			return 0;
>   		sensor_hub_device_close(st->hsdev);
>   		state_val = hid_sensor_get_usage_index(st->hsdev,
>   			st->power_state.report_id,
> @@ -57,7 +60,6 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>   			st->report_state.index,
>   			HID_USAGE_SENSOR_PROP_REPORTING_STATE_NO_EVENTS_ENUM);
>   	}
> -	st->data_ready = state;
>
>   	if (state_val >= 0) {
>   		state_val += st->power_state.logical_minimum;
> @@ -75,6 +77,13 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>
>   	return 0;
>   }
> +EXPORT_SYMBOL(hid_sensor_power_state);
> +
> +static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
> +						bool state)
> +{
> +	return hid_sensor_power_state(iio_trigger_get_drvdata(trig), state);
> +}
>
>   void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
>   {
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> index ca02f78..0f8e78c 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> @@ -22,5 +22,6 @@
>   int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>   				struct hid_sensor_common *attrb);
>   void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
> +int hid_sensor_power_state(struct hid_sensor_common *st, bool state);
>
>   #endif
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index 53ac060..392c30b 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -201,9 +201,8 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "gyro_3d_proc_event [%d]\n",
> -				gyro_state->common_attributes.data_ready);
> -	if (gyro_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "gyro_3d_proc_event\n");
> +	if (atomic_read(&gyro_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				gyro_state->gyro_val,
>   				sizeof(gyro_state->gyro_val));
> @@ -339,7 +338,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		goto error_free_dev_mem;
>   	}
> -	gyro_state->common_attributes.data_ready = false;
> +	atomic_set(&gyro_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   					&gyro_state->common_attributes);
>   	if (ret < 0) {
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 39b50be..e124b39 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -180,9 +180,8 @@ static int als_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct als_state *als_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "als_proc_event [%d]\n",
> -				als_state->common_attributes.data_ready);
> -	if (als_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "als_proc_event\n");
> +	if (atomic_read(&als_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				&als_state->illum,
>   				sizeof(als_state->illum));
> @@ -305,7 +304,7 @@ static int hid_als_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		goto error_free_dev_mem;
>   	}
> -	als_state->common_attributes.data_ready = false;
> +	atomic_set(&als_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   				&als_state->common_attributes);
>   	if (ret < 0) {
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index 1894ab1..07e98ec8 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -176,9 +176,8 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct prox_state *prox_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "prox_proc_event [%d]\n",
> -				prox_state->common_attributes.data_ready);
> -	if (prox_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "prox_proc_event\n");
> +	if (atomic_read(&prox_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				&prox_state->human_presence,
>   				sizeof(prox_state->human_presence));
> @@ -297,7 +296,7 @@ static int hid_prox_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		goto error_free_dev_mem;
>   	}
> -	prox_state->common_attributes.data_ready = false;
> +	atomic_set(&prox_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   				&prox_state->common_attributes);
>   	if (ret) {
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index 131ced0..54eea6a 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -202,9 +202,8 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct magn_3d_state *magn_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "magn_3d_proc_event [%d]\n",
> -				magn_state->common_attributes.data_ready);
> -	if (magn_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "magn_3d_proc_event\n");
> +	if (atomic_read(&magn_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				magn_state->magn_val,
>   				sizeof(magn_state->magn_val));
> @@ -343,7 +342,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		goto error_free_dev_mem;
>   	}
> -	magn_state->common_attributes.data_ready = false;
> +	atomic_set(&magn_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   					&magn_state->common_attributes);
>   	if (ret < 0) {
> diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
> index f0c465c..bf11678 100644
> --- a/drivers/iio/orientation/hid-sensor-incl-3d.c
> +++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
> @@ -200,9 +200,8 @@ static int incl_3d_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct incl_3d_state *incl_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "incl_3d_proc_event [%d]\n",
> -				incl_state->common_attributes.data_ready);
> -	if (incl_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "incl_3d_proc_event\n");
> +	if (atomic_read(&incl_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				(u8 *)incl_state->incl_val,
>   				sizeof(incl_state->incl_val));
> @@ -358,7 +357,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		goto error_free_dev_mem;
>   	}
> -	incl_state->common_attributes.data_ready = false;
> +	atomic_set(&incl_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   					&incl_state->common_attributes);
>   	if (ret) {
> diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
> index 51387bb..dccf848 100644
> --- a/drivers/iio/orientation/hid-sensor-rotation.c
> +++ b/drivers/iio/orientation/hid-sensor-rotation.c
> @@ -145,10 +145,8 @@ static int dev_rot_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct dev_rot_state *rot_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "dev_rot_proc_event [%d]\n",
> -				rot_state->common_attributes.data_ready);
> -
> -	if (rot_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "dev_rot_proc_event\n");
> +	if (atomic_read(&rot_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				(u8 *)rot_state->sampled_vals,
>   				sizeof(rot_state->sampled_vals));
> @@ -272,7 +270,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		return ret;
>   	}
> -	rot_state->common_attributes.data_ready = false;
> +	atomic_set(&rot_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   					&rot_state->common_attributes);
>   	if (ret) {
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index ff69da4..39df50c 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -180,9 +180,8 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
>   	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>   	struct press_state *press_state = iio_priv(indio_dev);
>
> -	dev_dbg(&indio_dev->dev, "press_proc_event [%d]\n",
> -				press_state->common_attributes.data_ready);
> -	if (press_state->common_attributes.data_ready)
> +	dev_dbg(&indio_dev->dev, "press_proc_event\n");
> +	if (atomic_read(&press_state->common_attributes.data_ready))
>   		hid_sensor_push_data(indio_dev,
>   				&press_state->press_data,
>   				sizeof(press_state->press_data));
> @@ -307,7 +306,7 @@ static int hid_press_probe(struct platform_device *pdev)
>   		dev_err(&pdev->dev, "failed to initialize trigger buffer\n");
>   		goto error_free_dev_mem;
>   	}
> -	press_state->common_attributes.data_ready = false;
> +	atomic_set(&press_state->common_attributes.data_ready, 0);
>   	ret = hid_sensor_setup_trigger(indio_dev, name,
>   				&press_state->common_attributes);
>   	if (ret) {
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 88d8d63..51f7cca 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -189,7 +189,7 @@ struct hid_sensor_common {
>   	struct hid_sensor_hub_device *hsdev;
>   	struct platform_device *pdev;
>   	unsigned usage_id;
> -	bool data_ready;
> +	atomic_t data_ready;
>   	struct iio_trigger *trigger;
>   	struct hid_sensor_hub_attribute_info poll;
>   	struct hid_sensor_hub_attribute_info report_state;
>

