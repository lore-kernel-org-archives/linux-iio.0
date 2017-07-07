Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr30112.outbound.protection.outlook.com ([40.107.3.112]:64512
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751155AbdGGJ0y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Jul 2017 05:26:54 -0400
Subject: Re: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc() and
 devm_kmemdup() return values
From: Peter Rosin <peda@axentia.se>
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20170707045311.GA4535@embeddedgus>
 <df6ae9c6-8ac7-368b-a1c2-4403387df02b@axentia.se>
Message-ID: <0ba9b76f-41f8-3171-2eb7-d9abbe106674@axentia.se>
Date: Fri, 7 Jul 2017 11:26:35 +0200
MIME-Version: 1.0
In-Reply-To: <df6ae9c6-8ac7-368b-a1c2-4403387df02b@axentia.se>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-07-07 06:57, Peter Rosin wrote:
> On 2017-07-07 06:53, Gustavo A. R. Silva wrote:
>> Check return values from call to devm_kzalloc() and devm_kmemup()
> 
> If someone cares enough: s/devm_kmemup/evm_kmemdup/

Strange, there seems to be some inherent shortage of 'd' characters...

Cheers,
pea :-)

> 
>> in order to prevent a NULL pointer dereference.
>>
>> This issue was detected using Coccinelle and the following semantic patch:
>>
>> @@
>> expression x;
>> identifier fld;
>> @@
>>
>> * x = devm_kzalloc(...);
>>    ... when != x == NULL
>>    x->fld
>>
>> Cc: Peter Rosin <peda@axentia.se>
>> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> 
> Either way,
> 
> Reviewed-by: Peter Rosin <peda@axentia.se>
> 
> Thanks!
> 

