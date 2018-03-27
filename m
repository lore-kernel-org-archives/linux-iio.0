Return-Path: <SRS0=TKGk=GR=huawei.com=jonathan.cameron@kernel.org>
Date: Tue, 27 Mar 2018 14:22:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Rosin <peda@axentia.se>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, "Randy Dunlap" <rdunlap@infradead.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: wrapper: unit-converter: new driver
Message-ID: <20180327142256.00003056@huawei.com>
In-Reply-To: <1e950fde-d3d9-ca9c-1055-7ab8fc57fc4a@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
	<20180319170246.26830-4-peda@axentia.se>
	<20180324140339.4ec66792@archlinux>
	<1e950fde-d3d9-ca9c-1055-7ab8fc57fc4a@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Tue, 27 Mar 2018 09:42:40 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-03-24 15:03, Jonathan Cameron wrote:
> > On Mon, 19 Mar 2018 18:02:46 +0100
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> If an ADC channel measures the midpoint of a voltage divider, the
> >> interesting voltage is often the voltage over the full resistance.
> >> E.g. if the full voltage it too big for the ADC to handle.
> >> Likewise, if an ADC channel measures the voltage across a resistor,
> >> the interesting value is often the current through the resistor.
> >>
> >> This driver solves both problems by allowing to linearly scale a channel
> >> and by allowing changes to the type of the channel. Or both.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>  
> > A few comments inline, but basically the code looks fine, just questions
> > around naming and bindings to answer.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> *snip*
> 
> >> +static int unit_converter_write_raw(struct iio_dev *indio_dev,
> >> +				    struct iio_chan_spec const *chan,
> >> +				    int val, int val2, long mask)
> >> +{
> >> +	struct unit_converter *uc = iio_priv(indio_dev);
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		return iio_write_channel_raw(uc->parent, val);  
> > Talk me through the logic of having this...  Supporting a DAC?
> > Bindings don't talk about that possibility...  
> 
> There's no logic at all, and I don't need it. It's just leftovers,
> should I remove it?
> 
> >> +	}
> >> +
> >> +	return -EINVAL;
> >> +}
> >> +  
> 
> *snip*
> 
> >> +static int unit_converter_configure_channel(struct device *dev,
> >> +					    struct unit_converter *uc,
> >> +					    enum iio_chan_type type)
> >> +{
> >> +	struct iio_chan_spec *chan = &uc->chan;
> >> +	struct iio_chan_spec const *pchan = uc->parent->channel;
> >> +	int ret;
> >> +
> >> +	chan->indexed = 1;
> >> +	chan->output = pchan->output;
> >> +	chan->ext_info = uc->ext_info;
> >> +
> >> +	if (type == -1) {
> >> +		ret = iio_get_channel_type(uc->parent, &type);
> >> +		if (ret < 0) {
> >> +			dev_err(dev, "failed to get parent channel type\n");
> >> +			return ret;
> >> +		}
> >> +	}
> >> +	chan->type = type;
> >> +
> >> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
> >> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);  
> > if the parent doesn't support RAW, is there a lot of point in carrying on?  
> 
> Nope, better to error out I suppose. But I'm not familiar with channels
> without RAW, what alternatives are there anyway?

Potentially _PROCESSED though that will need somewhat different handling.
A nasty trick for that might be to map it to RAW and then have the SCALE
reflect the divider circuit scale only.

It's perfectly possible to have channels with neither _RAW or _PROCESSED
but I suspect we don't care about them here.

There might be an application that needs to do buffered data flows in the
long run, but we can figure out how to do that when one exists.

It won't be a huge amount more than you have here, though we might need
a trigger pass through as well to allow you to set the trigger for
the front end and having it automatically applied to the backend.

Jonathan
> 
> >> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
> >> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> >> +
> >> +	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
> >> +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
> >> +
> >> +	chan->channel = 0;
> >> +
> >> +	return 0;
> >> +}  
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
