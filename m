Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeCXOE4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 10:04:56 -0400
Date: Sat, 24 Mar 2018 14:04:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Julian Veenstra <davidjulianveenstra@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH 05/11] staging: iio: ad2s1200: Introduce variable for
 repeated value
Message-ID: <20180324140451.54add9cb@archlinux>
In-Reply-To: <87efk9mznl.fsf@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
        <bee0f530c7bc4756a1c4fd3b533a6496d17d1a62.1521379685.git.davidjulianveenstra@gmail.com>
        <20180323141703.000028b5@huawei.com>
        <87efk9mznl.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 24 Mar 2018 13:22:22 +0100
David Julian Veenstra <davidjulianveenstra@gmail.com> wrote:

> On 23, March 2018 14:17, Jonathan Cameron wrote:
> 
> > On Sun, 18 Mar 2018 14:35:46 +0100
> > David Veenstra <davidjulianveenstra@gmail.com> wrote:
> >  
> >> Add variable to hold &spi->dev in ad2s1200_probe. This value is repeatedly
> >> used in ad2s1200_probe.
> >> 
> >> Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>  
> > I'm a little unconvinced by this one. It adds code to save
> > a really very trivial bit of repetition.  If it had been
> > via another pointer or this would have made a big difference
> > in number of lines by bringing a lot of entries below 80 chars
> > that weren't previous, then there would be a good argument.
> >
> > Here, not so much.  
> 
> The 9th patch adds another 4 occurrences. So in total &st->dev appears
> 9 times in ad2s1200_probe. To me it seemed worth it to
> introduce a variable for it. But I agree that it doesn't add much.
> 
> Best regards,
> David Veenstra
> 
OK, up to you then, I don't care enough to resist the change.

Jonathan


> >
> > Jonathan  
> >> ---
> >>  drivers/staging/iio/resolver/ad2s1200.c | 13 ++++++++-----
> >>  1 file changed, 8 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
> >> index 00efba598671..eceb86e952de 100644
> >> --- a/drivers/staging/iio/resolver/ad2s1200.c
> >> +++ b/drivers/staging/iio/resolver/ad2s1200.c
> >> @@ -118,19 +118,22 @@ static int ad2s1200_probe(struct spi_device *spi)
> >>  	unsigned short *pins = spi->dev.platform_data;
> >>  	struct ad2s1200_state *st;
> >>  	struct iio_dev *indio_dev;
> >> +	struct device *dev;
> >>  	int pn, ret = 0;
> >>  
> >> +	dev = &spi->dev;
> >> +
> >>  	for (pn = 0; pn < AD2S1200_PN; pn++) {
> >> -		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
> >> +		ret = devm_gpio_request_one(dev, pins[pn], GPIOF_DIR_OUT,
> >>  					    DRV_NAME);
> >>  		if (ret) {
> >> -			dev_err(&spi->dev, "request gpio pin %d failed\n",
> >> +			dev_err(dev, "request gpio pin %d failed\n",
> >>  				pins[pn]);
> >>  			return ret;
> >>  		}
> >>  	}
> >>  
> >> -	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> >> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> >>  	if (!indio_dev)
> >>  		return -ENOMEM;
> >>  
> >> @@ -141,14 +144,14 @@ static int ad2s1200_probe(struct spi_device *spi)
> >>  	st->sample = pins[0];
> >>  	st->rdvel = pins[1];
> >>  
> >> -	indio_dev->dev.parent = &spi->dev;
> >> +	indio_dev->dev.parent = dev;
> >>  	indio_dev->info = &ad2s1200_info;
> >>  	indio_dev->modes = INDIO_DIRECT_MODE;
> >>  	indio_dev->channels = ad2s1200_channels;
> >>  	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
> >>  	indio_dev->name = spi_get_device_id(spi)->name;
> >>  
> >> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
> >> +	ret = devm_iio_device_register(dev, indio_dev);
> >>  	if (ret)
> >>  		return ret;
> >>    
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

