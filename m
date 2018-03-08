Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.stresser.de ([88.198.198.115]:57328 "EHLO mail.stresser.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755180AbeCHJdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Mar 2018 04:33:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.stresser.de (Postfix) with ESMTP id 786154380064
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 10:33:08 +0100 (CET)
Received: from _ (frachter.heine.tech [46.4.84.91])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stresser.de (Postfix) with ESMTPSA id 9EC454380063
        for <linux-iio@vger.kernel.org>; Thu,  8 Mar 2018 10:33:02 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Thu, 08 Mar 2018 10:33:02 +0100
From: Michael Nosthoff <committed@heine.so>
To: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ
In-Reply-To: <e4800a5aded78249f54837798efa0e3b@heine.so>
References: <43f7cfe7bf868fb00e81a76246b9bc3a@heine.so>
 <f90c4698-15bf-ce11-ded9-f00b6ac0a263@metafoo.de>
 <e4800a5aded78249f54837798efa0e3b@heine.so>
Message-ID: <438ef108f17bcb2ca7ac2e284afd9489@heine.so>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2018-03-07 19:02, Michael Nosthoff wrote:
> On 2018-03-07 17:43, Lars-Peter Clausen wrote:
>> On 03/07/2018 05:17 PM, Michael Nosthoff wrote:
>> [...]
>>> +    case IIO_CHAN_INFO_SAMP_FREQ:
>>> +        if (!val) {
>>> +            ret = -EINVAL;
>>> +            break;
>>> +        }
>>> +
>>> +        for (i = 0; i < 16; i++)
>>> +            if (val == st->chip_info->sample_freq_avail[i])
>>> +                break;
>>> +
>>> +        if (i == 16) {
>>> +            ret = -EINVAL;
>>> +            break;
>>> +        }
>>> +
>>> +        st->mode &= ~AD7793_MODE_RATE(-1);
>>> +        st->mode |= AD7793_MODE_RATE(i);
>>> +        ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), 
>>> st->mode);
>>> +        ret = 0;
>> 
>> I don't think the ret = 0 is needed here, it should already be 0. But 
>> of
>> course it does not hurt either.
> 
> My fault. I tested against 4.14 which doesn't have the
> "use iio helper function to guarantee direct mode" commit which 
> initializes
> ret. Which produces a compiler warning.
> So if I remove it a backport would require that commit to be pulled 
> first.

I just noticed I mixed something up, the mentioned patch is already 
applied in 4.14.
I'll remove the line and resubmit the patch.


