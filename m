Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36916 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbbHVOA2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Aug 2015 10:00:28 -0400
Subject: Re: [PATCH 2/3] iio:humidity:si7020: added No Hold read mode
To: Nicola Corna <nicola@corna.info>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1440079909-1337-1-git-send-email-nicola@corna.info>
 <1440079909-1337-2-git-send-email-nicola@corna.info>
Cc: linux-iio@vger.kernel.org, jdelvare@suse.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55D88078.5080006@kernel.org>
Date: Sat, 22 Aug 2015 15:00:24 +0100
MIME-Version: 1.0
In-Reply-To: <1440079909-1337-2-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/08/15 15:11, Nicola Corna wrote:
> The Si7013/20/21 modules support 2 read modes:
>  * Hold mode, where the device stretches the clock until the end of the
> measurement
>  * No Hold mode, where the device replies NACK for every I2C call during
> the measurement
> Here the No Hold mode is implemented, selectable with the boolean
> parameter holdmode=N. The No Hold mode is less efficient, since it
> requires multiple calls to the device, but it can be used as a fallback if
> the clock stretching is not supported.
Interesting. Strikes me as something that should really be handled via the i2c
core (and device tree or similar bindings) rather than inside a driver as
a module parameter.  Perhaps info provided to the i2c client driver
via a check on whether the device supports clock stretching?

I'd like input from Jean on this.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>
> ---
> I've tested this on a Raspberry Pi 2, where the clock stretching is
> currently bugged.
>  drivers/iio/humidity/si7020.c | 55 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index 62fdbcf..a8bad04 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -2,6 +2,7 @@
>   * si7020.c - Silicon Labs Si7013/20/21 Relative Humidity and Temp Sensors
>   * Copyright (c) 2013,2014  Uplogix, Inc.
>   * David Barksdale <dbarksdale@uplogix.com>
> + * Copyright (c) 2015 Nicola Corna <nicola@corna.info>
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms and conditions of the GNU General Public License,
> @@ -30,16 +31,33 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> +#include <linux/jiffies.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  
>  /* Measure Relative Humidity, Hold Master Mode */
>  #define SI7020CMD_RH_HOLD	0xE5
> +/* Measure Relative Humidity, No Hold Master Mode */
> +#define SI7020CMD_RH_NO_HOLD	0xF5
>  /* Measure Temperature, Hold Master Mode */
>  #define SI7020CMD_TEMP_HOLD	0xE3
> +/* Measure Temperature, No Hold Master Mode */
> +#define SI7020CMD_TEMP_NO_HOLD	0xF3
>  /* Software Reset */
>  #define SI7020CMD_RESET		0xFE
> +/* Relative humidity measurement timeout (us) */
> +#define SI7020_RH_TIMEOUT	22800
> +/* Temperature measurement timeout (us) */
> +#define SI7020_TEMP_TIMEOUT	10800
> +/* Minimum delay between retries (No Hold Mode) in us */
> +#define SI7020_NOHOLD_SLEEP_MIN	2000
> +/* Maximum delay between retries (No Hold Mode) in us */
> +#define SI7020_NOHOLD_SLEEP_MAX	6000
> +
> +static bool holdmode = 1;
> +module_param(holdmode, bool, 0644);
> +MODULE_PARM_DESC(holdmode, "Select whether the measurement has to be done with Hold Mode (clock stretching) or No Hold Mode (repeated calls)");


>  
>  static int si7020_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan, int *val,
> @@ -47,16 +65,39 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct i2c_client **client = iio_priv(indio_dev);
>  	int ret;
> +	unsigned char buf[2];
> +	unsigned long start;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = i2c_smbus_read_word_data(*client,
> -					       chan->type == IIO_TEMP ?
> -					       SI7020CMD_TEMP_HOLD :
> -					       SI7020CMD_RH_HOLD);
> -		if (ret < 0)
> -			return ret;
> -		*val = ret >> 2;
> +		if (holdmode) {
> +			ret = i2c_smbus_read_word_data(*client,
> +						       chan->type == IIO_TEMP ?
> +						       SI7020CMD_TEMP_HOLD :
> +						       SI7020CMD_RH_HOLD);
> +			if (ret < 0)
> +				return ret;
> +			*val = ret >> 2;
> +		} else {
> +			ret = i2c_smbus_write_byte(*client,
> +						   chan->type == IIO_TEMP ?
> +						   SI7020CMD_TEMP_NO_HOLD :
> +						   SI7020CMD_RH_NO_HOLD);
> +			if (ret < 0)
> +				return ret;
> +			start = jiffies;
> +			while ((ret = i2c_master_recv(*client, buf, 2)) < 0) {
> +				if (time_after(jiffies, start +
> +					       usecs_to_jiffies(
> +							chan->type == IIO_TEMP ?
> +							SI7020_TEMP_TIMEOUT :
> +							SI7020_RH_TIMEOUT)))
> +					return ret;
> +				usleep_range(SI7020_NOHOLD_SLEEP_MIN,
> +					     SI7020_NOHOLD_SLEEP_MAX);
> +			}
> +			*val = ((buf[0] << 8) | buf[1]) >> 2;
> +		}
>  		/*
>  		 * Humidity values can sligthly exceed the 0-100%RH
>  		 * range and should be corrected by software
> 

