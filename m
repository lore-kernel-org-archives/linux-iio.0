Return-Path: <SRS0=CFMa=FG=oracle.com=dan.carpenter@kernel.org>
Date: Mon, 12 Feb 2018 16:18:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: 21cnbao@gmail.com, jic23@kernel.org, devel@driverdev.osuosl.org,
        lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 4/4] staging: iio: accel: Move adis16201 driver out of
 staging
Message-ID: <20180212131826.ebazvmp6iv7i5fav@mwanda>
References: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
 <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1518436499-8584-5-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

I think -M is prefered for these types of diffs?  Not sure.

On Mon, Feb 12, 2018 at 05:24:59PM +0530, Himanshu Jha wrote:
> +static int adis16201_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct adis *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->name = spi->dev.driver->name;
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &adis16201_info;
> +
> +	indio_dev->channels = adis16201_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(adis16201_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = adis_init(st, indio_dev, spi, &adis16201_data);
> +	if (ret)
> +		return ret;
> +
> +	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
> +	if (ret)
> +		return ret;

We should clean up the IRQ which we enabled in adis_init() instead of
returning directly.

> +
> +	/* Get the device into a sane initial state */
> +	ret = adis_initial_startup(st);
> +	if (ret)
> +		goto error_cleanup_buffer_trigger;
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret < 0)
> +		goto error_cleanup_buffer_trigger;
> +
> +	return 0;
> +
> +error_cleanup_buffer_trigger:
> +	adis_cleanup_buffer_and_trigger(st, indio_dev);
> +
> +	return ret;
> +}

Otherwise it looks fine to my not-an-iio-expert eye.

regards,
dan carpenter
