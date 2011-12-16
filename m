Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:33133 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440Ab1LQTxd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 17 Dec 2011 14:53:33 -0500
Message-ID: <4EEB84BC.4040302@free-electrons.com>
Date: Fri, 16 Dec 2011 18:49:48 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [RFC v2] IIO: Add hardware triggers support to the AT91 ADC driver
References: <1323282340-24475-1-git-send-email-maxime.ripard@free-electrons.com> <4EDFB067.1080306@free-electrons.com> <4EE61913.4090205@free-electrons.com> <4EE66EBD.4030008@kernel.org>
In-Reply-To: <4EE66EBD.4030008@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 12/12/2011 22:14, Jonathan Cameron wrote:
> Firstly, sorry I didn't reply when you first raised this.  Read it,
> thought I'll answer that later and then forgot!

That's ok, I do that all the time :)

>> I think this is really something we should worry about if this is not
>> already here.
> 
> I am unclear how this should be supported by the core?  Do we have any
> real business getting involved.  We already have an explicit trigger
> driver for timers on the blackfin.   Would something like that make
> sense here?

I find it odd to have an external driver when you have to write in the
exact same registers of the exact same peripheral. On the G20, it would
make sense, on the later boards, you just have to put the period in the
appropriate field of one of the ADC's register, the same one you use to
setup triggered conversions.

> From the point of view of interfaces we also have the rtc driver
> (which exits because I was using this as a dubious route to the
> various timers on the pxa27x..  There have been various discussions
> about generic support for these more general purpose timers but
> no one has ever had the time to do anything about it.

Well, for my usecase, I guess just a triggerX/frequency file, that fills
the iio_trigger structure would be just fine, and it would be the
responsibility of the set_trigger_state callback to do what it has to do
with it. Of course, I don't know precisely the other drivers' usecases,
so this is probably not generic/extendable enough for IIO, but I'm
really curious about this. Can you point me to these discussions you're
mentionning ? I'm afraid I didn't saw them.

>> Even though on the G20, the timer counters come from an external IP, so
>> we can safely say it is not our job to setup these, on the later Atmel
>> SoCs, the timer counters are embedded into the ADC, so we would
>> definitely need to setup at least the period of these counters through IIO.
> Right now we have as stated about a number of drivers doing this, but no
> inkernel interfaces.  There have been various discussions about taking
> the frequency control (that many chips that do data ready triggers have)
> into the iio core more directly (to make them available
> to in kernel users).  Perhaps that fits more with what you are after?

Definitely.

Maxime

>> On 07/12/2011 19:28, Maxime Ripard wrote:
>>> I also have a question related to that.
>>>
>>> The SAM9G20 has timer counters as trigger sources for the ADC. Is there
>>> some kind of integration for them in IIO, or should we do the setup of
>>> these counters outside of IIO ?
>>>
>>> Thanks,
>>> Maxime
>>>
>>> On 07/12/2011 19:25, Maxime Ripard wrote:
>>>> Hi all,
>>>>
>>>> This is a follow-up of the previous patchset about hardware triggers for the
>>>> ADC on AT91.
>>>>
>>>> This is still not for inclusion, as it relies on a duplication of !staging code.
>>>> But basically, I'm submitting it for review and be sure I do everything right.
>>>> Moreover, it will save some iterations when the time for it to be included will
>>>> come.
>>>>
>>>> I should have addressed all the points made by Jonathan in the v1, but here is
>>>> what changed:
>>>>   - Fix the timestamp declaration. scan_timestamp was set to true, but no
>>>> channel was declared for it. It is obviously wrong.
>>>>   - Rebased on brand new patches, instead of outdated branch. This patch now
>>>> requires the buffer clean ups and scan demux unit patchsets from Jonathan and
>>>> the brand new wrapper functions introduced by Lars Peter.
>>>>   - Renamed the triggers to be more explicit
>>>>   - Lot of small fixes and improvements: use ALIGN, change the location of
>>>> IRQ acknowledgements, etc.
>>>>   - Added comments, switched to kernel doc for the structure declarations
>>>>   - split the cosmetic changes into a new commit
>>>>
>>>> Thanks,
>>>> Maxime
>>>>
>>>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>>>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>>>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
