Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42110 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbbH0QUC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2015 12:20:02 -0400
In-Reply-To: <55DF33BF.7080808@metafoo.de>
References: <1440657930-14871-1-git-send-email-mranostay@gmail.com> <55DF2F67.3000209@metafoo.de> <55DF33BF.7080808@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [RFC] iio: ppm: Add IIO_PPM channel type
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 27 Aug 2015 17:19:55 +0100
To: Lars-Peter Clausen <lars@metafoo.de>,
	Matt Ranostay <mranostay@gmail.com>, jic23@kernel.org
CC: linux-iio@vger.kernel.org
Message-ID: <45FF83D8-055C-43ED-92BB-220D7A6DC4B9@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 27 August 2015 16:58:55 BST, Lars-Peter Clausen <lars@metafoo.de> wrote:
>On 08/27/2015 05:40 PM, Lars-Peter Clausen wrote:
>> On 08/27/2015 08:45 AM, Matt Ranostay wrote:
>>> There are air quality sensors that report data back in parts per
>million
>>> of VOC (Volatile Organic Compounds) which are usually indexed from
>CO2
>>> or another common pollutant.
>>>
>>> This patchset adds an IIO_PPM type because no other channels types
>fit
>>> this use case.
>> 
>> Hm, I'm not sure if parts-per-million is a good channel type. It's
>more of a
>> scale. The type would be concentration.[...]
>
>Reading a bit more[1], concentration doesn't actually seem to be the
>right
>term in this case, the correct term is mole fraction. Maybe we can use
>that
>as the type. That also makes it clear that the unit is molecules per
>molecule.
>
>- Lars
>
>[1] https://en.wikipedia.org/wiki/Concentration

Works for me.

I'm tending to prefer base units that don't have an arbitrary scale factor and use the
 IIO types to define.  Molecules per molecule then use scale would be my
 preference.

Agreed on using modifiers for what we are measuring.  Guessing there aren't that many sensor types out there.  If it gets really silly we can add a means of listing chemicals detected!

J
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
