Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:59205 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab1GRQL7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jul 2011 12:11:59 -0400
Message-ID: <4E245B49.90004@cam.ac.uk>
Date: Mon, 18 Jul 2011 17:11:53 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Paul Thomas <pthomas8589@gmail.com>
CC: lm-sensors@lm-sensors.org,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: add support for Analog Devices ad7194 a/d converter
References: <1310975165-19912-1-git-send-email-pthomas8589@gmail.com>	<4E241286.3090103@cam.ac.uk>	<4E242605.9050400@cam.ac.uk> <CAD56B7d+rixhKSoHJ4zcKhT6xMUUZZPERoOzSO74q6ZrHS7-Sg@mail.gmail.com>
In-Reply-To: <CAD56B7d+rixhKSoHJ4zcKhT6xMUUZZPERoOzSO74q6ZrHS7-Sg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/18/11 17:03, Paul Thomas wrote:
> On Mon, Jul 18, 2011 at 5:24 AM, Jonathan Cameron <jic23@cam.ac.uk> wrote:
>> On 07/18/11 12:01, Jonathan Cameron wrote:
>>> cc'ing linux-iio and AD's driver list.
>>>
>>> Any particular reason for posting to lm-sensors? Now it's there we'll
>>> keep them in the list though as someone might be interested.
>>>
>>> On 07/18/11 08:46, Paul Thomas wrote:
>>>> This uses the iio sysfs interface, and inculdes gain and differential settings
>>
>> Hi Paul,
>>
>> This driver is lagging somewhat in interface terms. Having said that, it applies
>> and compiles fine which will make catching up to current point much easier.
>>
>> If you are short on time I'm happy to do the conversion (as it is a nice simple
>> driver), but obviously I'll need to test it to find out what I messed up this
>> time.
>>
>> Big issues:
>>
>> 1) iio_dev->dev_data is going away, so please use the iio_priv stuff.
>> 2) interface is not terribly close the abi spec.
>> 3) use chan_spec based registration. Actually that'll clean up the abi
>> issues as well and give you much shorter code.
>> 4) differential channels are treated as separate channels (with appropriate
>> numbering).  This is easy here as there are no nasty constraints on channel
>> combinations (it only reads one at a time anyway!).
>>
>> Various nitpicks inline.  Though the above seems like a lot, you have done
>> all the fiddly stuff about actually talking the the chips. Cleaning up
>> interfaces is relatively straight forward!  Lots of fun stuff to add to this
>> chip at a later date, but in the spirit of your driver, lets keep it simple
>> for now!
>>
>> As long as you are happy to do a couple of rounds of testing, we could merge
>> this as is and do the abi work as a series of small steps on top of it?
>>
>> Thanks,
>>
>> Jonathan
> 
> Hi Jonathan, I'd be happy to do the fixing. Is there an existing
> multi-channel driver that might be helpful to reference here?
> 
Cool.

Lots of suitable drivers to copy.  Max1363 is my standard adc and that
driver is reasonably fully featured. I think most of the ADI drivers
are mostly unipolar only, but a quick grep tells me the ad7793 has
a mixture of differential an unipolar.

max1363 is probably the closest to what you have here in that it supports
the same range of combinations of inputs.

Jonathan
