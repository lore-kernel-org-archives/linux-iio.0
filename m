Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60714 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbaG1LDp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jul 2014 07:03:45 -0400
Message-id: <53D62E05.3080803@samsung.com>
Date: Mon, 28 Jul 2014 20:03:33 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: jic23@kernel.org, ch.naveen@samsung.com, arnd@arndb.de,
	kgene.kim@samsung.com, kyungmin.park@samsung.com,
	t.figa@samsung.com, linux-iio@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: exynos_adc: Add support for S3C24xx ADC
References: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com>
 <1405995074-3271-3-git-send-email-cw00.choi@samsung.com>
 <53D562AD.4090706@gmx.de>
In-reply-to: <53D562AD.4090706@gmx.de>
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/28/2014 05:35 AM, Hartmut Knaack wrote:
> Chanwoo Choi schrieb:
>> This patch add support for s3c2410/s3c2416/s3c2440/s3c2443 ADC. The s3c24xx
>> is alomost same as ADCv1. But, There are a little difference as following:
>> - ADCMUX register address to select channel
>> - ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)
> Hi, just some style issues: better separate things like 10bit with a space to 10 bit, there are some instances of this type in your code. Another issue inline.

OK I'll fix it.

>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt | 10 ++-
>>  drivers/iio/adc/exynos_adc.c                       | 89 +++++++++++++++++++++-
>>  2 files changed, 96 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> index b6e3989..fe34c76 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> @@ -11,11 +11,19 @@ New driver handles the following
>>  
>>  Required properties:
>>  - compatible:		Must be "samsung,exynos-adc-v1"
>> -				for exynos4412/5250 controllers.
>> +				for exynos4412/5250 and s5pv210 controllers.
>>  			Must be "samsung,exynos-adc-v2" for
>>  				future controllers.
>>  			Must be "samsung,exynos3250-adc" for
>>  				controllers compatible with ADC of Exynos3250.
>> +			Must be "samsung,s3c2410-adc" for
>> +				the ADC in s3c2410 and compatibles
>> +			Must be "samsung,s3c2416-adc" for
>> +				the ADC in s3c2416 and compatibles
>> +			Must be "samsung,s3c2440-adc" for
>> +				the ADC in s3c2440 and compatibles
>> +			Must be "samsung,s3c2443-adc" for
>> +				the ADC in s3c2443 and compatibles
>>  			Must be "samsung,s3c6410-adc" for
>>  				the ADC in s3c6410 and compatibles
>>  - reg:			Contains ADC register address range (base address and
>> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
>> index 05bdd2f12..7d28032 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -51,6 +51,9 @@
>>  #define ADC_V1_MUX(x)		((x) + 0x1c)
>>  #define ADC_V1_CLRINTPNDNUP(x)	((x) + 0x20)
>>  
>> +/* S3C2410 ADC registers definitions */
>> +#define ADC_S3C2410_MUX(x)	((x) + 0x18)
>> +
>>  /* Future ADC_V2 registers definitions */
>>  #define ADC_V2_CON1(x)		((x) + 0x00)
>>  #define ADC_V2_CON2(x)		((x) + 0x04)
>> @@ -67,6 +70,8 @@
>>  
>>  /* Bit definitions for S3C2410 ADC */
>>  #define ADC_S3C2410_CON_SELMUX(x) (((x) & 7) <<3)
>> +#define ADC_S3C2410_DATX_MASK	0x3FF
>> +#define ADC_S3C2416_CON_RES_SEL	(1 << 3)
> Since it is done this way in this driver, better use (1u << 3) here.

OK, I'll fix it.

Best Regards,
Chanwoo Choi
