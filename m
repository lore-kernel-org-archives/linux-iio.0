Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <1478180219.27477.4.camel@linux.intel.com>
Subject: Re: [PATCH] iio: common: hid-sensors: change the precision of scale
 values
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Ooi, Joyce" <joyce.ooi@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Song Hongyan <hongyan.song@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
  Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>,  linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kweh Hock Leong <hock.leong.kweh@intel.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>, Lay Kuan Loon
 <kuan.loon.lay@intel.com>
Date: Thu, 03 Nov 2016 06:36:59 -0700
In-Reply-To: <1478166093-23109-1-git-send-email-joyce.ooi@intel.com>
References: <1478166093-23109-1-git-send-email-joyce.ooi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Thu, 2016-11-03 at 17:41 +0800, Ooi, Joyce wrote:
> Extension of the scale precision is needed as there are some scale
> values
> that exceed 6 decimal points precision. For example, the scale for
> gyroscope from degrees/second to radians/second is 0.017453. If the
> unit
> exponent for gyroscope is -5, it will be
> 0.017453 -> exp: -5 -> 0.00000017453
> 
> However, because the decimal precision is up to 6, the mentioned
> scale
> value will be truncated to 0.000000. To avoid this, changes are made
> to
> extend the precision to 9 decimal points precision.
This change is already submitted by
Song Hongyan <hongyan.song@intel.com>

