Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:36888 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbaFDImT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 4 Jun 2014 04:42:19 -0400
Date: Wed, 4 Jun 2014 10:42:18 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Lars-Peter Clausen <lars@metafoo.de>
cc: linux-iio@vger.kernel.org, knaack.h@gmx.de
Subject: Re: [PATCH 11/15] iio:adc:ad799x: Add helper function to read/write
 config register
In-Reply-To: <538ED344.1030604@metafoo.de>
Message-ID: <alpine.DEB.2.01.1406041036070.12546@pmeerw.net>
References: <1401835335-29969-1-git-send-email-pmeerw@pmeerw.net> <1401835335-29969-12-git-send-email-pmeerw@pmeerw.net> <538ED344.1030604@metafoo.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> Should this and patch 13 be considered a bug fix?

patch 11 is not a bug fix; the ad799x driver did update the CONF_REG on 
ad7997 and ad7998 only

patch 13 is a bug fix I think; on ad7992/3/4 no channels were ever 
enabled, hence no events

> > ---
> >   drivers/iio/adc/ad799x.c | 24 ++++++++++++++++++++++++
> >   1 file changed, 24 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> > index dbc7c2b..0219970 100644
> > --- a/drivers/iio/adc/ad799x.c
> > +++ b/drivers/iio/adc/ad799x.c
> > @@ -136,6 +136,30 @@ struct ad799x_state {
> >   	unsigned int			transfer_size;
> >   };
> > 
> > +static int ad799x_write_config(struct ad799x_state *st, u16 val)
> > +{
> > +	switch (st->id) {
> > +	case ad7997:
> > +	case ad7998:
> > +		return i2c_smbus_write_word_swapped(st->client,
> > AD7998_CONF_REG,
> > +			val);
> > +	default:
> > +		return i2c_smbus_write_byte_data(st->client, AD7998_CONF_REG,
> > +			val);
> > +	}
> > +}
> > +
> > +static int ad799x_read_config(struct ad799x_state *st)
> > +{
> > +	switch (st->id) {
> > +	case ad7997:
> > +	case ad7998:
> > +		return i2c_smbus_read_word_swapped(st->client,
> > AD7998_CONF_REG);
> > +	default:
> > +		return i2c_smbus_read_byte_data(st->client, AD7998_CONF_REG);
> > +	}
> > +}
> > +
> >   /**
> >    * ad799x_trigger_handler() bh of trigger launched polling to ring buffer
> >    *
> > 
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
