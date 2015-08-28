Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:33553 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbbH1JFS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2015 05:05:18 -0400
Received: by lbbsx3 with SMTP id sx3so26411852lbb.0
        for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2015 02:05:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55E000F2.9000403@metafoo.de>
References: <1440657930-14871-1-git-send-email-mranostay@gmail.com>
	<55DF2F67.3000209@metafoo.de>
	<55DF33BF.7080808@metafoo.de>
	<CAKzfze_ySetkta6cAHo7yg4mJ49UC+ymdcj6u04xs0rYe8PA_A@mail.gmail.com>
	<55E000F2.9000403@metafoo.de>
Date: Fri, 28 Aug 2015 02:05:16 -0700
Message-ID: <CAKzfze_sOrrj4vQa4Ld0y4Q8aX7W3QogAKMhUU=8oU9Aqy3Mmg@mail.gmail.com>
Subject: Re: [RFC] iio: ppm: Add IIO_PPM channel type
From: Matt Ranostay <mranostay@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, attila@kinali.ch,
	Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Matt Porter <matt@ohporter.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 27, 2015 at 11:34 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/27/2015 11:40 PM, Matt Ranostay wrote:
>> On Thu, Aug 27, 2015 at 8:58 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>>> On 08/27/2015 05:40 PM, Lars-Peter Clausen wrote:
>>>> On 08/27/2015 08:45 AM, Matt Ranostay wrote:
>>>>> There are air quality sensors that report data back in parts per million
>>>>> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
>>>>> or another common pollutant.
>>>>>
>>>>> This patchset adds an IIO_PPM type because no other channels types fit
>>>>> this use case.
>>>>
>>>> Hm, I'm not sure if parts-per-million is a good channel type. It's more of a
>>>> scale. The type would be concentration.[...]
>>>
>>> Reading a bit more[1], concentration doesn't actually seem to be the right
>>> term in this case, the correct term is mole fraction. Maybe we can use that
>>> as the type. That also makes it clear that the unit is molecules per molecule.
>>>
>> Actually we can't use mole fraction for this because we aren't in a
>> chemistry lab, and know the other compounds that make up the local
>> atmosphere. Besides you'd have to include some insane lookup table for
>> molar mass of carbon or whatever VOC being measured :)
>
> I don't think you'd need that. Mole fraction tells you the number of
> molecules of something per total number of molecules. You don't need the
> mass for this.
>
> But what exactly is the sensor measuring? CO2 (or VOC) molecules per total
> number of molecules or number of CO2 molecules in a particular volume?
>
CC'ed my Swiss colleague on this because he knows much on the
interworkings of VOC sensors than I could hope to.
So simply these sensors are finding VOCs (which the sensor in question
does CO2 and tVOC indexes.. probably not too independent of  each
other)

But molecules are not parts.. think of taking an X volume of air and
figuring what is precent of oxygen is verses nitrogen, argon, etc,
etc. Sure the highest is nitrogen at atomic weight 14.01 with ~78% of
the "air", oxygen is ~20% at the weight of 16.00, and etc.

Think about cutting cube into a millions of pieces and figuring an X%
is Y substance which you can detect, but can't detect X, Y, and Z
(think any particles in 'air' that aren't bonded with carbon). So mole
fractions are impossible here, and you could only take a parts in a
known volume.

Most VOCs (if not all, bit of newbie here) use UV LEDs to ionize
particles, and with some maths calculate the parts-per-million.
>>
>> IIO_CONCENTRATION could be useful since you could just change the
>> scale to make it ppm or ppb or whatever.
>>
>>> - Lars
>>>
>>> [1] https://en.wikipedia.org/wiki/Concentration
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
