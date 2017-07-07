Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway23.websitewelcome.com ([192.185.49.218]:11298 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750984AbdGGE7T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2017 00:59:19 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id 4E92A14CA0
        for <linux-iio@vger.kernel.org>; Thu,  6 Jul 2017 23:35:58 -0500 (CDT)
Date: Thu, 06 Jul 2017 23:35:57 -0500
Message-ID: <20170706233558.Horde.ODusk8GBY3IYWs1gZsRKWv4@gator4166.hostgator.com>
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc()
 return value
References: <20170706220851.GA26284@embeddedgus>
 <01d4a23f-489a-6d1c-50ef-a77207719eae@axentia.se>
In-Reply-To: <01d4a23f-489a-6d1c-50ef-a77207719eae@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Peter,

Quoting Peter Rosin <peda@axentia.se>:

> On 2017-07-07 00:08, Gustavo A. R. Silva wrote:
>> Check return value from call to devm_kzalloc()
>> in order to prevent a NULL pointer dereference.
>
> Right, thanks for finding that one! There's another one inside the
> for loop that is just starting in the context of this patch. Care
> to fix checking the return value of that devm_kmemdup as well?
>

Sure, I'll send a new patch shortly.

> And someone should perhaps teach Coccinelle about devm_kmemdup...
>

Good catch, I just implemented that script.

>> This issue was detected using Coccinelle and the following semantic patch:
>>
>> @@
>> expression x;
>> identifier fld;
>> @@
>>
>> * x = devm_kzalloc(...);
>>   ... when != x == NULL
>>   x->fld
>>
>>
>
> One of these blank lines should perhaps be a "Fixes:" tag?
>

mmm, I don't get this...

> Cheers,
> peda
>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
>> ---
>>  drivers/iio/multiplexer/iio-mux.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/iio/multiplexer/iio-mux.c  
>> b/drivers/iio/multiplexer/iio-mux.c
>> index 37ba007..a8d672b 100644
>> --- a/drivers/iio/multiplexer/iio-mux.c
>> +++ b/drivers/iio/multiplexer/iio-mux.c
>> @@ -285,6 +285,9 @@ static int mux_configure_channel(struct device  
>> *dev, struct mux *mux,
>>  	child->ext_info_cache = devm_kzalloc(dev,
>>  					     sizeof(*child->ext_info_cache) *
>>  					     num_ext_info, GFP_KERNEL);
>> +	if (!child->ext_info_cache)
>> +		return -ENOMEM;
>> +
>>  	for (i = 0; i < num_ext_info; ++i) {
>>  		child->ext_info_cache[i].size = -1;
>>
>>

Thanks!
--
Gustavo A. R. Silva




