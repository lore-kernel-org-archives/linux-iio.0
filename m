Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54970 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab3KEVza (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Nov 2013 16:55:30 -0500
Message-ID: <52797797.10604@kernel.org>
Date: Tue, 05 Nov 2013 22:56:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 1/8] iio: hid_Sensors: fix crash during trigger unregister
References: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1383173333-18618-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/30/13 22:48, Srinivas Pandruvada wrote:
> We can't store the trigger instance created by iio_trigger_alloc, in
> trig field of iio_device structure. This needs to be stored in the
> driver private data. Othewise it can result in crash during module
> unload. Hence created a trig_ptr in the common data structure
> for each HID sensor IIO driver and storing here.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git

Will be a little while before this hits mainline because of the unusual merge window
timings.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c             | 5 +++--
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 9 ++++-----
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.h | 2 +-
>  drivers/iio/gyro/hid-sensor-gyro-3d.c               | 5 +++--
>  drivers/iio/light/hid-sensor-als.c                  | 5 +++--
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c       | 5 +++--
>  include/linux/hid-sensor-hub.h                      | 3 +++
>  7 files changed, 20 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index 46d22f3..7fbe136 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -349,7 +349,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&accel_state->common_attributes);
>  error_unreg_buffer_funcs:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_free_dev_mem:
> @@ -362,10 +362,11 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
>  {
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct accel_3d_state *accel_state = iio_priv(indio_dev);
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&accel_state->common_attributes);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	kfree(indio_dev->channels);
>  
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index dbc9141..363f8d2 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -71,11 +71,10 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  	return 0;
>  }
>  
> -void hid_sensor_remove_trigger(struct iio_dev *indio_dev)
> +void hid_sensor_remove_trigger(struct hid_sensor_common *attrb)
>  {
> -	iio_trigger_unregister(indio_dev->trig);
> -	iio_trigger_free(indio_dev->trig);
> -	indio_dev->trig = NULL;
> +	iio_trigger_unregister(attrb->trigger);
> +	iio_trigger_free(attrb->trigger);
>  }
>  EXPORT_SYMBOL(hid_sensor_remove_trigger);
>  
> @@ -106,7 +105,7 @@ int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  		dev_err(&indio_dev->dev, "Trigger Register Failed\n");
>  		goto error_free_trig;
>  	}
> -	indio_dev->trig = trig;
> +	indio_dev->trig = attrb->trigger = trig;
>  
>  	return ret;
>  
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> index 9a87314..ca02f78 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.h
> @@ -21,6 +21,6 @@
>  
>  int hid_sensor_setup_trigger(struct iio_dev *indio_dev, const char *name,
>  				struct hid_sensor_common *attrb);
> -void hid_sensor_remove_trigger(struct iio_dev *indio_dev);
> +void hid_sensor_remove_trigger(struct hid_sensor_common *attrb);
>  
>  #endif
> diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> index c688d97..74bbed7 100644
> --- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
> +++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
> @@ -347,7 +347,7 @@ static int hid_gyro_3d_probe(struct platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&gyro_state->common_attributes);
>  error_unreg_buffer_funcs:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_free_dev_mem:
> @@ -360,10 +360,11 @@ static int hid_gyro_3d_remove(struct platform_device *pdev)
>  {
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct gyro_3d_state *gyro_state = iio_priv(indio_dev);
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_GYRO_3D);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&gyro_state->common_attributes);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	kfree(indio_dev->channels);
>  
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index e59d00c..c104bda 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -313,7 +313,7 @@ static int hid_als_probe(struct platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&als_state->common_attributes);
>  error_unreg_buffer_funcs:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_free_dev_mem:
> @@ -326,10 +326,11 @@ static int hid_als_remove(struct platform_device *pdev)
>  {
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct als_state *als_state = iio_priv(indio_dev);
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ALS);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&als_state->common_attributes);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	kfree(indio_dev->channels);
>  
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index a98460b..ff7b9da 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -350,7 +350,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
>  error_iio_unreg:
>  	iio_device_unregister(indio_dev);
>  error_remove_trigger:
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&magn_state->common_attributes);
>  error_unreg_buffer_funcs:
>  	iio_triggered_buffer_cleanup(indio_dev);
>  error_free_dev_mem:
> @@ -363,10 +363,11 @@ static int hid_magn_3d_remove(struct platform_device *pdev)
>  {
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct magn_3d_state *magn_state = iio_priv(indio_dev);
>  
>  	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
>  	iio_device_unregister(indio_dev);
> -	hid_sensor_remove_trigger(indio_dev);
> +	hid_sensor_remove_trigger(&magn_state->common_attributes);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	kfree(indio_dev->channels);
>  
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index a265af2..206a2af 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -21,6 +21,8 @@
>  
>  #include <linux/hid.h>
>  #include <linux/hid-sensor-ids.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger.h>
>  
>  /**
>   * struct hid_sensor_hub_attribute_info - Attribute info
> @@ -184,6 +186,7 @@ struct hid_sensor_common {
>  	struct platform_device *pdev;
>  	unsigned usage_id;
>  	bool data_ready;
> +	struct iio_trigger *trigger;
>  	struct hid_sensor_hub_attribute_info poll;
>  	struct hid_sensor_hub_attribute_info report_state;
>  	struct hid_sensor_hub_attribute_info power_state;
> 
