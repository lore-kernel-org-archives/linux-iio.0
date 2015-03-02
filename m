Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp105.biz.mail.bf1.yahoo.com ([98.139.221.43]:46760 "EHLO
	smtp105.biz.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753705AbbCBTDu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Mar 2015 14:03:50 -0500
From: "Kevin Tsai" <ktsai@capellamicro.com>
To: "'Daniel Baluta'" <daniel.baluta@intel.com>
Cc: "'Jonathan Cameron'" <jic23@kernel.org>,
	"'Hartmut Knaack'" <knaack.h@gmx.de>,
	"'Lars-Peter Clausen'" <lars@metafoo.de>,
	"'Peter Meerwald'" <pmeerw@pmeerw.net>,
	<linux-iio@vger.kernel.org>,
	"'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
References: <1421921412-7710-1-git-send-email-daniel.baluta@intel.com>	<54C4C510.5090306@kernel.org>	<CAEnQRZAhTQEGiSeAOahG4A_iZhPgMYnoHwLjDeEWKarwVJO3qg@mail.gmail.com> <CAEnQRZDtkQiqxLQZ6f4SJW29sDtMvgFe55ecTFMKfi6O7rcNdg@mail.gmail.com>
In-Reply-To: <CAEnQRZDtkQiqxLQZ6f4SJW29sDtMvgFe55ecTFMKfi6O7rcNdg@mail.gmail.com>
Subject: RE: [PATCH] iio: light: Add support for Capella CM3323 color/light sensor
Date: Mon, 2 Mar 2015 11:03:45 -0800
Message-ID: <000d01d0551b$9d424bb0$d7c6e310$@capellamicro.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Daniel,

Ambient light sensor is trying to match the brightness sensitivity of human visual system.  Please see the following links:
http://en.wikipedia.org/wiki/Color_vision#mediaviewer/File:Eyesensitivity.svg
http://en.wikipedia.org/wiki/Color_vision

You can compare the spectrum with the datasheet.  The green channel is matched with ALS spectrum.

Kevin Tsai
03/02/15

-----Original Message-----
From: daniel.baluta@gmail.com [mailto:daniel.baluta@gmail.com] On Behalf Of Daniel Baluta
Sent: Monday, March 02, 2015 1:57 AM
To: Daniel Baluta
Cc: Jonathan Cameron; Kevin Tsai; Hartmut Knaack; Lars-Peter Clausen; Peter Meerwald; linux-iio@vger.kernel.org; Linux Kernel Mailing List
Subject: Re: [PATCH] iio: light: Add support for Capella CM3323 color/light sensor

On Sun, Jan 25, 2015 at 12:50 PM, Daniel Baluta <daniel.baluta@intel.com> wrote:
> On Sun, Jan 25, 2015 at 12:27 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 22/01/15 10:10, Daniel Baluta wrote:
>>> Minimal implementation providing raw light intensity and illuminance 
>>> readings. For illuminance user can compute lux values using raw 
>>> readings and scale.
>>>
>>> This driver also supports CM3323E sensor chip.
>>>
>>> Cc: Kevin Tsai <ktsai@capellamicro.com>
>>> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
>>
>> Hi Daniel,
>>
>> My only real question on this one is whether using the 'green' 
>> channel and pretending it is a measure of illuminance is a good idea 
>> or whether we are better leaving that decision to userspace...
>>
>> I'm guessing the reason it is green rather than clear is that the 
>> clear is letting infrared through and we don't have an additional 
>> infrared sensor available to allow that component to be removed?
>
> Hi Jonathan,
>
> <snip>
>>> +#define CM3323_COLOR_CHANNEL(_color, _addr) {\
>>> +     .type = IIO_INTENSITY, \
>>> +     .modified = 1, \
>>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
>>> +     .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME), \
>>> +     .channel2 = IIO_MOD_LIGHT_##_color, \
>>> +     .address = _addr, \
>>> +}
>>> +
>>> +/*
>>> + * CM3323's GREEN channel is used for reading illuminance
>> That's impressively random and unlikely to be anywhere near correct 
>> pretty much all the time!
>>
>> I'd personally prefer just not providing an illuminance channel and 
>> leaving it up to userspace to make the decision on whether the green 
>> channel is good enough...
>
> Datasheet says that the GREEN channel should be used for getting 
> illuminance readings. I'm not sure if this is totally random.
>
> I understand your worries, perhaps Kevin could 'enlighten' us here.
>
> I would  prefer to have the illuminance channel exported from IIO 
> because there are already userspace applications/frameworks  written 
> and tested for ALS that use IIO illuminance channel.
> We want to use this driver without modifying user space.
>
> Of course, one option for the moment would be to only export the 
> INTENSITY channels as per your recommendation and to decide later what 
> to do for the LIGHT channel.

Hi Kevin,

Could you tell us how reliable is using the GREEN channel for getting illuminance readings?

If no objection, I will resend this driver exposing only INTENSITY channels for the moment.

thanks,
Daniel.

