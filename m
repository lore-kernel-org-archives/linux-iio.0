Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52261 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbcL3RHc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 12:07:32 -0500
Subject: Re: [PATCH] iio: light: hid-sensor-als: Add duplicate IIO_LIGHT
 channel
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <1481838501-3033-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, linux-iio@vger.kernel.org,
        "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6e463a00-b742-33de-ac16-a0a443dccd5e@kernel.org>
Date: Fri, 30 Dec 2016 17:07:30 +0000
MIME-Version: 1.0
In-Reply-To: <1481838501-3033-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/12/16 21:48, Srinivas Pandruvada wrote:
> From: "Kweh, Hock Leong" <hock.leong.kweh@intel.com>
> 
> There is one light sensor type defined in the sensor hub specification,
> which has one Illuminance field. It doesn't distinguish between ambient
> light sensor or color sensor. Currently it is presented as IIO_INTENSITY
> channel. There are some user spaces specifically looking for IIO_LIGHT
> channel.
> To satisfy such user spaces this change also add a duplicate IIO_LIGHT
> channel. The units of measurement of Illuminance field is Lux, so it is
> still compatible to IIO ABI.
> 
> Signed-off-by: Kweh, Hock Leong <hock.leong.kweh@intel.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/light/hid-sensor-als.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 8bb1f90..059d964 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -31,13 +31,17 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include "../common/hid-sensors/hid-sensor-trigger.h"
>  
> -#define CHANNEL_SCAN_INDEX_ILLUM 0
> +enum {
> +	CHANNEL_SCAN_INDEX_INTENSITY = 0,
> +	CHANNEL_SCAN_INDEX_ILLUM = 1,
> +	CHANNEL_SCAN_INDEX_MAX
> +};
>  
>  struct als_state {
>  	struct hid_sensor_hub_callbacks callbacks;
>  	struct hid_sensor_common common_attributes;
>  	struct hid_sensor_hub_attribute_info als_illum;
> -	u32 illum;
> +	u32 illum[CHANNEL_SCAN_INDEX_MAX];
>  	int scale_pre_decml;
>  	int scale_post_decml;
>  	int scale_precision;
> @@ -55,6 +59,15 @@ static const struct iio_chan_spec als_channels[] = {
>  		BIT(IIO_CHAN_INFO_SCALE) |
>  		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
>  		BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.scan_index = CHANNEL_SCAN_INDEX_INTENSITY,
> +	},
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
> +		BIT(IIO_CHAN_INFO_SCALE) |
> +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +		BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.scan_index = CHANNEL_SCAN_INDEX_ILLUM,
>  	}
>  };
> @@ -86,6 +99,7 @@ static int als_read_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case 0:
>  		switch (chan->scan_index) {
> +		case  CHANNEL_SCAN_INDEX_INTENSITY:
>  		case  CHANNEL_SCAN_INDEX_ILLUM:
>  			report_id = als_state->als_illum.report_id;
>  			address =
> @@ -202,10 +216,12 @@ static int als_capture_sample(struct hid_sensor_hub_device *hsdev,
>  	struct iio_dev *indio_dev = platform_get_drvdata(priv);
>  	struct als_state *als_state = iio_priv(indio_dev);
>  	int ret = -EINVAL;
> +	u32 sample_data = *(u32 *)raw_data;
>  
>  	switch (usage_id) {
>  	case HID_USAGE_SENSOR_LIGHT_ILLUM:
> -		als_state->illum = *(u32 *)raw_data;
> +		als_state->illum[CHANNEL_SCAN_INDEX_INTENSITY] = sample_data;
> +		als_state->illum[CHANNEL_SCAN_INDEX_ILLUM] = sample_data;
>  		ret = 0;
>  		break;
>  	default:
> @@ -230,6 +246,8 @@ static int als_parse_report(struct platform_device *pdev,
>  			&st->als_illum);
>  	if (ret < 0)
>  		return ret;
> +	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_INTENSITY,
> +				    st->als_illum.size);
>  	als_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_ILLUM,
>  					st->als_illum.size);
>  
> 

