Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753521AbaKHMQC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Nov 2014 07:16:02 -0500
Message-ID: <545E0980.2080201@kernel.org>
Date: Sat, 08 Nov 2014 12:16:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Gwendal Grignou <gwendal@chromium.org>
CC: knaack.h@gmx.de, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: ak8975: add ak09911 and ak09912 support
References: <CAMHSBOWmmCdd=5HXJN-vz9saaPrq3n0p-LjCNvnX3Q3ZieZdRQ@mail.gmail.com>	 <1415225452-21957-1-git-send-email-gwendal@chromium.org>	 <1415225452-21957-4-git-send-email-gwendal@chromium.org> <1415286329.7340.16.camel@spandruv-hsb-test>
In-Reply-To: <1415286329.7340.16.camel@spandruv-hsb-test>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/11/14 15:05, Srinivas Pandruvada wrote:
> On Wed, 2014-11-05 at 14:10 -0800, Gwendal Grignou wrote:
>> Add 2 new definition entries to support ak0991x compass.
>> Add a more advanced function to check we are dealy with the
>> expected device.
> This commit message doesn't state that you are removing ak09911 driver.
> Although you added in cover letter, but that will not be present in the
> history.
> 
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>> ---
>>  drivers/iio/magnetometer/Kconfig   |  17 +-
>>  drivers/iio/magnetometer/Makefile  |   1 -
>>  drivers/iio/magnetometer/ak09911.c | 326 -------------------------------------
>>  drivers/iio/magnetometer/ak8975.c  | 197 ++++++++++++++++++++--
>>  4 files changed, 184 insertions(+), 357 deletions(-)
>>  delete mode 100644 drivers/iio/magnetometer/ak09911.c
>>
>> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
>> index b2dba9e..cd8750b 100644
>> --- a/drivers/iio/magnetometer/Kconfig
>> +++ b/drivers/iio/magnetometer/Kconfig
>> @@ -6,27 +6,16 @@
>>  menu "Magnetometer sensors"
>>  
>>  config AK8975
>> -	tristate "Asahi Kasei AK8975 3-Axis Magnetometer"
>> +	tristate "Asahi Kasei AK 3-Axis Magnetometer"
>>  	depends on I2C
>>  	depends on GPIOLIB
>>  	help
>> -	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
>> -	  Magnetometer. This driver can also support AK8963, if i2c
>> -	  device name is identified as ak8963.
>> +	  Say yes here to build support for Asahi Kasei AK8975, AK8963,
>> +	  AK09911 or AK09912 3-Axis Magnetometer.
>>  
>>  	  To compile this driver as a module, choose M here: the module
>>  	  will be called ak8975.
>>  
>> -config AK09911
> Instead
> config AK09911
> 	select AK8975
> 
> I stated my reason below.
Agreed.  This will reduce breakage and is common when merging drivers.

>> -	tristate "Asahi Kasei AK09911 3-axis Compass"
>> -	depends on I2C
>> -	help
>> -	  Say yes here to build support for Asahi Kasei AK09911 3-Axis
>> -	  Magnetometer.
>> -
>> -	  To compile this driver as a module, choose M here: the module
>> -	  will be called ak09911.
>> -

> 
> I need to test this driver.
> Jonathan,
> If possible, wait for Tested by tag from me or someone else.
Will do.
> 
> Thanks,
> Srinivas
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

