Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45664 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbbHBSNG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 14:13:06 -0400
Subject: Re: [PATCH 1/7] iio:accel:stk8312: add triggered buffer dependency
To: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <cover.1437955135.git.knaack.h@gmx.de>
 <ab6ffe2a496adb1a1167e698e1c78ef7753d52ec.1437955135.git.knaack.h@gmx.de>
 <4586F61A4A291F4DA44D32824E7C0F4022186E7F@IRSMSX109.ger.corp.intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55BE5DB0.6060204@kernel.org>
Date: Sun, 2 Aug 2015 19:13:04 +0100
MIME-Version: 1.0
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4022186E7F@IRSMSX109.ger.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/07/15 14:27, Breana, Tiberiu A wrote:
>> -----Original Message-----
>> From: Hartmut Knaack [mailto:knaack.h@gmx.de]
>> Sent: Tuesday, July 28, 2015 1:49 AM
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Lars-Peter Clausen; Peter Meerwald; Breana, Tiberiu
>> A
>> Subject: [PATCH 1/7] iio:accel:stk8312: add triggered buffer dependency
>>
>> Add the still missing dependencies for triggered buffer support.
>>
>> Fixes: 	95c12bba51c37 ("iio: accel: Add buffer mode for Sensortek STK8312")
>>
>> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
> 
> +1
> 
> Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
One day I'll remember to actually check all the dependencies when reviewing!
Thanks Hartmut.

Applied to the togreg branch of iio.git.

Jonathan
> 
>> ---
>>  drivers/iio/accel/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig index
>> 00e7bcbdbe24..c99d8e242218 100644
>> --- a/drivers/iio/accel/Kconfig
>> +++ b/drivers/iio/accel/Kconfig
>> @@ -140,6 +140,8 @@ config MMA9553
>>  config STK8312
>>  	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
>>  	depends on I2C
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>>  	help
>>  	  Say yes here to get support for the Sensortek STK8312 3-axis
>>  	  accelerometer.
>> --
>> 2.4.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

