Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59542 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbaIKQjT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 11 Sep 2014 12:39:19 -0400
In-Reply-To: <CACRpkdZuSsePVjPpmLV5bs5VOcbnH2_gK4-kOfbpBM1-7Q=zgQ@mail.gmail.com>
References: <1408815064-5763-1-git-send-email-linus.walleij@linaro.org> <53FB6205.5020704@kernel.org> <CACRpkdZuSsePVjPpmLV5bs5VOcbnH2_gK4-kOfbpBM1-7Q=zgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH] iio: st-sensors: add support for lis3lv02d accelerometer
From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 11 Sep 2014 17:39:01 +0100
To: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>,
	Lee Jones <lee.jones@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Message-ID: <c422075c-f86a-415b-a19b-d4c11fd5e0fd@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On September 11, 2014 10:13:24 AM GMT+01:00, Linus Walleij <linus.walleij@linaro.org> wrote:
>On Mon, Aug 25, 2014 at 6:19 PM, Jonathan Cameron <jic23@kernel.org>
>wrote:
>> On 23/08/14 18:31, Linus Walleij wrote:
>>> This adds support for the LIS3LV02 accelerometer found in the
>>> ST Microelectronics Nomadik board series.
>>>
>>> Cc: devicetree@vger.kernel.org
>>> Cc: Denis CIOCCA <denis.ciocca@st.com>
>>> Cc: Lee Jones <lee.jones@linaro.org>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> If anyone wants to look at what the misc driver supports that we
>still
>> don't have in the IIO driver then that would be great!
>
>I had a quick look at it:
>
>- The misc driver has a bridge that optionally registers the
>  accelerometer as a joystick in the input subsystem, so it
>  can be used as a polled joystick. That looks like something
>  we would want to be able to do for any accelerometer in a
>  generic glue file in IIO I think?

That is what we had iio-input for but it has languished unloved for quite a while.  Always too many other things to do!

Nasty bit in there is how to do bindings for it.  No one really likes the existing ones for iio client drivers.

Note it is more general than just accelerometers as all sorts of other devices
 are useful for human input.  At some point we need to figure out how to represent
 analog sensors connected to a generic ADC.
>
>- Ability to generate a "free-fall event" on a misc device
>  if the device containing the sensor is dropped. A special
>  interrupt can be enabled on the device for this. I can't quite
>  see how userspace is supposed to react to it, because this
>  miscdevice userspace ABI is sort of complex.
Long ago we had a discussion about how to handle this. I think the conclusion was we just needed a standard abi that any driver
 could use to notify user space if any sensor told the machine it was in free fall.  /Dev/freefall perhaps with simple poll /select support?

Can do this with iio events but perhaps a separate system would be lighter weight?  
Interesting trick would be to do a software filter for this for devices without hardware support.
>
>- Some driver-specific sysfs power management stuff
>
>- Context save/restore registers for power-off handling.
>
>- Trigger selftest from sysfs : I suspect this could be ported
>  over to all the ST Micro devices, as they are similar in that
>  way, same kind of test registers.
>
>- Possible to enable high-pass filter from the DT config.
>  (Should that not be dynamic?)
Probably. 
>
>Apart from that it has a custom sysfs interface to read the
>accelerometer, similar to the IIO interface. It seems to *only* support
>raw values AFAICT  though, not sensitivity adjustment, so my patch
>gives the ability to have better sensor handling in the kernel from an
>IIO point of view.
>
I likewise looked at this long ago (came out roughly concurrently with the similar lis3l02dq driver) came to roughly the same conclusion.
>Yours,
>Linus Walleij

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
