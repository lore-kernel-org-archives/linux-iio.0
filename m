Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750791AbdE1Pmo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 May 2017 11:42:44 -0400
Date: Sun, 28 May 2017 16:42:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 4/4] iio: hi8435: cleanup reset gpio
Message-ID: <20170528164238.56884259@kernel.org>
In-Reply-To: <b2b461d4-586d-d2e8-4188-8e25d5d7211e@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
        <20170519144802.14427-4-nikita.yoush@cogentembedded.com>
        <18fc343b-d7a4-c5b8-84e6-702af6e94e44@cogentembedded.com>
        <4ba5a0ce-d443-bdf0-bb23-9941b7db59a4@cogentembedded.com>
        <5eec10c5-9e13-b0fc-fe40-a8b74a4fdbb0@cogentembedded.com>
        <20170524203808.34aec03a@kernel.org>
        <b2b461d4-586d-d2e8-4188-8e25d5d7211e@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 May 2017 09:27:18 +0300
Nikita Yushchenko <nikita.yoush@cogentembedded.com> wrote:

> >>>>> Reset GPIO is active low.
> >>>>>
> >>>>> Currently driver uses gpiod_set_value(1) to clean reset, which depends
> >>>>> on device tree to contain GPIO_ACTIVE_HIGH - that does not match reality.
> >>>>>
> >>>>> This fixes driver to use _raw version of gpiod_set_value() to enforce
> >>>>> active-low semantics despite of what's written in device tree. Allowing
> >>>>> device tree to override that only opens possibility for errors and does
> >>>>> not add any value.
> >>>>>
> >>>>> Additionally, use _cansleep version to make things work with i2c-gpio
> >>>>> and other sleeping gpio drivers.    
> >>>> The reset gpio comes from platform hence it should be handled by DTS.
> >>>>
> >>>> In driver the gpio should not be raw.
> >>>>
> >>>> Even the hi8435 is active low but platform may invert signal (f.e. by
> >>>> adding trigger on the circuit path).    
> >>> I see.  However - isn't this pure theoretic?  Does such case exist?    
> >> I assure you that this is frequently used.
> >>
> >> Simply search google for "simple voltage level shifter"
> >> It might be on PNP or NPN transistor, hence logic might be inverted.
> >>  
> >>>
> >>> In vast majority of cases, GPIO polarity is chip-specific, not
> >>> chip-use-specific.  Thus this knowlege belongs to driver and not to
> >>> device tree describing particular chip usage.  Having this always
> >>> defined at usage side is IMO major source of errors.    
> >> GPIO comes from SoC then "circuit path" and finally chip reset input.
> >>
> >> What do you propose if h/w circuit path has simple voltage level shifter 
> >> on transistor. How to differentiate PNP and NPN cases?  
> > 
> > Hmm. Ah well, I clearly jumped too fast on this set and should have
> > left it for a while longer (I rushed a little as I'm away next weekend
> > and the cycle is moving towards rc3)
> > 
> > Sorry about that.
> > 
> > Anyhow, I am tempted to queue a revert of this patch.  The level
> > shifting case hadn't occurred to me (oops).
> > 
> > Thoughts?  
> 
> Well here is the full story.
> 
> - I found that chip's reset line is active low per datasheet, but device
> tree for board I work with states it is active high
> 
> - I checked driver code and found that driver depends on this incorrect
> setting, it won't work if device tree will state that gpio is active low
> 
> - I could revert values in driver code AND in device tree, this way make
> device tree be correct (against reality) but make dtb files flashed into
> existing systems incompatible with future kernels -  which I disliked
> 
> - Thus I thought that I can remove explicit definition of polarity from
> device tree (replacing it with neutrally-looking zero), and change
> driver to use _raw.  I assumed that there is no real gain to let device
> tree override gpio polarity for signal that is per-datasheet always
> active low
> 
> - Thinking further on this, I realized that for common case signal
> polarity is something defined by chip, and thus this knowledge belongs
> to chip's driver and not to chip user's device tree. Moreover, device
> tree writer could easily be not aware of signal polarity (too many
> datasheets are NDA-closed), thus hello copy-pasting, try-and-check and
> other counterproductive approaches.
> 
> - Then Vladimir pointed real-life case with signal inversion by handmade
> level shifter. Although scope of this is likely limited to hw labs,
> support for this is wanted and thus some way to override polarity in
> chip user's dts be available.  Still, this should be optional, without
> requiring dts to always define polarity of each gpio.
I have real hardware that effectively does the equivalent for interrupt
lines coming into the processor from some sensors.  Note quite the same,
but shows these things often do turn up as a fix on 'real' hardware.
> 
> 
> It becomes obvious that this topic has global scope, it is not something
> to solve within hi8345 driver or within iio.  For patch in question,
> possibilities are:
> - revert the patch, restore situation with driver depending on wrong
> statement in dts, maybe document that in bindings,
> - replace patch with code assuming that device tree has correct
> definition of reset gpio polarity; break existing device trees (all are
> out-of-tree as of today),
> - keep the patch, thus not break anything and still stop requiring
> device tree to contain wrong statement, but make entire situation
> somewhat hacky and loose support for board reverting signal between gpio
> provider and hi8435's pin (hopefully no such board exists).
> 
> I don't know. Maintainer should decide.
For now I went with a revert as the low risk option - we aren't making
the situation potentially worse as it's already broken.  It of
course would be great to rapidly come to a conclusion that has
the best of all possible worlds!

You are correct, this needs some wider guidance.  I've cc'd Linus
Walleij more to make sure he has a heads up than to suggest
we continue this conversation in this thread.

I don't know what the 'correct' way forward is.  Funnily enough
my immediate thought is to it it with a big hammer and define
an inverting gpiochip to represent the possible inverter.
So a bit like a gpiochip setting on i2c but in this case
it sits on a gpio.  So when you set the front gpio
(representing the inverter) it knows to set the opposite
on the actual gpio on the processor.

Probably overkill but would let you represent absolutely
many crazy topologies ;) Mind you might just as easily already
exist and I don't know about it (I did take a quick look
but didn't find anything like that)

Jonathan
> 
> Nikita

