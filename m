Return-Path: <alban.bedel@avionic-design.de>
Date: Wed, 14 Nov 2012 12:17:38 +0100
From: Alban Bedel <alban.bedel@avionic-design.de>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Roland Stigge <stigge@antcom.de>, linux-iio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Alban Bedel <alban.bedel@avionic-design.de>
Subject: Re: [PATCH] staging:iio:lpc32xx_adc: Add scale/offset support
Message-ID: <20121114121738.05df9ef8@avionic-0020.adnet.avionic-design.de>
In-Reply-To: <f16ac222-cb36-4ada-bd00-c9166ea94dd3@email.android.com>
References: <1352306690-25841-1-git-send-email-alban.bedel@avionic-design.de>
	<509B7BF0.5050704@antcom.de>
	<509BD1D9.20100@jic23.retrosnub.co.uk>
	<20121108175617.06429ab1@avionic-0020.adnet.avionic-design.de>
	<f16ac222-cb36-4ada-bd00-c9166ea94dd3@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

On Thu, 08 Nov 2012 17:28:46 +0000
Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:

> 
> 
> Alban Bedel <alban.bedel@avionic-design.de> wrote:
> 
> >On Thu, 08 Nov 2012 15:38:01 +0000
> >Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> >
> >> Why not do this with regulators?  That would give a more flexible
> >> system and all that stuff is already well supported (if fixed
> >voltages
> >> are supplied then used fixed regulators).
> >
> >I agree that would probably be better. But for me that raise the
> >question of having this stuff in the ADC driver at all. Most ADC just
> >return a value from 0 to MAX and have no way to find out their supply
> >voltage.
>
> A lot of iio drivers require a regulator for exactly this reason.  Either
> it is fixed and can go in device tree or it isn't and can be queried
> or set. 
> 
> > If we start with binding to regulators in the drivers we'll soon get a
> > lots of non-flexible and duplicated code.

> Why? Duplication maybe but I don't see where inflexibility comes from..
> duplication may mean some library functions would be useful.

Inflexible because the drivers have to provide an information that they
inherently don't have, and the consumers can't use relative values as
they don't have access to the reference voltage.

> >It would be a lot nicer if the ADC channels could be bound to a
> >regulator and a transform function that compute a real world voltage
> >out
> >of:
> > - The ADC value
> > - The ADC range
> > - The regulator representing the ADC reference voltage
> >
> >The simplest transform would be a linear curve with an optional offset,
> >but any kind of transform would also be possible allowing to represent
> >about any circuit that might be between the supply regulator and the
> >ADC
> >input.

> This still sits in the realm of regulators.  Far as iio driver is concerned
> there is a voltage on a pin.  What that means wrt to resulting scale
> is device dependent.  It is an obscure use case where the reference
> inputs are changing frequently..

I was more thinking of an ADC measuring a value with a circuit that is
not linear. But I now see that such thing should be part of the
consumer not the ADC driver.

> Now I can see an arguement for a suitable regulator which takes one voltage in
> and does flexible transformations of it.  Also it can work the otherway with iio
> driver requesting a different reference value.

IMHO it would make much more sense if the ADC had nothing to do with
the reference voltage. The only thing an ADC can reliably provide is
the values it read and a function that convert a (value,ref_voltage)
pair to a voltage. Anything else is IMHO beyond the scope of an ADC and
shouldn't be part of the driver layer.

> Now there may be a case for transforms on incoming adc channels as they are
> inherently dynamic.  Right now we promise only to give what the adc saw not
> some way before it on the otherside of weirdness.
> 
> So I am not yet convinced! Perhaps example configurations would help?
> 
> Remember that we deliberately leave as much data transforming to userspace as
> possible. So far the only non linear stuff has been slow so it hasn't mattered.

That I fully understand, what I don't get is why the ADC drivers are
forced to provide an information they don't have.

Alban
