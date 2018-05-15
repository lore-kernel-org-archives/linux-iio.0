Return-Path: <SRS0=8hrw=IC=gmail.com=silvan.murer@kernel.org>
Message-ID: <1526395385.32235.8.camel@gmail.com>
Subject: Re: [PATCH] iio: dac: Add regulator framework to LTC2632 device
 driver
From: Silvan Murer <silvan.murer@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Tue, 15 May 2018 16:43:05 +0200
In-Reply-To: <687efcfb-a9a8-99e7-8a81-150c3a4712a3@metafoo.de>
References: <1526293892.12966.21.camel@gmail.com>
	 <687efcfb-a9a8-99e7-8a81-150c3a4712a3@metafoo.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Thanks Lars for the feedback.
I created just now, a new patch which includes just the of_match_table
fix. For the other stuffe i will create a new version of the patch (v2)
soon. 

On Mon, 2018-05-14 at 13:14 +0200, Lars-Peter Clausen wrote:
> On 05/14/2018 12:31 PM, Silvan Murer wrote:
> > 
> > This patch adds support for external reference voltage through the
> > regulator framework.
> > The patch add also the remove function to the device driver.
> > 
> > Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
> Hi,
> 
> Thanks for the patch. A few comments.
> 
> > 
> > ---
> >  .../devicetree/bindings/iio/dac/ltc2632.txt        |  9 +++
> >  drivers/iio/dac/ltc2632.c                          | 86
> > +++++++++++++++++-----
> >  2 files changed, 78 insertions(+), 17 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > index eb911e5..d369a4b 100644
> > --- a/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > +++ b/Documentation/devicetree/bindings/iio/dac/ltc2632.txt
> > @@ -14,10 +14,19 @@ apply. In particular, "reg" and "spi-max-
> > frequency" properties must be given.
> >  
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
> This should not only update the example, but also add a 'optional
> properties' section where the property is documented.
> 
> > 
> >  		};
> >  	};
> > diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
> > index ac5e05f..4a5c5bd 100644
> > --- a/drivers/iio/dac/ltc2632.c
> > +++ b/drivers/iio/dac/ltc2632.c
> [...
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
> > @@ -247,6 +253,41 @@ static int ltc2632_probe(struct spi_device
> > *spi)
> >  	chip_info = (struct ltc2632_chip_info *)
> >  			spi_get_device_id(spi)->driver_data;
> >  
> > +	st->vref_reg = devm_regulator_get_optional(&spi->dev,
> > "vref");
> > +	if (IS_ERR(st->vref_reg)) {
> There are two error cases that should be handled. One is no regulator
> is
> specified and the other is a regulator is specified, but something
> went
> wrong. In the later case the error should be reported and not
> ignored. Have
> a look at e.g. ad5592r-base.c as an example.
> 
> > 
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
> > +		st->vref_mv = regulator_get_voltage(st-
> > >vref_reg)/1000;
> Should be space around '/'.
> 
> > 
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
> > @@ -255,14 +296,23 @@ static int ltc2632_probe(struct spi_device
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
> > +	return devm_iio_device_register(&spi->dev, indio_dev);
> > +}
> > +
> > +static int ltc2632_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct ltc2632_state *st = iio_priv(indio_dev);
> > +
> > +	devm_iio_device_unregister(&spi->dev, indio_dev);
> > +
> > +	if (st->vref_reg != NULL) {
> > +		regulator_disable(st->vref_reg);
> > +		devm_regulator_put(st->vref_reg);
> >  	}
> >  
> > -	return devm_iio_device_register(&spi->dev, indio_dev);
> > +	devm_iio_device_free(&spi->dev, indio_dev);
> The idea behind the devm_* interface is that you do not explicitly
> call it
> in the remove() callback. It will automatically run after the remove
> function.
> 
> This means in this case you can remove the devm_regulator_put() and
> devm_iio_device_free().
> 
> The devm_iio_device_unregister() still needs to say since we have to
> unregister the device before we disable the regulator. But you can
> simplify
> this by using the non-managed API
> (iio_device_unregister()/iio_device_unregister()).
> 
> > 
> > +	return 0;
> >  }
> >  
> >  static const struct spi_device_id ltc2632_id[] = {
> > @@ -276,15 +326,6 @@ static const struct spi_device_id ltc2632_id[]
> > = {
> >  };
> >  MODULE_DEVICE_TABLE(spi, ltc2632_id);
> >  
> > -static struct spi_driver ltc2632_driver = {
> > -	.driver		= {
> > -		.name	= "ltc2632",
> > -	},
> > -	.probe		= ltc2632_probe,
> > -	.id_table	= ltc2632_id,
> > -};
> > -module_spi_driver(ltc2632_driver);
> > -
> >  static const struct of_device_id ltc2632_of_match[] = {
> >  	{
> >  		.compatible = "lltc,ltc2632-l12",
> > @@ -309,6 +350,17 @@ static const struct of_device_id
> > ltc2632_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, ltc2632_of_match);
> >  
> > +static struct spi_driver ltc2632_driver = {
> > +	.driver		= {
> > +		.name	= "ltc2632",
> > +		.of_match_table = of_match_ptr(ltc2632_of_match),
> It's a bit strange that of_match_table was not assigned in the first
> place.
> I think this should be a separate change and be declared as a fix.
> 
> > 
> > +	},
> > +	.probe		= ltc2632_probe,
> > +	.remove     = ltc2632_remove,
> This line uses tabs for alignment, while all the other lines use
> tabs.
> 
> > 
> > +	.id_table	= ltc2632_id,
> > +};
> > +module_spi_driver(ltc2632_driver);
