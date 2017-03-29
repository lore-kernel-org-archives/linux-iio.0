Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48488 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752776AbdC2QZD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 12:25:03 -0400
Date: Wed, 29 Mar 2017 17:24:36 +0100
In-Reply-To: <alpine.DEB.2.20.1703291736300.2989@hadrien>
References: <20170329151712.GA5651@arushi-HP-Pavilion-Notebook> <alpine.DEB.2.20.1703291736300.2989@hadrien>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [Outreachy kernel] [RESEND PATCH] staging: iio: Remove extra Parenthesis
To: Julia Lawall <julia.lawall@lip6.fr>,
        Arushi Singhal <arushisinghal19971997@gmail.com>
CC: outreachy-kernel@googlegroups.com,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <FF3FE5AC-E990-4D1F-88C7-2468665C6393@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 29 March 2017 16:38:28 BST, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>On Wed, 29 Mar 2017, Arushi Singhal wrote:
>
>> Remove the extra parenthesis remove the checkpatch issue.
>
>Is this a patch on the current state of the staging tree?  When I do a
>pull and then look at the code, the line numbers are all off.
>Furthermore, there are not calls to BIT with parentheses around them,
>so
>it looks like this is a patch on the result of another patch that you
>sent
>that was not accepted.
>
>When Greg says resend what was not picked up, he doesn't mean resend it
>as
>is, but reapply the patch to the current state of the kernel, and if it
>still applies correctly, send the result.

I picked this up on Saturday as I had already pushed out the IIO togreg branch with the original patch
and I try to never rebase that other than fast forwards.

So didn't need a resend, but patch was originally correct in this case.

At this time a cycle i tend to send pulls to Greg about every two weeks so there can be a bit of
 lag in IIO patches getting to the staging tree.

Jonathan
>
>julia
>
>>
>> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
>> ---
>>  drivers/staging/iio/cdc/ad7746.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/iio/cdc/ad7746.c
>b/drivers/staging/iio/cdc/ad7746.c
>> index 033a41fd9bee..b4afc12f827f 100644
>> --- a/drivers/staging/iio/cdc/ad7746.c
>> +++ b/drivers/staging/iio/cdc/ad7746.c
>> @@ -50,10 +50,10 @@
>>  #define AD7746_STATUS_RDYCAP		BIT(0)
>>
>>  /* Capacitive Channel Setup Register Bit Designations
>(AD7746_REG_CAP_SETUP) */
>> -#define AD7746_CAPSETUP_CAPEN		(BIT(7))
>> -#define AD7746_CAPSETUP_CIN2		(BIT(6)) /* AD7746 only */
>> -#define AD7746_CAPSETUP_CAPDIFF		(BIT(5))
>> -#define AD7746_CAPSETUP_CACHOP		(BIT(0))
>> +#define AD7746_CAPSETUP_CAPEN		BIT(7)
>> +#define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
>> +#define AD7746_CAPSETUP_CAPDIFF		BIT(5)
>> +#define AD7746_CAPSETUP_CACHOP		BIT(0)
>>
>>  /* Voltage/Temperature Setup Register Bit Designations
>(AD7746_REG_VT_SETUP) */
>>  #define AD7746_VTSETUP_VTEN		(1 << 7)
>> @@ -61,9 +61,9 @@
>>  #define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
>>  #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
>>  #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
>> -#define AD7746_VTSETUP_EXTREF		(BIT(4))
>> -#define AD7746_VTSETUP_VTSHORT		(BIT(1))
>> -#define AD7746_VTSETUP_VTCHOP		(BIT(0))
>> +#define AD7746_VTSETUP_EXTREF		BIT(4)
>> +#define AD7746_VTSETUP_VTSHORT		BIT(1)
>> +#define AD7746_VTSETUP_VTCHOP		BIT(0)
>>
>>  /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP)
>*/
>>  #define AD7746_EXCSETUP_CLKCTRL		BIT(7)
>> @@ -87,7 +87,7 @@
>>  #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
>>
>>  /* CAPDAC Register Bit Designations (AD7746_REG_CAPDACx) */
>> -#define AD7746_CAPDAC_DACEN		(BIT(7))
>> +#define AD7746_CAPDAC_DACEN		BIT(7)
>>  #define AD7746_CAPDAC_DACP(x)		((x) & 0x7F)
>>
>>  /*
>> --
>> 2.11.0
>>
>> --
>> You received this message because you are subscribed to the Google
>Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it,
>send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to
>outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit
>https://groups.google.com/d/msgid/outreachy-kernel/20170329151712.GA5651%40arushi-HP-Pavilion-Notebook.
>> For more options, visit https://groups.google.com/d/optout.
>>

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
