Return-Path: <SRS0=4xe3=6N=embeddedor.com=garsilva@kernel.org>
Date: Mon, 10 Jul 2017 14:44:23 -0500
Message-ID: <20170710144423.Horde.7iJn7zvwA-jFfY4uTu7coYW@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Rosin <peda@axentia.se>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc() and
 devm_kmemdup() return values
References: <20170707045311.GA4535@embeddedgus>
 <df6ae9c6-8ac7-368b-a1c2-4403387df02b@axentia.se>
 <0ba9b76f-41f8-3171-2eb7-d9abbe106674@axentia.se>
 <20170709181023.54458b6c@kernel.org>
In-Reply-To: <20170709181023.54458b6c@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Quoting Jonathan Cameron <jic23@kernel.org>:

> On Fri, 7 Jul 2017 11:26:35 +0200
> Peter Rosin <peda@axentia.se> wrote:
>
>> On 2017-07-07 06:57, Peter Rosin wrote:
>> > On 2017-07-07 06:53, Gustavo A. R. Silva wrote:
>> >> Check return values from call to devm_kzalloc() and devm_kmemup()
>> >
>> > If someone cares enough: s/devm_kmemup/evm_kmemdup/
>>
>> Strange, there seems to be some inherent shortage of 'd' characters...
>>
>> Cheers,
>> pea :-)
>>
>> >
>> >> in order to prevent a NULL pointer dereference.
>> >>
>> >> This issue was detected using Coccinelle and the following  
>> semantic patch:
>> >>
>> >> @@
>> >> expression x;
>> >> identifier fld;
>> >> @@
>> >>
>> >> * x = devm_kzalloc(...);
>> >>    ... when != x == NULL
>> >>    x->fld
>> >>
>> >> Cc: Peter Rosin <peda@axentia.se>
>> >> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> >
>> > Either way,
>> >
>> > Reviewed-by: Peter Rosin <peda@axentia.se>
>> >
>> > Thanks!
>> >
> The relevant patch adding the file in questions hasn't yet worked it's
> way back to the iio tree so I can't apply this until it does.
>
> That is likely to be a few weeks away yet.  Please give me a poke if
> I seem to have forgotten it!
>

OK, I will do that. :)

Thanks!
--
Gustavo A. R. Silva
