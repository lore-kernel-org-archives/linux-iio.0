Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47161 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753174AbbGSM5q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 19 Jul 2015 08:57:46 -0400
Message-ID: <55AB9EC7.6030909@kernel.org>
Date: Sun, 19 Jul 2015 13:57:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Reyad Attiyat <reyad.attiyat@gmail.com>,
	srinivas.pandruvada@linux.intel.com
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hid_sensor_magn_3d: Fix scale for rotation from north
 channels
References: <1436946198-10395-1-git-send-email-reyad.attiyat@gmail.com>
In-Reply-To: <1436946198-10395-1-git-send-email-reyad.attiyat@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/07/15 08:43, Reyad Attiyat wrote:
> Some devices on a hid sensor hub will not report a measurement unit. This
> causes the rotation from north channels to have an incorrect scale value.
> This patch will set the unit to degrees if the maximum value is 360 when
> the unit exponent value is accounted for.
> 
> Signed-off-by: Reyad Attiyat <reyad.attiyat@gmail.com>
Hmm. Ah well, another quirk to work around I guess.

Looks fine to me.  Would like an Ack from Srinivas though.
Also this is a bit large and invasive to send on as a fix (as it's not
a regression) so will need to wait for the next merge window.
Can mark it as stable material though so it will filter back through
in the long run.

If there are lots of devices being broken by this, let me know and maybe
we will try and see if Greg is happy to pass it on to Linus.

Jonathan

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
> 

