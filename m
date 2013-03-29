Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46574 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab3C2J0U (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 05:26:20 -0400
Message-ID: <51555E3D.6080102@kernel.org>
Date: Fri, 29 Mar 2013 09:26:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	My self <ch.naveen@samsung.com>, patches@linaro.org
Subject: Re: [PATCH 2/2] iio: exynos_adc: Fix a typo in Kconfig help text
References: <1364290931-25772-1-git-send-email-sachin.kamat@linaro.org> <1364290931-25772-2-git-send-email-sachin.kamat@linaro.org> <CAHfPSqA188F0FFUv1jxiD1WTAmsS72TcN0gkPR24iisb-Qp=TA@mail.gmail.com>
In-Reply-To: <CAHfPSqA188F0FFUv1jxiD1WTAmsS72TcN0gkPR24iisb-Qp=TA@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/26/2013 01:23 PM, Naveen Krishna Ch wrote:
> On 26 March 2013 15:12, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> Fixes a trivial typo.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/iio/adc/Kconfig |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
>> index ab0767e6..718084f 100644
>> --- a/drivers/iio/adc/Kconfig
>> +++ b/drivers/iio/adc/Kconfig
>> @@ -108,7 +108,7 @@ config EXYNOS_ADC
>>         depends on OF
>>         help
>>           Core support for the ADC block found in the Samsung EXYNOS series
>> -         of SoCs for drivers such as the touchscreen and hwmon to use to share
> I took these lines from arch/arm/plat-samsung/Kconfig for S3C ADC.
> Sure if this change makes sence.
Original text is just fine and has a subtly different meaning so not taking this
patch.

>> +         of SoCs for drivers such as the touchscreen and hwmon to use and share
>>           this resource.
>>
>>  config LP8788_ADC
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> --
> Shine bright,
> (: Nav :)
> 