Thanks,
Srinivas
> 
> Signed-off-by: Ooi, Joyce <joyce.ooi@intel.com>
> ---
>  .../iio/common/hid-sensors/hid-sensor-attributes.c | 65 +++++++++++-
> ----------
>  1 file changed, 33 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> index dc33c1d..c1f8c22 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
> @@ -30,34 +30,34 @@
>  	u32 usage_id;
>  	int unit; /* 0 for default others from HID sensor spec */
>  	int scale_val0; /* scale, whole number */
> -	int scale_val1; /* scale, fraction in micros */
> +	int scale_val1; /* scale, fraction in nanos */
>  } unit_conversion[] = {
> -	{HID_USAGE_SENSOR_ACCEL_3D, 0, 9, 806650},
> +	{HID_USAGE_SENSOR_ACCEL_3D, 0, 9, 806650000},
>  	{HID_USAGE_SENSOR_ACCEL_3D,
>  		HID_USAGE_SENSOR_UNITS_METERS_PER_SEC_SQRD, 1, 0},
>  	{HID_USAGE_SENSOR_ACCEL_3D,
> -		HID_USAGE_SENSOR_UNITS_G, 9, 806650},
> +		HID_USAGE_SENSOR_UNITS_G, 9, 806650000},
>  
> -	{HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453},
> +	{HID_USAGE_SENSOR_GYRO_3D, 0, 0, 17453293},
>  	{HID_USAGE_SENSOR_GYRO_3D,
>  		HID_USAGE_SENSOR_UNITS_RADIANS_PER_SECOND, 1, 0},
>  	{HID_USAGE_SENSOR_GYRO_3D,
> -		HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND, 0,
> 17453},
> +		HID_USAGE_SENSOR_UNITS_DEGREES_PER_SECOND, 0,
> 17453293},
>  
> -	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000},
> +	{HID_USAGE_SENSOR_COMPASS_3D, 0, 0, 1000000},
>  	{HID_USAGE_SENSOR_COMPASS_3D, HID_USAGE_SENSOR_UNITS_GAUSS,
> 1, 0},
>  
> -	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453},
> +	{HID_USAGE_SENSOR_INCLINOMETER_3D, 0, 0, 17453293},
>  	{HID_USAGE_SENSOR_INCLINOMETER_3D,
> -		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453},
> +		HID_USAGE_SENSOR_UNITS_DEGREES, 0, 17453293},
>  	{HID_USAGE_SENSOR_INCLINOMETER_3D,
>  		HID_USAGE_SENSOR_UNITS_RADIANS, 1, 0},
>  
>  	{HID_USAGE_SENSOR_ALS, 0, 1, 0},
>  	{HID_USAGE_SENSOR_ALS, HID_USAGE_SENSOR_UNITS_LUX, 1, 0},
>  
> -	{HID_USAGE_SENSOR_PRESSURE, 0, 100, 0},
> -	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL,
> 0, 1000},
> +	{HID_USAGE_SENSOR_PRESSURE, 0, 100000, 0},
> +	{HID_USAGE_SENSOR_PRESSURE, HID_USAGE_SENSOR_UNITS_PASCAL,
> 0, 1000000},
>  };
>  
>  static int pow_10(unsigned power)
> @@ -266,16 +266,16 @@ int hid_sensor_write_raw_hyst_value(struct
> hid_sensor_common *st,
>  /*
>   * This fuction applies the unit exponent to the scale.
>   * For example:
> - * 9.806650 ->exp:2-> val0[980]val1[665000]
> - * 9.000806 ->exp:2-> val0[900]val1[80600]
> - * 0.174535 ->exp:2-> val0[17]val1[453500]
> - * 1.001745 ->exp:0-> val0[1]val1[1745]
> - * 1.001745 ->exp:2-> val0[100]val1[174500]
> - * 1.001745 ->exp:4-> val0[10017]val1[450000]
> - * 9.806650 ->exp:-2-> val0[0]val1[98066]
> + * 9.806650000 ->exp:2-> val0[980]val1[665000000]
> + * 9.000806000 ->exp:2-> val0[900]val1[80600000]
> + * 0.17453293 ->exp:2-> val0[17]val1[453293000]
> + * 1.00174532 ->exp:0-> val0[1]val1[1745320]
> + * 1.00174532 ->exp:2-> val0[100]val1[174532000]
> + * 1.00174532 ->exp:4-> val0[10017]val1[453200000]
> + * 9.80665000 ->exp:-2-> val0[0]val1[98066500]
>   */
> -static void adjust_exponent_micro(int *val0, int *val1, int scale0,
> -				  int scale1, int exp)
> +static void adjust_exponent_nano(int *val0, int *val1, int scale0,
> +				 int scale1, int exp)
>  {
>  	int i;
>  	int x;
> @@ -285,32 +285,32 @@ static void adjust_exponent_micro(int *val0,
> int *val1, int scale0,
>  	if (exp > 0) {
>  		*val0 = scale0 * pow_10(exp);
>  		res = 0;
> -		if (exp > 6) {
> +		if (exp > 9) {
>  			*val1 = 0;
>  			return;
>  		}
>  		for (i = 0; i < exp; ++i) {
> -			x = scale1 / pow_10(5 - i);
> +			x = scale1 / pow_10(8 - i);
>  			res += (pow_10(exp - 1 - i) * x);
> -			scale1 = scale1 % pow_10(5 - i);
> +			scale1 = scale1 % pow_10(8 - i);
>  		}
>  		*val0 += res;
>  			*val1 = scale1 * pow_10(exp);
>  	} else if (exp < 0) {
>  		exp = abs(exp);
> -		if (exp > 6) {
> +		if (exp > 9) {
>  			*val0 = *val1 = 0;
>  			return;
>  		}
>  		*val0 = scale0 / pow_10(exp);
>  		rem = scale0 % pow_10(exp);
>  		res = 0;
> -		for (i = 0; i < (6 - exp); ++i) {
> -			x = scale1 / pow_10(5 - i);
> -			res += (pow_10(5 - exp - i) * x);
> -			scale1 = scale1 % pow_10(5 - i);
> +		for (i = 0; i < (9 - exp); ++i) {
> +			x = scale1 / pow_10(8 - i);
> +			res += (pow_10(8 - exp - i) * x);
> +			scale1 = scale1 % pow_10(8 - i);
>  		}
> -		*val1 = rem * pow_10(6 - exp) + res;
> +		*val1 = rem * pow_10(9 - exp) + res;
>  	} else {
>  		*val0 = scale0;
>  		*val1 = scale1;
> @@ -332,14 +332,15 @@ int hid_sensor_format_scale(u32 usage_id,
>  			unit_conversion[i].unit == attr_info->units) 
> {
>  			exp  = hid_sensor_convert_exponent(
>  						attr_info-
> >unit_expo);
> -			adjust_exponent_micro(val0, val1,
> -					unit_conversion[i].scale_val
> 0,
> -					unit_conversion[i].scale_val
> 1, exp);
> +			adjust_exponent_nano(val0, val1,
> +					     unit_conversion[i].scal
> e_val0,
> +					     unit_conversion[i].scal
> e_val1,
> +					     exp);
>  			break;
>  		}
>  	}
>  
> -	return IIO_VAL_INT_PLUS_MICRO;
> +	return IIO_VAL_INT_PLUS_NANO;
>  }
>  EXPORT_SYMBOL(hid_sensor_format_scale);
>  
