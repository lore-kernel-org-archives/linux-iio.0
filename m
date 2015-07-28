Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vegas.theobroma-systems.com ([144.76.126.164]:38857 "EHLO
	mail.theobroma-systems.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752146AbbG1JLh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2015 05:11:37 -0400
Message-ID: <55B74741.3000408@theobroma-systems.com>
Date: Tue, 28 Jul 2015 11:11:29 +0200
From: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
MIME-Version: 1.0
To: Mark Rutland <mark.rutland@arm.com>,
	Martin Kepplinger <martink@posteo.de>
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
	"christoph.muellner@theobroma-systems.com"
	<christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH 8/8] iio: mma8452: add devicetree property to allow all
 pin wirings
References: <1438006095-26920-1-git-send-email-martink@posteo.de> <1438006095-26920-9-git-send-email-martink@posteo.de> <20150727142336.GB10821@leverpostej> <55B6423C.7030301@posteo.de> <20150727173345.GF10821@leverpostej>
In-Reply-To: <20150727173345.GF10821@leverpostej>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 2015-07-27 19:33, Mark Rutland wrote:
> On Mon, Jul 27, 2015 at 03:37:48PM +0100, Martin Kepplinger wrote:
>> Am 2015-07-27 um 16:23 schrieb Mark Rutland:
>>> On Mon, Jul 27, 2015 at 03:08:15PM +0100, Martin Kepplinger wrote:
>>>> For the devices supported by the mma8452 driver, two interrupt pins are
>>>> available to route the interrupt signals to. By default INT1 is assumed.
>>>>
>>>> This adds a bitmask DT property for users to configure interrupt sources
>>>> for INT2, if that is the wired interrupt pin for them.
>>>
>>> This sounds like configureation rather than a HW property. Why does this
>>> need to be in the DT?
>>
>> It's a hardware property of the board that uses the device. There might
>> be boards that connect just one of them at random, which is the reason
>> for this DT property. There also might be exotic users who will want
>> to use both pins to route different interrupt sources to (not yet
>> supported, but no problem with such a bitmask).
> 
> Ok, so I'm somewhat confused as to what the hardware looks like and what
> this means.
> 
> Could you elaborate on how INT1 and INT2 are used? It looks like they're
> used as output pins, and so interrupt-names would seem appropriate for
> describing the combination which is wired up.

They are just the chip's two possible interrupt lines for us to get
notified about event.

You build a board, you use one of these 4 chips, wiring up just one of
the 2 interrupt pins. By far most people won't ever need both pins.

DT describes your hardware, right? So you describe how you built your
board (wired the accelerometer chip) with this DT property.

> 
> w.r.t. configuring the choice of output(s), that sounds like a runtime
> decision rather than something which needs to be configured statically.

This won't be useful during runtime. (De)activating events is what you
do in iio sysfs.

Even in the rare case (maybe supported in the future) when you want one
interrupt source on one pin and another source on the other pin, that
describes your hardware. You wire, say, data-ready to Linux and
motion-detection to some strange alarm system. When you change your
hardware (say, use Linux for both pins), I think it would justify
changing a DT property.

Btw, we are talking about very theoretical stuff here. For now (and even
possibly forever) we just don't ever want to break a DT propery we
introduce here, thus the bitmask.

> 
>>>> This is important for everyone to be able to use this driver, no matter
>>>> how their chip is wired. At the moment, only 0xff for using INT2 for all
>>>> available interrupt sources is supported. See the devicetree documentation
>>>> file for more details.
>>>>
>>>> Since this doesn't change the default behaviour, it doesn't break anything
>>>> for existing users.
>>>>
>>>> Signed-off-by: Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
>>>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>>>> ---
>>>>  .../devicetree/bindings/iio/accel/mma8452.txt        |  4 ++++
>>>>  drivers/iio/accel/mma8452.c                          | 20 +++++++++++++-------
>>>>  2 files changed, 17 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/iio/accel/mma8452.txt b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>>> index 8d98e05..738a430 100644
>>>> --- a/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>>> +++ b/Documentation/devicetree/bindings/iio/accel/mma8452.txt
>>>> @@ -10,6 +10,9 @@ Optional properties:
>>>>  
>>>>    - interrupt-parent: should be the phandle for the interrupt controller
>>>>    - interrupts: interrupt mapping for GPIO IRQ
>>>> +  - use_int2: bitmask to choose interrupt sources assumed to be wired to
>>>> +    interrupt pin INT2 instead of INT1. Only 0xff (INT2 for every interrupt
>>>> +    source) is supported at the moment.
>>>
>>> s/_/-/ in property names, please.
>>
>> ok. If I don't do a version 6 really soon, I'll reply with this patch
>> corrected here.
>>
>>>
>>> We generally avoid bitmasks in properties, and we also usually exepct a
>>> full cell even if data is smaller. The fact that you expect /bits/ 8 
>>> must be documented here if that's truly necessary.
>>
>> It's not truly necessary. It's just a nice fit. There is one 8 bit
>> (device memory) register that basically could (in the future) be
>> exposed through this DT property.
>>
>> For now it's just 0xff or nothing. We only don't want to create an
>> interface that could restrict us from implementing more in the future
>> without breaking anything.
> 
> It sounds like you wouldn't need this (at least for now) if you were to
> use interrupt-names to describe whether INT1 and/or INT2 were wired up.
> 
> Thanks,
> Mark.
> 
