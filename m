Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:39997 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752878Ab2AMM2A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Jan 2012 07:28:00 -0500
Date: 13 Jan 2012 12:27:56 +0000
From: "J.I. Cameron" <jic23@cam.ac.uk>
To: "Palande, Ameya" <ameya.palande@ti.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: Re: drv2665 driver placement query
Message-ID: <Prayer.1.3.4.1201131227560.21317@hermes-2.csi.cam.ac.uk>
In-Reply-To: <CAHFNHeU3SgdgOqM_4z5Ys2w06dJ2+r7xu-VzT5-Fsk4a9QNMtA@mail.gmail.com>
References: <CAHFNHeW=XM0=c-PiOtttzgL68jrAwPyeM-iZMQffVx2yq3BN-g@mail.gmail.com>
 <4F0F3DFD.6010106@metafoo.de>
 <CAHFNHeW79qOv8=VudvRZsbR3C4DcMhWA-bqhC1k+R7dj5XNYqw@mail.gmail.com>
 <4F0F5FC4.3080008@metafoo.de>
 <CAHFNHeU3SgdgOqM_4z5Ys2w06dJ2+r7xu-VzT5-Fsk4a9QNMtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Jan 12 2012, Palande, Ameya wrote:

>On Thu, Jan 12, 2012 at 2:33 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 01/12/2012 11:05 PM, Palande, Ameya wrote:
>>> Hi Lars,
>>>
>>> On Thu, Jan 12, 2012 at 12:09 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>>> Hi,
>>>>
>>>> On 01/12/2012 08:39 PM, Palande, Ameya wrote:
>>>>> Hi,
>>>>>
>>>>> I submitted a driver for Texas Instruments DRV2665 chip for placing it
>>>>> under "drivers/misc".
>>>>> But I guess it is more appropriate to put it under "drivers/staging/iio"
>>>>> Reference: https://lkml.org/lkml/2012/1/10/31
>>>>
>>>>>
>>>>> Here is the description of the chip:
>>>>>
>>>>> DRV2665 IC drives piezo actuator which enables a wide variety of
>>>>> high-resolution haptic effects, including feedback localized to
>>>>> specific areas of the device, as well as vibrations and pulses that
>>>>> change in frequency based on how the user is interacting with the
>>>>> device.
>>>>>
>>>>> Can you tell me where should I put it under "staging/iio" ?
>>>>>
>>>>
>>>>
>>>> I had a short look at your driver and it looks to me as if all it does is
>>>> expose the raw registers as sysfs attributes. So I think one thing you first
>>>> have to do is to figure out a generic interface for the device class. How does
>>>> a application usually use these kinds of devices, how can the interface be
>>>> abstracted, so it applies to a wider range of devices of this class and not
>>>> only to this one specific device.
>>>
>>> Workflow for using DRV2665 is:
>>> 1. Set the desired configuration
>>> 2. Send waveform data to data register
>>
>> Well that's basically the work-flow for every driver ;) Setup config, write data.
>>
>> But the data and config also have a meaning. So what is the high-level task a
>> software want to perform when setting certain up a configuration?
>
>Configuration can include:
>1. Selecting FIFO or Analog input
>2. Selecting timeout period between when the FIFO runs empty and the
>DRV2665 goes into idle mode
>3. Overriding bit for the boost converter and amplifier enables
>4. Programing the GAIN control
>
>> A good start would probably to break the config register down into it's
>> different elements and don't expose the raw register anymore.
>
>Thank for suggesting it! I will implement that.
>However my original question is still unanswered: Where should I place
>this driver in iio?

Any chance of a datasheet?  At the moment it looks like something that might fit
better in either input (stuff is there for force feedback joysticks etc),
or I believe there was some work on a general haptics framework a while back
(though google implies that kind of disappeard).  I'm not against it going in IIO (probably in a new category) but only if it doesn't fit better elsewhere!

>
