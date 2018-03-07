Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:44296 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754173AbeCGSC5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 13:02:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 38F294380064
        for <linux-iio@vger.kernel.org>; Wed,  7 Mar 2018 19:02:56 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id D54CF4380063
        for <linux-iio@vger.kernel.org>; Wed,  7 Mar 2018 19:02:54 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Wed, 07 Mar 2018 19:02:54 +0100
From: Michael Nosthoff <committed@heine.so>
To: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ
In-Reply-To: <f90c4698-15bf-ce11-ded9-f00b6ac0a263@metafoo.de>
References: <43f7cfe7bf868fb00e81a76246b9bc3a@heine.so>
 <f90c4698-15bf-ce11-ded9-f00b6ac0a263@metafoo.de>
Message-ID: <e4800a5aded78249f54837798efa0e3b@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-03-07 17:43, Lars-Peter Clausen wrote:
> On 03/07/2018 05:17 PM, Michael Nosthoff wrote:
>> This commit is a follow-up to changes made to ad_sigma_delta.h
>> in staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ
>> which broke ad7793 as it was not altered to match those changes.
>> 
>> This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ
>> attribute wherein usage has some advantages like it can be accessed by
>> in-kernel consumers as well as reduces the code size.
>> 
>> Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the
>> sampling_frequency attribute instead of using IIO_DEV_ATTR_SAMP_FREQ()
>> macro.
>> 
>> Move code from the functions associated with IIO_DEV_ATTR_SAMP_FREQ()
>> into respective read and write hooks with the mask set to
>> IIO_CHAN_INFO_SAMP_FREQ.
>> 
>> Signed-off-by: Michael Nosthoff <committed@heine.so>
> 
> Hi,
> 
> Thanks for fixing this. Patch looks good. We should add the fixes tag 
> to the
> commit messages, so it gets picked up for the right stable branches.
> 
> Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement 
> IIO_CHAN_INFO_SAMP_FREQ")
> 
> Other than that just one minor comment inline.

Agree on the fixes tag. Further comment inline.

> 
> [...]
>> +    case IIO_CHAN_INFO_SAMP_FREQ:
>> +        if (!val) {
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +
>> +        for (i = 0; i < 16; i++)
>> +            if (val == st->chip_info->sample_freq_avail[i])
>> +                break;
>> +
>> +        if (i == 16) {
>> +            ret = -EINVAL;
>> +            break;
>> +        }
>> +
>> +        st->mode &= ~AD7793_MODE_RATE(-1);
>> +        st->mode |= AD7793_MODE_RATE(i);
>> +        ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), 
>> st->mode);
>> +        ret = 0;
> 
> I don't think the ret = 0 is needed here, it should already be 0. But 
> of
> course it does not hurt either.

My fault. I tested against 4.14 which doesn't have the
"use iio helper function to guarantee direct mode" commit which 
initializes
ret. Which produces a compiler warning.
So if I remove it a backport would require that commit to be pulled 
first.

> 
>> +        break;
>>     default:
>>         ret = -EINVAL;
>>     }
>> --
>> 2.7.4
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
