Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:57545 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754732Ab1HaLoQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 07:44:16 -0400
Message-ID: <4E5E207E.1040101@cam.ac.uk>
Date: Wed, 31 Aug 2011 12:52:30 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 12/12] iio: ad7192: add temp_scale attribute, change module
 description
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com> <1314788260-5791-12-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-12-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 11:57, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> Use KBUILD_MODNAME
> Fix indention style
Again, not all in the right place in the series, but it's so
trivial we'll leave it be. I'll probably fix up that mutex whitespace
issue where it occurred.

> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
merged
> ---
>  drivers/staging/iio/adc/ad7291.c |   17 ++++++++++++-----
>  1 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 0811c5e..636e635 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -101,7 +101,7 @@ struct ad7291_chip_info {
>  	u16			int_vref_mv;
>  	u16			command;
>  	u16			c_mask;	/* Active voltage channels for events */
> -	struct mutex 		state_lock;
> +	struct mutex		state_lock;
>  };
>  
>  static int ad7291_i2c_read(struct ad7291_chip_info *chip, u8 reg, u16 *data)
> @@ -513,6 +513,13 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
>  		*val =  scale_uv / 1000;
>  		*val2 = (scale_uv % 1000) * 1000;
>  		return IIO_VAL_INT_PLUS_MICRO;
> +	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
> +		/*
> +		* One LSB of the ADC corresponds to 0.25 deg C.
> +		* The temperature reading is in 12-bit twos complement format
> +		*/
> +		*val = 250;
> +		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -539,7 +546,8 @@ static const struct iio_chan_spec ad7291_channels[] = {
>  	AD7291_VOLTAGE_CHAN(7),
>  	{
>  		.type = IIO_TEMP,
> -		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE),
> +		.info_mask = (1 << IIO_CHAN_INFO_AVERAGE_RAW_SEPARATE) |
> +				(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
>  		.indexed = 1,
>  		.channel = 0,
>  		.event_mask =
> @@ -683,7 +691,7 @@ MODULE_DEVICE_TABLE(i2c, ad7291_id);
>  
>  static struct i2c_driver ad7291_driver = {
>  	.driver = {
> -		.name = "ad7291",
> +		.name = KBUILD_MODNAME,
>  	},
>  	.probe = ad7291_probe,
>  	.remove = __devexit_p(ad7291_remove),
> @@ -701,8 +709,7 @@ static __exit void ad7291_exit(void)
>  }
>  
>  MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7291 digital"
> -			" temperature sensor driver");
> +MODULE_DESCRIPTION("Analog Devices AD7291 ADC driver");
>  MODULE_LICENSE("GPL v2");
>  
>  module_init(ad7291_init);

