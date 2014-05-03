Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54077 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753197AbaECTfp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 15:35:45 -0400
Message-ID: <5365456E.20703@kernel.org>
Date: Sat, 03 May 2014 20:37:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 08/16] iio: hid-sensors: Pressure:  adjust scale and offset
References: <1397863356-2470-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1397863356-2470-8-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1397863356-2470-8-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/04/14 00:22, Srinivas Pandruvada wrote:
> Using units and unit exponent to calculate scale which is compliant
> to IIO ABI.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied
> ---
>   drivers/iio/pressure/hid-sensor-press.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index e0e6409..ff69da4 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -36,6 +36,10 @@ struct press_state {
>   	struct hid_sensor_common common_attributes;
>   	struct hid_sensor_hub_attribute_info press_attr;
>   	u32 press_data;
> +	int scale_pre_decml;
> +	int scale_post_decml;
> +	int scale_precision;
> +	int value_offset;
>   };
>
>   /* Channel definitions */
> @@ -102,12 +106,12 @@ static int press_read_raw(struct iio_dev *indio_dev,
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SCALE:
> -		*val = press_state->press_attr.units;
> -		ret_type = IIO_VAL_INT;
> +		*val = press_state->scale_pre_decml;
> +		*val2 = press_state->scale_post_decml;
> +		ret_type = press_state->scale_precision;
>   		break;
>   	case IIO_CHAN_INFO_OFFSET:
> -		*val = hid_sensor_convert_exponent(
> -				press_state->press_attr.unit_expo);
> +		*val = press_state->value_offset;
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SAMP_FREQ:
> @@ -229,6 +233,11 @@ static int press_parse_report(struct platform_device *pdev,
>   	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
>   			st->press_attr.report_id);
>
> +	st->scale_precision = hid_sensor_format_scale(
> +				HID_USAGE_SENSOR_PRESSURE,
> +				&st->press_attr,
> +				&st->scale_pre_decml, &st->scale_post_decml);
> +
>   	/* Set Sensitivity field ids, when there is no individual modifier */
>   	if (st->common_attributes.sensitivity.index < 0) {
>   		sensor_hub_input_get_attribute_info(hsdev,
>

