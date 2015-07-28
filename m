Return-Path: <martink@posteo.de>
Message-ID: <55B80C6D.5040607@posteo.de>
Date: Wed, 29 Jul 2015 01:12:45 +0200
From: Martin Kepplinger <martink@posteo.de>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
 "knaack.h@gmx.de" <knaack.h@gmx.de>,
 "lars@metafoo.de" <lars@metafoo.de>,
 "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
 "mfuzzey@parkeon.com" <mfuzzey@parkeon.com>,
 "roberta.dobrescu@gmail.com" <roberta.dobrescu@gmail.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 Pawel Moll <Pawel.Moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 "galak@codeaurora.org" <galak@codeaurora.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "christoph.muellner@theobroma-systems.com" <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH 8/8] iio: mma8452: add devicetree property to allow all
 pin wirings
References: <1438006095-26920-1-git-send-email-martink@posteo.de> <1438006095-26920-9-git-send-email-martink@posteo.de> <20150727142336.GB10821@leverpostej> <55B6423C.7030301@posteo.de> <20150727173345.GF10821@leverpostej> <55B74741.3000408@theobroma-systems.com> <20150728092809.GA15213@leverpostej>
In-Reply-To: <20150728092809.GA15213@leverpostej>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

Am 2015-07-28 um 11:28 schrieb Mark Rutland:
> On Tue, Jul 28, 2015 at 10:11:29AM +0100, Martin Kepplinger wrote:
>>
>>
>> On 2015-07-27 19:33, Mark Rutland wrote:
>>> On Mon, Jul 27, 2015 at 03:37:48PM +0100, Martin Kepplinger wrote:
>>>> Am 2015-07-27 um 16:23 schrieb Mark Rutland:
>>>>> On Mon, Jul 27, 2015 at 03:08:15PM +0100, Martin Kepplinger wrote:
>>>>>> For the devices supported by the mma8452 driver, two interrupt pins are
>>>>>> available to route the interrupt signals to. By default INT1 is assumed.
>>>>>>
>>>>>> This adds a bitmask DT property for users to configure interrupt sources
>>>>>> for INT2, if that is the wired interrupt pin for them.
>>>>>
>>>>> This sounds like configureation rather than a HW property. Why does this
>>>>> need to be in the DT?
>>>>
>>>> It's a hardware property of the board that uses the device. There might
>>>> be boards that connect just one of them at random, which is the reason
>>>> for this DT property. There also might be exotic users who will want
>>>> to use both pins to route different interrupt sources to (not yet
>>>> supported, but no problem with such a bitmask).
>>>
>>> Ok, so I'm somewhat confused as to what the hardware looks like and what
>>> this means.
>>>
>>> Could you elaborate on how INT1 and INT2 are used? It looks like they're
>>> used as output pins, and so interrupt-names would seem appropriate for
>>> describing the combination which is wired up.
>>
>> They are just the chip's two possible interrupt lines for us to get
>> notified about event.
> 
> Ok. So that matches my understanding.
> 
>> You build a board, you use one of these 4 chips, wiring up just one of
>> the 2 interrupt pins. By far most people won't ever need both pins.
>>
>> DT describes your hardware, right? So you describe how you built your
>> board (wired the accelerometer chip) with this DT property.
> 
> Ok.
> 
>>> w.r.t. configuring the choice of output(s), that sounds like a runtime
>>> decision rather than something which needs to be configured statically.
>>
>> This won't be useful during runtime. (De)activating events is what you
>> do in iio sysfs.
>>
>> Even in the rare case (maybe supported in the future) when you want one
>> interrupt source on one pin and another source on the other pin, that
>> describes your hardware. You wire, say, data-ready to Linux and
>> motion-detection to some strange alarm system. When you change your
>> hardware (say, use Linux for both pins), I think it would justify
>> changing a DT property.
> 
> In that case you would need additional properties anyway.
> 
>> Btw, we are talking about very theoretical stuff here. For now (and even
>> possibly forever) we just don't ever want to break a DT propery we
>> introduce here, thus the bitmask.
> 
> I don't think you need the bitmask.
> 
> I think all you need is interrupt-names, e.g.
> 
> dev1 {
> 	/* both wired up */
> 	interrupts = <&some_ic 0 47>, <&some_ic 5 62>;
> 	interrupt-names = "INT1", "INT2";
> }
> 
> dev2 {
> 	/* only INT2 wired up */
> 	interrupts = <&some_ic 3 96>;
> 	interrupt-names = "INT2";
> }
> 
> You can figure out which interrupts are wired up by trying to acquire
> them by name, then falling back to acquiting an anonymouos interrupt
> (assuming it's INT1) to keep compatible with existing DTBs. You can
> choose which to use arbitrarily, try to load balance, or whatever you'd
> like.
> 
> If it's later necessary to route some interrupts to another device,
> additional properties can be added to accomodate that. We already know
> that the bitmask alone is not sufficient for that case.
> 

Yes, this sounds reasonable indeed. I like the idea. I'm sorry I won't
rewrite patch 8/8 now. Relocation and a lot to do before holidays. I'll
be happy to write and test this properly in one month from now, if not
done by somebody until then.

Until then, since patches 1-7 only introduce a bindings document, they
shouldn't be problematic for devicetree people.


So if Jonathan and IIO people find anybody for review, feel free to take
patches 1-7. In any case, there is direct register access via debugfs to
at least somehow make the driver work for everybody ;)

so long, thanks.
                    martin

> Thanks,
> Mark.
> 
