Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39997 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbdCFXqY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 6 Mar 2017 18:46:24 -0500
Subject: Re: [PATCH] MAINTAINERS: drop broken reference to i2c/trivial-devices
To: Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org
References: <20170206165411.4796-1-wsa@the-dreams.de>
 <5f80e863-6738-d9dd-e8ce-8606fd858447@kernel.org>
Cc: linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Kevin Tsai <ktsai@capellamicro.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <02ad19b9-ae0e-715a-2572-ca5338a09509@kernel.org>
Date: Mon, 6 Mar 2017 22:34:26 +0000
MIME-Version: 1.0
In-Reply-To: <5f80e863-6738-d9dd-e8ce-8606fd858447@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/02/17 18:26, Jonathan Cameron wrote:
> On 06/02/17 16:54, Wolfram Sang wrote:
>> Due to RST rework, the reference to i2c/trivial-devices was changed, but the
>> result is broken. However, let's just drop the whole reference, since it
>> doesn't make sense in the first place to reference this "global" file
>> for a single driver.
>>
>> Fixes: 8c27ceff3604b2 ("docs: fix locations of several documents that got moved")
>> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
>> Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
>> Cc: Kevin Tsai <ktsai@capellamicro.com>
> Applied to the togreg branch of iio.git.
Something went wrong and this never made it there.
Just reapplied it.

Sorry about that.

Jonathan
> 
> Thanks,
> 
> Jonathan
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  MAINTAINERS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 023e4a8c3d104d..3c67142f17e913 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2974,7 +2974,6 @@ CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
>>  M:	Kevin Tsai <ktsai@capellamicro.com>
>>  S:	Maintained
>>  F:	drivers/iio/light/cm*
>> -F:	Documentation/devicetree/bindings/i2c/trivial-admin-guide/devices.rst
>>  
>>  CAVIUM I2C DRIVER
>>  M:	Jan Glauber <jglauber@cavium.com>
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

