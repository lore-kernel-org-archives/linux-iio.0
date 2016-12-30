Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50409 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbcL3K2K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 05:28:10 -0500
Subject: Re: [RFC PATCH 2/2] iio: Add gravity sensor support
To: Song Hongyan <hongyan.song@intel.com>, linux-iio@vger.kernel.org
References: <1481105675-27431-1-git-send-email-hongyan.song@intel.com>
 <1481105675-27431-2-git-send-email-hongyan.song@intel.com>
Cc: jikos@kernel.org, srinivas.pandruvada@intel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <91153b54-5728-b69d-8e9b-e09825df203b@kernel.org>
Date: Fri, 30 Dec 2016 10:28:07 +0000
MIME-Version: 1.0
In-Reply-To: <1481105675-27431-2-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/12/16 10:14, Song Hongyan wrote:
> Gravity sensor and accelerometer have similar channels and
> share channel usage ids. So the most of the code for accel_3d
> can be reused.
I would like to have seen a reference to the source for the IDs in here. Took
me a little while to confirm these were no officially assigned (rather than in the
reserved space).  I found them in:
http://www.usb.org/developers/hidpage/HUTRR59_-_Usages_for_Wearables.pdf

Also, perhaps a reference to a device that supports this?  Would be useful to give
us an idea of how new it is for the purposes of distribution kernel back ports etc.

I'd also like an Ack for this from Srinivas if possible.

These are computed values presumably using various other sensors to separate out the
gravity - I guess putting it in the acceleration modules makes sense rather than anywhere
else.

So looks fine to me. Only real request for future on this sort of patch is to provide
a little more background information.

Thanks,

