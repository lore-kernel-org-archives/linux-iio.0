Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35319 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbH0Vki (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 17:40:38 -0400
Received: by lbcbn3 with SMTP id bn3so19576970lbc.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2015 14:40:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <55DF33BF.7080808@metafoo.de>
References: <1440657930-14871-1-git-send-email-mranostay@gmail.com>
	<55DF2F67.3000209@metafoo.de>
	<55DF33BF.7080808@metafoo.de>
Date: Thu, 27 Aug 2015 14:40:36 -0700
Message-ID: <CAKzfze_ySetkta6cAHo7yg4mJ49UC+ymdcj6u04xs0rYe8PA_A@mail.gmail.com>
Subject: Re: [RFC] iio: ppm: Add IIO_PPM channel type
From: Matt Ranostay <mranostay@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Aug 27, 2015 at 8:58 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 08/27/2015 05:40 PM, Lars-Peter Clausen wrote:
>> On 08/27/2015 08:45 AM, Matt Ranostay wrote:
>>> There are air quality sensors that report data back in parts per million
>>> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
>>> or another common pollutant.
>>>
>>> This patchset adds an IIO_PPM type because no other channels types fit
>>> this use case.
>>
>> Hm, I'm not sure if parts-per-million is a good channel type. It's more of a
>> scale. The type would be concentration.[...]
>
> Reading a bit more[1], concentration doesn't actually seem to be the right
> term in this case, the correct term is mole fraction. Maybe we can use that
> as the type. That also makes it clear that the unit is molecules per molecule.
>
Actually we can't use mole fraction for this because we aren't in a
chemistry lab, and know the other compounds that make up the local
atmosphere. Besides you'd have to include some insane lookup table for
molar mass of carbon or whatever VOC being measured :)

IIO_CONCENTRATION could be useful since you could just change the
scale to make it ppm or ppb or whatever.

> - Lars
>
> [1] https://en.wikipedia.org/wiki/Concentration
