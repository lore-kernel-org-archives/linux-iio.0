Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50555 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753966AbcIDQXC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Sep 2016 12:23:02 -0400
Subject: Re: [PATCH v1 1/1] iio:core: fix IIO_VAL_FRACTIONAL sign handling
To: Gregor Boirie <gregor.boirie@parrot.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <e66c33d8d00c51878039a967f2650f7bc1866e90.1472840709.git.gregor.boirie@parrot.com>
 <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org>
 <20160904161128.GA2016@geburah.sephiroth>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bbf0670a-fe1c-17f0-1f08-d9fd236df449@kernel.org>
Date: Sun, 4 Sep 2016 17:23:00 +0100
MIME-Version: 1.0
In-Reply-To: <20160904161128.GA2016@geburah.sephiroth>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/09/16 17:11, Gregor Boirie wrote:
> On Sat, Sep 03, 2016 at 04:13:30PM +0100, Jonathan Cameron wrote:
>> On 02/09/16 19:27, Gregor Boirie wrote:
>>> 7985e7c100 ("iio: Introduce a new fractional value type") introduced a
>>> new IIO_VAL_FRACTIONAL value type meant to represent rational type numbers
>>> expressed by a numerator and denominator combination.
>>>
>>> Formating of IIO_VAL_FRACTIONAL values relies upon do_div() usage. This
>>> fails handling negative values properly since parameters are reevaluated
>>> as unsigned values.
>>> Fix this by using div_s64_rem() instead. Computed integer part will carry
>>> properly signed value. Formatted fractional part will always be positive.
>>>
>>> Fixes: 7985e7c100 ("iio: Introduce a new fractional value type")
>>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
>>
>> Hi Gregor,
> Hi,
> 
>>
>> While this looks sensible to me, I always gain an almighty headache when
>> I hit the various divide functions.
> So am I.
>>
>> Lars, the fractional code was yours in the first place.
>> If you have time can you sanity check this please.
> This patch may break a lot things indeed. I'd feel much more comfortable if
> someone else could perform additional testing too.
> 
How about adding a patch that adds a case of this to the iio_dummy driver?

That way we can all easily test it.

Jonathan
> Grégor.
>>
>> Jonathan
>>
>>> ---
>>>  drivers/iio/industrialio-core.c | 5 ++---
>>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
>>> index f914d5d..d2b8899 100644
>>> --- a/drivers/iio/industrialio-core.c
>>> +++ b/drivers/iio/industrialio-core.c
>>> @@ -613,9 +613,8 @@ ssize_t iio_format_value(char *buf, unsigned int type, int size, int *vals)
>>>  			return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>>>  	case IIO_VAL_FRACTIONAL:
>>>  		tmp = div_s64((s64)vals[0] * 1000000000LL, vals[1]);
>>> -		vals[1] = do_div(tmp, 1000000000LL);
>>> -		vals[0] = tmp;
>>> -		return sprintf(buf, "%d.%09u\n", vals[0], vals[1]);
>>> +		vals[0] = (int)div_s64_rem(tmp, 1000000000, &vals[1]);
>>> +		return sprintf(buf, "%d.%09u\n", vals[0], abs(vals[1]));
>>>  	case IIO_VAL_FRACTIONAL_LOG2:
>>>  		tmp = (s64)vals[0] * 1000000000LL >> vals[1];
>>>  		vals[1] = do_div(tmp, 1000000000LL);
>>>
>>

