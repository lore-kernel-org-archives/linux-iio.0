Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53956 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbcGWKzy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jul 2016 06:55:54 -0400
Subject: Re: [PATCH v2 2/4] iio: adc: add support for Allwinner SoCs ADC
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	jdelvare@suse.com, linux@roeck-us.net, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-3-git-send-email-quentin.schulz@free-electrons.com>
 <e24c8b63-7774-66d2-3317-43fd5598ecc9@kernel.org>
 <578DE5C9.8070502@free-electrons.com>
 <e763fba8-391f-f353-9ffe-354c08305dc5@kernel.org>
 <26aa8f33-8525-6d82-ca17-b782c55c2c82@free-electrons.com>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a3928a7a-b600-27b8-a038-dc5e0c8a7a99@kernel.org>
Date: Sat, 23 Jul 2016 08:37:47 +0200
MIME-Version: 1.0
In-Reply-To: <26aa8f33-8525-6d82-ca17-b782c55c2c82@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/07/16 14:15, Quentin Schulz wrote:
> On 20/07/2016 16:57, Jonathan Cameron wrote:
>> On 19/07/16 09:33, Quentin Schulz wrote:
>>> On 18/07/2016 15:18, Jonathan Cameron wrote:
>>>> On 15/07/16 10:59, Quentin Schulz wrote:
> [...]
>>>>> +	enable_irq(info->temp_data_irq);
>>>> Is this hardware spitting out extra irqs?  If not, much better to just
>>>> leave it enabled all the time and control whether it can occur or not
>>>> by controlling the device state..
>>>
>>> The temp_data_irq occurs every SUNXI_GPADC_TEMP_PERIOD(x) periods (in
>>> the current state of the driver: 2s). What do you mean by controlling
>>> the device state? Enabling or disabling the hardware part of the IP
>>> responsible of getting the temperature
>>> (SUNXI_GPADC_TP_TPR_TEMP_ENABLE(x) here)?
>> Yes, or something along those lines if it wakes up fast enough.
> 
> The ADC wakes up fast enough but resets its internal time clock (I don't
> know if it's the right term to use). Note that the temperature interrupt
> occurs by period of X seconds in this IP.
> 
> This means that each time we disable the ADC on the hardware side, no
> temperature interrupt will occur within the first X seconds. I don't
> think this is what we want.
I'm guessing X is non trivial ;)

So fair enough.  Could you add this justification as a comment in the
driver somewhere so that people coming back to this in a few years time
will know what the justification for this 'unusual' handling is.

Thanks,

Jonathan
> 
> [...]
> 
> Quentin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

