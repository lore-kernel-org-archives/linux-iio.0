Return-Path: <SRS0=XA61=IK=gmail.com=silvan.murer@kernel.org>
Message-ID: <1527059966.7868.5.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: dac: Add support for external reference
 voltage through the regulator framework.
From: Silvan Murer <silvan.murer@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Wed, 23 May 2018 09:19:26 +0200
In-Reply-To: <20180522182553.2b3ab124@archlinux>
References: <1526905288-28668-1-git-send-email-silvan.murer@gmail.com>
	 <1526905288-28668-3-git-send-email-silvan.murer@gmail.com>
	 <20180522182553.2b3ab124@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Thank you Jonathan

On Die, 2018-05-22 at 18:25 +0100, Jonathan Cameron wrote:
> On Mon, 21 May 2018 14:21:28 +0200
> Silvan Murer <silvan.murer@gmail.com> wrote:
> 
> > 
> > Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
> > Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> Applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> 
> > 
> > ---
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
> >   * Copyright 2017 Maxime Roussin-B_langer
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
