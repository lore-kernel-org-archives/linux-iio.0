Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:49448 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934274AbcAZMde (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Jan 2016 07:33:34 -0500
Date: Tue, 26 Jan 2016 13:33:32 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: pressure: mpl115: fix temperature offset sign
In-Reply-To: <56A4FCCA.80500@kernel.org>
Message-ID: <alpine.DEB.2.02.1601261333010.22166@pmeerw.net>
References: <1453306051-8817-1-git-send-email-akinobu.mita@gmail.com> <56A4FCCA.80500@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Jan 2016, Jonathan Cameron wrote:

> On 20/01/16 16:07, Akinobu Mita wrote:
> > According to the datasheet, the resolusion of temperature sensor is
> > -5.35 counts/C. Temperature ADC is 472 counts at 25C.
> > (https://www.sparkfun.com/datasheets/Sensors/Pressure/MPL115A1.pdf
> > NOTE: This is older revision, but this information is removed from the
> > latest datasheet from nxp somehow)
> > 
> > Temp [C] = (Tadc - 472) / -5.35 + 25
> >          = (Tadc - 605.750000) * -0.186915888
> > 
> > So the correct offset is -605.750000.

Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
 
> > Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald <pmeerw@pmeerw.net>
> > Cc: linux-iio@vger.kernel.org
> Peter,
> 
> I'd like your Ack on this given it is your driver.  That way
> I can be lazy and not cross check the datasheet myself.
> 
> Jonathan
> > ---
> >  drivers/iio/pressure/mpl115.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
> > index 138344c..73f2f0c 100644
> > --- a/drivers/iio/pressure/mpl115.c
> > +++ b/drivers/iio/pressure/mpl115.c
> > @@ -118,7 +118,7 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
> >  		*val = ret >> 6;
> >  		return IIO_VAL_INT;
> >  	case IIO_CHAN_INFO_OFFSET:
> > -		*val = 605;
> > +		*val = -605;
> >  		*val2 = 750000;
> >  		return IIO_VAL_INT_PLUS_MICRO;
> >  	case IIO_CHAN_INFO_SCALE:
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
