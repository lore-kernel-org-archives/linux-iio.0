Return-Path: <lars@metafoo.de>
Message-ID: <51FE5CF9.3000608@metafoo.de>
Date: Sun, 04 Aug 2013 15:54:01 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Mario Domenech Goulart <mario@ossystems.com.br>
CC: Otavio Salvador <otavio@ossystems.com.br>,
 Jonathan Cameron <jic23@kernel.org>,
 linux-iio@vger.kernel.org
Subject: Re: RFC: driver for TI ADS124x ADC series
References: <877ggd2fkl.fsf@parenteses.org> <CAP9ODKqt35M833c990JhGeYvQJgK77_my01qdFwahF4xF-iEQw@mail.gmail.com> <51F8B4BE.8000308@metafoo.de> <8761vrymzo.fsf@parenteses.org>
In-Reply-To: <8761vrymzo.fsf@parenteses.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/31/2013 01:42 PM, Mario Domenech Goulart wrote:
[...]
>
> +static void wait_for_drdy(int drdy_gpio)
> +{
> +	u8 drdy;
> +
> +	for (;;) {
> +		drdy = gpio_get_value(drdy_gpio);
> +		if (!drdy)
> +			return;
> +		usleep_range(1000, 2000);
> +	}

As Jonathan said, using a interrupt here is better. But even of you fallback
to polling you need a timeout, otherwise you can easily be stuck here
forever in case the device mallfunctions.

> +}

[...]
> +
> +static int ads124x_probe(struct spi_device *spi)
> +{
> +	struct device_node *np = spi->dev.of_node;
> +	struct iio_dev *indio_dev;
> +	struct ads124x_state *st;
> +	int ret;
> +
> +	indio_dev = iio_device_alloc(sizeof(*st));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	/* Initialize GPIO pins */
> +	st->drdy_gpio = of_get_named_gpio(np, "drdy-gpio", 0);
> +	st->start_gpio = of_get_named_gpio(np, "start-gpio", 0);
> +	st->reset_gpio = of_get_named_gpio(np, "reset-gpio", 0);

All custom properties need a vendor prefix.

> +
> +	ret = devm_gpio_request_one(&indio_dev->dev, st->drdy_gpio,
> +				    GPIOF_IN, "adc-drdy");
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "failed to get adc-drdy-gpios: %d\n",
> +			ret);
> +		goto error;
> +	}
> +
> +	ret = devm_gpio_request_one(&indio_dev->dev, st->start_gpio,
> +				    GPIOF_OUT_INIT_LOW, "adc-start");
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "failed to get adc-start-gpios: %d\n",
> +			ret);
> +		goto error;
> +	}
> +
> +	ret = devm_gpio_request_one(&indio_dev->dev, st->reset_gpio,
> +				    GPIOF_OUT_INIT_LOW, "adc-reset");
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "failed to get adc-reset-gpios: %d\n",
> +			ret);
> +		goto error;
> +	}
> +
> +	ret = of_property_read_u32(np, "vref-mv", &st->vref_mv);
> +	if (ret < 0)
> +		goto error;
> +
> +	/* Initialize SPI */
> +	spi_set_drvdata(spi, indio_dev);
> +	st->spi = spi;
> +	st->spi->mode = SPI_MODE_1;
> +	st->spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = np->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads124x_iio_info;
> +
> +	/* Setup the ADC channels available on the board */
> +	ret = of_property_read_u32(np, "#channels", &indio_dev->num_channels);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = ads124x_init_chan_array(indio_dev, np);
> +	if (ret < 0)
> +		goto error;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret)
> +		goto error;
> +
> +	ads124x_reset(st);
> +	ads124x_start(st);
> +	ads124x_stop_reading_continuously(st);
> +
> +	mutex_init(&st->lock);
> +
> +	return 0;
> +
> +error:
> +	iio_device_free(indio_dev);
> +	dev_err(&spi->dev, "ADS124x: Error while probing.\n");
> +
> +	return ret;
> +}
> +
> +static int ads124x_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct ads124x_state *st;

Maybe do the initialization of st here instead of a few lines down.

> +
> +	iio_device_unregister(indio_dev);
> +	iio_device_free(indio_dev);
> +
> +	st = iio_priv(indio_dev);
> +	mutex_destroy(&st->lock);
> +
> +	return 0;
> +}
