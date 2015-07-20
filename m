Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1437409526.2377.145.camel@spandruv-DESK3.jf.intel.com>
Subject: Re: [PATCH] hid_sensor_magn_3d: Fix scale for rotation from north
 channels
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 20 Jul 2015 09:25:26 -0700
In-Reply-To: <1436946198-10395-1-git-send-email-reyad.attiyat@gmail.com>
References: <1436946198-10395-1-git-send-email-reyad.attiyat@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Reyad,
On Wed, 2015-07-15 at 02:43 -0500, Reyad Attiyat wrote:
> Some devices on a hid sensor hub will not report a measurement unit. This
> causes the rotation from north channels to have an incorrect scale value.
> This patch will set the unit to degrees if the maximum value is 360 when
> the unit exponent value is accounted for.
> 
Somebody pointed this to me this and supposed to send me patch. 
The issue here is that for compass we only had flux values were
presented. So the scale has to only account for flux units like Gauss.

When you added tilt using rotation attributes, there will be two
separate iio units (radian for tilt and gauss for flux). Although we
have two attributes, both are returning same, which is a problem. So we
need to add the correct return value for in_rot_scale, which are in
radians. On some platforms both flux and tilt attributes are present.

So I think you should just need 
{HID_USAGE_SENSOR_COMPASS_3D,
		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453},

to convert from HID sensor default unit degrees to radian for IIO. The
hid_sensor_format_scale will take care of unit exponents.

In addition we have to call for tilt separately
st->scale_precision = 	hid_sensor_format_scale(
HID_USAGE_SENSOR_COMPASS_3D,
&st->magn[CHANNEL_SCAN_INDEX_NORTH_MAGN_TILT_COMP],
		&st->scale_pre_tilt_decml, &st->scale_post_tilt_decml);

and return different values for raw read on IIO_CHAN_INFO_SCALE.

I think this will address issue.

Thanks,
Srinivas

> Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
> ---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c | 19 ++++++++++++++++
>  drivers/iio/magnetometer/hid-sensor-magn-3d.c      | 26 +++++++++++++++++++++-
>  include/linux/hid-sensor-hub.h                     |  4 ++++
>  3 files changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index e81f434..3c79847 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -46,6 +46,7 @@ static struct {
>  
>  	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000},
>  	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS, 1, 0},
> +	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_DEGREES, 1, 0},
>  
>  	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453},
>  	{HID_USAGE_SENSOR_INCLINOMETER_3D,
> @@ -317,6 +318,24 @@ static void adjust_exponent_micro(int *val0, int *val1, int scale0,
>  	}
>  }
>  
> +void hid_sensor_get_unit_expo_fraction(
> +		struct hid_sensor_hub_attribute_info *attr_info,
> +		int *num, int *denom)
> +{
> +	s32 exp = hid_sensor_convert_exponent(attr_info->unit_expo);
> +
> +	if (exp == 0) {
> +		*num = *denom = 1;
> +	} else if (exp < 0) {
> +		*num = 1;
> +		*denom = pow_10(abs(exp));
> +	} else if (exp > 0) {
> +		*num = pow_10(exp);
> +		*denom = 1;
> +	}
> +}
> +EXPORT_SYMBOL(hid_sensor_get_unit_expo_fraction);
> +
>  int hid_sensor_format_scale(u32 usage_id,
>  			struct hid_sensor_hub_attribute_info *attr_info,
>  			int *val0, int *val1)
> diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> index d8a0c8d..173d2f5 100644
> --- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> +++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
> @@ -311,6 +311,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
>  	int i;
>  	int attr_count = 0;
>  	struct iio_chan_spec *_channels;
> +	struct hid_sensor_hub_attribute_info *first_channel_attr_info;
>  
>  	/* Scan for each usage attribute supported */
>  	for (i = 0; i < MAGN_3D_CHANNEL_MAX; i++) {
> @@ -389,9 +390,32 @@ static int magn_3d_parse_report(struct platform_device *pdev,
>  	dev_dbg(&pdev->dev, "magn_3d Setup %d IIO channels\n",
>  			*chan_count);
>  
> +	first_channel_attr_info = &(st->magn[_channels[0].address]);
> +
> +	/* Try and set unit based off exponent, logical min and max */
> +	if (!first_channel_attr_info->units) {
> +		int num, denom;
> +		s32 log_min = first_channel_attr_info->logical_minimum;
> +		s32 log_max = first_channel_attr_info->logical_maximum;
> +
> +		dev_dbg(&pdev->dev, "magn_3d Units not set. Unit Expo %d Logical Min: %d Max: %d\n",
> +					first_channel_attr_info->unit_expo,
> +					log_min, log_max);
> +
> +		hid_sensor_get_unit_expo_fraction(first_channel_attr_info,
> +						&num, &denom);
> +
> +		/* Check for unit Degrees */
> +		if (log_min == 0 && num == 1 && (log_max == 360 * denom)) {
> +			first_channel_attr_info->units =
> +					HID_USAGE_SENSOR_UNITS_DEGREES;
> +			dev_dbg(&pdev->dev, "magn_3d Set units to degrees.");
> +		}
> +
> +	}
>  	st->scale_precision = hid_sensor_format_scale(
>  				HID_USAGE_SENSOR_COMPASS_3D,
> -				&st->magn[CHANNEL_SCAN_INDEX_X],
> +				first_channel_attr_info,
>  				&st->scale_pre_decml, &st->scale_post_decml);
>  
>  	/* Set Sensitivity field ids, when there is no individual modifier */
> diff --git a/include/linux/hid-sensor-hub.h b/include/linux/hid-sensor-hub.h
> index 0042bf3..627fd68 100644
> --- a/include/linux/hid-sensor-hub.h
> +++ b/include/linux/hid-sensor-hub.h
> @@ -267,6 +267,10 @@ int hid_sensor_format_scale(u32 usage_id,
>  			    struct hid_sensor_hub_attribute_info *attr_info,
>  			    int *val0, int *val1);
>  
> +void hid_sensor_get_unit_expo_fraction(
> +			struct hid_sensor_hub_attribute_info *attr_info,
> +			int *num, int *denom);
> +
>  s32 hid_sensor_read_poll_value(struct hid_sensor_common *st);
>  
>  #endif
