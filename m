Return-Path: <SRS0=22p1=KH=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 23 Jul 2018 15:55:14 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Kent Gustavsson <kent@minoris.se>, Hartmut Knaack
	<knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: add support for mcp3911
Message-ID: <20180723155514.00006820@huawei.com>
In-Reply-To: <20180722190051.GB27516@gmail.com>
References: <20180721195923.7610-1-marcus.folkesson@gmail.com>
	<alpine.DEB.2.21.1807212259480.13457@vps.pmeerw.net>
	<20180722090838.0080aaf5@archlinux>
	<20180722190051.GB27516@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Sun, 22 Jul 2018 21:00:51 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Hi Jonathan,
> 
> Thanks, all good catches.
> 
> On Sun, Jul 22, 2018 at 09:08:38AM +0100, Jonathan Cameron wrote:
> > On Sat, 21 Jul 2018 23:19:48 +0200 (CEST)
> > Peter Meerwald-Stadler <pmeerw@pmeerw.net> wrote:
> >   
> > > Hello,
> > >   
> > > > MCP3911 is a dual channel Analog Front End (AFE) containing two
> > > > synchronous sampling delta-sigma Analog-to-Digital Converters (ADC).    
> > > 
> > > some comments below...  
> > 
> > +CC Mark for the unusual SPI addressing stuff.  I'm mostly interested in what
> > precedent there is for bindings etc.
> >   
> 
> Yep, I'm not entirely sure that the SPI framework can handle multiple
> clients on the same CS.
> The reason why we created device-addr is that the chip supports that and
> may have hardcoded chip address from factory.
> The chip address is also part of the protocol so we have to specify it.

It will certainly be 'interesting' if we ever try to support it.

> 
...

...
> > > > +static int mcp3911_write(struct mcp3911 *adc, u8 reg, u32 val, u8 len)
> > > > +{
> > > > +	dev_dbg(&adc->spi->dev, "Writing 0x%x to register 0x%x\n", val, reg);
> > > > +
> > > > +	cpu_to_be32s(&val);
> > > > +	val >>= (3-len)*8;  
> > Hmm. It might be worth considering regmap here to handle all this stuff for
> > you rather than re rolling the same stuff.
> >   
> 
> We were looking at regmap, but it does not seems to support registers of
> different size.
> This chip has register values of 8, 16 and 24 bits.

Fair enough. I thought we were really looking at autoincrement, of
the address for a fixed sized register - which is fine in regmap.
Those wider registers are described as having ADDR and ADDR+1 etc.

> 
> > > > +	val |= REG_WRITE(reg, adc->dev_addr);
> > > > +
> > > > +	return spi_write(adc->spi, &val, len+1);
> > > > +}
> > > > +

> > > > +
> > > > +static int mcp3911_read_raw(struct iio_dev *indio_dev,
> > > > +			    struct iio_chan_spec const *channel, int *val,
> > > > +			    int *val2, long mask)
> > > > +{
> > > > +	struct mcp3911 *adc = iio_priv(indio_dev);
> > > > +	int ret = -EINVAL;
> > > > +
> > > > +	mutex_lock(&adc->lock);
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_RAW:
> > > > +		ret = mcp3911_read(adc,
> > > > +				MCP3911_CHANNEL(channel->channel), val, 3);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		ret = IIO_VAL_INT;
> > > > +		break;
> > > > +
> > > > +	case IIO_CHAN_INFO_OFFSET:
> > > > +		ret = mcp3911_read(adc,
> > > > +				MCP3911_OFFCAL(channel->channel), val, 3);
> > > > +		if (ret)
> > > > +			goto out;
> > > > +
> > > > +		ret = IIO_VAL_INT;
> > > > +		break;
> > > > +
> > > > +	case IIO_CHAN_INFO_HARDWAREGAIN:
> > > > +		ret = mcp3911_get_hwgain(adc, channel->channel, val);  
> > 
> > I'm not convinced it's useful to expose this as it right control for this
> > is scale.
> >   
> 
> Hmm, all other drivers that are using HARDWAREGAIN (ina2xx-adc, stx104 +
> a few more that are not ADC:s) are, what I can tell, exposing it.
> 
> But maybe it should'nt.

Yup, as ever things are a bit messy.  However, best to not expose it unless
there is a very good reason.
> > > > +
> > > > +		break;
> > > > +
> > > > +	case IIO_CHAN_INFO_HARDWAREGAIN:    
> > 
> > Default choice (by precedent) is to control variable gain
> > front ends via the scale parameter.   Hardware gain
> > is not meant to have any 'visible' impact on the output
> > value - most commonly used when the thing we are measuring
> > is not amplitude of anything.  
> 
> Hmm, Ok. I'm not sure I understand how hardware gain is supposed to work
> then.

For this use case it isn't. 

> Maybe I just remove it.

That's the best plan.

...
> > > > +
> > > > +static int mcp3911_config_of(struct mcp3911 *adc)
> > > > +{
> > > > +	u32 configreg;
> > > > +	u32 statuscomreg;
> > > > +	int ret;
> > > > +
> > > > +	of_property_read_u32(adc->np, "device-addr", &adc->dev_addr);  
> > This is 'interesting' - I wonder if there is any precedence for it.
> >   
> 
> I guess we still need it since the device may have a hardcoded (from
> factory) address that we need to deal with.

Fair enough.  Still good to hear from Mark on whether there are other similar
devices so the binding can be consistent.


> > > > +
> > > > +	of_property_read_u32(adc->np, "ch0-width", &adc->width[0]);
> > > > +	switch (adc->width[0]) {
> > > > +	case 24:
> > > > +		statuscomreg &= ~MCP3911_STATUSCOM_CH0_24WIDTH;
> > > > +		dev_dbg(&adc->spi->dev, "set channel 0 into 24bit mode\n");
> > > > +		break;
> > > > +	case 16:
> > > > +		statuscomreg |= MCP3911_STATUSCOM_CH0_24WIDTH;
> > > > +		dev_dbg(&adc->spi->dev, "set channel 0 into 16bit mode\n");
> > > > +		break;
> > > > +	default:
> > > > +		adc->width[0] = 24;
> > > > +		dev_info(&adc->spi->dev, "invalid width for channel 0. Use 24bit.\n");
> > > > +		break;
> > > > +	}  
> > This feels like something that isn't really a dt choice, as it's not down to
> > wiring but rather down to precision desired.  
> 
> You are right. I will remove them and stick to 24bit width.
>
That's the easiest option.  If anyone 'really' wants 16bit we'll figure it out
later.
 
..
Thanks

Jonathan
