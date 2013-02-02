Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43826 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab3BBKdO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 05:33:14 -0500
Message-ID: <510CEB68.5000205@kernel.org>
Date: Sat, 02 Feb 2013 10:33:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [RFC 11/11] iio/adc: (max1363) Add basic OF bindings and external
 vref support
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-12-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-12-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 09:43 PM, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Mostly fine.  Comments below are on the fact I'd prefer
a reference voltage coming from a regulator than being
a bit of platform data.
> ---
>  Documentation/devicetree/bindings/iio/max1363.txt |   54 +++++++++++++++++++++
>  drivers/iio/adc/max1363.c                         |   54 ++++++++++++++++-----
>  2 files changed, 95 insertions(+), 13 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/max1363.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/max1363.txt b/Documentation/devicetree/bindings/iio/max1363.txt
> new file mode 100644
> index 0000000..6d22861
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/max1363.txt
> @@ -0,0 +1,54 @@
> +Device Tree bindings for MAX1363 and compatible ADC controllers
> +
> +This binding uses the common IIO binding[1].
> +
> +[1] Documentation/devicetree/bindings/iio/iio-bindings.txt
> +
> +Required properties:
> +
> +- compatible, shall be one of the following:
> +	"maxim,max1361"
> +	"maxim,max1362"
> +	"maxim,max1363"
> +	"maxim,max1364"
> +	"maxim,max1036"
> +	"maxim,max1037"
> +	"maxim,max1038"
> +	"maxim,max1039"
> +	"maxim,max1136"
> +	"maxim,max1137"
> +	"maxim,max1138"
> +	"maxim,max1139"
> +	"maxim,max1236"
> +	"maxim,max1237"
> +	"maxim,max1238"
> +	"maxim,max1239"
> +	"maxim,max11600"
> +	"maxim,max11601"
> +	"maxim,max11602"
> +	"maxim,max11603"
> +	"maxim,max11604"
> +	"maxim,max11605"
> +	"maxim,max11606"
> +	"maxim,max11607"
> +	"maxim,max11608"
> +	"maxim,max11609"
> +	"maxim,max11610"
> +	"maxim,max11611"
> +	"maxim,max11612"
> +	"maxim,max11613"
> +	"maxim,max11614"
> +	"maxim,max11615"
> +	"maxim,max11616"
> +	"maxim,max11617"
> +
> +- reg: shall be the I2C device address
> +
> +Required properties for IIO bindings:
> +- #io-channel-cells: from common IIO bindings; shall be set to 1.
> +
> +Optional properties:
> +- vref: Reference voltage in mV. If the provided reference voltage matches
> +	the internal reference voltage, the internal reference voltage is used.
> +	Otherwise it is assumed that an external reference voltage is used,
> +	and the chip is programmed accordingly.

Why not use a regulator? It has a nice device tree map and if it's just a fixed
voltage, we have the fixed regulator driver for them.  This is pretty common
throughout IIO (unsuprisingly) and we've been generally getting with platform
data that does this in favour of regulators.  Back when we started out, the
regulators framework was new so providing an alternative was pretty much
required.  Now it's pretty universal.


> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 51165d6..cf49a20 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -31,6 +31,7 @@
>  #include <linux/slab.h>
>  #include <linux/err.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -162,6 +163,7 @@ struct max1363_chip_info {
>   * @mask_low:		bitmask for enabled low thresholds
>   * @thresh_high:	high threshold values
>   * @thresh_low:		low threshold values
> + * @vref_mv:		Actual (external or internal) reference voltage
>   */
>  struct max1363_state {
>  	struct i2c_client		*client;
> @@ -181,6 +183,7 @@ struct max1363_state {
>  	/* 4x unipolar first then the fours bipolar ones */
>  	s16				thresh_high[8];
>  	s16				thresh_low[8];
> +	u16				vref_mv;
>  };
>  
>  #define MAX1363_MODE_SINGLE(_num, _mask) {				\
> @@ -392,6 +395,8 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	int ret;
> +	unsigned long scale_uv;
> +
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
>  		ret = max1363_read_single_chan(indio_dev, chan, val, m);
> @@ -399,16 +404,10 @@ static int max1363_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		if ((1 << (st->chip_info->bits + 1)) >
> -		    st->chip_info->int_vref_mv) {
> -			*val = 0;
> -			*val2 = 500000;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		} else {
> -			*val = (st->chip_info->int_vref_mv)
> -				>> st->chip_info->bits;
> -			return IIO_VAL_INT;
> -		}
> +		scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
> +		*val = scale_uv / 1000;
> +		*val2 = (scale_uv % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -1389,12 +1388,16 @@ static const struct max1363_chip_info max1363_chip_info_tbl[] = {
>  
>  static int max1363_initial_setup(struct max1363_state *st)
>  {
> -	st->setupbyte = MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD
> -		| MAX1363_SETUP_POWER_UP_INT_REF
> -		| MAX1363_SETUP_INT_CLOCK
> +	st->setupbyte = MAX1363_SETUP_INT_CLOCK
>  		| MAX1363_SETUP_UNIPOLAR
>  		| MAX1363_SETUP_NORESET;
>  
> +	if (st->vref_mv != st->chip_info->int_vref_mv)
> +		st->setupbyte |= MAX1363_SETUP_AIN3_IS_REF_EXT_TO_REF;
> +	else
> +		st->setupbyte |= MAX1363_SETUP_POWER_UP_INT_REF
> +		  | MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_INT;
> +
>  	/* Set scan mode writes the config anyway so wait until then*/
>  	st->setupbyte = MAX1363_SETUP_BYTE(st->setupbyte);
>  	st->current_mode = &max1363_mode_table[st->chip_info->default_mode];
> @@ -1526,6 +1529,26 @@ static void max1363_buffer_cleanup(struct iio_dev *indio_dev)
>  	iio_kfifo_free(indio_dev->buffer);
>  }
>  
> +#ifdef CONFIG_OF
> +static int max1363_parse_of(struct device *dev, struct max1363_state *st)
> +{
> +	struct device_node *np = dev->of_node;
> +	u32 vref_mv;
> +
> +	if (!of_property_read_u32(np, "vref", &vref_mv)) {
> +		if (vref_mv == 0 || vref_mv > USHRT_MAX)
> +			return -EINVAL;
> +		st->vref_mv = vref_mv;
> +	}
> +	return 0;
> +}
> +#else
> +static int max1363_parse_of(struct device *dev, struct max1363_state *st)
> +{
> +	return 0;
> +}
> +#endif
> +
>  static int max1363_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> @@ -1562,6 +1585,11 @@ static int max1363_probe(struct i2c_client *client,
>  	st->chip_info = &max1363_chip_info_tbl[id->driver_data];
>  	st->client = client;
>  
> +	st->vref_mv = st->chip_info->int_vref_mv;
> +	ret = max1363_parse_of(&client->dev, st);
> +	if (ret)
> +		goto error_disable_reg;
> +
>  	ret = max1363_alloc_scan_masks(indio_dev);
>  	if (ret)
>  		goto error_disable_reg;
> 
