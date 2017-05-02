Return-Path: <SRS0=/UZX=4I=gmail.com=eraretuya@kernel.org>
Date: Tue, 2 May 2017 19:59:18 +0800
From: Eva Rachel Retuya <eraretuya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, dmitry.torokhov@gmail.com,
	michael.hennerich@analog.com, daniel.baluta@gmail.com,
	amsfield22@gmail.com, florian.vaussard@heig-vd.ch,
	linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 3/4] iio: accel: adxl345: Setup DATA_READY trigger
Message-ID: <20170502115917.GC3030@Socrates-UM>
References: <cover.1493450577.git.eraretuya@gmail.com>
 <d5c737cf4e5a2d639d09ad95f58ab32e01d0c338.1493450577.git.eraretuya@gmail.com>
 <977684c1-8c87-80ae-fc13-576e30e88384@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <977684c1-8c87-80ae-fc13-576e30e88384@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, May 01, 2017 at 01:32:00AM +0100, Jonathan Cameron wrote:
[...]
> Coming together nicely, but a few more bits and pieces inline...
> 
> One slight worry is that the irq names stuff is to restrictive
> as we want to direct different interrupts to different pins if
> both are supported!
> 
> Jonathan
[...]
> > +#define ADXL345_IRQ_NAME		"adxl345_event"
> I'd just put this inline.  It doesn't really give any benefit to
> have this defined at the top.

Ack.

> > +
> >  /*
> >   * In full-resolution mode, scale factor is maintained at ~4 mg/LSB
> >   * in all g ranges.
> > @@ -49,6 +56,8 @@
> >  static const int adxl345_uscale = 38300;
> >  
> >  struct adxl345_data {
> > +	struct iio_trigger *data_ready_trig;
> > +	bool data_ready_trig_on;
> >  	struct regmap *regmap;
> >  	struct mutex lock; /* protect this data structure */
> >  	u8 data_range;
> > @@ -158,17 +167,62 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
> >  	return -EINVAL;
> >  }
> >  
[...]
> > -int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> > +int adxl345_core_probe(struct device *dev, struct regmap *regmap, int irq,
> >  		       const char *name)
> >  {
> >  	struct adxl345_data *data;
> >  	struct iio_dev *indio_dev;
> >  	u32 regval;
> > +	int of_irq;
> >  	int ret;
> >  
> >  	ret = regmap_read(regmap, ADXL345_REG_DEVID, &regval);
> > @@ -199,6 +253,22 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> >  		dev_err(dev, "Failed to set data range: %d\n", ret);
> >  		return ret;
> >  	}
> > +	/*
> > +	 * Any bits set to 0 send their respective interrupts to the INT1 pin,
> > +	 * whereas bits set to 1 send their respective interrupts to the INT2
> > +	 * pin. Map all interrupts to the specified pin.
> This is an interesting comment.  The usual reason for dual interrupt
> pins is precisely to not map all functions to the same one.  That allows
> for a saving in querying which interrupt it is by having just the data ready
> on one pin and just the events on the other...
> 
> Perhaps the current approach won't support that mode of operation?
> Clearly we can't merge a binding that enforces them all being the same
> and then change it later as it'll be incompatible.
> 

I've thought about this before since to me that's the better approach
than one or the other. I'm in a time crunch before hence I went with
this way. The input driver does this as well and what I just did is to
match what it does. If you could point me some drivers for reference,
I'll gladly analyze those and present something better on the next
revision.

Thanks,
Eva

> I'm not quite sure how one should do this sort of stuff in DT though.
> 
> Rob?
> > +	 */
> > +	of_irq = of_irq_get_byname(dev->of_node, "INT2");
> > +	if (of_irq == irq)
> > +		regval = 0xFF;
> > +	else
> > +		regval = 0x00;
> > +
> > +	ret = regmap_write(data->regmap, ADXL345_REG_INT_MAP, regval);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to set up interrupts: %d\n", ret);
> > +		return ret;
> > +	}
> >  
> >  	mutex_init(&data->lock);
> >  
