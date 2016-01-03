Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57191 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751392AbcACPuM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jan 2016 10:50:12 -0500
Subject: Re: [PATCH v2] iio: adc: mcp3422: Add support for MCP3425
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
References: <1451132174-4172-1-git-send-email-akinobu.mita@gmail.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5689432E.8050100@kernel.org>
Date: Sun, 3 Jan 2016 15:50:06 +0000
MIME-Version: 1.0
In-Reply-To: <1451132174-4172-1-git-send-email-akinobu.mita@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/12/15 12:16, Akinobu Mita wrote:
> The MCP3425 is a single channel up to 16-bit A/D converter which has
> features:
> 
> - On-Board Programmable Gain Amplifier (PGA):
>  - Gains of 1, 2, 4 or 8
> - Programmable Data Rate Options:
>  - 15 SPS (16 bits), 60 SPS (14 bits), 240 SPS (12 bits)
> 
> The mcp3422 driver also supports the MCP3421 which is a single channel.
> So we can support MCP3425 with a little changes to mcp3422 driver.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
Applied to the togreg branch of iio.git. 

I dropped a few of this list of cc's 

Thanks,

Jonathan
> ---
> * v2
> - reuse mcp3421's code (suggested by Peter Meerwald-Stadler)
> - remove a change for the first configuration access channel
> 
>  Documentation/devicetree/bindings/iio/adc/mcp3422.txt | 1 +
>  drivers/iio/adc/Kconfig                               | 6 +++---
>  drivers/iio/adc/mcp3422.c                             | 7 +++++--
>  3 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> index dcae4cc..82bcce0 100644
> --- a/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> +++ b/Documentation/devicetree/bindings/iio/adc/mcp3422.txt
> @@ -6,6 +6,7 @@ Required properties:
>  	"microchip,mcp3422" or
>  	"microchip,mcp3423" or
>  	"microchip,mcp3424" or
> +	"microchip,mcp3425" or
>  	"microchip,mcp3426" or
>  	"microchip,mcp3427" or
>  	"microchip,mcp3428"
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7868c74..0c843a6 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -246,11 +246,11 @@ config MCP320X
>  	  called mcp320x.
>  
>  config MCP3422
> -	tristate "Microchip Technology MCP3422/3/4/6/7/8 driver"
> +	tristate "Microchip Technology MCP3421/2/3/4/5/6/7/8 driver"
>  	depends on I2C
>  	help
> -	  Say yes here to build support for Microchip Technology's
> -	  MCP3422, MCP3423, MCP3424, MCP3426, MCP3427 or MCP3428
> +	  Say yes here to build support for Microchip Technology's MCP3421
> +	  MCP3422, MCP3423, MCP3424, MCP3425, MCP3426, MCP3427 or MCP3428
>  	  analog to digital converters.
>  
>  	  This driver can also be built as a module. If so, the module will be
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 6eca7ae..ebad83e 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -1,11 +1,12 @@
>  /*
> - * mcp3422.c - driver for the Microchip mcp3422/3/4/6/7/8 chip family
> + * mcp3422.c - driver for the Microchip mcp3421/2/3/4/5/6/7/8 chip family
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
> @@ -357,6 +358,7 @@ static int mcp3422_probe(struct i2c_client *client,
>  
>  	switch (adc->id) {
>  	case 1:
> +	case 5:
>  		indio_dev->channels = mcp3421_channels;
>  		indio_dev->num_channels = ARRAY_SIZE(mcp3421_channels);
>  		break;
> @@ -395,6 +397,7 @@ static const struct i2c_device_id mcp3422_id[] = {
>  	{ "mcp3422", 2 },
>  	{ "mcp3423", 3 },
>  	{ "mcp3424", 4 },
> +	{ "mcp3425", 5 },
>  	{ "mcp3426", 6 },
>  	{ "mcp3427", 7 },
>  	{ "mcp3428", 8 },
> @@ -421,5 +424,5 @@ static struct i2c_driver mcp3422_driver = {
>  module_i2c_driver(mcp3422_driver);
>  
>  MODULE_AUTHOR("Angelo Compagnucci <angelo.compagnucci@gmail.com>");
> -MODULE_DESCRIPTION("Microchip mcp3422/3/4/6/7/8 driver");
> +MODULE_DESCRIPTION("Microchip mcp3421/2/3/4/5/6/7/8 driver");
>  MODULE_LICENSE("GPL v2");
> 

