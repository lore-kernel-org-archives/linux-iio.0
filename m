Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:55151 "EHLO
	smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbcDHRGT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Apr 2016 13:06:19 -0400
Date: Fri, 8 Apr 2016 19:06:06 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: add driver for Maxim Integrated
 DS1803
Message-ID: <20160408170606.GA20159@x220>
References: <20160407165118.GA2333@x220>
 <alpine.DEB.2.02.1604072130040.26969@pmeerw.net>
 <20160408152817.GA2847@x220>
 <alpine.DEB.2.02.1604081755420.8980@pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1604081755420.8980@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Apr 08, 2016 18:00, Peter Meerwald-Stadler wrote:
> 
> > > maybe a #define to explain the name of register 0
> > 
> > Well this zero is not register nor any kind of command that DS1803 needs to send
> > back pots values.
> > DS1803 only requires the standard R/W bit to be set as read.
> > I used _word_ function series to get back a word (16 bits) as this poti returns
> > 16 bits.
> > 
> > How should I named it?
> > 
> > #define NON_COMMAND 0
> > ?
> 
> maybe i2c_transfer() is more appropriate then
> 
>         u8 databuf[2];
>         struct i2c_msg msgs[2] = {
>                 { .addr = client->addr, .len = sizeof(databuf), .buf = databuf,
>                   .flags = I2C_M_RD } };
>         ret = i2c_transfer(client->adapter, msgs, 2);
> 
> this does not send any data to the chip but only reads two bytes

Good point. But maybe the better solution would be to use i2c_master_recv?
Anyhow I will check both options ;)

> > Or should I use different function? (2x i2c_smbus_read_byte?)
> > 
> > The i2c_smbus_read_byte() function also used 0 as command
> > for its transfers...
> 
> > > > +static int ds1803_write_raw(struct iio_dev *indio_dev,
> > > > +			     struct iio_chan_spec const *chan,
> > > > +			     int val, int val2, long mask)
> > > > +{
> > > > +	struct ds1803_data *data = iio_priv(indio_dev);
> > > > +	int pot = chan->channel;
> > > > +
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		if (val > DS1803_MAX_POS || val < 0)
> > > 
> > > check that val2 is 0 or use .write_raw_get_fmt
> > 
> > At this point I do not know why should I do it, but I will look into that.
> 
> write_raw expects a VAL_INT_PLUS_MICROS per default, passed 
> in val and val2
> 
> you can change that with .write_raw_get_fmt (e.g. to expect VAL_INT),
> or just make sure that the micros are 0

Thank you for the explanation.

-- 
Slawomir Stepien
