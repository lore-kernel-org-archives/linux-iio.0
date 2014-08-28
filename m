Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52925 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753875AbaH1FOH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 28 Aug 2014 01:14:07 -0400
Message-ID: <53FEBA43.2000607@ti.com>
Date: Thu, 28 Aug 2014 10:42:35 +0530
From: Vignesh R <vigneshr@ti.com>
MIME-Version: 1.0
To: Lee Jones <lee.jones@linaro.org>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_adc: make sample delay, open
 delay, averaging DT parameters
References: <1409141990-29627-1-git-send-email-vigneshr@ti.com> <1409141990-29627-2-git-send-email-vigneshr@ti.com> <20140827135635.GH6364@lee--X1>
In-Reply-To: <20140827135635.GH6364@lee--X1>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Wednesday 27 August 2014 07:26 PM, Lee Jones wrote:
> On Wed, 27 Aug 2014, Vignesh R wrote:
> 
>> Number of averaging, open delay, sample delay are made DT parameters.
>> By decreasing averaging and delays more samples can be obtained per
>> second increasing performance of ADC. Previously the number of
>> averages per step was fixed to 16. Making these parameters
>> configurable will help in balancing speed vs accuracy.
>> For each ADC step provide DT based paramters to set open delay,
>> sample delay and number of averaging. One configurable step is
>> used per ADC channel. Since there can be atmost 8 ADC channels,
>> steps 16 to 8 are used for ADC.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>  .../bindings/input/touchscreen/ti-tsc-adc.txt      |   18 +++++++
>>  drivers/iio/adc/ti_am335x_adc.c                    |   49 +++++++++++++++++---
>>  include/linux/mfd/ti_am335x_tscadc.h               |    3 ++
>>  3 files changed, 63 insertions(+), 7 deletions(-)
> 
> [...]
> 
>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>> index fb96c84..26d3e84 100644
>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>> @@ -82,14 +82,17 @@
> 
> There are so many different formats at play here, it's difficult to
> see what's happening where!

I did not understand "different formats". Please explain.

> 
>>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
>>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
>>  #define STEPCONFIG_FIFO1	BIT(26)
>> +#define STEPCONFIG_AVG_MAX	16
>>  
>>  /* Delay register */
>>  #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>  #define STEPDELAY_OPEN(val)	((val) << 0)
> 
> What's the point in shifting by zero?

I agree. But my patch did not add these lines. I can remove them. Do you
want me to do this change as part of current patch or as a separate
cleanup patch?

> 
>>  #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>> +#define STEPDELAY_OPEN_MAX	0x3FFFF
> 
> Put this up the top, then you can use it when defining
> STEPDELAY_OPEN_MASK.

Done.

> 
>>  #define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
>>  #define STEPDELAY_SAMPLE(val)	((val) << 24)
>>  #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
>> +#define STEPDELAY_SAMPLE_MAX	0xFF
> 
>>  /* Charge Config */
>>  #define STEPCHARGE_RFP_MASK	(7 << 12)
> 

Regards
Vignesh R
