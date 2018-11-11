Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728275AbeKLATU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 19:19:20 -0500
Date: Sun, 11 Nov 2018 14:30:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Message-ID: <20181111142939.316cdd47@archlinux>
In-Reply-To: <30c1ff317baefde88a0f4d0a002b19010290d16b.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
        <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
        <30c1ff317baefde88a0f4d0a002b19010290d16b.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 6 Nov 2018 09:24:44 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Mon, 2018-11-05 at 17:14 -0200, Renato Lui Geh wrote:
> > The ad7780 driver previously did not read the correct device output, as
> > it read an outdated value set at initialization. It now updates its
> > voltage on read.
> >   
> 
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to check it.  I'm not that fussed about pushing this
one as a fix, as most of the time these things are on fixed regulators
anyway, but it is nice to do it right.

> Looks good from my side.
Ack?

Much preferred if you are willing to give a formal acknowledgement.

Thanks,

Jonathan


> 
> Alex
> 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v3:
> > 	- removed initialization (int voltage_uv = 0)
> > 	- returns error when voltage_uv is null
> > Changes in v4:
> > 	- returns error when voltage_uv is negative
> > 
> >  drivers/staging/iio/adc/ad7780.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index b67412db0318..c7cb05cedbbc 100644
> > --- a/drivers/staging/iio/adc/ad7780.c
> > +++ b/drivers/staging/iio/adc/ad7780.c
> > @@ -87,12 +87,16 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> >  			   long m)
> >  {
> >  	struct ad7780_state *st = iio_priv(indio_dev);
> > +	int voltage_uv;
> >  
> >  	switch (m) {
> >  	case IIO_CHAN_INFO_RAW:
> >  		return ad_sigma_delta_single_conversion(indio_dev, chan,
> > val);
> >  	case IIO_CHAN_INFO_SCALE:
> > -		*val = st->int_vref_mv * st->gain;
> > +		voltage_uv = regulator_get_voltage(st->reg);
> > +		if (voltage_uv < 0)
> > +			return voltage_uv;
> > +		*val = (voltage_uv / 1000) * st->gain;
> >  		*val2 = chan->scan_type.realbits - 1;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_OFFSET:  
