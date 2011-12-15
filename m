Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43771 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756537Ab1LOThR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 15 Dec 2011 14:37:17 -0500
Message-ID: <4EEA4C60.4060409@free-electrons.com>
Date: Thu, 15 Dec 2011 20:37:04 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Alexander Stein <alexander.stein@systec-electronic.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
References: <1323856877-18255-1-git-send-email-maxime.ripard@free-electrons.com> <1323856877-18255-2-git-send-email-maxime.ripard@free-electrons.com> <77881664.jmuBXsRUXo@ws-stein>
In-Reply-To: <77881664.jmuBXsRUXo@ws-stein>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/12/2011 11:27, Alexander Stein wrote:
> On Wednesday 14 December 2011 11:01:15 Maxime Ripard wrote:
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
>>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  include/linux/platform_data/at91_adc.h |   23 +++++++++++++++++++++++
>>  1 files changed, 23 insertions(+), 0 deletions(-)
>>  create mode 100644 include/linux/platform_data/at91_adc.h
>>
>> diff --git a/include/linux/platform_data/at91_adc.h
>> b/include/linux/platform_data/at91_adc.h new file mode 100644
>> index 0000000..bad80b7
>> --- /dev/null
>> +++ b/include/linux/platform_data/at91_adc.h
>> @@ -0,0 +1,23 @@
>> +/*
>> + * Copyright (C) 2011 Free Electrons
>> + *
>> + * Licensed under the GPLv2 or later.
>> + *
>> + */
>> +
>> +#ifndef _AT91_ADC_H_
>> +#define _AT91_ADC_H_
>> +
>> +/**
>> + * struct at91_adc_data - platform data for ADC driver
>> + * @channels_use:	channels in use on the board as a bitmask
>> + * @vref:		Reference voltage for the ADC in millvolts
> 
> Nitpick, this should write millivolts, no?

Yes, of course :)

> 
>> + */
>> +struct at91_adc_data {
>> +	unsigned long	channels_used;
>> +	u16		vref;
>> +};
>> +
>> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
>> +
>> +#endif
> 
> Regards,
> Alexander


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
