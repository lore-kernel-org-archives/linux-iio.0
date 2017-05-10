Return-Path: <SRS0=fcpV=4Q=gmail.com=eraretuya@kernel.org>
Date: Wed, 10 May 2017 21:31:38 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-iio@vger.kernel.org,
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
Message-ID: <20170510133137.GC5456@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
 <CAHp75VcTptSxGnHJzosbio-8PG3ojgr2vfhL9QuUf+OgeCQWGA@mail.gmail.com>
 <20170502121554.GD3030@Socrates-UM>
 <4fb7b73e-e1e6-9e7b-bf60-87d3842c57cc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4fb7b73e-e1e6-9e7b-bf60-87d3842c57cc@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 05, 2017 at 07:26:06PM +0100, Jonathan Cameron wrote:
> On 02/05/17 13:15, Eva Rachel Retuya wrote:
> > On Mon, May 01, 2017 at 02:31:00PM +0300, Andy Shevchenko wrote:
> > [...]
> >>> -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> >>> +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >>>                        const char *name);
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
> > 
> > http://lxr.free-electrons.com/source/drivers/iio/gyro/mpu3050.h#L41
> > http://lxr.free-electrons.com/source/drivers/iio/gyro/mpu3050-i2c.c#L34
> > 
> >>
> >>>  #include <linux/delay.h>
> >>> +#include <linux/interrupt.h>
> >>>  #include <linux/module.h>
> >>
> >>> +#include <linux/of_irq.h>
> >>
> >> Can we get rid of gnostic resource providers?
> >>
> > 
> > I'm uninformed and still learning. Please let me know how to approach
> > this in some other way.
> > 
> >>> +static const struct iio_trigger_ops adxl345_trigger_ops = {
> >>
> >>> +       .owner = THIS_MODULE,
> >>
> >> Do we still need this kind of lines?
> >>
> > 
> > I'm not sure either.
> > Jonathan, is it OK to omit this and also the one below?
> No it's not.  There are ways avoiding the necessity of specifying this
> via some macro magic.  It could be done easily enough but hasn't been
> yet.
> 
> > 
> >>> +       .set_trigger_state = adxl345_drdy_trigger_set_state,
> >>> +};
> >>
> >>>  static const struct iio_info adxl345_info = {
> >>
> >>>         .driver_module  = THIS_MODULE,
> >>
> >> Ditto, though it's in the current code.
> Same issue.  Could be fixed, but right now you need them.

Noted, I will leave them as-is.

> 
> Patches welcome ;)  Basic eventual aim would be to drop
> these fields from the structures entirely but obviously
> there would have to be some intermediate steps.>

I'll suggest this as a coding task for Outreachy.

Thanks,
Eva

> >>>         .read_raw       = adxl345_read_raw,
> >>>  };
> >>
> >>> +       /*
> >>> +        * Any bits set to 0 send their respective interrupts to the INT1 pin,
> >>> +        * whereas bits set to 1 send their respective interrupts to the INT2
> >>> +        * pin. Map all interrupts to the specified pin.
> >>> +        */
> >>> +       of_irq = of_irq_get_byname(dev->of_node, "INT2");
> >>
> >> So, can we get it in resourse provider agnostic way?
> >>
> >>> +       if (of_irq == irq)
> >>> +               regval = 0xFF;
> >>> +       else
> >>> +               regval = 0x00;
> >>
> >> regval = of_irq == irq ? 0xff : 0x00; ?
> >>
> > 
> > OK.
> > 
> > Thanks,
> > Eva
> > 
> >>> +
> >>> +       ret = regmap_write(data->regmap, ADXL345_REG_INT_MAP, regval);
> >>> +       if (ret < 0) {
> >>> +               dev_err(dev, "Failed to set up interrupts: %d\n", ret);
> >>> +               return ret;
> >>> +       }
> >>
> >> -- 
> >> With Best Regards,
> >> Andy Shevchenko
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
