Return-Path: <SRS0=KeEb=HH=huawei.com=jonathan.cameron@kernel.org>
Date: Wed, 18 Apr 2018 10:37:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Rosin <peda@axentia.se>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Randy
 Dunlap <rdunlap@infradead.org>, "Andrew F . Davis" <afd@ti.com>, Fabio
 Estevam <festevam@gmail.com>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: afe: unit-converter: new driver
Message-ID: <20180418103721.00004171@huawei.com>
In-Reply-To: <81e69701-d49b-6675-010d-99d5d3eaf827@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
	<20180410152802.30958-3-peda@axentia.se>
	<20180415183140.04c39ebe@archlinux>
	<81e69701-d49b-6675-010d-99d5d3eaf827@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 16 Apr 2018 09:12:45 +0200
Peter Rosin <peda@axentia.se> wrote:

> On 2018-04-15 19:31, Jonathan Cameron wrote:
> > On Tue, 10 Apr 2018 17:28:02 +0200
> > Peter Rosin <peda@axentia.se> wrote:
> >   
> >> If an ADC channel measures the midpoint of a voltage divider, the
> >> interesting voltage is often the voltage over the full resistance.
> >> E.g. if the full voltage is too big for the ADC to handle.
> >> Likewise, if an ADC channel measures the voltage across a shunt
> >> resistor, the interesting value is often the current through the
> >> resistor.
> >>
> >> This driver solves both problems by allowing to linearly scale a channel
> >> and by allowing changes to the type of the channel. Or both.
> >>
> >> Signed-off-by: Peter Rosin <peda@axentia.se>  
> > So I 'think' the only outstanding question is Andrew's one about the driver
> > name.  We aren't in a hurry at this point in the kernel cycle, so lets
> > wait until that discussion has ended.  Assuming that we do possibly end
> > up with a change, then please roll all the patches up into a single series
> > to avoid me getting confusion.  
> 
> Yeah, sure, sorry for the split series, but the lt6106 that's present in
> one of our newer designs didn't occur to me until just seconds after
> firing the first half of the series. Which is kind of typical...
> 
> Anyway, about the driver naming. The suggestion I like best so far is
> linear-scaler from Linus W, but thinking about it some more I think I
> like iio-rescale even better.
> 
> Any objections to iio-rescale?

Works for me. But then I rarely care 'that much' about naming and am
responsible for plenty of previous confusing choices ;)

Jonathan

> 
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
