Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbdIJPZP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Sep 2017 11:25:15 -0400
Date: Sun, 10 Sep 2017 16:25:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dragos Bogdan <dragos.bogdan@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ad7793: Fix the serial interface reset
Message-ID: <20170910162510.087415ad@archlinux>
In-Reply-To: <39dcf265-8917-cec5-6165-83f9a53c7888@metafoo.de>
References: <20170905121613.26969-1-dragos.bogdan@analog.com>
        <39dcf265-8917-cec5-6165-83f9a53c7888@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 5 Sep 2017 14:17:21 +0200
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 09/05/2017 02:16 PM, Dragos Bogdan wrote:
> > The serial interface can be reset by writing 32 consecutive 1s to the device.
> > 'ret' was initialized correctly but its value was overwritten when
> > ad7793_check_platform_data() was called. Since a dedicated reset function
> > is present now, it should be used instead.
> > 
> > Fixes: 2edb769d246e ("iio:ad7793: Add support for the ad7798 and ad7799")
> > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>  
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks

Jonathan
> 
> > ---
> >  drivers/iio/adc/ad7793.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> > index e6706a09e100..47c3d7f32900 100644
> > --- a/drivers/iio/adc/ad7793.c
> > +++ b/drivers/iio/adc/ad7793.c
> > @@ -257,7 +257,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
> >  	unsigned int vref_mv)
> >  {
> >  	struct ad7793_state *st = iio_priv(indio_dev);
> > -	int i, ret = -1;
> > +	int i, ret;
> >  	unsigned long long scale_uv;
> >  	u32 id;
> >  
> > @@ -266,7 +266,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
> >  		return ret;
> >  
> >  	/* reset the serial interface */
> > -	ret = spi_write(st->sd.spi, (u8 *)&ret, sizeof(ret));
> > +	ret = ad_sd_reset(&st->sd, 32);
> >  	if (ret < 0)
> >  		goto out;
> >  	usleep_range(500, 2000); /* Wait for at least 500us */
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

