Return-Path: <lars@metafoo.de>
Message-ID: <55DF33BF.7080808@metafoo.de>
Date: Thu, 27 Aug 2015 17:58:55 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Matt Ranostay <mranostay@gmail.com>, jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [RFC] iio: ppm: Add IIO_PPM channel type
References: <1440657930-14871-1-git-send-email-mranostay@gmail.com> <55DF2F67.3000209@metafoo.de>
In-Reply-To: <55DF2F67.3000209@metafoo.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 08/27/2015 05:40 PM, Lars-Peter Clausen wrote:
> On 08/27/2015 08:45 AM, Matt Ranostay wrote:
>> There are air quality sensors that report data back in parts per million
>> of VOC (Volatile Organic Compounds) which are usually indexed from CO2
>> or another common pollutant.
>>
>> This patchset adds an IIO_PPM type because no other channels types fit
>> this use case.
> 
> Hm, I'm not sure if parts-per-million is a good channel type. It's more of a
> scale. The type would be concentration.[...]

Reading a bit more[1], concentration doesn't actually seem to be the right
term in this case, the correct term is mole fraction. Maybe we can use that
as the type. That also makes it clear that the unit is molecules per molecule.

- Lars

[1] https://en.wikipedia.org/wiki/Concentration
