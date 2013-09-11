Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56928 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041Ab3IKRlo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Sep 2013 13:41:44 -0400
Message-ID: <5230B972.6000603@kernel.org>
Date: Wed, 11 Sep 2013 19:41:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] MAINTAINERS: Update Jonathan's email address
References: <1378893625-1430-1-git-send-email-sachin.kamat@linaro.org> <5230B7AF.3050003@kernel.org>
In-Reply-To: <5230B7AF.3050003@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/13 19:34, Jonathan Cameron wrote:
> On 09/11/13 11:00, Sachin Kamat wrote:
>> Updated with the current one.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Jonathan Cameron <jic23@kernel.org>
> Hehe, sometimes I'm so lazy that people really do my own job for me ;)
> 
> Applied to the togreg branch of iio.git.
> 
> I suppose technically the arm bit ought to go a different route, but I doubt anyone
> cares...
Actually I had second thoughts on this and have dropped the arm bit for now, will send
a separate patch for that via the right list.

Thanks
>> ---
>>  MAINTAINERS |    6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 65e2955..cc4e666 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -948,7 +948,7 @@ S:	Maintained
>>  F:	arch/arm/mach-ixp4xx/
>>  
>>  ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
>> -M:	Jonathan Cameron <jic23@cam.ac.uk>
>> +M:	Jonathan Cameron <jic23@kernel.org>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Maintained
>>  F:	arch/arm/mach-pxa/stargate2.c
>> @@ -4132,7 +4132,7 @@ S:	Maintained
>>  F:	drivers/media/rc/iguanair.c
>>  
>>  IIO SUBSYSTEM AND DRIVERS
>> -M:	Jonathan Cameron <jic23@cam.ac.uk>
>> +M:	Jonathan Cameron <jic23@kernel.org>
>>  L:	linux-iio@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/iio/
>> @@ -7870,7 +7870,7 @@ S:	Maintained
>>  F:	drivers/staging/media/go7007/
>>  
>>  STAGING - INDUSTRIAL IO
>> -M:	Jonathan Cameron <jic23@cam.ac.uk>
>> +M:	Jonathan Cameron <jic23@kernel.org>
>>  L:	linux-iio@vger.kernel.org
>>  S:	Odd Fixes
>>  F:	drivers/staging/iio/
>>
