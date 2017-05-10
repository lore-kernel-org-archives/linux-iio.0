Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36288 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbdEJNYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 May 2017 09:24:54 -0400
Date: Wed, 10 May 2017 21:24:50 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>,
        Florian Vaussard <florian.vaussard@heig-vd.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: Setup DATA_READY trigger
Message-ID: <20170510132448.GB5456@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
 <CAHp75VcTptSxGnHJzosbio-8PG3ojgr2vfhL9QuUf+OgeCQWGA@mail.gmail.com>
 <20170502121554.GD3030@Socrates-UM>
 <CAHp75Vfu_6Lw-JbuB0ensrP-9hPDKavaSJO0s3wGM8Vm2Gwuhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAHp75Vfu_6Lw-JbuB0ensrP-9hPDKavaSJO0s3wGM8Vm2Gwuhg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, May 03, 2017 at 12:05:00AM +0300, Andy Shevchenko wrote:
> On Tue, May 2, 2017 at 3:15 PM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
> > On Mon, May 01, 2017 at 02:31:00PM +0300, Andy Shevchenko wrote:
> > [...]
> >> > -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> >> > +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >> >                        const char *name);
> >>
> >> I think I commented this once. Instead of increasing parameters,
> >> please introduce a new struct (as separate preparatory patch) which
> >> will hold current parameters. Let's call it
> >> strut adxl345_chip {
> >>  struct device *dev;
> >>  struct regmap *regmap;
> >>  const char *name;
> >> };
> >>
> >> I insisnt in this chage.
> >
> > I'm not sure if what you want is more simpler, is it something like what
> > this driver does?
> 
> Nope. The driver you were referring to does the same you did.
> 
> I'm proposing the above struct to be introduced along with changing
> prototype like:
> 
>  -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> const char *name);
>  +int adxl345_core_probe(struct adxl345_chip *chip);
> 
> In next patch adding interrupt would not touch prototypes at all!
> 

OK, got it. Thanks for clarifying.

> >
> > http://lxr.free-electrons.com/source/drivers/iio/gyro/mpu3050.h#L41
> > http://lxr.free-electrons.com/source/drivers/iio/gyro/mpu3050-i2c.c#L34
> 
> >> > +#include <linux/of_irq.h>
> >>
> >> Can we get rid of gnostic resource providers?
> >>
> >
> > I'm uninformed and still learning. Please let me know how to approach
> > this in some other way.
> 
> I suppose something like platform_get_irq(); to use.
> But it would be nice to you to investigate more.

I had a look and it seems I have to convert to platform_driver in order
to make use of that function. Is this correct?

Eva

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
