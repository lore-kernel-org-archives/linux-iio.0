Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55735 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbcCEOcQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 09:32:16 -0500
Subject: Re: [PATCH v4 3/4] iio: ad5755: added full support for devicetree
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org
References: <1456833376-29758-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1456833376-29758-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1456833376-29758-3-git-send-email-sean.nyekjaer@prevas.dk>
Cc: devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAEDEB.7090309@kernel.org>
Date: Sat, 5 Mar 2016 14:32:11 +0000
MIME-Version: 1.0
In-Reply-To: <1456833376-29758-3-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/16 11:56, Sean Nyekjaer wrote:
> Devicetree can provide platform data
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> ---
> These large switch cases make the driver hard to read? Does someone have any
> ideas to make this more readable?
Only option that comes to mind would be to use a look up table and search
it... See below.  Moves the switch statement stuff into a static array.  Can
be done neater than I have below, but you'll get the idea.
> 
> The dc-dc-phase and channel mode i rather hard to do without defines? Will it
> be okay to use them here?
> Example:
> adi,mode = CURRENT_4mA_20mA or adi,mode = VOLTAGE_PLUSMINUS_10V
> They are generic DAC/ADC properties...
I can't think of a better way - there are too many missing cases that are
invalid to break it up into more elements.  So sure, fine in my view as is.
> 
> Changes since v3:
> - replaced '_' with '-'
> - Now used actual values instead of register values.
> 
> Changes since v2:
> - removed defines from DT
> 
>  drivers/iio/dac/ad5755.c | 227 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 226 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index e1b6e78..4a2866e 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/delay.h>
> +#include <linux/of.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/platform_data/ad5755.h>
> @@ -556,6 +557,223 @@ static const struct ad5755_platform_data ad5755_default_pdata = {
>  	},
>  };
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
> +	    of_property_read_bool(np, "adi,ext-dc-dc-compenstation-resistor");
> +
> +	if (!of_property_read_u32(np, "adi,dc-dc-phase", &tmp))
> +		pdata->dc_dc_phase = tmp;
> +	else
> +		pdata->dc_dc_phase = AD5755_DC_DC_PHASE_ALL_SAME_EDGE;
> +
> +	if (!of_property_read_u32(np, "adi,dc-dc-freq", &tmp))
> +		switch (tmp) {
static const int ad5755_dcdc_freq_table[3][2] =
{ { 250000, AD5755_DC_DC_FREQ_250kHZ },
  { 410000, AD5755_DC_DC_FREQ_410kHZ },
  { 650000, AD5755_DC_DC_FREQ_650kZ } };

  for (i = 0; i < 3; i++) {
      if (tmp == ad5755_dcdc_freq_table[i][0]) {
      	 pdata->dc_dc_freq = ad5755_dcdc_freq_table[i][1];
	 break;
      }
  if (i == 3) {
     dev_err(dev,
             "adi,dc-dc-freq out of range selecting 410kHz");
     pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
  }

Or something along those lines..  Makes more sense for the larger ones.
> +		case 250000:
> +			pdata->dc_dc_freq = AD5755_DC_DC_FREQ_250kHZ;
> +			break;
> +		case 410000:
> +			pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
> +			break;
> +		case 650000:
> +			pdata->dc_dc_freq = AD5755_DC_DC_FREQ_650kHZ;
> +			break;
> +		default:
> +			dev_err(dev,
> +				"adi,dc-dc-freq out of range selecting 410kHz");
> +			pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
> +	} else
> +		pdata->dc_dc_freq = AD5755_DC_DC_FREQ_410kHZ;
> +
> +	if (!of_property_read_u32(np, "adi,dc-dc-maxv", &tmp))
> +		switch (tmp) {
> +		case 23000:
> +			pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
> +			break;
> +		case 24500:
> +			pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_24V5;
> +			break;
> +		case 27000:
> +			pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_27V;
> +			break;
> +		case 29500:
> +			pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_29V5;
> +			break;
> +		default:
> +			dev_err(dev,
> +				"adi,dc-dc-maxv out of range selecting 23V");
> +			pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
> +	} else
> +		pdata->dc_dc_maxv = AD5755_DC_DC_MAXV_23V;
> +
> +	devnr = 0;
> +	for_each_child_of_node(np, pp) {
> +		if (devnr > AD5755_NUM_CHANNELS) {
> +			dev_err(dev,
> +				"There is to many channels defined in DT\n");
> +			goto error_out;
> +		}
> +
> +		if (!of_property_read_u32(pp, "adi,mode", &tmp))
> +			pdata->dac[devnr].mode = tmp;
> +		else
> +			pdata->dac[devnr].mode = AD5755_MODE_CURRENT_4mA_20mA;
> +
> +		pdata->dac[devnr].ext_current_sense_resistor =
> +		    of_property_read_bool(pp, "adi,ext-current-sense-resistor");
> +
> +		pdata->dac[devnr].enable_voltage_overrange =
> +		    of_property_read_bool(pp, "adi,enable-voltage-overrange");
> +
> +		if (!of_property_read_u32_array(pp, "adi,slew", tmparray, 3)) {
> +			pdata->dac[devnr].slew.enable = tmparray[0];
> +			switch (tmparray[1]) {
> +			case 64000:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_64k;
> +				break;
> +			case 32000:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_32k;
> +				break;
> +			case 16000:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_16k;
> +				break;
> +			case 8000:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_8k;
> +				break;
> +			case 4000:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_4k;
> +				break;
> +			case 2000:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_2k;
> +				break;
> +			case 1000:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_1k;
> +				break;
> +			case 500:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_500;
> +				break;
> +			case 250:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_250;
> +				break;
> +			case 125:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_125;
> +				break;
> +			case 64:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_64;
> +				break;
> +			case 32:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_32;
> +				break;
> +			case 16:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_16;
> +				break;
> +			case 8:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_8;
> +				break;
> +			case 4:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_4;
> +				break;
> +			case 0:
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_0_5;
> +				break;
> +			default:
> +				dev_err(dev,
> +					"channel %d slew rate out of range selecting 64kHz",
> +					devnr);
> +				pdata->dac[devnr].slew.rate =
> +				    AD5755_SLEW_RATE_64k;
> +			}
> +			switch (tmparray[2]) {
> +			case 1:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_1;
> +				break;
> +			case 2:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_2;
> +				break;
> +			case 4:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_4;
> +				break;
> +			case 16:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_16;
> +				break;
> +			case 32:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_32;
> +				break;
> +			case 64:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_64;
> +				break;
> +			case 128:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_128;
> +				break;
> +			case 256:
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_256;
> +				break;
> +			default:
> +				dev_err(dev,
> +					"channel %d slew step size out of range selecting 1 LSB",
> +					devnr);
> +				pdata->dac[devnr].slew.step_size =
> +				    AD5755_SLEW_STEP_SIZE_1;
> +			}
> +		} else {
> +			pdata->dac[devnr].slew.enable = false;
> +			pdata->dac[devnr].slew.rate = AD5755_SLEW_RATE_64k;
> +			pdata->dac[devnr].slew.step_size =
> +			    AD5755_SLEW_STEP_SIZE_1;
> +		}
> +		devnr++;
> +	}
> +
> +	return pdata;
> +
> + error_out:
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
>  static int ad5755_probe(struct spi_device *spi)
>  {
>  	enum ad5755_type type = spi_get_device_id(spi)->driver_data;
> @@ -583,8 +801,15 @@ static int ad5755_probe(struct spi_device *spi)
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->num_channels = AD5755_NUM_CHANNELS;
>  
> -	if (!pdata)
> +	if (spi->dev.of_node)
> +		pdata = ad5755_parse_dt(&spi->dev);
> +	else
> +		pdata = spi->dev.platform_data;
> +
> +	if (!pdata) {
> +		dev_warn(&spi->dev, "no platform data? using default\n");
>  		pdata = &ad5755_default_pdata;
> +	}
>  
>  	ret = ad5755_init_channels(indio_dev, pdata);
>  	if (ret)
> 