Jonathan
> 
> Signed-off-by: Song Hongyan <hongyan.song@intel.com>
> ---
>  drivers/iio/accel/hid-sensor-accel-3d.c | 74 +++++++++++++++++++++++++++------
>  include/linux/hid-sensor-ids.h          |  3 ++
>  2 files changed, 64 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
> index ab1e238..9edd574 100644
> --- a/drivers/iio/accel/hid-sensor-accel-3d.c
> +++ b/drivers/iio/accel/hid-sensor-accel-3d.c
> @@ -90,6 +90,41 @@ struct accel_3d_state {
>  	}
>  };
>  
> +/* Channel definitions */
> +static const struct iio_chan_spec gravity_channels[] = {
> +	{
> +		.type = IIO_GRAVITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.scan_index = CHANNEL_SCAN_INDEX_X,
> +	}, {
> +		.type = IIO_GRAVITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.scan_index = CHANNEL_SCAN_INDEX_Y,
> +	}, {
> +		.type = IIO_GRAVITY,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Z,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.scan_index = CHANNEL_SCAN_INDEX_Z,
> +	}
> +};
> +
>  /* Adjust channel real bits based on report descriptor */
>  static void accel_3d_adjust_channel_bit_mask(struct iio_chan_spec *channels,
>  						int channel, int size)
> @@ -111,6 +146,8 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>  	int report_id = -1;
>  	u32 address;
>  	int ret_type;
> +	struct hid_sensor_hub_device *hsdev =
> +					accel_state->common_attributes.hsdev;
>  
>  	*val = 0;
>  	*val2 = 0;
> @@ -122,8 +159,7 @@ static int accel_3d_read_raw(struct iio_dev *indio_dev,
>  		if (report_id >= 0)
>  			*val = sensor_hub_input_attr_get_raw_value(
>  					accel_state->common_attributes.hsdev,
> -					HID_USAGE_SENSOR_ACCEL_3D, address,
> -					report_id,
> +					hsdev->usage, address, report_id,
>  					SENSOR_HUB_SYNC);
>  		else {
>  			*val = 0;
> @@ -272,7 +308,7 @@ static int accel_3d_parse_report(struct platform_device *pdev,
>  			st->accel[2].index, st->accel[2].report_id);
>  
>  	st->scale_precision = hid_sensor_format_scale(
> -				HID_USAGE_SENSOR_ACCEL_3D,
> +				hsdev->usage,
>  				&st->accel[CHANNEL_SCAN_INDEX_X],
>  				&st->scale_pre_decml, &st->scale_post_decml);
>  
> @@ -295,9 +331,12 @@ static int accel_3d_parse_report(struct platform_device *pdev,
>  static int hid_accel_3d_probe(struct platform_device *pdev)
>  {
>  	int ret = 0;
> -	static const char *name = "accel_3d";
> +	static const char *name;
>  	struct iio_dev *indio_dev;
>  	struct accel_3d_state *accel_state;
> +	const struct iio_chan_spec *channel_spec;
> +	int channel_size;
> +
>  	struct hid_sensor_hub_device *hsdev = pdev->dev.platform_data;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev,
> @@ -311,24 +350,30 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  	accel_state->common_attributes.hsdev = hsdev;
>  	accel_state->common_attributes.pdev = pdev;
>  
> -	ret = hid_sensor_parse_common_attributes(hsdev,
> -					HID_USAGE_SENSOR_ACCEL_3D,
> +	if (hsdev->usage == HID_USAGE_SENSOR_ACCEL_3D) {
> +		name = "accel_3d";
> +		channel_spec = accel_3d_channels;
> +		channel_size = sizeof(accel_3d_channels);
> +	} else {
> +		name = "gravity";
> +		channel_spec = gravity_channels;
> +		channel_size = sizeof(gravity_channels);
> +	}
> +	ret = hid_sensor_parse_common_attributes(hsdev, hsdev->usage,
>  					&accel_state->common_attributes);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup common attributes\n");
>  		return ret;
>  	}
> +	indio_dev->channels = kmemdup(channel_spec, channel_size, GFP_KERNEL);
>  
> -	indio_dev->channels = kmemdup(accel_3d_channels,
> -				      sizeof(accel_3d_channels), GFP_KERNEL);
>  	if (!indio_dev->channels) {
>  		dev_err(&pdev->dev, "failed to duplicate channels\n");
>  		return -ENOMEM;
>  	}
> -
>  	ret = accel_3d_parse_report(pdev, hsdev,
> -				    (struct iio_chan_spec *)indio_dev->channels,
> -				    HID_USAGE_SENSOR_ACCEL_3D, accel_state);
> +				(struct iio_chan_spec *)indio_dev->channels,
> +				hsdev->usage, accel_state);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to setup attributes\n");
>  		goto error_free_dev_mem;
> @@ -363,7 +408,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
>  	accel_state->callbacks.send_event = accel_3d_proc_event;
>  	accel_state->callbacks.capture_sample = accel_3d_capture_sample;
>  	accel_state->callbacks.pdev = pdev;
> -	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D,
> +	ret = sensor_hub_register_callback(hsdev, hsdev->usage,
>  					&accel_state->callbacks);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "callback reg failed\n");
> @@ -390,7 +435,7 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct accel_3d_state *accel_state = iio_priv(indio_dev);
>  
> -	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_ACCEL_3D);
> +	sensor_hub_remove_callback(hsdev, hsdev->usage);
>  	iio_device_unregister(indio_dev);
>  	hid_sensor_remove_trigger(&accel_state->common_attributes);
>  	iio_triggered_buffer_cleanup(indio_dev);
> @@ -404,6 +449,9 @@ static int hid_accel_3d_remove(struct platform_device *pdev)
>  		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>  		.name = "HID-SENSOR-200073",
>  	},
> +	{	/* gravity sensor */
> +		.name = "HID-SENSOR-20007b",
> +	},
>  	{ /* sentinel */ }
>  };
>  MODULE_DEVICE_TABLE(platform, hid_accel_3d_ids);
> diff --git a/include/linux/hid-sensor-ids.h b/include/linux/hid-sensor-ids.h
> index f2ee90a..b6778fd2 100644
> --- a/include/linux/hid-sensor-ids.h
> +++ b/include/linux/hid-sensor-ids.h
> @@ -52,6 +52,9 @@
>  #define HID_USAGE_SENSOR_ANGL_VELOCITY_Y_AXIS			0x200458
>  #define HID_USAGE_SENSOR_ANGL_VELOCITY_Z_AXIS			0x200459
>  
> +/* Gravity vector */
> +#define HID_USAGE_SENSOR_GRAVITY_VECTOR				0x20007B
> +
>  /* ORIENTATION: Compass 3D: (200083) */
>  #define HID_USAGE_SENSOR_COMPASS_3D				0x200083
>  #define HID_USAGE_SENSOR_DATA_ORIENTATION			0x200470
> 

