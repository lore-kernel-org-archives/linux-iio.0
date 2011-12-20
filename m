Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:33921 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755Ab1LTLqB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Dec 2011 06:46:01 -0500
Date: 20 Dec 2011 11:45:58 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: michael.hennerich@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: pll: New driver for ADF4350/ADF4351 Wideband Synthesizers
 (PLL)
Message-ID: <Prayer.1.3.4.1112201145580.21192@hermes-2.csi.cam.ac.uk>
In-Reply-To: <4EF05092.8050502@analog.com>
References: <1323436951-11246-1-git-send-email-michael.hennerich@analog.com>
 <4EE36FA1.5070902@kernel.org>
 <4EE5D49E.7010507@analog.com>
 <4EE90733.9040304@kernel.org>
 <4EF05092.8050502@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Dec 20 2011, Michael Hennerich wrote:

>On 12/14/2011 09:29 PM, Jonathan Cameron wrote:
>> On 12/12/2011 10:17 AM, Michael Hennerich wrote:
>>> On 12/10/2011 03:41 PM, Jonathan Cameron wrote:
>>>> On 12/09/2011 01:22 PM, michael.hennerich@analog.com wrote:
>>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>>
>>>>> This patch adds support for Analog Devices ADF4350/ADF4351
>>>>> Wideband Synthesizers (35MHz to 4.4GHz).
>>>> Hi Michael,
>>>>
>>>> Whilst I have no particular issue with having this device driver
>>>> in IIO I can see that it has considerable overlap with the clock
>>>> infrastructure. Perhaps you could give a quick summary of why it
>>>> doesn't make more sense to fit this device in there?
>>> Hi Jonathan,
>>>
>>> The in-kernel clock infrastructure is aimed for SoC like
>>> clock distribution. Typically one master clock,
>>> and a number of scaled down clocks for the various clock
>>> salve peripherals. For example typical clock slaves here are:
>>> SPI, I2C, UART, MMC, Video, etc.
>> Agreed, but is it absolutely limited to that?  Conceptually the problem
>> being solved is similar.  They have a source clock and an output clock
>> that is some multiple of the frequency.
>>> This PLL device is more aimed for generating a standalone clock
>>> used in industrial and communications applications.
>>> For example a Local Oscillator (LO) Frequency used with a Wide-band Mixer
>>> generating another Intermediate Frequency (IF) which is then samples by an
>>> ADC.
>> Sure, different uses but still feels like they are roughly the same
>> at heart.
>>> Also PLL input clocks are typically high stability, low phase noise
>>> clock sources,
>>> an not something derived from a SoC clock.
>> Agreed, but the quality of the sources doesn't have much to do with
>> the way they are handled in kernel :) Maybe this is one to revist
>> at a later point.  Perhaps we will end up with a clk provider that
>> is an IIO client using the inkernel interfaces..  Afterall, you
>> could use a much more general dds for the same sort of thing
>> (odd, but I bet someone will sooner or later ;)
>
>Hi Jonathan,
>
>I'll take a look and add the in-kernel interface as well.
>To be consequent this device must be a clock slave and a clock provider.
>But foremost it's an iio client, with a defined user interface -
>since this is our target application.
Cool.
>
>>>
>>>> There are a number of 'magic' register elements in the platform
>>>> data. I'd much prefer to see them broken down into their
>>>> constituent parts.
>>>>
>>>> Various other bits and bobs inline...
>>>>> Signed-off-by: Michael Hennerich<michael.hennerich@analog.com>
>>>>> ---
>>>>>    .../staging/iio/Documentation/sysfs-bus-iio-pll    |   46 ++
>>>>>    drivers/staging/iio/Kconfig                        |    1 +
>>>>>    drivers/staging/iio/Makefile                       |    1 +
>>>>>    drivers/staging/iio/pll/Kconfig                    |   16 +
>>>>>    drivers/staging/iio/pll/Makefile                   |    5 +
>>>>>    drivers/staging/iio/pll/adf4350.c                  |  485
>>>>> ++++++++++++++++++++
>>>>>    drivers/staging/iio/pll/adf4350.h                  |  121 +++++
>>>>>    7 files changed, 675 insertions(+), 0 deletions(-)
>>>>>    create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-pll
>>>>>    create mode 100644 drivers/staging/iio/pll/Kconfig
>>>>>    create mode 100644 drivers/staging/iio/pll/Makefile
>>>>>    create mode 100644 drivers/staging/iio/pll/adf4350.c
>>>>>    create mode 100644 drivers/staging/iio/pll/adf4350.h
>>>>>
>>>>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-pll
>>>>> b/drivers/staging/iio/Documentation/sysfs-bus-iio-pll
>>>>> new file mode 100644
>>>>> index 0000000..2aa2497
>>>>> --- /dev/null
>>>>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-pll
>>>>> @@ -0,0 +1,46 @@
>>>>> +
>>>>> +What:                /sys/bus/iio/devices/iio:deviceX/out_pllY_freq
>>>>> +KernelVersion:       3.2.0
>>>>> +Contact:     linux-iio@vger.kernel.org
>>>>> +Description:
>>>>> +             Stores PLL Y frequency in Hz. Reading returns the
>>>>> +             actual frequency in Hz. When setting a new frequency,
>>>>> the PLL
>>>>> +             requires some time to lock. If available, the user can
>>>>> read
>>>>> +             out_pllY_locked in order to check whether the PLL has
>>>>> locked
>>>>> +             or not.
>>>> Is the fact that it is a pll vital?  ultimately it's just a frequency
>>>> output
>>>> as far as we are concerned (up to the 'locked' stuff).  I wonder if we
>>>> should
>>>> be sharing more between this interface and the dds one.  (I'm happy to be
>>>> convinced either way!)
>>> In fact - I was thinking about the same thing.
>>> The DDS parts are typically different from the PLL,
>>> however there is a common denominator.
>>>
>>> How about we rename iio/dds to iio/frequency.
>>> But I'm a bit unsure about the naming convention.
>>>
>>> For dds we have out_ddsX_freqY or out_ddsX_outY_enable.
>>> shall we keep that scheme and likewise add:
>>> out_pllX_freqY, or move on to something like:
>>>
>>> out_devX_freqY ?
>>> out_freqX_Y ?
>> This one looks reasonable to me.  DDSs are currently the only
>> case we have with two
>>> out_outX_Y_enable ?
>> this one is rather uggly. Maybe we need a channel type
>> for ac voltage?   altvolage perhaps?  Or could just add sufficient
>> to allow us to treat it as a volage.
>I like this idea. Altvoltage sounds sensible. Acvoltage would sound
>more familiar, but given the fact that the 'C' stands for current ...
Agreed, altvoltage is good as we can then have altcurrent etc which is
nice. 
>
>> There is also the double indexes that we don't allow anywhere else.
>> They are here because we have different waveforms with same underlying
>> channel.  We could had a bonus optional index to all channels I suppose
>> and have this as the only current user?  Or maybe just a flag to say its
>> a 'subchannel' and use channel2.  Afterall these channels are neither
>> going to have modifiers or to be differential so I can't see a clash
>> occuring on the use of that...
>Well one of the indexes with the DDS parts is used to distinguish
>the tuning words options, in combination with the pincontrol feature.
>PLL devices typically doesn't feature this.
>
>So bottom line - can we agree on:
>
>out_altvoltageX_freqY
>out_altvoltageX_phaseY
>out_altvoltageX_scale
>out_altvoltageX_enable
>...
>Where X stands for the output channel, and Y for some sort of option.

Looks good as far as I am concerned. Might be worth a quick check through
of dds and meter devices to see how we can extend this to cover them.
>
>For the PLL and clock distribution parts that I have currently in the make.
>Y would be always 0.
>
>
>>>
>>>>      Having said that, the dds docs at least haven't
>>>> caught up with the out_ and in_ prefixes which isn't a great start...
>>> Thanks - I noticed that and a patch is already in my queue.
>> Cool.
>>
>>>> How about semantics of having a write to this file wait to return until
>>>> locking has occured?  Just a thought.
>>> I could do that - but we need the pll_locked attribute anyways.
>>> The PLL could unlock under certain circumstances.
>>> We therefore need an option to check the lock state.
>> Agreed.  This comes back to the age old question of unifying
>> 'unexpected' events (similar loss of tracking for resolvers).
>> We have the classic thresholds well covered, but it's not clear
>> to me whether these even want to go through the same path.
>Well there is a need for such events, I don't mind if they take the same 
>route.
I think this is a more general kernel question ideally.  How to handle
something that corresponds to a 'all hell has broken loose, shut down the
kit' event. Probably a few levels below that as well

This driver is going to need to be a lot more widely posted than IIO I think.
Good luck figuring out who to send it to.

Jonathan
