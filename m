Return-Path: <SRS0=Wk9p=NS=babblebit.net=cmc@kernel.org>
Date: Wed, 7 Nov 2018 09:18:44 +0000
From: Chris Coffey <cmc@babblebit.net>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Slawomir Stepien <sst@poczta.fm>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Message-ID: <20181107091844.v4mnwus4h7s4rbwg@deb-660>
References: <20181106113130.9612-1-cmc@babblebit.net>
 <6f3ead94-b1ed-900d-b675-3822d67dbfd7@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6f3ead94-b1ed-900d-b675-3822d67dbfd7@axentia.se>
List-ID: <linux-iio@vger.kernel.org>

Thank you for the review! A few comments inline.

On Tue, Nov 06, 2018 at 04:37:11PM +0000, Peter Rosin wrote:
> Hi!
> 
> Some comments inline...
> 
> On 2018-11-06 12:31, Chris Coffey wrote:
> > This patch adds driver support for the Microchip MCP41xxx/42xxx family
> > of digital potentiometers:
> > 

[snip]

> > +
> > +	data->buf[0] = MCP41010_WIPER_ENABLE << channel;
> > +	data->buf[0] |= MCP41010_WRITE;
> 
> Will this not clobber the other channel for mcp42xxx chips???
> 

I see you followed up on this in another message, so I'll respond there.

[snip]

> > +static int mcp41010_probe(struct spi_device *spi)
> > +{
> > +	int err;
> > +	struct device *dev = &spi->dev;
> > +	unsigned long devid = spi_get_device_id(spi)->driver_data;
> > +	struct mcp41010_data *data;
> > +	struct iio_dev *indio_dev;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	spi_set_drvdata(spi, indio_dev);
> > +	data->spi = spi;
> > +	data->cfg = &mcp41010_cfg[devid];
> 
> I'm missing a "of_device_get_match_data(dev)" call somewhere in here, see e.g. the
> max5481.c file in this directory. Yes, that's missing from the mcp4131 driver as
> well, but that's not a valid reason for not doing it here AFAICT...
> 
> Cheers,
> Peter
> 

Ah, interesting; I was unaware of of_device_get_match_data(). I'll add
that for v2.

Thanks again,
Chris
