Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54069 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbaECTfR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 15:35:17 -0400
Message-ID: <53654553.30107@kernel.org>
Date: Sat, 03 May 2014 20:36:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 06/16] iio: hid-sensors: Compass 3D: adjust scale and
 offset
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1397863356-2470-6-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-6-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/14 00:22, Srinivas Pandruvada wrote:
> Using units and unit exponent to calculate scale which is compliant
> to IIO ABI.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/magnetometer/hid-sensor-magn-3d.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index 6d162b7..131ced0 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -42,6 +42,10 @@ struct magn_3d_state {
>   	struct hid_sensor_common common_attributes;
>   	struct hid_sensor_hub_attribute_info magn[MAGN_3D_CHANNEL_MAX];
>   	u32 magn_val[MAGN_3D_CHANNEL_MAX];
> +	int scale_pre_decml;
> +	int scale_post_decml;
> +	int scale_precision;
> +	int value_offset;
>   };
>
>   static const u32 magn_3d_addresses[MAGN_3D_CHANNEL_MAX] = {
> @@ -124,12 +128,12 @@ static int magn_3d_read_raw(struct iio_dev *indio_dev,
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SCALE:
> -		*val = magn_state->magn[CHANNEL_SCAN_INDEX_X].units;
> -		ret_type = IIO_VAL_INT;
> +		*val = magn_state->scale_pre_decml;
> +		*val2 = magn_state->scale_post_decml;
> +		ret_type = magn_state->scale_precision;
>   		break;
>   	case IIO_CHAN_INFO_OFFSET:
> -		*val = hid_sensor_convert_exponent(
> -			magn_state->magn[CHANNEL_SCAN_INDEX_X].unit_expo);
> +		*val = magn_state->value_offset;
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -263,6 +267,11 @@ static int magn_3d_parse_report(struct platform_device *pdev,
>   			st->magn[1].index, st->magn[1].report_id,
>   			st->magn[2].index, st->magn[2].report_id);
>
> +	st->scale_precision = hid_sensor_format_scale(
> +				HID_USAGE_SENSOR_COMPASS_3D,
> +				&st->magn[CHANNEL_SCAN_INDEX_X],
> +				&st->scale_pre_decml, &st->scale_post_decml);
> +
>   	/* Set Sensitivity field ids, when there is no individual modifier */
>   	if (st->common_attributes.sensitivity.index < 0) {
>   		sensor_hub_input_get_attribute_info(hsdev,
>

