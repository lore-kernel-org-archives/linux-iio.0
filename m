Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45461 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751898AbeCCQOR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Mar 2018 11:14:17 -0500
Message-ID: <1520091473.3137.4.camel@gmail.com>
Subject: Re: [PATCH 6/6] Staging: iio: adis16209: Use sign_extend32 and
 adjust a switch statement
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, daniel.baluta@gmail.com
Date: Sat, 03 Mar 2018 21:07:53 +0530
In-Reply-To: <20180303160557.26462aa7@archlinux>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
         <982b80d683b8c8e8c61cbc5b0864c265ea2ac768.1519995673.git.shreeya.patel23498@gmail.com>
         <20180303160557.26462aa7@archlinux>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 2018-03-03 at 16:05 +0000, Jonathan Cameron wrote:
> On Fri,  2 Mar 2018 19:04:49 +0530
> Shreeya Patel <shreeya.patel23498@gmail.com> wrote:
> 
> > 
> > Use sign_extend32 function instead of manually coding it.
> > Also, adjust a switch block to explicitly match channels
> > and return -EINVAL as default case which makes the code
> > semantically more clear.
> > 
> > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> Changes are fine, but 2 changes to different things should be
> in 2 patches.  Please split. I'd probably have taken this anyway if
> it hadn't been queued behind the requested changes to the previous 2
> patches anyway.
> 
> Good work on this series though so looking forward to v3. 
> Note please mark the set as [PATCH v3] to make it clear it
> is the 3rd version of some of this.

Yes, I'll do the changes.

Do I need to include the patches which have been merged from
this series in v3? 

Thanks
> 
> > 
> > ---
> >  drivers/staging/iio/accel/adis16209.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/accel/adis16209.c
> > b/drivers/staging/iio/accel/adis16209.c
> > index 7363fd0..5ab44a4 100644
> > --- a/drivers/staging/iio/accel/adis16209.c
> > +++ b/drivers/staging/iio/accel/adis16209.c
> > @@ -150,10 +150,16 @@ static int adis16209_read_raw(struct iio_dev
> > *indio_dev,
> >  		switch (chan->type) {
> >  		case IIO_VOLTAGE:
> >  			*val = 0;
> > -			if (chan->channel == 0)
> > +			switch (chan->channel) {
> > +			case 0:
> >  				*val2 = 305180; /* 0.30518 mV */
> > -			else
> > +				break;
> > +			case 1:
> >  				*val2 = 610500; /* 0.6105 mV */
> > +				break;
> > +			default:
> > +				return -EINVAL;
> > +			}
> >  			return IIO_VAL_INT_PLUS_MICRO;
> >  		case IIO_TEMP:
> >  			*val = -470;
> > @@ -197,9 +203,8 @@ static int adis16209_read_raw(struct iio_dev
> > *indio_dev,
> >  		ret = adis_read_reg_16(st, addr, &val16);
> >  		if (ret)
> >  			return ret;
> > -		val16 &= (1 << bits) - 1;
> > -		val16 = (s16)(val16 << (16 - bits)) >> (16 -
> > bits);
> > -		*val = val16;
> > +
> > +		*val = sign_extend32(val16, bits - 1);
> >  		return IIO_VAL_INT;
> >  	}
> >  	return -EINVAL;
