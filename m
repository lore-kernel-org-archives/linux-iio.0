Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38558 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275AbbJaKV6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Oct 2015 06:21:58 -0400
Subject: Re: [PATCH v5 5/5] iio: humidity: si7020: add No Hold read mode
To: Nicola Corna <nicola@corna.info>, Wolfram Sang <wsa@the-dreams.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-5-git-send-email-nicola@corna.info>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56349644.2060308@kernel.org>
Date: Sat, 31 Oct 2015 10:21:56 +0000
MIME-Version: 1.0
In-Reply-To: <1446118467-26453-5-git-send-email-nicola@corna.info>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/10/15 11:34, Nicola Corna wrote:
> The Si7013/20/21 modules support 2 read modes:
>  * Hold mode (blocking), where the device stretches the clock until the end
> of the measurement
>  * No Hold mode (non-blocking), where the device replies NACK for every I2C
> call during the measurement
> Here the No Hold mode is implemented, selectable with the blocking_io
> variable within si7020_platform_data. The default mode is Hold, unless the
> adapter does not support clock stretching, in which case the No Hold mode
> is used.
> 
> Signed-off-by: Nicola Corna <nicola@corna.info>
I'm fine with this.  The dependency below should I think show up in the
coming merge window, so this lot might as well go via Wolfram.

Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> This patch depends on patch "[PATCH v4 1/2] iio: humidity: si7020: replaced
> bitmask on humidity values with range check"
>  drivers/iio/humidity/si7020.c        | 75 ++++++++++++++++++++++++++++++++----
>  include/linux/platform_data/si7020.h | 21 ++++++++++
>  2 files changed, 89 insertions(+), 7 deletions(-)
>  create mode 100644 include/linux/platform_data/si7020.h
> 
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index 12128d1..674a61a 100644
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
> @@ -30,33 +31,78 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> +#include <linux/jiffies.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/platform_data/si7020.h>
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
>  
>  static int si7020_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
>  {
>  	struct i2c_client **client = iio_priv(indio_dev);
> +	struct si7020_platform_data *pdata;
>  	int ret;
> +	bool holdmode;
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
> +		pdata = dev_get_platdata(&(*client)->dev);
> +		if (pdata)
> +			holdmode = pdata->blocking_io;
> +		else
> +			holdmode = !i2c_check_quirks((*client)->adapter,
> +				   I2C_AQ_NO_CLK_STRETCH);
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
>  		 * Humidity values can slightly exceed the 0-100%RH
>  		 * range and should be corrected by software
> @@ -116,6 +162,7 @@ static int si7020_probe(struct i2c_client *client,
>  {
>  	struct iio_dev *indio_dev;
>  	struct i2c_client **data;
> +	struct si7020_platform_data *pdata;
>  	int ret;
>  
>  	if (!i2c_check_functionality(client->adapter,
> @@ -123,6 +170,20 @@ static int si7020_probe(struct i2c_client *client,
>  				     I2C_FUNC_SMBUS_READ_WORD_DATA))
>  		return -ENODEV;
>  
> +	pdata = dev_get_platdata(&client->dev);
> +	if (pdata) {
> +		if (pdata->blocking_io) {
> +			if (i2c_check_quirks(client->adapter,
> +			   I2C_AQ_NO_CLK_STRETCH))
> +				return -ENODEV;
> +		} else if (!i2c_check_functionality(client->adapter,
> +			  I2C_FUNC_I2C))
> +			return -ENODEV;
> +	} else
> +		if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C) &&
> +		   i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH))
> +			return -ENODEV;
> +
>  	/* Reset device, loads default settings. */
>  	ret = i2c_smbus_write_byte(client, SI7020CMD_RESET);
>  	if (ret < 0)
> diff --git a/include/linux/platform_data/si7020.h b/include/linux/platform_data/si7020.h
> new file mode 100644
> index 0000000..8bb5848
> --- /dev/null
> +++ b/include/linux/platform_data/si7020.h
> @@ -0,0 +1,21 @@
> +/*
> + * Copyright (C) 2015 Nicola Corna <nicola@corna.info>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#ifndef __SI7020_H_
> +#define __SI7020_H_
> +
> +struct si7020_platform_data {
> +	bool blocking_io;
> +};
> +#endif /* __SI7020_H_ */
> 

