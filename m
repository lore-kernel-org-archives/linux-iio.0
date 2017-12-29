Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755405AbdL2MHN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 07:07:13 -0500
Date: Fri, 29 Dec 2017 12:07:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Ji-Hun Kim <jihuun.k@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        device-drivers-devel@blackfin.uclinux.org,
        devel@driverdev.osuosl.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: iio: add spaces around '-' operator
Message-ID: <20171229120708.3f1b10b7@archlinux>
In-Reply-To: <alpine.DEB.2.20.1712280706110.2220@hadrien>
References: <20171228024927.GA3113@MacBook-Air>
        <alpine.DEB.2.20.1712280706110.2220@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 28 Dec 2017 07:07:17 +0100 (CET)
Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Wed, 27 Dec 2017, Ji-Hun Kim wrote:
> 
> > Clean up checkpatch warning:
> > CHECK: spaces preferred around that '-' (ctx:VxV)
> >
> > Signed-off-by: Ji-Hun Kim <jihuun.k@gmail.com>
> > ---
> >  drivers/staging/iio/adc/ad7192.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> > index f015955..c4eff71 100644
> > --- a/drivers/staging/iio/adc/ad7192.c
> > +++ b/drivers/staging/iio/adc/ad7192.c
> > @@ -340,7 +340,7 @@ ad7192_show_scale_available(struct device *dev,
> >  }
> >
> >  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> > -			     in_voltage-voltage_scale_available,
> > +			     in_voltage - voltage_scale_available,  
> 
> I think this has been discussed at length before, and it is a hyphen not a
> subtraction.  IIO_DEVICE_ATTR_NAMED is a macro, as indicated by the
> capital letters, and you have to look and see what the code expands into.

Technically it is a subtraction, but the symbol rather than the c operator ;)
It's indicating that this sysfs attribute is referring to any
voltage channels minus other voltage channels (differential channels).

Sometimes I wonder if we should leave this there for ever as a way of
getting people to understand that they need to look really closely
at what checkpatch is suggesting and not assume it is right.

Jonathan

> 
> julia
> 
> >  			     0444, ad7192_show_scale_available, NULL, 0);
> >
> >  static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
> > --
> > 2.10.1 (Apple Git-78)
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

