Return-Path: <SRS0=5eqf=6K=embeddedor.com=garsilva@kernel.org>
Date: Thu, 06 Jul 2017 23:51:51 -0500
Message-ID: <20170706235151.Horde.0bV02ctiQ59WNlX28lLjSHX@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
 <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc()
 return value
References: <20170706220851.GA26284@embeddedgus>
 <01d4a23f-489a-6d1c-50ef-a77207719eae@axentia.se>
 <20170706233558.Horde.ODusk8GBY3IYWs1gZsRKWv4@gator4166.hostgator.com>
 <a60a8371-a947-50a5-08d3-a22496eb7679@axentia.se>
In-Reply-To: <a60a8371-a947-50a5-08d3-a22496eb7679@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>


Quoting Peter Rosin <peda@axentia.se>:

> On 2017-07-07 06:35, Gustavo A. R. Silva wrote:
>> Hi Peter,
>>
>> Quoting Peter Rosin <peda@axentia.se>:
>>
>>> On 2017-07-07 00:08, Gustavo A. R. Silva wrote:
>>>> Check return value from call to devm_kzalloc()
>>>> in order to prevent a NULL pointer dereference.
>>>
>>> Right, thanks for finding that one! There's another one inside the
>>> for loop that is just starting in the context of this patch. Care
>>> to fix checking the return value of that devm_kmemdup as well?
>>>
>>
>> Sure, I'll send a new patch shortly.
>>
>>> And someone should perhaps teach Coccinelle about devm_kmemdup...
>>>
>>
>> Good catch, I just implemented that script.
>>
>>>> This issue was detected using Coccinelle and the following semantic patch:
>>>>
>>>> @@
>>>> expression x;
>>>> identifier fld;
>>>> @@
>>>>
>>>> * x = devm_kzalloc(...);
>>>>   ... when != x == NULL
>>>>   x->fld
>>>>
>>>>
>>>
>>> One of these blank lines should perhaps be a "Fixes:" tag?
>>>
>>
>> mmm, I don't get this...
>
> If you add a Fixes-tag, like below, you help the stable kernel maintainers
> decide what to look at. In this case it might be overkill since the thing
> you fix is so fresh and does not apply to any old kernel. But I think it
> is a good habit...
>
> Fixes: 7ba9df54b091 ("iio: multiplexer: new iio category and iio-mux driver")
>
> (and it is a bit unusual to see two blank lines before the SoB-tag)
>
> Sorry for not spelling it out the first time.
>

Oh, I get it now. Thank you very much for clarifying. I will  
definitely keep that in mind for future fixes when that could apply.

Thanks!
--
Gustavo A. R. Silva
