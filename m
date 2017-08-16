Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:39070 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751588AbdHPNZI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 16 Aug 2017 09:25:08 -0400
Date: Wed, 16 Aug 2017 15:25:06 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Andreas Klinger <ak@it-klinger.de>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org, wsa@the-dreams.de, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: srf08: add support for srf02 in i2c mode
In-Reply-To: <20170814090209.GA9929@arbeit>
Message-ID: <alpine.DEB.2.20.1708161513360.27224@vps.pmeerw.net>
References: <20170814090209.GA9929@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> srf02 added with support for i2c interface
> 
> Attributes for setting max range or sensitivity are omitted for the case of
> srf02 type sensor, because they are not supported by the hardware.

comments below
 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  drivers/iio/proximity/Kconfig |  8 ++---
>  drivers/iio/proximity/srf08.c | 77 ++++++++++++++++++++++++++++++++-----------
>  2 files changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index df33ccc0d035..ae070950f920 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -57,12 +57,12 @@ config SX9500
>  	  module will be called sx9500.
>  
>  config SRF08
> -	tristate "Devantech SRF08/SRF10 ultrasonic ranger sensor"
> +	tristate "Devantech SRF02/SRF08/SRF10 ultrasonic ranger sensor"
>  	depends on I2C
>  	help
> -	  Say Y here to build a driver for Devantech SRF08/SRF10 ultrasonic
> -	  ranger sensor. This driver can be used to measure the distance
> -	  of objects.
> +	  Say Y here to build a driver for Devantech SRF02/SRF08/SRF10
> +	  ultrasonic ranger sensors with i2c interface.
> +	  This driver can be used to measure the distance of objects.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called srf08.
> diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
> index 52573b013313..6ccf8f9fd703 100644
> --- a/drivers/iio/proximity/srf08.c
> +++ b/drivers/iio/proximity/srf08.c
> @@ -1,15 +1,17 @@
>  /*
> - * srf08.c - Support for Devantech SRF08 ultrasonic ranger
> + * srf08.c - Support for Devantech SRF02/SRF08/SRF10 ultrasonic ranger
> + *           with I2C-Interface
>   *
> - * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
> + * Copyright (c) 2016, 2017 Andreas Klinger <ak@it-klinger.de>
>   *
>   * This file is subject to the terms and conditions of version 2 of
> - * the GNU General Public License.  See the file COPYING in the main
> + * the GNU General Public License. See the file COPYING in the main
>   * directory of this archive for more details.
>   *
>   * For details about the device see:
>   * http://www.robot-electronics.co.uk/htm/srf08tech.html
>   * http://www.robot-electronics.co.uk/htm/srf10tech.htm
> + * http://www.robot-electronics.co.uk/htm/srf02tech.htm
>   */
>  
>  #include <linux/err.h>
> @@ -34,11 +36,10 @@
>  
>  #define SRF08_CMD_RANGING_CM	0x51	/* Ranging Mode - Result in cm */
>  
> -#define SRF08_DEFAULT_RANGE	6020	/* default value of Range in mm */
> -
>  #define SRF08_MAX_SENSITIVITY	32	/* number of Gain Register values */
>  
>  enum srf08_sensor_type {
> +	SRF02,
>  	SRF08,
>  	SRF10,
>  	SRF_MAX_TYPE
> @@ -75,6 +76,8 @@ struct srf08_data {
>   * is called "Sensitivity" here.
>   */
>  static const int srf08_sensitivity[SRF_MAX_TYPE][SRF08_MAX_SENSITIVITY] = {
> +	[SRF02] = {
> +	},
>  	[SRF08] = {
>  	 94,  97, 100, 103, 107, 110, 114, 118,
>  	123, 128, 133, 139, 145, 152, 159, 168,
> @@ -93,6 +96,11 @@ static const int srf08_default_sensitivity[SRF_MAX_TYPE] = {
>  	[SRF10] = 700,
>  };
>  
> +static const int srf08_default_range[SRF_MAX_TYPE] = {

the information regarding range unit (mm) is lost, maybe add a comment?

> +	[SRF08] = 6020,
> +	[SRF10] = 6020,
> +};
> +
>  static int srf08_read_ranging(struct srf08_data *data)
>  {
>  	struct i2c_client *client = data->client;
> @@ -409,6 +417,15 @@ static const struct iio_info srf08_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> +/*
> + * srf02 don't have an adjustable range or sensitivity,
> + * so we don't need attributes at all
> + */
> +static const struct iio_info srf02_info = {
> +	.read_raw = srf08_read_raw,
> +	.driver_module = THIS_MODULE,
> +};
> +
>  static int srf08_probe(struct i2c_client *client,
>  					 const struct i2c_device_id *id)
>  {
> @@ -434,7 +451,13 @@ static int srf08_probe(struct i2c_client *client,
>  	indio_dev->name = id->name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->info = &srf08_info;
> +
> +	/* srf02 is not using sensitivity nor max_range */
> +	if (id->driver_data == SRF02)
> +		indio_dev->info = &srf02_info;
> +	else
> +		indio_dev->info = &srf08_info;
> +
>  	indio_dev->channels = srf08_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(srf08_channels);
>  
> @@ -447,24 +470,39 @@ static int srf08_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	/*
> -	 * set default values of device here
> -	 * these register values cannot be read from the hardware
> -	 * therefore set driver specific default values
> -	 */
> -	ret = srf08_write_range_mm(data, SRF08_DEFAULT_RANGE);
> -	if (ret < 0)
> -		return ret;
> +	if (srf08_default_range[id->driver_data]) {


it would be nice to have a chip_info struct with chip-specific 
information, so we can point to the relevant struct once instead of 
picking the correct entry from srf08_default_sensitivity and 
srf08_default_range separately

so far, we have only two defaults tables... no big deal

> +		/*
> +		 * set default range of device here
> +		 * these register values cannot be read from he hardware
> +		 * therefore set driver specific default values
> +		 *
> +		 * srf02 don't have a default value so it'll be omitted
> +		 */
> +		ret = srf08_write_range_mm(data,
> +					srf08_default_range[id->driver_data]);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
> -	ret = srf08_write_sensitivity(data,
> -			srf08_default_sensitivity[id->driver_data]);
> -	if (ret < 0)
> -		return ret;
> +	if (srf08_default_sensitivity[id->driver_data]) {
> +		/*
> +		 * set default sensitivity of device here
> +		 * these register values cannot be read from the hardware
> +		 * therefore set driver specific default values
> +		 *
> +		 * srf02 don't have a default value so it'll be omitted
> +		 */
> +		ret = srf08_write_sensitivity(data,
> +				srf08_default_sensitivity[id->driver_data]);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct of_device_id of_srf08_match[] = {
> +	{ .compatible = "devantech,srf02", (void *)SRF02},
>  	{ .compatible = "devantech,srf08", (void *)SRF08},
>  	{ .compatible = "devantech,srf10", (void *)SRF10},
>  	{},
> @@ -473,6 +511,7 @@ static const struct of_device_id of_srf08_match[] = {
>  MODULE_DEVICE_TABLE(of, of_srf08_match);
>  
>  static const struct i2c_device_id srf08_id[] = {
> +	{ "srf02", SRF02 },
>  	{ "srf08", SRF08 },
>  	{ "srf10", SRF10 },
>  	{ }
> @@ -490,5 +529,5 @@ static struct i2c_driver srf08_driver = {
>  module_i2c_driver(srf08_driver);
>  
>  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> -MODULE_DESCRIPTION("Devantech SRF08/SRF10 ultrasonic ranger driver");
> +MODULE_DESCRIPTION("Devantech SRF02/SRF08/SRF10 i2c ultrasonic ranger driver");
>  MODULE_LICENSE("GPL");
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
