Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:60942 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170AbaG1LSq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jul 2014 07:18:46 -0400
Message-id: <53D63193.1020506@samsung.com>
Date: Mon, 28 Jul 2014 20:18:43 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: jic23@kernel.org, ch.naveen@samsung.com, arnd@arndb.de,
	kgene.kim@samsung.com, kyungmin.park@samsung.com,
	t.figa@samsung.com, linux-iio@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: exynos_adc: add support for s3c64xx adc
References: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com>
 <1405995074-3271-2-git-send-email-cw00.choi@samsung.com>
 <53D549A2.1000900@gmx.de>
In-reply-to: <53D549A2.1000900@gmx.de>
Content-type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/28/2014 03:49 AM, Hartmut Knaack wrote:
> Chanwoo Choi schrieb:
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> The ADC in s3c64xx is almost the same as exynosv1, but
>> has a different 'select' method. Adding this here will be
>> helpful to move over the existing s3c64xx platform from the
>> legacy plat-samsung/adc driver to the new exynos-adc.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |  2 ++
>>  drivers/iio/adc/exynos_adc.c                       | 32 +++++++++++++++++++++-
>>  2 files changed, 33 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> index 6d34891..b6e3989 100644
>> --- a/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> +++ b/Documentation/devicetree/bindings/arm/samsung/exynos-adc.txt
>> @@ -16,6 +16,8 @@ Required properties:
>>  				future controllers.
>>  			Must be "samsung,exynos3250-adc" for
>>  				controllers compatible with ADC of Exynos3250.
>> +			Must be "samsung,s3c6410-adc" for
>> +				the ADC in s3c6410 and compatibles
>>  - reg:			Contains ADC register address range (base address and
>>  			length) and the address of the phy enable register.
>>  - interrupts: 		Contains the interrupt information for the timer. The
>> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
>> index 87e0895..05bdd2f12 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -40,12 +40,16 @@
>>  #include <linux/iio/machine.h>
>>  #include <linux/iio/driver.h>
>>  
>> -/* EXYNOS4412/5250 ADC_V1 registers definitions */
>> +/* S3C/EXYNOS4412/5250 ADC_V1 registers definitions */
>>  #define ADC_V1_CON(x)		((x) + 0x00)
>> +#define ADC_V1_TSC(x)		((x) + 0x04)
>>  #define ADC_V1_DLY(x)		((x) + 0x08)
>>  #define ADC_V1_DATX(x)		((x) + 0x0C)
>> +#define ADC_V1_DATY(x)		((x) + 0x10)
>> +#define ADC_V1_UPDN(x)		((x) + 0x14)
>>  #define ADC_V1_INTCLR(x)	((x) + 0x18)
>>  #define ADC_V1_MUX(x)		((x) + 0x1c)
>> +#define ADC_V1_CLRINTPNDNUP(x)	((x) + 0x20)
>>  
>>  /* Future ADC_V2 registers definitions */
>>  #define ADC_V2_CON1(x)		((x) + 0x00)
>> @@ -61,6 +65,9 @@
>>  #define ADC_V1_CON_PRSCLV(x)	(((x) & 0xFF) << 6)
>>  #define ADC_V1_CON_STANDBY	(1u << 2)
>>  
>> +/* Bit definitions for S3C2410 ADC */
>> +#define ADC_S3C2410_CON_SELMUX(x) (((x) & 7) <<3)
> There is a whitespace missing.

OK, I'll fix it.

Best Regards,
Chanwoo Choi

