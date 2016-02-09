Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail01.prevas.se ([62.95.78.3]:5776 "EHLO mail01.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751841AbcBIIWO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 9 Feb 2016 03:22:14 -0500
Subject: Re: [PATCH v2 3/4] iio: ad5755: added full support for devicetree
To: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
References: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-3-git-send-email-sean.nyekjaer@prevas.dk>
CC: <devicetree@vger.kernel.org>
From: =?UTF-8?Q?Sean_Nyekj=c3=a6r?= <sean.nyekjaer@prevas.dk>
Message-ID: <56B9A1B2.6030007@prevas.dk>
Date: Tue, 9 Feb 2016 09:22:10 +0100
MIME-Version: 1.0
In-Reply-To: <1454509864-32285-3-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On 2016-02-03 15:31, Sean Nyekjaer wrote:
> Devicetree can provide platform data
>
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Lars do you have time to look at this before i'm fixing the comments 
from Jonathan and Rob :-)

Sean
> ---
> Changes since v1:
> - this patch added
>
> I'm adding dt bindings header file with the same info as, the platform data as
> the devicetree can't understand enums.
> Please give an idea to work around this :-)
>
>   drivers/iio/dac/ad5755.c             | 87 +++++++++++++++++++++++++++++++++++-
>   include/dt-bindings/iio/adi,ad5755.h | 66 +++++++++++++++++++++++++++
>   2 files changed, 152 insertions(+), 1 deletion(-)
>   create mode 100644 include/dt-bindings/iio/adi,ad5755.h
>
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index e1b6e78..c1e2546 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -14,9 +14,11 @@
>   #include <linux/slab.h>
>   #include <linux/sysfs.h>
>   #include <linux/delay.h>
> +#include <linux/of.h>
>   #include <linux/iio/iio.h>
>   #include <linux/iio/sysfs.h>
>   #include <linux/platform_data/ad5755.h>
> +#include <dt-bindings/iio/adi,ad5755.h>
>   
>   #define AD5755_NUM_CHANNELS 4
>   
> @@ -556,6 +558,82 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
>   	},
>   };
>   
> +#ifdef CONFIG_OF
> +static struct ad5755_platform_data *ad5755_parse_dt(struct device *dev)
> +{
> +	struct device_node *np = dev->of_node;
> +	struct device_node *pp;
> +	struct ad5755_platform_data *pdata;
> +	unsigned int tmp;
> +	unsigned int tmparray[3];
> +	int devnr;
> +
> +	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
> +	if (!pdata)
> +		return NULL;
> +
> +	pdata->ext_dc_dc_compenstation_resistor =
> +	       of_property_read_bool(np, "adi,ext_dc_dc_compenstation_resistor");
> +
> +	if (!of_property_read_u32(np, "adi,dc_dc_phase", &tmp))
> +		pdata->dc_dc_phase = tmp;
> +	else
> +		pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
> +
> +	if (!of_property_read_u32(np, "adi,dc_dc_freq", &tmp))
> +		pdata->dc_dc_freq = tmp;
> +	else
> +		pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
> +
> +	if (!of_property_read_u32(np, "adi,dc_dc_maxv", &tmp))
> +		pdata->dc_dc_maxv = tmp;
> +	else
> +		pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
> +
> +	devnr = 0;
> +	for_each_child_of_node(np, pp) {
> +		if (devnr > AD5755_NUM_CHANNELS) {
> +			dev_err(dev, "There is to many channels defined in DT\n");
> +			goto error_out;
> +		}
> +
> +		if (!of_property_read_u32(pp, "adi,mode", &tmp))
> +			pdata->dac[devnr].mode = tmp;
> +		else
> +			pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
> +
> +		pdata->dac[devnr].ext_current_sense_resistor =
> +		       of_property_read_bool(pp, "adi,ext_current_sense_resistor");
> +
> +		pdata->dac[devnr].enable_voltage_overrange =
> +			of_property_read_bool(pp, "adi,enable_voltage_overrange");
> +		if (!of_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
> +			pdata->dac[devnr].slew.enable = tmparray[0];
> +			pdata->dac[devnr].slew.rate = tmparray[1];
> +			pdata->dac[devnr].slew.step_size = tmparray[2];
> +		} else {
> +			pdata->dac[devnr].slew.enable = false;
> +			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
> +			pdata->dac[devnr].slew.step_size = AD5755_SLEW_STEP_SIZE_1;
> +		}
> +
> +		devnr++;
> +	}
> +
> +	return pdata;
> +
> +error_out:
> +	devm_kfree(dev, pdata);
> +	return NULL;
> +}
> +#else
> +static
> +struct adf4350_platform_data *adf4350_parse_dt(struct device *dev)
> +{
> +	return NULL;
> +}
> +#endif
> +
>   static int ad5755_probe(struct spi_device *spi)
>   {
>   	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
> @@ -583,8 +661,15 @@ static int ad5755_probe(struct spi_device *spi)
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->num_channels = AD5755_NUM_CHANNELS;
>   
> -	if (!pdata)
> +	if (spi->dev.of_node)
> +		pdata = ad5755_parse_dt(&spi->dev);
> +	else
> +		pdata = spi->dev.platform_data;
> +
> +	if (!pdata) {
> +		dev_warn(&spi->dev, "no platform data? using default\n");
>   		pdata = &ad5755_default_pdata;
> +	}
>   
>   	ret = ad5755_init_channels(indio_dev, pdata);
>   	if (ret)
> diff --git a/include/dt-bindings/iio/adi,ad5755.h b/include/dt-bindings/iio/adi,ad5755.h
> new file mode 100644
> index 0000000..117466b
> --- /dev/null
> +++ b/include/dt-bindings/iio/adi,ad5755.h
> @@ -0,0 +1,66 @@
> +/*
> + * Copyright (c) 2012-2014, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _DT_BINDINGS_AD5755_H
> +#define _DT_BINDINGS_AD5755_H
> +
> +#define	AD5755_MODE_VOLTAGE_0V_5V			0
> +#define AD5755_MODE_VOLTAGE_0V_10V			1
> +#define AD5755_MODE_VOLTAGE_PLUSMINUS_5V		2
> +#define AD5755_MODE_VOLTAGE_PLUSMINUS_10V		3
> +#define AD5755_MODE_CURRENT_4mA_20mA			4
> +#define AD5755_MODE_CURRENT_0mA_20mA			5
> +#define AD5755_MODE_CURRENT_0mA_24mA			6
> +
> +#define AD5755_DC_DC_PHASE_ALL_SAME_EDGE		0
> +#define AD5755_DC_DC_PHASE_A_B_SAME_EDGE_C_D_OPP_EDGE	1
> +#define AD5755_DC_DC_PHASE_A_C_SAME_EDGE_B_D_OPP_EDGE	2
> +#define AD5755_DC_DC_PHASE_90_DEGREE			3
> +
> +#define AD5755_DC_DC_FREQ_250kHZ			0
> +#define AD5755_DC_DC_FREQ_410kHZ			1
> +#define AD5755_DC_DC_FREQ_650kHZ			2
> +
> +#define AD5755_DC_DC_MAXV_23V				0
> +#define AD5755_DC_DC_MAXV_24V5				1
> +#define AD5755_DC_DC_MAXV_27V				2
> +#define AD5755_DC_DC_MAXV_29V5				3
> +
> +#define AD5755_SLEW_RATE_64k				0
> +#define AD5755_SLEW_RATE_32k				1
> +#define AD5755_SLEW_RATE_16k				2
> +#define AD5755_SLEW_RATE_8k				3
> +#define AD5755_SLEW_RATE_4k				4
> +#define AD5755_SLEW_RATE_2k				5
> +#define AD5755_SLEW_RATE_1k				6
> +#define AD5755_SLEW_RATE_500				7
> +#define AD5755_SLEW_RATE_250				8
> +#define AD5755_SLEW_RATE_125				9
> +#define AD5755_SLEW_RATE_64				10
> +#define AD5755_SLEW_RATE_32				11
> +#define AD5755_SLEW_RATE_16				12
> +#define AD5755_SLEW_RATE_8				13
> +#define AD5755_SLEW_RATE_4				14
> +#define AD5755_SLEW_RATE_0_5				15
> +
> +#define AD5755_SLEW_STEP_SIZE_1				0
> +#define AD5755_SLEW_STEP_SIZE_2				1
> +#define AD5755_SLEW_STEP_SIZE_4				2
> +#define AD5755_SLEW_STEP_SIZE_8				3
> +#define AD5755_SLEW_STEP_SIZE_16 			4
> +#define AD5755_SLEW_STEP_SIZE_32			5
> +#define AD5755_SLEW_STEP_SIZE_64			6
> +#define AD5755_SLEW_STEP_SIZE_128			7
> +#define AD5755_SLEW_STEP_SIZE_256			8
> +
> +#endif				/* _DT_BINDINGS_AD5755_H */

