Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46650 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751576AbdBYQsu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Feb 2017 11:48:50 -0500
Subject: Re: [Outreachy kernel] [PATCH v2 1/2] staging: iio: ad7152: Use BIT()
 macro for left shifting 1
To: Julia Lawall <julia.lawall@lip6.fr>,
        sayli karnik <karniksayli1995@gmail.com>
References: <cover.1487483384.git.karniksayli1995@gmail.com>
 <06283c7cbccd40a7214bf4f047c3829e53b6d448.1487483384.git.karniksayli1995@gmail.com>
 <alpine.DEB.2.20.1702192101420.2363@hadrien>
Cc: outreachy-kernel@googlegroups.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <658d6a83-8464-be05-5a06-fcd1d33b6710@kernel.org>
Date: Sat, 25 Feb 2017 16:47:47 +0000
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1702192101420.2363@hadrien>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/02/17 20:02, Julia Lawall wrote:
> 
> 
> On Mon, 20 Feb 2017, sayli karnik wrote:
> 
>> Replace left shifting on 1 with the BIT(x) macro as suggested by
>> checkpatch.pl.
>>
>> Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
> 
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

For obvious reasons I'm going to leave patch 2 alone!

Thanks,

Jonathan
> 
>> ---
>> v2:
>> Used GENMASK() macro instead of BIT() macro for multi-bit bitfields.
>> Removed extra parentheses around argument to macro
>>
>>  drivers/staging/iio/cdc/ad7152.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
>> index b91b50f..e8609b8 100644
>> --- a/drivers/staging/iio/cdc/ad7152.c
>> +++ b/drivers/staging/iio/cdc/ad7152.c
>> @@ -41,10 +41,10 @@
>>  #define AD7152_REG_CFG2			26
>>
>>  /* Status Register Bit Designations (AD7152_REG_STATUS) */
>> -#define AD7152_STATUS_RDY1		(1 << 0)
>> -#define AD7152_STATUS_RDY2		(1 << 1)
>> -#define AD7152_STATUS_C1C2		(1 << 2)
>> -#define AD7152_STATUS_PWDN		(1 << 7)
>> +#define AD7152_STATUS_RDY1		BIT(0)
>> +#define AD7152_STATUS_RDY2		BIT(1)
>> +#define AD7152_STATUS_C1C2		BIT(2)
>> +#define AD7152_STATUS_PWDN		BIT(7)
>>
>>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
>>  #define AD7152_SETUP_CAPDIFF		(1 << 5)
>> --
>> 2.7.4
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/06283c7cbccd40a7214bf4f047c3829e53b6d448.1487483384.git.karniksayli1995%40gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
>>

