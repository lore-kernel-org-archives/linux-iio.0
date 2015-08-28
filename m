Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-220.synserver.de ([212.40.185.220]:1086 "EHLO
	smtp-out-200.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751389AbbH1Geu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 28 Aug 2015 02:34:50 -0400
Message-ID: <55E000F2.9000403@metafoo.de>
Date: Fri, 28 Aug 2015 08:34:26 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [RFC] iio: ppm: Add IIO_PPM channel type
References: <1440657930-14871-1-git-send-email-mranostay@gmail.com>	<55DF2F67.3000209@metafoo.de>	<55DF33BF.7080808@metafoo.de> <CAKzfze_ySetkta6cAHo7yg4mJ49UC+ymdcj6u04xs0rYe8PA_A@mail.gmail.com>
In-Reply-To: <CAKzfze_ySetkta6cAHo7yg4mJ49UC+ymdcj6u04xs0rYe8PA_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/27/2015 11:40 PM, Matt Ranostay wrote:
> On Thu, Aug 27, 2015 at 8:58 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 08/27/2015 05:40 PM, Lars-Peter Clausen wrote:
>>> On 08/27/2015 08:45 AM, Matt Ranostay wrote:
>>>> There are air quality sensors that report data back in parts per million
>>>> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
>>>> or another common pollutant.
>>>>
>>>> This patchset adds an IIO_PPM type because no other channels types fit
>>>> this use case.
>>>
>>> Hm, I'm not sure if parts-per-million is a good channel type. It's more of a
>>> scale. The type would be concentration.[...]
>>
>> Reading a bit more[1], concentration doesn't actually seem to be the right
>> term in this case, the correct term is mole fraction. Maybe we can use that
>> as the type. That also makes it clear that the unit is molecules per molecule.
>>
> Actually we can't use mole fraction for this because we aren't in a
> chemistry lab, and know the other compounds that make up the local
> atmosphere. Besides you'd have to include some insane lookup table for
> molar mass of carbon or whatever VOC being measured :)

I don't think you'd need that. Mole fraction tells you the number of
molecules of something per total number of molecules. You don't need the
mass for this.

But what exactly is the sensor measuring? CO2 (or VOC) molecules per total
number of molecules or number of CO2 molecules in a particular volume?

> 
> IIO_CONCENTRATION could be useful since you could just change the
> scale to make it ppm or ppb or whatever.
> 
>> - Lars
>>
>> [1] https://en.wikipedia.org/wiki/Concentration
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

