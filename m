Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:39440 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbeFCOnE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jun 2018 10:43:04 -0400
Date: Sun, 3 Jun 2018 15:43:01 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Tomasz Duszynski <tduszyns@gmail.com>
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix relative humidity unit
Message-ID: <20180603154301.478e4361@archlinux>
In-Reply-To: <20180603154154.0941f5fd@archlinux>
References: <20180528153859.813-1-tduszyns@gmail.com>
        <20180603154154.0941f5fd@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 3 Jun 2018 15:41:54 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 28 May 2018 17:38:59 +0200
> Tomasz Duszynski <tduszyns@gmail.com> wrote:
> 
> > According to IIO ABI relative humidity reading should be
> > returned in milli percent.
> > 
> > This patch addresses that by applying proper scaling and
> > returning integer instead of fractional format type specifier.
> > 
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>  
> 
> I'll be wanting input from Linus on this as he seems to be the last person
> to have taken particular interest in the driver.

Sorry, my email had 'stalled' for some reason so I didn't see the rest of
the thread.

Please ignore.

J
> 
> > ---
> >  drivers/iio/pressure/bmp280-core.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> > index 5ec3e41b65f2..fe87d27779d9 100644
> > --- a/drivers/iio/pressure/bmp280-core.c
> > +++ b/drivers/iio/pressure/bmp280-core.c
> > @@ -415,10 +415,9 @@ static int bmp280_read_humid(struct bmp280_data *data, int *val, int *val2)
> >  	}
> >  	comp_humidity = bmp280_compensate_humidity(data, adc_humidity);
> >  
> > -	*val = comp_humidity;
> > -	*val2 = 1024;
> > +	*val = comp_humidity * 1000 / 1024;  
> 
> Why not just *val = *val * 1000 and leave the rest alone?
> 
> >  
> > -	return IIO_VAL_FRACTIONAL;
> > +	return IIO_VAL_INT;
> >  }
> >  
> >  static int bmp280_read_raw(struct iio_dev *indio_dev,  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

