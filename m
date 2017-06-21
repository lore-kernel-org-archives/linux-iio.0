Return-Path: <SRS0=2+RU=52=pmeerw.net=pmeerw@kernel.org>
Date: Wed, 21 Jun 2017 22:38:17 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: light: tcs3472: fix ATIME register write
In-Reply-To: <20170621202943.214986fd@kernel.org>
Message-ID: <alpine.DEB.2.20.1706212208330.20198@vps.pmeerw.net>
References: <1497279909-11197-1-git-send-email-akinobu.mita@gmail.com> <1497279909-11197-2-git-send-email-akinobu.mita@gmail.com> <20170621202943.214986fd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> > The integration time is controlled by the ATIME register only.  However,
> > this register is written by i2c_smbus_write_word_data() in write_raw().
> > 
> > We actually don't need to write a subsequent register.  So just use
> > i2c_smbus_write_byte_data() instead.

> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> As I read the datasheet, this looks like it won't cause any actual
> harm (where the top byte is written is unused).

looks good to me as well,
Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>

> > ---
> >  drivers/iio/light/tcs3472.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
> > index 3aa71e3..a9e153b 100644
> > --- a/drivers/iio/light/tcs3472.c
> > +++ b/drivers/iio/light/tcs3472.c
> > @@ -169,7 +169,7 @@ static int tcs3472_write_raw(struct iio_dev *indio_dev,
> >  		for (i = 0; i < 256; i++) {
> >  			if (val2 == (256 - i) * 2400) {
> >  				data->atime = i;
> > -				return i2c_smbus_write_word_data(
> > +				return i2c_smbus_write_byte_data(
> >  					data->client, TCS3472_ATIME,
> >  					data->atime);
> >  			}
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
