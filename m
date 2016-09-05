Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:7897 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932667AbcIHIJq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Sep 2016 04:09:46 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        <linux-iio@vger.kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <e66c33d8d00c51878039a967f2650f7bc1866e90.1472840709.git.gregor.boirie@parrot.com> <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org>
In-Reply-To: <e20dc6d8-7bd0-0feb-6464-a8af61b880a9@kernel.org>
Subject: Re: [PATCH v1 1/1] iio:core: fix IIO_VAL_FRACTIONAL sign handling
Date: Mon, 5 Sep 2016 01:59:08 -0600
Message-ID: <32c015f4-bbd7-e2f4-3b4c-f7799ea95360@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/03/2016 05:13 PM, Jonathan Cameron wrote:
> On 02/09/16 19:27, Gregor Boirie wrote:
>> 7985e7c100 ("iio: Introduce a new fractional value type") introduced a
>> new IIO_VAL_FRACTIONAL value type meant to represent rational type numbers
>> expressed by a numerator and denominator combination.
>>
>> Formating of IIO_VAL_FRACTIONAL values relies upon do_div() usage. This
>> fails handling negative values properly since parameters are reevaluated
>> as unsigned values.
>> Fix this by using div_s64_rem() instead. Computed integer part will carry
>> properly signed value. Formatted fractional part will always be positive.
>>
>> Fixes: 7985e7c100 ("iio: Introduce a new fractional value type")
>> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> 
> Hi Gregor,
> 
> While this looks sensible to me, I always gain an almighty headache when
> I hit the various divide functions.
> 
> Lars, the fractional code was yours in the first place.
> If you have time can you sanity check this please.

Looks good. While looking into this I noticed that we have a very similar
patch[1] in our tree, seems like somebody forgot to send that upstream.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>


[1]
https://github.com/analogdevicesinc/linux/commit/1dbcdcfd0c8d3f5513572697685d9f30ba49d851

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

