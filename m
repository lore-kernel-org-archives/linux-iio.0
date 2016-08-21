Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:33672 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752174AbcHUUfl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2016 16:35:41 -0400
Subject: Re: [PATCH] iio: ad5755: fix off-by-one on devnr limit check
To: Jonathan Cameron <jic23@kernel.org>,
        Colin King <colin.king@canonical.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <1469486401-17839-1-git-send-email-colin.king@canonical.com>
 <1efdfc25-b13d-c383-2346-75b414b32081@kernel.org>
Cc: linux-kernel@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3ed48869-735a-002b-d89e-b1a694d19b6e@metafoo.de>
Date: Sun, 21 Aug 2016 22:07:33 +0200
MIME-Version: 1.0
In-Reply-To: <1efdfc25-b13d-c383-2346-75b414b32081@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/21/2016 09:30 PM, Jonathan Cameron wrote:
> On 25/07/16 23:40, Colin King wrote:
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> The comparison for devnr limits is off-by-one, the current check
>> allows 0 to AD5755_NUM_CHANNELS and the limit should be in fact
>> 0 to AD5755_NUM_CHANNELS - 1.  This can lead to an out of bounds
>> write to pdata->dac[devnr]. Fix this by replacing > with >= on the
>> comparison.
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Lars? 
> 
> Looks correct to me.
> 
> I'd also like a fixes tag for this if possible.  Guessing it
> might well be the original driver introduction but best to be
> sure ;)

It's new in 4.8-rc1. It was introduced by the devictree support patch.

Fixes: c947459979c6 ("iio: ad5755: add support for dt bindings")

