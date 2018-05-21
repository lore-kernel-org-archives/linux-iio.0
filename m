Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51073 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752631AbeEUM3v (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 May 2018 08:29:51 -0400
Message-ID: <1526905789.25155.6.camel@gmail.com>
Subject: Re: [PATCH v3] iio: dac: Add support for external reference voltage
 through the regulator framework.
From: Silvan Murer <silvan.murer@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Mon, 21 May 2018 14:29:49 +0200
In-Reply-To: <20180520112312.668e0213@archlinux>
References: <1526775557.32235.33.camel@gmail.com>
         <20180520112312.668e0213@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,
Many Thanks for your kindly feedback and your patience!
I changed my patch process and sent them now (v4) with the "git sent-
email" command. I think this would be much more stable now. I could
also test the patch by store the mail as mbox and patch them with the
"git am" command into the clean repository.
Let me know, if it works to on your side to verify my new patch
process.
Thanks for your work and patience
Silvan

On Son, 2018-05-20 at 11:23 +0100, Jonathan Cameron wrote:
> On Sun, 20 May 2018 02:19:17 +0200
> Silvan Murer <silvan.murer@gmail.com> wrote:
> 
> > 
> > Add support for external reference voltage through the regulator
> > framework.
> > 
> > Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> Content looks fine, but I'm having the same issue with subtle issues
> with
> patch formatting.  Please check and see if you can figure out what is
> causing this.
> 
> Anyhow, I'd like this to sit on the lists a little longer to give
> time for Devicetree binding feedback.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > ---
> > Changes in v3:
> > 	- remove extra spaces and tab
> > Changes in v2:
> > 	- Add 'optional properties' documentation
> > 	- Return an error when a regulator is specified
> > 	- Use internal reference when no regulator is specified
> > 	- Use iio_device_register instead of devm_iio_device_register
> > 
> >  .../devicetree/bindings/iio/dac/ltc2632.txt        | 14 +++++
> >  drivers/iio/dac/ltc2632.c                          | 70
> > +++++++++++++++++++---
> >  2 files changed, 75 insertions(+), 9 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > index eb911e5..e0d5fea 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > @@ -12,12 +12,26 @@ Required properties:
> >  Property rules described in
> > Documentation/devicetree/bindings/spi/spi-bus.txt
> >  apply. In particular, "reg" and "spi-max-frequency" properties
> > must be given.
> >  
> > +Optional properties:
> > +	- vref-supply: Phandle to the external reference voltage
> > supply. This should
> > +	  only be set if there is an external reference voltage
> > connected to the VREF
> > +	  pin. If the property is not set the internal reference
> > is used.
> > +
> >  Example:
> >  
> > +	vref: regulator-vref {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vref-ltc2632";
> > +		regulator-min-microvolt = <1250000>;
> > +		regulator-max-microvolt = <1250000>;
> > +		regulator-always-on;
> > +	};
> > +
> >  	spi_master {
> >  		dac: ltc2632@0 {
> >  			compatible = "lltc,ltc2632-l12";
> >  			reg = <0>; /* CS0 */
> >  			spi-max-frequency = <1000000>;
> > +			vref-supply = <&vref>; /* optional */
> >  		};
> >  	};
> > diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> > index d322b78..9551156 100644
> > --- a/drivers/iio/dac/ltc2632.c
> > +++ b/drivers/iio/dac/ltc2632.c
> > @@ -2,6 +2,7 @@
> >   * LTC2632 Digital to analog convertors spi driver
> >   *
> >   * Copyright 2017 Maxime Roussin-Bélanger
> > + * expanded by Silvan Murer <silvan.murer@gmail.com>
> >   *
> >   * Licensed under the GPL-2.
> >   */
> > @@ -10,6 +11,7 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/module.h>
> >  #include <linux/iio/iio.h>
> > +#include <linux/regulator/consumer.h>
> >  
> >  #define LTC2632_DAC_CHANNELS                    2
> >  
> > @@ -28,7 +30,7 @@
> >  /**
> >   * struct ltc2632_chip_info - chip specific information
> >   * @channels:		channel spec for the DAC
> > - * @vref_mv:		reference voltage
> > + * @vref_mv:		internal reference voltage
> >   */
> >  struct ltc2632_chip_info {
> >  	const struct iio_chan_spec *channels;
> > @@ -39,10 +41,14 @@ struct ltc2632_chip_info {
> >   * struct ltc2632_state - driver instance specific data
> >   * @spi_dev:			pointer to the spi_device
> > struct
> >   * @powerdown_cache_mask	used to show current channel
> > powerdown state
> > + * @vref_mv			used reference voltage
> > (internal or external)
> > + * @vref_reg		regulator for the reference voltage
> >   */
> >  struct ltc2632_state {
> >  	struct spi_device *spi_dev;
> >  	unsigned int powerdown_cache_mask;
> > +	int vref_mv;
> > +	struct regulator *vref_reg;
> >  };
> >  
> >  enum ltc2632_supported_device_ids {
> > @@ -90,7 +96,7 @@ static int ltc2632_read_raw(struct iio_dev
> > *indio_dev,
> >  
> >  	switch (m) {
> >  	case IIO_CHAN_INFO_SCALE:
> > -		*val = chip_info->vref_mv;
> > +		*val = st->vref_mv;
> >  		*val2 = chan->scan_type.realbits;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	}
> > @@ -247,6 +253,45 @@ static int ltc2632_probe(struct spi_device
> > *spi)
> >  	chip_info = (struct ltc2632_chip_info *)
> >  			spi_get_device_id(spi)->driver_data;
> >  
> > +	st->vref_reg = devm_regulator_get_optional(&spi->dev,
> > "vref");
> > +	if (PTR_ERR(st->vref_reg) == -ENODEV) {
> > +		/* use internal reference voltage */
> > +		st->vref_reg = NULL;
> > +		st->vref_mv = chip_info->vref_mv;
> > +
> > +		ret = ltc2632_spi_write(spi,
> > LTC2632_CMD_INTERNAL_REFER,
> > +				0, 0, 0);
> > +		if (ret) {
> > +			dev_err(&spi->dev,
> > +				"Set internal reference command
> > failed, %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	} else if (IS_ERR(st->vref_reg)) {
> > +		dev_err(&spi->dev,
> > +				"Error getting voltage reference
> > regulator\n");
> > +		return PTR_ERR(st->vref_reg);
> > +	} else {
> > +		/* use external reference voltage */
> > +		ret = regulator_enable(st->vref_reg);
> > +		if (ret) {
> > +			dev_err(&spi->dev,
> > +				"enable reference regulator
> > failed, %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +		st->vref_mv = regulator_get_voltage(st->vref_reg)
> > / 1000;
> > +
> > +		ret = ltc2632_spi_write(spi,
> > LTC2632_CMD_EXTERNAL_REFER,
> > +				0, 0, 0);
> > +		if (ret) {
> > +			dev_err(&spi->dev,
> > +				"Set external reference command
> > failed, %d\n",
> > +				ret);
> > +			return ret;
> > +		}
> > +	}
> > +
> >  	indio_dev->dev.parent = &spi->dev;
> >  	indio_dev->name = dev_of_node(&spi->dev) ?
> > dev_of_node(&spi->dev)->name
> >  						 :
> > spi_get_device_id(spi)->name;
> > @@ -255,14 +300,20 @@ static int ltc2632_probe(struct spi_device
> > *spi)
> >  	indio_dev->channels = chip_info->channels;
> >  	indio_dev->num_channels = LTC2632_DAC_CHANNELS;
> >  
> > -	ret = ltc2632_spi_write(spi, LTC2632_CMD_INTERNAL_REFER,
> > 0, 0, 0);
> > -	if (ret) {
> > -		dev_err(&spi->dev,
> > -			"Set internal reference command failed,
> > %d\n", ret);
> > -		return ret;
> > -	}
> > +	return iio_device_register(indio_dev);
> > +}
> > +
> > +static int ltc2632_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct ltc2632_state *st = iio_priv(indio_dev);
> > +
> > +	iio_device_unregister(indio_dev);
> > +
> > +	if (st->vref_reg)
> > +		regulator_disable(st->vref_reg);
> >  
> > -	return devm_iio_device_register(&spi->dev, indio_dev);
> > +	return 0;
> >  }
> >  
> >  static const struct spi_device_id ltc2632_id[] = {
> > @@ -306,6 +357,7 @@ static struct spi_driver ltc2632_driver = {
> >  		.of_match_table = of_match_ptr(ltc2632_of_match),
> >  	},
> >  	.probe		= ltc2632_probe,
> > +	.remove		= ltc2632_remove,
> >  	.id_table	= ltc2632_id,
> >  };
> >  module_spi_driver(ltc2632_driver);
> > -- 
> > 2.7.4
