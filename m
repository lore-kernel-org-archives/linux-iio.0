Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:2494 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932254AbcFHPuu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2016 11:50:50 -0400
Message-ID: <57583BD6.90208@nvidia.com>
Date: Wed, 8 Jun 2016 21:07:58 +0530
From: Laxman Dewangan <ldewangan@nvidia.com>
MIME-Version: 1.0
To: "Andrew F. Davis" <afd@ti.com>, Guenter Roeck <linux@roeck-us.net>
CC: Jonathan Cameron <jic23@kernel.org>, <robh+dt@kernel.org>,
	<corbet@lwn.net>, <lars@metafoo.de>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-hwmon@vger.kernel.org>,
	Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/3] iio: adc: ina3221: Add support for IIO ADC driver
 for TI INA3221
References: <1464784454-7988-1-git-send-email-ldewangan@nvidia.com> <1464784454-7988-2-git-send-email-ldewangan@nvidia.com> <44e28639-67b6-7586-5e6d-c0180ccded79@kernel.org> <5751863E.907@roeck-us.net> <575190A9.2090906@nvidia.com> <57519FA3.9010208@ti.com> <20160607223058.GA20120@roeck-us.net> <575833EE.60009@ti.com>
In-Reply-To: <575833EE.60009@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Wednesday 08 June 2016 08:34 PM, Andrew F. Davis wrote:
> On 06/07/2016 05:30 PM, Guenter Roeck wrote:
>> On Fri, Jun 03, 2016 at 10:17:55AM -0500, Andrew F. Davis wrote:
>>> On 06/03/2016 09:14 AM, Laxman Dewangan wrote:
>>>> On Friday 03 June 2016 06:59 PM, Guenter Roeck wrote:
>>>>> On 06/03/2016 03:06 AM, Jonathan Cameron wrote:
>>>>>> On 01/06/16 13:34, Laxman Dewangan wrote:
>>>>>>> The INA3221 is a three-channel, high-side current and bus voltage
>>>>>>> monitor
>>>>>>> with an I2C interface from Texas Instruments. The INA3221 monitors both
>>>>>>> shunt voltage drops and bus supply voltages in addition to having
>>>>>>> programmable conversion times and averaging modes for these signals.
>>>>>>> The INA3221 offers both critical and warning alerts to detect multiple
>>>>>>> programmable out-of-range conditions for each channel.
>>>>>>>
>>>>>>> Add support for INA3221 SW driver via IIO ADC interface. The device is
>>>>>>> register as iio-device and provides interface for voltage/current
>>>>>>> and power
>>>>>>> monitor. Also provide interface for setting oneshot/continuous mode and
>>>>>>> critical/warning threshold for the shunt voltage drop.
>>>>>>>
>>>>>>> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
>>>>>> Hi Laxman,
>>>>>>
>>>>>> As ever with any driver lying on the border of IIO and hwmon, please
>>>>>> include
>>>>>> a short justification of why you need an IIO driver and also cc the
>>>>>> hwmon list + maintainers. (cc'd on this reply).
>>>>>>
>>>>>> I simply won't take a driver where the hwmon maintainers aren't happy.
>>>>>> As it stands I'm not seeing obvious reasons in the code for why this
>>>>>> should be an IIO device.
>>>>>>
>>>>> Me not either.
>>>>>
>>>>> I have a hwmon driver for the same chip pending from Andrew Davis (TI)
>>>>> which I am just about to accept. We had directed Andrew back in April
>>>>> to write a hwmon driver for the chip, which he did.
>>>>>
>>>> Thanks Guenter,  I found the series
>>>>
>>>> [PATCH v2 0/2] Add support for INA3221 Triple Current/Voltage Monitors
>>>> Looks fine to me. I can use the hwmon.
>>>>
>>> If you search even further back you can see I originally went with an
>>> IIO driver as well, comparing the IIO and hwmon version for the simple
>>> use cases I needed the hwmod version turned out much simpler, so it was
>>> probably the right framework for now.
>>>
>>>> However, some of the stuff from my patch are not there which I will add
>>>> later once original patch applied:
>>>> - Dynamic mode changes for continuous and one-shot from sysfs.
>>>> - In one shot, when try to read voltage data, do conversion and then read.
>>>>
>>> My attempt is rather minimal, to be honest I like your stab at this
>>> driver better in some ways, especially relating to DT putting each
>>> channel in its own node with labels, I think this is a bit more clean
>>> and will be more extendable if/when new multi-channel monitor chips are
>>> made.
>>>
>>>> Not sure whether exporting the following will help or not. Can you
>>>> please confirm?
>>>> - Oversampling time i.e. average sample
>>>> - conversion time for bus voltage and shunt voltage if default is not
>>>> suited for system.
>>>>
>>>>
>>> These can always be added as needed, but the DT changes are not as easy.
>>> I would like it if this got in this cycle but if you think something
>>> will be needed to help your improvements, that can not be added
>>> incrementally, it would probably be best to get them into the initial DT
>>> binding doc now.
>>>
>> Andrew,
>>
>> with this, the hwmon driver is pretty much on hold. What do you want me to do ?
>> Should I wait for DT updates ?
>>
> If Laxman would like to commit to making these changes I do not problem
> waiting a bit to get this right the first time.
>
> If we don't hear back soon then I'd just take it as is and anything
> needing to be fixed can be later.
>
>

I will be able to post the patch tomorrow.
I think this series can be applied and then on top of it, I will post 
the dt changes and other my changes.

As this is new driver and no one using now, it will be fine to have dt 
changes if everything complete in one cycle.

I will work from the tree on which this applied to post my patches.

