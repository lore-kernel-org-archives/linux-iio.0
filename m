Return-Path: <sst@poczta.fm>
Date: Sun, 20 Mar 2016 11:23:41 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: add driver for Microchip
 MCP413X/414X/415X/416X/423X/424X/425X/426X
Message-ID: <20160320102341.GB10728@x220>
References: <20160319131952.GA10728@x220>
 <alpine.DEB.2.02.1603191437060.15969@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1603191437060.15969@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

On Mar 19, 2016 14:48, Peter Meerwald-Stadler wrote:
> > +#define MCP4131_WIPER_SHIFT	(4)
> 
> () not needed

OK

> > +struct mcp4131_data {
> > +	struct spi_device *spi;
> > +	unsigned long devid;
> > +	struct mutex lock;
> > +	u8 tx[2], rx[2];
> 
> alignment requirements for SPI transfer?

Do you mean the ____cacheline_aligned attribute?
I did not add it because I'm not quite sure why it's needed there. Will have to
find it out...
Could you point me some materials where it's explained?

I think I can drop two separated buffers in favor of one buffer (e.g. buf[2]). I
saw drivers doing that. Do you think that's a good idea?

> > +	data->rx[0] = 0;
> > +	data->rx[1] = 0;
> 
> initialization needed?

No. You're right.

> setup of data->xfer + data->tx is done outside the lock, this seems wrong

True. Will fix it in v3.

> > +	dev_info(&spi->dev, "Registered %s\n", indio_dev->name);
> 
> I'd rather drop this message

OK. Will leave only the dev_info for errors.
 
> > +static int mcp4131_remove(struct spi_device *spi)
> > +{
> > +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +	struct mcp4131_data *data = iio_priv(indio_dev);
> > +
> > +	mutex_destroy(&data->lock);
> 
> no need to call
> 
> > +	devm_iio_device_unregister(&spi->dev, indio_dev);
> 
> don't call this explicitly, it is done automatically after _remove

That's why it's called managed (devm_*)?

> > +
> > +	dev_info(&spi->dev, "Unregistered %s\n", indio_dev->name);
> 
> don't
> 
> I think the entire _remove can be removed

OK.

Thank you for the review. I'm learning a lot!

-- 
Slawomir Stepien
