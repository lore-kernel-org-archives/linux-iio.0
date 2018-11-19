Return-Path: <SRS0=1ZJt=N6=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 19 Nov 2018 13:48:40 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Chris Coffey <cmc@babblebit.net>
CC: Jonathan Cameron <jic23@kernel.org>, Slawomir Stepien <sst@poczta.fm>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Peter Rosin <peda@axentia.se>,
	"Rob Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181119134840.00006108@huawei.com>
In-Reply-To: <20181117203130.efhp4amahjx3qxwo@deb-660>
References: <20181114095241.27037-1-cmc@babblebit.net>
	<20181114095241.27037-3-cmc@babblebit.net>
	<20181114103015.GB1214@x220.localdomain>
	<20181116181043.7a8d48dc@archlinux>
	<20181117203130.efhp4amahjx3qxwo@deb-660>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Sat, 17 Nov 2018 20:31:30 +0000
Chris Coffey <cmc@babblebit.net> wrote:

> On Fri, Nov 16, 2018 at 06:10:43PM +0000, Jonathan Cameron wrote:
> > On Wed, 14 Nov 2018 11:30:15 +0100
> > Slawomir Stepien <sst@poczta.fm> wrote:
> >   
> > > On lis 14, 2018 09:52, Chris Coffey wrote:  
> > > > This patch adds driver support for the Microchip MCP41xxx/42xxx family
> > > > of digital potentiometers:
> > > > 
> > > > DEVICE      Wipers  Positions   Resistance (kOhm)
> > > > MCP41010    1       256         10
> > > > MCP41050    1       256         50
> > > > MCP41100    1       256         100
> > > > MCP42010    2       256         10
> > > > MCP42050    2       256         50
> > > > MCP42100    2       256         100
> > > > 
> > > > Datasheet: http://ww1.microchip.com/downloads/en/devicedoc/11195c.pdf    
> > > 
> > > Hi
> > > 
> > > Some hints inline.  
> > A few minor comments from me.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Thank you for the review; I have one question below.
> 
> Thanks,
> Chris
> 
> [snip]
> 
> > > > +static int mcp41010_probe(struct spi_device *spi)
> > > > +{
> > > > +	int err;
> > > > +	struct device *dev = &spi->dev;
> > > > +	unsigned long devid = spi_get_device_id(spi)->driver_data;    
> > > 
> > > I guess the calculation of devid value can now be done only when
> > > of_device_get_match_data() did not return config.
> > >   
> > > > +	struct mcp41010_data *data;
> > > > +	struct iio_dev *indio_dev;
> > > > +
> > > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > > +	if (!indio_dev)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	data = iio_priv(indio_dev);
> > > > +	spi_set_drvdata(spi, indio_dev);
> > > > +	data->spi = spi;
> > > > +	data->cfg = of_device_get_match_data(&spi->dev);
> > > > +	if (!data->cfg)
> > > > +		data->cfg = &mcp41010_cfg[devid];
> > > > +
> > > > +	mutex_init(&data->lock);
> > > > +
> > > > +	indio_dev->dev.parent = dev;
> > > > +	indio_dev->info = &mcp41010_info;
> > > > +	indio_dev->channels = mcp41010_channels;
> > > > +	indio_dev->num_channels = data->cfg->wipers;
> > > > +	indio_dev->name = spi_get_device_id(spi)->name;  
> > 
> > It is a bit odd to use the of match for the data, but
> > then get the name always from the spi_device_id table.
> > We probably need a separate source for the names such
> > as in the config structure.
> >   
> 
> I see what you mean. Is this something you'd like me to do for v3 (add
> the names to the config struct), or were you thinking more in the
> abstract, "this is something we should consider doing in the future"?
If we are going to explicitly support he of_device_get_match_data
path then we should do the names as well in v3.

Just end up with an odd half measure otherwise!

Jonathan
> 
> [snip]
