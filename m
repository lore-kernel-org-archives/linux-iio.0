Return-Path: <SRS0=of0l=GY=ti.com=afd@kernel.org>
Subject: Re: [PATCH v2 0/2] iio: add unit converter
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Phil Reid <preid@electromag.com.au>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20180403153635.8228-1-peda@axentia.se>
 <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
 <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <05f62c0d-4088-dfd1-4a6a-f3ed308824d7@ti.com>
Date: Tue, 3 Apr 2018 13:55:52 -0500
MIME-Version: 1.0
In-Reply-To: <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

On 04/03/2018 01:09 PM, Peter Rosin wrote:
> On 2018-04-03 19:41, Andrew F. Davis wrote:
>> On 04/03/2018 10:36 AM, Peter Rosin wrote:
>>> Hi!
>>>
>>> This driver implements support for voltage dividers and current
>>> sense circuits. It's pretty generic and should be easily adaptable
>>> to other linear scaling purposes...
>>>
>>
>> I really like this idea, defining channel scaling / channel type
>> conversion in DT will be very useful. So much so that I would recommend
>> this not be a use specific driver but instead moved into the IIO core.
>>
>> This would allow defining these channel conversions in the device node
>> itself, so as to not need a separate node just for the converter (the
>> conversion is not a device and probably should not have it's own node
>> anyway). It would also help with enabling this support for buffered
>> readers/writers and not just devices only supporting _raw reads/writes.
> 
> In my case, the voltage dividers and the current sense circuit are very
> much real, and I can point my finger at them on the board. Sure, they
> are not ICs, but to not call them devices is wrong IMHO, and the ADC
> which is involved have very little to do with the voltage dividers and
> the fact that it is involved in sensing current. 


I would argue support resistors are still part of the "current sensing
device", even if they are physically external to the ADC IC. As you say
though, it doesn't really matter that much to this discussion.


> This is not an argument
> for not moving the functionally to the core though, but that has some
> problems AFAICT. Because you need some kind of clever and generic
> binding to make the core do its thing, and it might not be easy to come
> up with something that fits all devices? And if we do put this in the
> core, that opens the door for more complex unit converters later on
> (non-linear etc), further complicating the generic bindings.
> 


For the simple case of linear scaling of the channel input/output, and
type conversion I don't see much problem. They will not need to be
extended, new bindings can be added for more complex cases. When more
complex cases show up additional bindings will be needed either way.


> That said, I'm obviously biased since I want this to get in sooner
> rather than later...
> 


Adding this functionality to the IIO core doesn't really block this
patch-set, it will just make this patch-set unneeded in the future
if/when support goes into the core..

Andrew


> Cheers,
> Peter
> 
