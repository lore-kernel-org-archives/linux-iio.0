Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:39470 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752502AbbLXWXe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Dec 2015 17:23:34 -0500
Date: Thu, 24 Dec 2015 23:23:33 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
cc: linux-iio@vger.kernel.org,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: mcp3422: Add support for MCP3425
In-Reply-To: <1450977067-30639-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <alpine.DEB.2.02.1512242316130.8572@pmeerw.net>
References: <1450977067-30639-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 25 Dec 2015, Akinobu Mita wrote:

> The MCP3425 is a single channel up to 16-bit A/D converter which has
> features:
> 
> - On-Board Programmable Gain Amplifier (PGA):
>  - Gains of 1, 2, 4 or 8
> - Programmable Data Rate Options:
>  - 15 SPS (16 bits), 60 SPS (14 bits), 240 SPS (12 bits)
> 
> So we can support MCP3425 with a little changes to mcp3422 driver.

comments below
 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/iio/adc/mcp3422.txt |  1 +
>  drivers/iio/adc/Kconfig                               |  4 ++--
>  drivers/iio/adc/mcp3422.c                             | 16 +++++++++++++---
>  3 files changed, 16 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> index 333139c..84289bd 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> @@ -5,6 +5,7 @@ Required properties:
>  	"microchip,mcp3422" or
>  	"microchip,mcp3423" or
>  	"microchip,mcp3424" or
> +	"microchip,mcp3425" or
>  	"microchip,mcp3426" or
>  	"microchip,mcp3427" or
>  	"microchip,mcp3428"
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7868c74..e4b1de9 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -246,11 +246,11 @@ config MCP320X
>  	  called mcp320x.
>  
>  config MCP3422
> -	tristate "Microchip Technology MCP3422/3/4/6/7/8 driver"
> +	tristate "Microchip Technology MCP3422/3/4/5/6/7/8 driver"
>  	depends on I2C
>  	help
>  	  Say yes here to build support for Microchip Technology's
> -	  MCP3422, MCP3423, MCP3424, MCP3426, MCP3427 or MCP3428
> +	  MCP3422, MCP3423, MCP3424, MCP3425, MCP3426, MCP3427 or MCP3428
>  	  analog to digital converters.
>  
>  	  This driver can also be built as a module. If so, the module will be
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 3555122..ba0c3ad 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -1,11 +1,12 @@
>  /*
> - * mcp3422.c - driver for the Microchip mcp3422/3/4/6/7/8 chip family
> + * mcp3422.c - driver for the Microchip mcp3422/3/4/5/6/7/8 chip family
>   *
>   * Copyright (C) 2013, Angelo Compagnucci
>   * Author: Angelo Compagnucci <angelo.compagnucci@gmail.com>
>   *
>   * Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/22088b.pdf
>   *            http://ww1.microchip.com/downloads/en/DeviceDoc/22226a.pdf
> + *            http://ww1.microchip.com/downloads/en/DeviceDoc/22072b.pdf
>   *
>   * This driver exports the value of analog input voltage to sysfs, the
>   * voltage unit is nV.
> @@ -317,6 +318,10 @@ static const struct iio_chan_spec mcp3424_channels[] = {
>  	MCP3422_CHAN(3),
>  };
>  
> +static const struct iio_chan_spec mcp3425_channels[] = {
> +	MCP3422_CHAN(0),
> +};

I think the idea is to reuse mcp3421_channels also for mcp3425 (both have 
just one channel), so the above struct is not needed

 +
>  static const struct iio_info mcp3422_info = {
>  	.read_raw = mcp3422_read_raw,
>  	.write_raw = mcp3422_write_raw,
> @@ -352,6 +357,10 @@ static int mcp3422_probe(struct i2c_client *client,
>  	indio_dev->info = &mcp3422_info;
>  
>  	switch (adc->id) {
> +	case 5:
> +		indio_dev->channels = mcp3425_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(mcp3425_channels);
> +		break;

just do
case 1:
case 5:
                indio_dev->channels = mcp3421_channels;
                indio_dev->num_channels = ARRAY_SIZE(mcp3421_channels);
                break;

>  	case 2:
>  	case 3:
>  	case 6:
> @@ -368,7 +377,7 @@ static int mcp3422_probe(struct i2c_client *client,
>  
>  	/* meaningful default configuration */
>  	config = (MCP3422_CONT_SAMPLING
> -		| MCP3422_CHANNEL_VALUE(1)
> +		| MCP3422_CHANNEL_VALUE(0)

why is the default behaviour changed? this should go in a separate patch 
together with justification

is MCP3422_CHANNEL_VALUE(1) correct for the mcp3421? maybe this would be a 
bugfix rather...

>  		| MCP3422_PGA_VALUE(MCP3422_PGA_1)
>  		| MCP3422_SAMPLE_RATE_VALUE(MCP3422_SRATE_240));
>  	mcp3422_update_config(adc, config);
> @@ -386,6 +395,7 @@ static const struct i2c_device_id mcp3422_id[] = {
>  	{ "mcp3422", 2 },
>  	{ "mcp3423", 3 },
>  	{ "mcp3424", 4 },
> +	{ "mcp3425", 5 },
>  	{ "mcp3426", 6 },
>  	{ "mcp3427", 7 },
>  	{ "mcp3428", 8 },
> @@ -412,5 +422,5 @@ static struct i2c_driver mcp3422_driver = {
>  module_i2c_driver(mcp3422_driver);
>  
>  MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
> -MODULE_DESCRIPTION("Microchip mcp3422/3/4/6/7/8 driver");
> +MODULE_DESCRIPTION("Microchip mcp3422/3/4/5/6/7/8 driver");
>  MODULE_LICENSE("GPL v2");
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
