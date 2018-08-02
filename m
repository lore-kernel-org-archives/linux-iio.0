Return-Path: <SRS0=av6O=KR=huawei.com=jonathan.cameron@kernel.org>
Date: Thu, 2 Aug 2018 10:21:04 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: <smohanad@codeaurora.org>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, "Rob
 Herring" <robh+dt@kernel.org>, <linux-iio-owner@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: Add QCOM SPMI PMIC5 ADC driver
Message-ID: <20180802102104.00001c6b@huawei.com>
In-Reply-To: <c738f4481d33bd3e6d0f78ff98600057@codeaurora.org>
References: <1532563769-23154-1-git-send-email-smohanad@codeaurora.org>
	<20180728120831.03e0087b@archlinux>
	<c738f4481d33bd3e6d0f78ff98600057@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Tue, 31 Jul 2018 11:08:13 -0700
<smohanad@codeaurora.org> wrote:

> On 2018-07-28 04:08, Jonathan Cameron wrote:
> > On Wed, 25 Jul 2018 17:09:29 -0700
> > Siddartha Mohanadoss <smohanad@codeaurora.org> wrote:
> >   
> >> This patch adds support for QCOM SPMI PMIC5 family
> >> of ADC driver that supports hardware based offset and
> >> gain compensation. The ADC peripheral can measure both
> >> voltage and current channels whose input signal is
> >> connected to the PMIC ADC AMUX.
> >> 
> >> The register set and configuration has been refreshed
> >> compared to the prior QCOM PMIC ADC family. Register
> >> ADC5 as part of the IIO framework.
> >> 
> >> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>  
> > 
> > Hi Siddartha,
> > 
> > My main questions inline are around providing both PROCESSED and
> > RAW readouts for the channels.   Generally this is something we
> > don't ever do (as there is little point and it increases the exposed
> > ABI).  Now the oddity here is you've copied from the
> > qcom-spmi-vadc driver which does this and IIRC that was because
> > the initial submission didn't do any of the complex maths to get
> > to the PROCESSED values.  That was introduced later, leaving us with
> > a mess as we couldn't remove the existing ABI in case someone was
> > using it.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba71704af4a0aae0d9e5812dbdd7bca95e181b14
> > 
> > So... I'm not convinced either way yet on whether we should let
> > this one through as a continuation of the exception we made there
> > or not.  Does this matter to you, or can you drop the RAW interface?  
> 
> Hi Jonathan,
> 
> There could be few use cases that would be useful for the client to
> have an option to read only the ADC code.
> 
> a) Few clients can request the ADC conversion and directly program
> the raw code in the hardware.

Why?  Typically it's of no use to them unless they have 'magically' gotten
the conversion routines from somewhere.  So this never applies to general
purpose code, just to stuff tuned for the particular hardware platform.
Not a zero sized pool of applications, but I'm not convinced we need
to put much effort into support them (unless as I said earlier they are
already out there for this platform due to similarities to the ones where
we already provide this).

There is also a problem - how does software know if the threshold is in
raw units or processed ones?  Normal assumption (I hope we documented it
somewhere) is that thresholds are matched to channel read outs. So if
the channel is processed, the threshold is in the right units, if raw
then it's in raw units.

> 
> b) Few clients can program the thresholds in hardware with ADC code to
> receive notification on a threshold crossing.

This one is interesting.  Mostly the client needs the conversion information
to know how to set that threshold.  Hence it is better off setting it in
real world units and letting the driver match that to the actual ADC threshold.
There is one common exception to this.  Light sensors typically use multiple
photodiodes to figure out illuminance and thresholds tend to based on one
of these raw readings.

Normally we get around this one by exposing the 'intensity' channel for the
photodiode in question as _raw only so the threshold can be applied against it.

> 
> c) Some clients may want to know when small movements occur,
> so it would be useful for the client to measure the ADC code and they
> could add a delta for the next threshold crossing.

It can still do that, it's just not as 'cheap' as it can apply those thresholds
as 'processed' units.  Otherwise small is extremely poorly defined so how
would userspace set it?

> 
> d) If a client wants to do their own math and apply their own scaling i 
> can see
> them requesting only the ADC code. They could add the scaling in the ADC 
> driver
> but if they choose add offset to the raw code and program the hardware 
> then
> providing only the code would be useful.

Works for specific devices, but is unusable for generic software. If we go
this way there is little point in having a generic subsystem which is one
of the reasons I resist providing this.

> 
> e) The raw ADC code is useful for debugging purpose. This point is 
> optional
> as it can also be done by logging the ADC code with a pr_debug.
Sure, or debugfs.
> 
> > 
> > There other bits inline are trivial enough I would just have
> > ignored or fixed them when applying if it weren't for this question.
> > 
> > (apologies if we have been round this before - I may have forgotten
> > or I may have been dozing during previous review.  This question has
> > come up for a few drivers recently so I'm more aware of it now)
> >   
...
> >> +#define ADC5_CHAN(_dname, _type, _mask, _pre, _scale)			\
> >> +	{								\
> >> +		.datasheet_name = (_dname),				\
> >> +		.prescale_index = _pre,					\
> >> +		.type = _type,						\
> >> +		.info_mask = _mask,					\
> >> +		.scale_fn_type = _scale,				\
> >> +	},								\
> >> +
> >> +#define ADC5_CHAN_TEMP(_dname, _pre, _scale)				\
> >> +	ADC5_CHAN(_dname, IIO_TEMP,					\
> >> +		BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_PROCESSED),	\  
> > I'm fairly sure we've been round this before.  A device should not 
> > supply
> > both raw and processed values without very very good reasons.
> > So far the only reasons we have had that I consider valid are:
> > 
> > 1. We got it wrong initially and output raw values, only to have 
> > processed
> >    added later to support something non linear.  We are stuck with 
> > supporting
> >    raw by existing ABI.
> > 
> > 2. We have a non linear channel that needs processed values and has 
> > events.
> >    For some reason we can't map the event controls from processed back
> >    to raw (weird case but who knows) so we have to support both.
> > 
> > 
> > Now this case 'kind' of falls into case 1 as that is what I think 
> > happened
> > with the qcom-spmi-vadc driver and lead to both being there.  
> 
> Clients could also request the reference channels ADC code and do their 
> own
> math and scaling. If there are any offsets that may be added to the ADC 
> code
> then this can be done within the client driver that programs its 
> hardware
> for any threshold crossing notification.

Hmm. I'm having trouble being convinced.  The whole point is that a client
should not be doing it's own scaling.  If it has an offset or similar
to apply it should be applied to the 'real world' value that is a standard
interface, not magically combined with it to generate the answer.

We go through this question every couple of months, and I try to remain
consistent in blocking drivers from providing both interfaces simply because
it makes it very hard for generic userspace.

Jonathan

> 
> > 
> > Hmm. This is awkward as in theory we are adding another 'broken' 
> > interface
> > here, but it is reasonable to assume that there might be code that 
> > requires
> > this interface on such a similar chip.
> > 
> > Do you definitely need to support both for some applications?  
> > Technically
> > we would not be causing a regression if we don't support _raw as it
> > never worked for this particular device, but I can sympathise (and be 
> > persuaded)
> > to let it go here if there is a strong usecase.
> >   
> >> +		_pre, _scale)						\
...
