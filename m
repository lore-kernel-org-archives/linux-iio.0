Return-Path: <gregor.boirie@parrot.com>
Message-ID: <57D0584E.2000709@parrot.com>
Date: Wed, 7 Sep 2016 20:11:26 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>
Subject: Re: [PATCH v1 1/1] iio:core: fix IIO_VAL_FRACTIONAL sign handling
References: <e66c33d8d00c51878039a967f2650f7bc1866e90.1472840709.git.gregor.boirie@parrot.com> <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org> <32c015f4-bbd7-e2f4-3b4c-f7799ea95360@metafoo.de> <419daee6-1e68-dba4-3e04-3c13d58eea44@kernel.org>
In-Reply-To: <419daee6-1e68-dba4-3e04-3c13d58eea44@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Just to mention that a somewhat similar patch might be needed to handle 
negative
IIO_VAL_FRACTIONAL_LOG2 values.

On 09/05/2016 10:24 PM, Jonathan Cameron wrote:
> On 05/09/16 08:59, Lars-Peter Clausen wrote:
>> On 09/03/2016 05:13 PM, Jonathan Cameron wrote:
>>> On 02/09/16 19:27, Gregor Boirie wrote:
>>>> 7985e7c100 ("iio: Introduce a new fractional value type") introduced a
>>>> new IIO_VAL_FRACTIONAL value type meant to represent rational type numbers
>>>> expressed by a numerator and denominator combination.
>>>>
>>>> Formating of IIO_VAL_FRACTIONAL values relies upon do_div() usage. This
>>>> fails handling negative values properly since parameters are reevaluated
>>>> as unsigned values.
>>>> Fix this by using div_s64_rem() instead. Computed integer part will carry
>>>> properly signed value. Formatted fractional part will always be positive.
>>>>
>>>> Fixes: 7985e7c100 ("iio: Introduce a new fractional value type")
>>>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>>> Hi Gregor,
>>>
>>> While this looks sensible to me, I always gain an almighty headache when
>>> I hit the various divide functions.
>>>
>>> Lars, the fractional code was yours in the first place.
>>> If you have time can you sanity check this please.
>> Looks good. While looking into this I noticed that we have a very similar
>> patch[1] in our tree, seems like somebody forgot to send that upstream.
>>
>> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
> Applied to the fixes-togreg branch of iio.git and marked for stable.
> Good to know about the previous patch - if there was anything hiding around
> this I would assume that would have shaken it out by now!
>
> Thanks
>
> Jonathan
>>
>> [1]
>> https://github.com/analogdevicesinc/linux/commit/1dbcdcfd0c8d3f5513572697685d9f30ba49d851
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
