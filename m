Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:51252 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeIBNOY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Sep 2018 09:14:24 -0400
Date: Sun, 2 Sep 2018 09:59:16 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathieu Othacehe <m.othacehe@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: isl29501: Simplify code to kill compiler
 warning
Message-ID: <20180902095916.6aa5e5f6@archlinux>
In-Reply-To: <20180825093055.2cee2159@archlinux>
References: <20180823212436.17423-1-geert@linux-m68k.org>
        <20180825093055.2cee2159@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 25 Aug 2018 09:30:55 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 23 Aug 2018 23:24:35 +0200
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> 
> > With gcc 4.1.2:
> > 
> >     drivers/iio/proximity/isl29501.c: In function ‘isl29501_register_write’:
> >     drivers/iio/proximity/isl29501.c:235: warning: ‘msb’ may be used uninitialized in this function
> > 
> > While this is a false positive, it can easily be avoided by removing the
> > "msb" intermediate variable.
> > Remove the "lsb" intermediate variable for consistency.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>  
> 
> Looks sensible to me, but I'd obviously like to leave a little time for 
> Mathieu to comment as it's his driver.
Long enough. I guess Mathieu is busy so I'll apply this (mostly before
it goes so far back in my email that I loose it)

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.  I thought about marking for stable
to reduce noise but decided that compiler is old enough (and I've not
seen it with GCC 8 IIRC) that I wouldn't bother.

Basically I'm taking this on the merits of it being better code rather 
than the warning fix :)

Thanks,

Jonathan
> 
> Jonathan
> 
> > ---
> > Compile-tested only.
> > ---
> >  drivers/iio/proximity/isl29501.c | 12 ++----------
> >  1 file changed, 2 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
> > index e5e94540f404dd2c..5ae549075b27c50d 100644
> > --- a/drivers/iio/proximity/isl29501.c
> > +++ b/drivers/iio/proximity/isl29501.c
> > @@ -232,7 +232,6 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
> >  				   u32 value)
> >  {
> >  	const struct isl29501_register_desc *reg = &isl29501_registers[name];
> > -	u8 msb, lsb;
> >  	int ret;
> >  
> >  	if (!reg->msb && value > U8_MAX)
> > @@ -241,22 +240,15 @@ static u32 isl29501_register_write(struct isl29501_private *isl29501,
> >  	if (value > U16_MAX)
> >  		return -ERANGE;
> >  
> > -	if (!reg->msb) {
> > -		lsb = value & 0xFF;
> > -	} else {
> > -		msb = (value >> 8) & 0xFF;
> > -		lsb = value & 0xFF;
> > -	}
> > -
> >  	mutex_lock(&isl29501->lock);
> >  	if (reg->msb) {
> >  		ret = i2c_smbus_write_byte_data(isl29501->client,
> > -						reg->msb, msb);
> > +						reg->msb, value >> 8);
> >  		if (ret < 0)
> >  			goto err;
> >  	}
> >  
> > -	ret = i2c_smbus_write_byte_data(isl29501->client, reg->lsb, lsb);
> > +	ret = i2c_smbus_write_byte_data(isl29501->client, reg->lsb, value);
> >  
> >  err:
> >  	mutex_unlock(&isl29501->lock);  
> 
