Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.206]:45037 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751031AbdAPRJ6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 12:09:58 -0500
Date: Mon, 16 Jan 2017 18:10:26 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, matthew.weber@rockwellcollins.com,
        maury.anderson@rockwellcollins.com, devicetree@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3] iio: max5481: Add support for Maxim digital
 potentiometers
Message-ID: <20170116171026.GA1676@x220.localdomain>
References: <20170114212139.GA3418@x220.localdomain>
 <e48d9285-a077-36b3-b904-d9cf95c50a82@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e48d9285-a077-36b3-b904-d9cf95c50a82@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Jan 15, 2017 14:27, Jonathan Cameron wrote:
> A few more bits an pieces.
> 
> Thanks,

Thanks for the review!

> Jonathan
> > ---
> > +static int max5481_write_cmd(struct max5481_data *data, u8 cmd, u16 val)
> > +{
> > +	struct spi_device *spi = data->spi;
> > +
> > +	data->msg[0] = cmd;
> > +
> > +	switch (cmd) {
> > +	case MAX5481_WRITE_WIPER:
> > +		data->msg[1] = val >> 2;
> > +		data->msg[2] = (val & 0x3) << 6;
> > +		return spi_write(spi, data->msg, ARRAY_SIZE(data->msg));
> array_size will give you the number of elements in the array. Here that
> is fine, but inconsistent with the use of sizeof(data->msg[0]) below.

Yes, you are right.
Do you think that plain 3 and 1 below will be OK in this case? This is the way
the protocol is defined.
Or maybe ARRAY_SIZE above is OK, but below I will just write 1?

> > +
> > +	case MAX5481_COPY_AB_TO_NV:
> > +	case MAX5481_COPY_NV_TO_AB:
> > +		return spi_write(spi, data->msg, sizeof(data->msg[0]));
> > +
> > +	default:
> > +		return -EIO;
> > +	}
> > +}
> > +
> > (...)
> > +static int max5481_probe(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct max5481_data *data;
> > +	const struct spi_device_id *id = spi_get_device_id(spi);
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	dev_set_drvdata(&spi->dev, indio_dev);
> > +	data = iio_priv(indio_dev);
> > +
> > +	data->spi = spi;
> To use the of data you have below this will need different handling,
> specifically the use of of_match_device to get access to the data.
> See something like adc/max1363 for how to do this.

OK thanks!

> > +	data->cfg = &max5481_cfg[id->driver_data];
> > +
> > +	indio_dev->name = id->name;
> > +	indio_dev->dev.parent = &spi->dev;
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +
> > +	/* variant specific configuration */
> > +	indio_dev->info = &max5481_info;
> > +	indio_dev->channels = max5481_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(max5481_channels);
> > +
> > +	/* restore wiper from NV */
> > +	ret = max5481_write_cmd(data, MAX5481_COPY_NV_TO_AB, 0);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	return iio_device_register(indio_dev);
> > +}
> > (...)
> > +MODULE_AUTHOR("Maury Anderson <maury.anderson@rockwellcollins.com>");
> > +MODULE_DESCRIPTION("max5481 SPI driver");
> > +MODULE_LICENSE("GPL v2");
> > 
> 1

Do you mean:
MODULE_LICENSE("GPL");
?

-- 
Slawomir Stepien
