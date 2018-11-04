Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.239]:32884 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728909AbeKDUDB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 15:03:01 -0500
Date: Sun, 4 Nov 2018 11:48:45 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v4 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181104104845.GA1600@x220.localdomain>
References: <20181029165241.22993-1-sst@poczta.fm>
 <20181103122108.6124f55a@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181103122108.6124f55a@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On lis 03, 2018 12:21, Jonathan Cameron wrote:
> On Mon, 29 Oct 2018 17:52:41 +0100
> Slawomir Stepien <sst@poczta.fm> wrote:
> 
> > devm_* APIs are device managed and make code simpler.
> > 
> > Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> Very nearly perfect (I think).
> 
> But there is one path where we don't quite manage to clean everything up.

Or maybe more than on. See below and in v5.

> > ---
> Also, I should be seeing a version log here to avoid me having to look back
> at previous versions (potentially) to remind me what needed changing.

I am so sorry about that. Will add the whole history in v5.

> > @@ -909,65 +917,41 @@ static int ad7280_probe(struct spi_device *spi)
> >  
> >  	ret = ad7280_attr_init(st);
> >  	if (ret < 0)
> > -		goto error_free_channels;
> > +		return ret;
> >  
> > -	ret = iio_device_register(indio_dev);
> > +	ret = devm_add_action(&spi->dev, ad7280_sw_power_down, st);
> >  	if (ret)
> What state are we left in if the devm_add_action fails?
> 
> Answer: Everything is unwound except the thing we were adding the action
> for.  So you need to call ad7280_sw_power_down in the error path here.

OK. I have also moved the devm_add_action call just after spi_setup in v5. So
the action will be also called for fail in: ad7280_chain_setup,
ad7280_channel_init and ad7280_attr_init. I think it is ok to do so if we are
calling this action also when devm_add_action fails.

> > -		goto error_free_attr;
> > +		return ret;

Thank you for review!

-- 
Slawomir Stepien
