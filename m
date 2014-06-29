Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41426 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753603AbaF2Xct (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jun 2014 19:32:49 -0400
Message-id: <53B0A219.2000301@samsung.com>
Date: Mon, 30 Jun 2014 08:32:41 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
MIME-version: 1.0
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: jic23@kernel.org, ch.naveen@samsung.com, t.figa@samsung.com,
	kgene.kim@samsung.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, rdunlap@infradead.org,
	sachin.kamat@linaro.org, kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCHv5 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and
 code clean
References: <1403843406-28229-1-git-send-email-cw00.choi@samsung.com>
 <53AD54EC.2050606@gmail.com>
In-reply-to: <53AD54EC.2050606@gmail.com>
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Tomasz,

On 06/27/2014 08:26 PM, Tomasz Figa wrote:
> Hi Chanwoo,
> 
> On 27.06.2014 06:30, Chanwoo Choi wrote:
>> Changes from v4:
>> - Use 'exynos_adc_data' structure instead of 'exynos_adc_ops' structure
>>   and remove enum variable of ADC version
>> - Fix wrong name of special clock (sclk_tsadc -> sclk_adc)
>> - Add reviewed message by Naveen Krishna Chatradhi
>> - Add functions for ADC clock control
>>
>> Changes from v3:
>> - Add new 'exynos_adc_ops' structure to improve readability according to
>>  Tomasz Figa comment[1]
>>  [1] https://lkml.org/lkml/2014/4/16/238
>> - Add new 'exynos3250-adc-v2' compatible string to support Exynos3250 ADC
>> - Fix wrong compaitlbe string of ADC in Exynos3250 dtsi file
>>
>> Changes from v2:
>> - Check return value of clock function to deal with error exception
>> - Fix minor coding style to improve readability
>>
>> Changes from v1:
>> - Add new "samsung,exynos-adc-v3" compatible to support Exynos3250 ADC
>> - Add a patch about DT binding documentation
>>
>> Chanwoo Choi (4):
>>   iio: adc: exynos_adc: Add exynos_adc_data structure to improve readability
>>   iio: adc: exynos_adc: Control special clock of ADC to support Exynos3250 ADC
>>   iio: devicetree: Add DT binding documentation for Exynos3250 ADC
>>   ARM: dts: Fix wrong compatible string for Exynos3250 ADC
>>
>>  .../devicetree/bindings/arm/samsung/exynos-adc.txt |  26 +-
>>  arch/arm/boot/dts/exynos3250.dtsi                  |   4 +-
>>  drivers/iio/adc/exynos_adc.c                       | 326 +++++++++++++++------
>>  3 files changed, 268 insertions(+), 88 deletions(-)
>>
> 
> For the whole series:
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>

Thanks for your review.

Best Regards,
Chanwoo Choi

