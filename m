Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbeKCWVZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 18:21:25 -0400
Date: Sat, 3 Nov 2018 13:10:02 +0000
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
Subject: Re: [PATCH v3 2/3] staging: iio: ad7780: update voltage on read
Message-ID: <20181103131002.7956a08b@archlinux>
In-Reply-To: <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
        <1bc4bdf6342d4bc0c2fea17fb3bcd79fabf0e1d1.1541082656.git.renatogeh@gmail.com>
        <b0c6d0356b83259e1adad3bf74cca3a56ae33847.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 1 Nov 2018 15:20:55 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Thu, 2018-11-01 at 11:43 -0300, Renato Lui Geh wrote:
> > The ad7780 driver previously did not read the correct device output, as
> > it read an outdated value set at initialization. It now updates its
> > voltage on read.
> > 
> > Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> > ---
> > Changes in v3:
> > 	- removed initialization (int voltage_uv = 0)
> > 	- returns error when voltage_uv is null
> > 
> >  drivers/staging/iio/adc/ad7780.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7780.c
> > b/drivers/staging/iio/adc/ad7780.c
> > index 91e016d534ed..f2a11e9424cd 100644
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
> > +		if (!voltage_uv)  
> 
> This looks wrong.
> I admit this was done in the same way in the probe function, but that looks
> a bit wrong as well.
> 
> Typically, the return value of `regulator_get_voltage()` would get checked
> with:
> 
> ret = regulator_get_voltage(st->reg);
> if (ret < 0)
>    return ret;
> *val = ret / 1000;
> 
> So, negative values are errors and zero & positive values are valid voltage
> values.
This one is a stylistic choice for readability. I ever so slightly
prefer how Alex has it but don't care enough that I'd have commented on it ;)

However, nice to tidy up as you'll be respinning patch 3 anyway!

Thanks,

Jonathan

> 
> > +			return -EINVAL;
> > +		*val = (voltage_uv / 1000) * st->gain;
> >  		*val2 = chan->scan_type.realbits - 1;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >  	case IIO_CHAN_INFO_OFFSET:  
