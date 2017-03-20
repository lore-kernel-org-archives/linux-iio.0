Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34221 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753297AbdCTKel (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Mar 2017 06:34:41 -0400
Received: by mail-pf0-f194.google.com with SMTP id o126so16644418pfb.1
        for <linux-iio@vger.kernel.org>; Mon, 20 Mar 2017 03:34:41 -0700 (PDT)
Date: Mon, 20 Mar 2017 16:04:32 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>,
        outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] staging: iio: accel: adis16201: remove iio_dev mlock
Message-ID: <20170320103432.GA8228@aishwarya>
References: <20170317214356.GA8369@aishwarya>
 <c4f803ee-8a6a-520e-2be3-bb68a57a8303@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c4f803ee-8a6a-520e-2be3-bb68a57a8303@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 19, 2017 at 10:19:42AM +0000, Jonathan Cameron wrote:
> On 17/03/17 21:43, Aishwarya Pant wrote:
> > In the driver adis16201 read raw does not require an iio_dev->mlock for
> > reads. It can run concurrently as adis_read_reg_16() is protected by a
> > transaction lock.
> > 
> > Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> Great, one suggestion for a follow up patch below.
> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> > 
> > ---
> > Changes in v3:
> > 	-- Fix change log format
> > 	-- Send patch to linuc-iio
> > Changes in v2:
> > 	-- Remove read lock
> > 
> >  drivers/staging/iio/accel/adis16201.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
> > index d6c8658..fd2baf2 100644
> > --- a/drivers/staging/iio/accel/adis16201.c
> > +++ b/drivers/staging/iio/accel/adis16201.c
> > @@ -223,17 +223,13 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
> >  		default:
> >  			return -EINVAL;
> >  		}
> > -		mutex_lock(&indio_dev->mlock);
> >  		addr = adis16201_addresses[chan->scan_index];
> >  		ret = adis_read_reg_16(st, addr, &val16);
> Not a lot of point in having the local variable addr given it's
> only used here.  Perhaps you could follow up with a patch getting
> rid of it?

Sure. I will look at clean-up opportunities here. 

But I'm unsure of where I should be rebasing from? 
greg's staging tree or the togreg branch of the iio tree.
https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/
According to the link, togreg was last updated 2 weeks ago.

thanks
Aishwarya


> > -		if (ret) {
> > -			mutex_unlock(&indio_dev->mlock);
> > +		if (ret)
> >  			return ret;
> > -		}
> >  		val16 &= (1 << bits) - 1;
> >  		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
> >  		*val = val16;
> > -		mutex_unlock(&indio_dev->mlock);
> >  		return IIO_VAL_INT;
> >  	}
> >  	return -EINVAL;
> > 
> 
