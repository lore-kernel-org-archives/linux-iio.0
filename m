Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46089 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754088AbaCMPpL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 13 Mar 2014 11:45:11 -0400
In-Reply-To: <5320C79B.4000109@gmx.de>
References: <1394570219-7672-1-git-send-email-jic23@kernel.org> <1394570219-7672-6-git-send-email-jic23@kernel.org> <5320C79B.4000109@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 5/5] iio:adc:spear_adc move out of staging
From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 13 Mar 2014 15:45:03 +0000
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: sr@denx.de
Message-ID: <ed852795-5e47-4fd7-adba-2547a767c3d4@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On March 12, 2014 8:46:19 PM GMT+00:00, Hartmut Knaack <knaack.h@gmx.de> wrote:
>Jonathan Cameron schrieb:
>> This simple driver is ready to move out of staging.
>>
>> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
>> ---
>>  drivers/iio/adc/Kconfig             |   8 +
>>  drivers/iio/adc/Makefile            |   1 +
>>  drivers/iio/adc/spear_adc.c         | 429
>++++++++++++++++++++++++++++++++++++
>>  drivers/staging/iio/adc/Kconfig     |   8 -
>>  drivers/staging/iio/adc/Makefile    |   1 -
>>  drivers/staging/iio/adc/spear_adc.c | 429
>------------------------------------
>>  6 files changed, 438 insertions(+), 438 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index 5553206..2e3e1b0 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -164,6 +164,14 @@ config NAU7802
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called nau7802.
>>  
>> +config SPEAR_ADC
>> +	tristate "ST SPEAr ADC"
>> +	depends on PLAT_SPEAR || COMPILE_TEST
>Are you sure to keep COMPILE_TEST in?
Yes. Allows those without a spear specific config to build test. Prevents a lot of bugs sneaking in for more obscure platforms.

We do this for any drivers that don't require any other support from the platform.
>> +	depends on HAS_IOMEM
>> +	help
>> +	  Say yes here to build support for the integrated ADC inside the
>> +	  ST SPEAr SoC. Provides direct access via sysfs.
>> +
>>  config TI_ADC081C
>>  	tristate "Texas Instruments ADC081C021/027"
>>  	depends on I2C
>>

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
