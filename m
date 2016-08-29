Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41525 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757454AbcH2PRB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Aug 2016 11:17:01 -0400
Subject: Re: [PATCH] iio: ad5755: fix off-by-one on devnr limit check
To: Lars-Peter Clausen <lars@metafoo.de>,
        Colin King <colin.king@canonical.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1469486401-17839-1-git-send-email-colin.king@canonical.com>
 <1efdfc25-b13d-c383-2346-75b414b32081@kernel.org>
 <3ed48869-735a-002b-d89e-b1a694d19b6e@metafoo.de>
Cc: linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dc382576-c8d8-3d63-219a-b8a9dee7db1f@kernel.org>
Date: Mon, 29 Aug 2016 16:16:58 +0100
MIME-Version: 1.0
In-Reply-To: <3ed48869-735a-002b-d89e-b1a694d19b6e@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/08/16 21:07, Lars-Peter Clausen wrote:
> On 08/21/2016 09:30 PM, Jonathan Cameron wrote:
>> On 25/07/16 23:40, Colin King wrote:
>>> From: Colin Ian King <colin.king@canonical.com>
>>>
>>> The comparison for devnr limits is off-by-one, the current check
>>> allows 0 to AD5755_NUM_CHANNELS and the limit should be in fact
>>> 0 to AD5755_NUM_CHANNELS - 1.  This can lead to an out of bounds
>>> write to pdata->dac[devnr]. Fix this by replacing > with >= on the
>>> comparison.
>>>
>>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> Lars? 
>>
>> Looks correct to me.
>>
>> I'd also like a fixes tag for this if possible.  Guessing it
>> might well be the original driver introduction but best to be
>> sure ;)
> 
> It's new in 4.8-rc1. It was introduced by the devictree support patch.
> 
> Fixes: c947459979c6 ("iio: ad5755: add support for dt bindings")
Thanks Lars,

Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

