Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46203 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbbEGXdt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:49 -0400
Message-ID: <554BECB8.6020202@kernel.org>
Date: Thu, 07 May 2015 23:52:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Murphy <dmurphy@ti.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: heart_monitor: Add TI afe4403 heart monitor
References: <1429720331-1900-1-git-send-email-dmurphy@ti.com> <1429720331-1900-4-git-send-email-dmurphy@ti.com> <553D3091.7010900@kernel.org> <5540E21F.1080302@ti.com>
In-Reply-To: <5540E21F.1080302@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/15 14:52, Dan Murphy wrote:
> Jonathan
> 
> On 04/26/2015 01:38 PM, Jonathan Cameron wrote:
>> On 22/04/15 17:32, Dan Murphy wrote:
>>> Add the TI afe4403 heart rate monitor.
>>> This device detects reflected LED
>>> wave length fluctuations and presents an ADC
>>> value to the user space to be converted to a
>>> heart rate.
>>>
>>> Data sheet located here:
>>> http://www.ti.com/product/AFE4403/datasheet
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> Hi Dan,
>>
>> Good to see this coming back again!
>>
>> Anyhow, various comments inline, but the biggest issue is the ABI usage.
>> Please take a long hard look at the ABI docs (Documentation/ABI/test/sysfs-bus-iio*) and the use that is being made of them here.  This doesn't conform to
>> the ABI in a number of places and there is no documentation to imply that
>> it is creating new ABI.
>>
>> There are 4 input channels here Ambient1, Ambient2, led1 and led2.
>> We also have a two differential channels - though as these are seperated in
>> time it's just (I think) for convenience.
>>
>> These can then feed back to ambient cancellation DACs thus hopefully giving
>> just the nice led signals an allowing measurement of Pleth (which is what
>> we are aiming for?)
>> So two output DAC channels, use extended name to say what they are.
>> out_voltage0_ambientcancelation (perhaps...)  OR... Perhaps it would
>> be preferable to treat this as a caliboffset to the input channels.
>> (I think I prefer this second option).
>>
>> Your other channels allow manipulation of the signal chain - I think these
>> pretty much boil down to gains of one type or another?  If we don't have
>> a suitable ABI element for all of them then propose it, but they don't
>> look like output channels to me.
>>
>> You do have LED controls however which might be representable as output
>> channels, but they need to be more clearly described than below.
>>
>> One big issue here is that this isn't actually pulse measurement device
>> at all. It's measuring the pleth signal (photoplethysmography - which here
>> is just a light intensity measure - I think!) which can via 'magic' be used
>> to derive a pulse.  That's not a problem, but the channel types aren't
>> going to include heart_rate as that's not output from the device.
>>
>>> ---
>>>  drivers/iio/Kconfig                 |   1 +
>>>  drivers/iio/Makefile                |   1 +
>>>  drivers/iio/heart_monitor/Kconfig   |  19 +
>>>  drivers/iio/heart_monitor/Makefile  |   6 +
>>>  drivers/iio/heart_monitor/afe4403.c | 702 ++++++++++++++++++++++++++++++++++++
> 
> I am thinking of changing the directory to health as opposed to heart_monitor.
> 
> Thoughts?
> 
> <snip>
> 
It's easy to move them around later so don't worry too much.  Do you have
other drivers coming up that would make the health naming sensible?

J
