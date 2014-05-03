Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54060 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbaECTep (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 15:34:45 -0400
Message-ID: <53654533.80109@kernel.org>
Date: Sat, 03 May 2014 20:36:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 05/16] iio: hid-sensors: ALS: adjust scale and offset
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1397863356-2470-5-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-5-git-send-email-srinivas.pandruvada@linux.intel.com>
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
>   drivers/iio/light/hid-sensor-als.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
> index 621541f..39b50be 100644
> --- a/drivers/iio/light/hid-sensor-als.c
> +++ b/drivers/iio/light/hid-sensor-als.c
> @@ -37,6 +37,10 @@ struct als_state {
>   	struct hid_sensor_common common_attributes;
>   	struct hid_sensor_hub_attribute_info als_illum;
>   	u32 illum;
> +	int scale_pre_decml;
> +	int scale_post_decml;
> +	int scale_precision;
> +	int value_offset;
>   };
>
>   /* Channel definitions */
> @@ -102,12 +106,12 @@ static int als_read_raw(struct iio_dev *indio_dev,
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SCALE:
> -		*val = als_state->als_illum.units;
> -		ret_type = IIO_VAL_INT;
> +		*val = als_state->scale_pre_decml;
> +		*val2 = als_state->scale_post_decml;
> +		ret_type = als_state->scale_precision;
>   		break;
>   	case IIO_CHAN_INFO_OFFSET:
> -		*val = hid_sensor_convert_exponent(
> -				als_state->als_illum.unit_expo);
> +		*val = als_state->value_offset;
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -229,6 +233,11 @@ static int als_parse_report(struct platform_device *pdev,
>   	dev_dbg(&pdev->dev, "als %x:%x\n", st->als_illum.index,
>   			st->als_illum.report_id);
>
> +	st->scale_precision = hid_sensor_format_scale(
> +				HID_USAGE_SENSOR_ALS,
> +				&st->als_illum,
> +				&st->scale_pre_decml, &st->scale_post_decml);
> +
>   	/* Set Sensitivity field ids, when there is no individual modifier */
>   	if (st->common_attributes.sensitivity.index < 0) {
>   		sensor_hub_input_get_attribute_info(hsdev,
>

