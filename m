Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:52152 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755464AbcDHP22 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Apr 2016 11:28:28 -0400
Date: Fri, 8 Apr 2016 17:28:17 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1803
Message-ID: <20160408152817.GA2847@x220>
References: <20160407165118.GA2333@x220>
 <alpine.DEB.2.02.1604072130040.26969@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1604072130040.26969@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Apr 07, 2016 21:36, Peter Meerwald-Stadler wrote:
> 
> > The following functions are supported:
> >  - write, read potentiometer value
> >  - potentiometer scale
> 
> minor comments below, nice driver

Thank you for your comments!

> > +#include <linux/cache.h>
> 
> for what is cache.h needed?

It is not needed here. I will delete it in v2.

> > +static int ds1803_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct ds1803_data *data = iio_priv(indio_dev);
> > +	int pot = chan->channel;
> > +	s32 ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret = i2c_smbus_read_word_swapped(data->client, 0);
> 
> maybe a #define to explain the name of register 0

Well this zero is not register nor any kind of command that DS1803 needs to send
back pots values.
DS1803 only requires the standard R/W bit to be set as read.
I used _word_ function series to get back a word (16 bits) as this poti returns
16 bits.

How should I named it?

#define NON_COMMAND 0
?

Or should I use different function? (2x i2c_smbus_read_byte?)

The i2c_smbus_read_byte() function also used 0 as command
for its transfers...

> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		/* Get bits for given pot */
> > +		*val = (pot == 0 ? ret >> 8 : ret & 255);
> 
> often 0xff is used to mask a byte

OK.

> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val = 1000 * data->cfg->kohms;
> > +		*val2 = DS1803_MAX_POS;
> > +		return IIO_VAL_FRACTIONAL;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int ds1803_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val, int val2, long mask)
> > +{
> > +	struct ds1803_data *data = iio_priv(indio_dev);
> > +	int pot = chan->channel;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		if (val > DS1803_MAX_POS || val < 0)
> 
> check that val2 is 0 or use .write_raw_get_fmt

At this point I do not know why should I do it, but I will look into that.

> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->info = &ds1803_info;
> > +	indio_dev->channels = ds1803_channels;
> > +	indio_dev->num_channels = DS1803_NUM_WIPERS;
> 
> ARRAY_SIZE(ds1803_channels)

Good point.

-- 
Slawomir Stepien
