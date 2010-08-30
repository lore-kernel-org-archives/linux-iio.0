Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:45089 "EHLO
	ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab0H3Oxd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Aug 2010 10:53:33 -0400
Message-ID: <4C7BC70E.6090901@cam.ac.uk>
Date: Mon, 30 Aug 2010 15:58:22 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: Re: [PATCH 3/3] staging:iio:hmc5843 change ABI to comply with documentation
References: <1283165728-2231-2-git-send-email-manuel.stahl@iis.fraunhofer.de> <1283177032-7014-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1283177032-7014-3-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This one would benefit from an ack from Shubhrajyoti Datta (cc'd)

It's his driver and whilst to my eye this looks fine it would
be good to have his input on the scale numbers.

If he doesn't reply for a bit send it on anyway ;)  (as it is
fairly trivial)

I actually promised to fix this myself in the original review
but I'm happy you beat me to it ;)

One issue inline...  Fix that and feel free to add my sign-off.

Thanks,

Jonathan

On 08/30/10 15:03, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |   32 ++++++++++++++--------------
>  1 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 92f6c6f..66aab5a 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -95,15 +95,15 @@
>  #define	CONF_NOT_USED				0x03
>  #define	MEAS_CONF_MASK				0x03
>  
> -static const int regval_to_counts_per_mg[] = {
> -	1620,
> -	1300,
> -	970,
> -	780,
> -	530,
> -	460,
> -	390,
> -	280
> +static const char *regval_to_scale[] = {
> +	"0.0000006173",
> +	"0.0000007692",
> +	"0.0000010309",
> +	"0.0000012821",
> +	"0.0000018868",
> +	"0.0000021739",
> +	"0.0000025641",
> +	"0.0000035714",
>  };
>  static const int regval_to_input_field_mg[] = {
>  	700,
> @@ -322,7 +322,7 @@ static IIO_DEVICE_ATTR(meas_conf,
>   * 6		| 50
>   * 7		| Not used
>   */
> -static IIO_CONST_ATTR_AVAIL_SAMP_FREQ("0.5 1 2 5 10 20 50");
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("0.5 1 2 5 10 20 50");
>  
>  static s32 hmc5843_set_rate(struct i2c_client *client,
>  				u8 rate)
> @@ -459,17 +459,17 @@ static IIO_DEVICE_ATTR(magn_range,
>  			set_range,
>  			HMC5843_CONFIG_REG_B);
>  
> -static ssize_t show_gain(struct device *dev,
> +static ssize_t show_scale(struct device *dev,
>  			struct device_attribute *attr,
>  			char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct hmc5843_data *data = indio_dev->dev_data;
> -	return sprintf(buf, "%d\n", regval_to_counts_per_mg[data->range]);
> +	return strlen(strcpy(buf, regval_to_scale[data->range]));

That leaves us without a trailing "\n".  Makes for messy use of cat ;)
Probably easier to use

return sprintf(buf, "%s\n", regval_to_scale[data->range]);
>  }
> -static IIO_DEVICE_ATTR(magn_gain,
> +static IIO_DEVICE_ATTR(magn_scale,
>  			S_IRUGO,
> -			show_gain,
> +			show_scale,
>  			NULL , 0);
>  
>  static struct attribute *hmc5843_attributes[] = {
> @@ -477,11 +477,11 @@ static struct attribute *hmc5843_attributes[] = {
>  	&iio_dev_attr_operating_mode.dev_attr.attr,
>  	&iio_dev_attr_sampling_frequency.dev_attr.attr,
>  	&iio_dev_attr_magn_range.dev_attr.attr,
> -	&iio_dev_attr_magn_gain.dev_attr.attr,
> +	&iio_dev_attr_magn_scale.dev_attr.attr,
>  	&iio_dev_attr_magn_x_raw.dev_attr.attr,
>  	&iio_dev_attr_magn_y_raw.dev_attr.attr,
>  	&iio_dev_attr_magn_z_raw.dev_attr.attr,
> -	&iio_const_attr_available_sampling_frequency.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
>  	NULL
>  };
>  

