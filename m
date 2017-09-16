Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48246 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751294AbdIPWdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Sep 2017 18:33:09 -0400
Date: Sat, 16 Sep 2017 15:33:00 -0700
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad7192: Use the dedicated reset function
Message-ID: <20170916153300.7e2731af@archlinux>
In-Reply-To: <20170916152223.03b1d347@archlinux>
References: <1505397028-15461-1-git-send-email-stefan.popa@analog.com>
        <1c2f62f5-3a64-29a0-7bbf-8545173530f9@analog.com>
        <20170916152223.03b1d347@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 16 Sep 2017 15:22:23 -0700
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 14 Sep 2017 16:31:06 +0200
> Michael Hennerich <michael.hennerich@analog.com> wrote:
> 
> > On 14.09.2017 15:50, Stefan Popa wrote:  
> > > SPI host drivers can use DMA to transfer data, so the buffer should be properly allocated.
> > > Keeping it on the stack could cause an undefined behavior.
> > > 
> > > The dedicated reset function solves this issue.
> > > 
> > > Signed-off-by: Stefan Popa <stefan.popa@analog.com>    
> > 
> > Acked-by: Michael Hennerich <michael.hennerich@analog.com>  
> 
> Applied to the togreg branch of iio.git rather than staging
> branch as the reset functionality is reasonably recent and
> not going to be available in stable kernels etc..
> 
> Good work. I was reading this on a plane the other day and
> noticed the same issue - always nice when someone else
> fixes something on your todo list ;)
> 
> Jonathan

Doh, I had forgotten the support was part of a fix for a different
driver so is only in the fixes-togreg branch of iio.git.

I'll take this one the same way with a bit of a tweak to the patch
title to make it clear it is fixing something.

Jonathan
> 
> > 
> > Well done!
> > 
> >   
> > > ---
> > >   drivers/staging/iio/adc/ad7192.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > > index d11c6de..6150d27 100644
> > > --- a/drivers/staging/iio/adc/ad7192.c
> > > +++ b/drivers/staging/iio/adc/ad7192.c
> > > @@ -223,11 +223,9 @@ static int ad7192_setup(struct ad7192_state *st,
> > >   	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
> > >   	unsigned long long scale_uv;
> > >   	int i, ret, id;
> > > -	u8 ones[6];
> > >   
> > >   	/* reset the serial interface */
> > > -	memset(&ones, 0xFF, 6);
> > > -	ret = spi_write(st->sd.spi, &ones, 6);
> > > +	ret = ad_sd_reset(&st->sd, 48);
> > >   	if (ret < 0)
> > >   		goto out;
> > >   	usleep_range(500, 1000); /* Wait for at least 500us */
> > >     
> > 
> >   
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

