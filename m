Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:45708 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbcCTLbh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2016 07:31:37 -0400
Date: Sun, 20 Mar 2016 12:32:18 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: add driver for Microchip
 MCP413X/414X/415X/416X/423X/424X/425X/426X
Message-ID: <20160320113218.GC10728@x220>
References: <20160319131952.GA10728@x220>
 <alpine.DEB.2.02.1603191437060.15969@pmeerw.net>
 <56EE7A81.9010503@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56EE7A81.9010503@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mar 20, 2016 10:25, Jonathan Cameron wrote:
> >> +struct mcp4131_data {
> >> +	struct spi_device *spi;
> 
> This is only used to lookup elements of your cfg array, I'd just have
> a pointer to the relevant element of that array in here instead.
> 
> struct mcp4131_cfg *cfg;
> 
> and in probe do
> data->cfg = &mcp4131_cfg[id];

Great idea. I'll use it in v3.

> >> +	unsigned long devid;
> >> +	struct mutex lock;
> >> +	u8 tx[2], rx[2];
> > 
> > alignment requirements for SPI transfer?
> By which he means put them at the end of this structure and
> mark the with __cacheline_aligned.  It's not technically about alignment
> but rather about ensuring nothing else is in the cacheline which will on some
> spi devices be scrubbed when a transaction occurs.

Thank you for this explanation. I'll move it at the and mark it with the
attribute.

> >> +	data->rx[0] = 0;
> >> +	data->rx[1] = 0;
> > 
> > initialization needed?
> > 
> > setup of data->xfer + data->tx is done outside the lock, this seems wrong
> agreed.

I'll lock the mutex just before switching the mask in _read_raw and in
write_raw like this:

mutex_lock(&data->lock);

switch(mask) {
case IIO_CHAN_INFO_RAW:
(...)
}

mutex_unlock(&data->lock);

> Now I'd change the way you are doing this slightly so that you have
> data->cfg pointing to mcp4131[data->devid].  Moves the 'what part am I?'
> question to a single place in the probe function giving slightly cleaner code.
> >> +		*val = 1000 * mcp4131_cfg[data->devid].kohms;
> >> +		*val2 = mcp4131_cfg[data->devid].max_pos;
> >> +		return IIO_VAL_FRACTIONAL;

Something like this:

		*val = 1000 * data->cfg->kohms;
		*val2 = data->cfg->max_pos;
		mutex_unlock(&data->lock);
		return IIO_VAL_FRACTIONAL;
?

> >> +	dev_info(&spi->dev, "Registered %s\n", indio_dev->name);
> > 
> > I'd rather drop this message
> Agreed, adds noise and it's easy to check if the register succeeded anyway
> by just looking to see if the device is there in sysfs.

OK

> >> +static int mcp4131_remove(struct spi_device *spi)
> >> +{
> >> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> >> +	struct mcp4131_data *data = iio_priv(indio_dev);
> >> +
> >> +	mutex_destroy(&data->lock);
> > 
> > no need to call
> Hmm. This is an oddity, the mutex_destroy exists to aid in debugging locking
> issues by explicity marking the mutex as do not use - iff the mutex
> debugging is enabled.  In this case the storage is promptly deleted anyway
> so any attempt to use the mutex would result in a null pointer dereference
> anyway.  Hence probably not worth having it here.

OK.

Thank your for all the explanations. This helps a lot.

-- 
Slawomir Stepien
