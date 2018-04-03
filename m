Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr00098.outbound.protection.outlook.com ([40.107.0.98]:7224
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752924AbeDCSJS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Apr 2018 14:09:18 -0400
Subject: Re: [PATCH v2 0/2] iio: add unit converter
To: "Andrew F. Davis" <afd@ti.com>, linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180403153635.8228-1-peda@axentia.se>
 <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
Date: Tue, 3 Apr 2018 20:09:08 +0200
MIME-Version: 1.0
In-Reply-To: <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-04-03 19:41, Andrew F. Davis wrote:
> On 04/03/2018 10:36 AM, Peter Rosin wrote:
>> Hi!
>>
>> This driver implements support for voltage dividers and current
>> sense circuits. It's pretty generic and should be easily adaptable
>> to other linear scaling purposes...
>>
> 
> I really like this idea, defining channel scaling / channel type
> conversion in DT will be very useful. So much so that I would recommend
> this not be a use specific driver but instead moved into the IIO core.
> 
> This would allow defining these channel conversions in the device node
> itself, so as to not need a separate node just for the converter (the
> conversion is not a device and probably should not have it's own node
> anyway). It would also help with enabling this support for buffered
> readers/writers and not just devices only supporting _raw reads/writes.

In my case, the voltage dividers and the current sense circuit are very
much real, and I can point my finger at them on the board. Sure, they
are not ICs, but to not call them devices is wrong IMHO, and the ADC
which is involved have very little to do with the voltage dividers and
the fact that it is involved in sensing current. This is not an argument
for not moving the functionally to the core though, but that has some
problems AFAICT. Because you need some kind of clever and generic
binding to make the core do its thing, and it might not be easy to come
up with something that fits all devices? And if we do put this in the
core, that opens the door for more complex unit converters later on
(non-linear etc), further complicating the generic bindings.

That said, I'm obviously biased since I want this to get in sooner
rather than later...

Cheers,
Peter
