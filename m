Return-Path: <SRS0=OunF=HB=axentia.se=peda@kernel.org>
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
 <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
 <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
Date: Thu, 12 Apr 2018 16:29:33 +0200
MIME-Version: 1.0
In-Reply-To: <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 2018-04-11 18:13, Andrew F. Davis wrote:
> On 04/11/2018 10:51 AM, Lars-Peter Clausen wrote:
>> On 04/11/2018 05:43 PM, Andrew F. Davis wrote:
>>> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>>>> This is a current sense amplifier from Analog Devices.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/iio/afe/Kconfig              |  3 +-
>>>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>>>> index 642ce4eb12a6..0e10fe8f459a 100644
>>>> --- a/drivers/iio/afe/Kconfig
>>>> +++ b/drivers/iio/afe/Kconfig
>>>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>>>  	depends on OF || COMPILE_TEST
>>>>  	help
>>>>  	  Say yes here to build support for the IIO unit converter
>>>> -	  that handles voltage dividers and current sense shunts.
>>>> +	  that handles voltage dividers, current sense shunts and
>>>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
>>>
>>> Could work better to split these out into separate drivers. Maybe a
>>> iio-shunt-resistor.c that does just voltage->current with the
>>> appropriate scaling. Then make a a separate lt6106.c.
>>
>> I don't think we need a separate driver here. There are tons of circuits
>> that all work the same way and all require the same properties. If we'd add
>> a driver for each of them we'd get buried in boilerplate code.
>>
> 
> Fair enough, then it should at least be renamed to something generic
> like current-sense-amplifier, as you said lots of circuits do this, not
> just lt6106s. We will have then have support for:
> 
> current-sense-amplifier
> current-sense-shunt
> voltage-divider

For the compatible "current-sense-amplifier", I would advocate the
properties...

 sense-resistor-micro-ohms
 sense-gain

(or something close to that)

...and not input-resistor-ohms and output-resistor-ohms which are way
more particular to the LT6106.

But as I said in the cover letter, I didn't go with sense-gain since I
thought I would end up with requests for non-integer gains. There is
yet to be a comment on the non-integer gain problem, and before there
is a path forward for that case, I'm reluctant.

> compatibles in this driver called "unit-converter" which is still a
> misnomer IMHO.

I don't remember you having presented your preference, and I think
that goes against the established bike-shedding protocol?

Cheers,
Peter
