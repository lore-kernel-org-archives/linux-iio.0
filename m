Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:54790 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbbK3JF2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2015 04:05:28 -0500
Date: Mon, 30 Nov 2015 10:05:28 +0100
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Ludovic Desroches <ludovic.desroches@atmel.com>,
	<linux-iio@vger.kernel.org>
Subject: Re: directions to write a new adc driver
Message-ID: <20151130090528.GF11016@odux.rfo.atmel.com>
References: <20151127150823.GB11016@odux.rfo.atmel.com>
 <565B3313.40208@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <565B3313.40208@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Firstly, thanks for the detailed answer.

On Sun, Nov 29, 2015 at 05:17:07PM +0000, Jonathan Cameron wrote:
> On 27/11/15 15:08, Ludovic Desroches wrote:
> > Hi,
> > 
> > I want to add support for the ADC device of the SAMA5D2 SoC. I may
> > write a new driver because they are some changes about the register
> > contents. Moreover, the new device doesn't fit the dt bindings (which are
> > not very good since there is configuration stuff which is not
> > relating to the SoC or to the board).
> > 
> > My main concern is how to adress the configuration of my ADC, some
> > examples:
> > - choosing the resolution (some resolutions will impact the sampling
> >   time)
> The nasty here comes with the buffers.  Right now we are defining the
> resolution of a given element to be fixed.  Clearly in some SoC ADCs this
> isn't really true (in stand alone ones it pretty much always is fixed).
> Partly this then depends on the data layout - if it is such that we
> can effectively ignore it in describing the channel (i.e. the other bits
> are 0 anyway) then we tend to use _scale attributes to control the resolution.
> I'm not against having additional ABI for this, as long as it is clear.
> 
> We can add a callback to override the buffer descriptions with a runtime
> built version as long as the exposed ABI doesn't change.
> 
> Having quickly browsed the datasheet we are talking 12,13,14 bits, done
> by oversampling.  We have control for oversampling via an info_mask
> element so the control is fine.
> 
> Looks like values are sign extended to 16bits which is great as well
> as it means the buffer logic doesn't even have to know that different
> resolutions are supported.

Yes I don't think I'll have issue with buffer logic. I'll have a deeper
look to scale attribute and info_mask.

> 
> > - enabling the sleep mode or not
> This is an irritatingly open question kernel wide.  It basically boils down
> to a 'low power mode' or not I guess.  Every now and then someone suggests
> a general kernel twiddle knob for this, but right now we end up with a mess
> of different methods.  To a degree it depends on the driver writer to make
> a sensible decision on whether sleep mode is too costly or not. If it's not
> then don't turn it on...  Intermediate tricks to do with allowing a window
> in which it is disabled (runtime pm based normally) work well sometimes.
> 
> Here it looks like you could work out whether there is time to enable
> it for some types of trigger (timing based ones).  If so enable it, if
> not don't.  Hard for other trigger types however...

Ok. I'll try to keep it simple.

> 
> > - using offset correction
> Ah, found this in the datasheet (wasn't initially sure what you meant).
> Classic offset and gain, use calibscale and calibbias for this for the
> simple cases.  The final mode is 'novel' and will need some new ABI
> or perhaps just figuring out which of the gain modes will work for
> a given input value... Not sure.
> 
> 

Sorry I was not clear. This part is nice to have so I have time to think
about it.

> 
> > - signed or unsigned conversions
> That should be defined by the hardware...?  Or are we talking differential
> vs single ended conversion? If that then have two lots of channels for the
> the two cases and enable / disable as relevant - lots of standard ADC drivers
> do this.  Something like the max1363 driver should be a good example.
> 

I was not talking differential vs single ended conversion but thanks for
the tip.

Yes it should be defined by the hardware. Does it mean that this
information has to be in the device tree? 
It seems that choosing signed or unsigned conversion is applied to all the
channels. Do I have to manage it in the driver? I mean, I was told that
channel 1 is used for signed conversions (I don't know how, dt? sysfs?),
do I have to switch to signed to do the conversions then switch back to
unsigned or do I let the user configuring the adc for signed conversion
and requesting channel 1 conversion?

> 
> > - etc.
> > 
> > Having a look to other adc drivers, it seems resolution only depends on the
> > SoC.
> > Is there a generic solution?
> Not really - sometimes it really is soc dependent - e.g. a given soc
> has only one option, but in the flexible case we don't have a good solution.
> 
> > If not, can I create the files I need for my
> > device in sysfs?
> Yes
> > 
> > Which adc driver would be the best to take as a reference?
> For a generic ADC I'd normally say either the max1363 or the various
> analog devices parts. It gets less obvious for the quirks of a SoC
> - they all seem to be special cases!
> 
> > 
> > If you have some interesting discussions, I am interested too. I have
> > browsed the iio mainling list up to september but I have not found
> > answers.
> Yeah, we aren't the best at documentation and things tend to get burried
> over the years on the mailing list!

I won't cast the first stone, I'm doing the same!

> 
> A few other points to note from the datasheet for this one -
> 1) You have touchscreen specific hardware in there.  Is the plan a combined
> driver?  Looks fairly standard so that might be the easiest option.  One day
> I'll figure out if this stuff is generic enough across SoCs to do it
> as an IIO consumer with a few magic extra bits but for now a combined
> driver is probably easiest (though you then need to get it past both sets
> of reviewers!)

I was wondering how I will manage this part. It seems there is no change
for this feature with previous versions.
My first idea was to do a separate driver for it. I don't know if it is
a good idea since using it have consequences on channels available,
maybe the sampling time.
I think I'll start with a combined driver and I'll try to put the
touchscreen stuff outside of the at91_adc driver in order to share it
with the new one. 

> 2) Lots of trigger options here - you can register as many triggers as you
> likes so this should be fine.  You'll need to prevent those that never
> reach userspace from being used by other device however using the validate
> callbacks.

Not sure I will support all kind of triggers.

> 3) Dma support - I've not pinned down how useful this is yet, but the recent
>    dma buffers support from Lars may be useful here.  Looks like it does
>    tightly packed channels in a nice linear buffer so looks good.
>    I got lost in the description however so will leave figuring this out to
>    you ;)
>    

I have seen the threads about dma buffer support but I have to think
about it yet.

> 4) I love the bit where you can set the differential channels to be unsigned
>    and the single ended ones signed.... Sometimes it's best to not admit
>    that the hardware allows bonkers options ;)
> 5) Repeated channel reads in the sequencer.  We don't currently provide
> any means of doing this as it's horendous to design a generic interface
> around and relatively rarely makes much sense in an application.
> 
> 6) Events support - looks straight forward to support he threshold stuff.
> 7) The last channel measurement trigger stuff is 'unusual' - but not hard
> to support - just give it it's own integration time I guess and set this
> magic stuff if it differs from other channels.
> 

Lot of things to do I want to support all the features!

> Anyhow, nice enough looking ADC with not to 'silly' a hardware interface.
> > 
> > Thanks for you help
> > 
> > Regards
> > 
> > Ludovic


Thanks again for your help, I have to assimilate all these information.

Regards

Ludovic
