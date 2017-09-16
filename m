Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbdIPWW2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Sep 2017 18:22:28 -0400
Date: Sat, 16 Sep 2017 15:22:23 -0700
From: Jonathan Cameron <jic23@kernel.org>
To: Michael Hennerich <michael.hennerich@analog.com>
Cc: Stefan Popa <stefan.popa@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: ad7192: Use the dedicated reset function
Message-ID: <20170916152223.03b1d347@archlinux>
In-Reply-To: <1c2f62f5-3a64-29a0-7bbf-8545173530f9@analog.com>
References: <1505397028-15461-1-git-send-email-stefan.popa@analog.com>
        <1c2f62f5-3a64-29a0-7bbf-8545173530f9@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Sep 2017 16:31:06 +0200
Michael Hennerich <michael.hennerich@analog.com> wrote:

> On 14.09.2017 15:50, Stefan Popa wrote:
> > SPI host drivers can use DMA to transfer data, so the buffer should be properly allocated.
> > Keeping it on the stack could cause an undefined behavior.
> > 
> > The dedicated reset function solves this issue.
> > 
> > Signed-off-by: Stefan Popa <stefan.popa@analog.com>  
> 
> Acked-by: Michael Hennerich <michael.hennerich@analog.com>

Applied to the togreg branch of iio.git rather than staging
branch as the reset functionality is reasonably recent and
not going to be available in stable kernels etc..

Good work. I was reading this on a plane the other day and
noticed the same issue - always nice when someone else
fixes something on your todo list ;)

Jonathan

> 
> Well done!
> 
> 
> > ---
> >   drivers/staging/iio/adc/ad7192.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index d11c6de..6150d27 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -223,11 +223,9 @@ static int ad7192_setup(struct ad7192_state *st,
> >   	struct iio_dev *indio_dev = spi_get_drvdata(st->sd.spi);
> >   	unsigned long long scale_uv;
> >   	int i, ret, id;
> > -	u8 ones[6];
> >   
> >   	/* reset the serial interface */
> > -	memset(&ones, 0xFF, 6);
> > -	ret = spi_write(st->sd.spi, &ones, 6);
> > +	ret = ad_sd_reset(&st->sd, 48);
> >   	if (ret < 0)
> >   		goto out;
> >   	usleep_range(500, 1000); /* Wait for at least 500us */
> >   
> 
> 

