Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:52144 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753503Ab2ALWv5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Jan 2012 17:51:57 -0500
Received: by mail-iy0-f171.google.com with SMTP id z21so3901275iab.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Jan 2012 14:51:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4F0F5FC4.3080008@metafoo.de>
References: <CAHFNHeW=XM0=c-PiOtttzgL68jrAwPyeM-iZMQffVx2yq3BN-g@mail.gmail.com>
	<4F0F3DFD.6010106@metafoo.de>
	<CAHFNHeW79qOv8=VudvRZsbR3C4DcMhWA-bqhC1k+R7dj5XNYqw@mail.gmail.com>
	<4F0F5FC4.3080008@metafoo.de>
Date: Thu, 12 Jan 2012 14:51:56 -0800
Message-ID: <CAHFNHeU3SgdgOqM_4z5Ys2w06dJ2+r7xu-VzT5-Fsk4a9QNMtA@mail.gmail.com>
Subject: Re: drv2665 driver placement query
From: "Palande, Ameya" <ameya.palande@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 12, 2012 at 2:33 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 01/12/2012 11:05 PM, Palande, Ameya wrote:
>> Hi Lars,
>>
>> On Thu, Jan 12, 2012 at 12:09 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> Hi,
>>>
>>> On 01/12/2012 08:39 PM, Palande, Ameya wrote:
>>>> Hi,
>>>>
>>>> I submitted a driver for Texas Instruments DRV2665 chip for placing it
>>>> under "drivers/misc".
>>>> But I guess it is more appropriate to put it under "drivers/staging/iio"
>>>> Reference: https://lkml.org/lkml/2012/1/10/31
>>>
>>>>
>>>> Here is the description of the chip:
>>>>
>>>> DRV2665 IC drives piezo actuator which enables a wide variety of
>>>> high-resolution haptic effects, including feedback localized to
>>>> specific areas of the device, as well as vibrations and pulses that
>>>> change in frequency based on how the user is interacting with the
>>>> device.
>>>>
>>>> Can you tell me where should I put it under "staging/iio" ?
>>>>
>>>
>>>
>>> I had a short look at your driver and it looks to me as if all it does is
>>> expose the raw registers as sysfs attributes. So I think one thing you first
>>> have to do is to figure out a generic interface for the device class. How does
>>> a application usually use these kinds of devices, how can the interface be
>>> abstracted, so it applies to a wider range of devices of this class and not
>>> only to this one specific device.
>>
>> Workflow for using DRV2665 is:
>> 1. Set the desired configuration
>> 2. Send waveform data to data register
>
> Well that's basically the work-flow for every driver ;) Setup config, write data.
>
> But the data and config also have a meaning. So what is the high-level task a
> software want to perform when setting certain up a configuration?

Configuration can include:
1. Selecting FIFO or Analog input
2. Selecting timeout period between when the FIFO runs empty and the
DRV2665 goes into idle mode
3. Overriding bit for the boost converter and amplifier enables
4. Programing the GAIN control

> A good start would probably to break the config register down into it's
> different elements and don't expose the raw register anymore.

Thank for suggesting it! I will implement that.
However my original question is still unanswered: Where should I place
this driver in iio?

Cheers,
Ameya.
