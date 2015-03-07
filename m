Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58645 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbbCGTIu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Mar 2015 14:08:50 -0500
Message-ID: <54FB4CBF.3070408@kernel.org>
Date: Sat, 07 Mar 2015 19:08:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, pmeerw@pmeerw.net, vlad.dogaru@intel.com
Subject: Re: [PATCH] iio: accel: mma9551: Check gpiod_to_irq return value
References: <1425292752-7768-1-git-send-email-roberta.dobrescu@gmail.com> <54F4471E.1090705@metafoo.de>
In-Reply-To: <54F4471E.1090705@metafoo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/03/15 11:18, Lars-Peter Clausen wrote:
> On 03/02/2015 11:39 AM, Roberta Dobrescu wrote:
>> The return value of gpiod_to_irq should be checked before giving
>> it to devm_request_threaded_irq in order to not pass an error
>> code in case it fails.
>>
>> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
>> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
>> ---
>> gpiod_to_irq also appears in the following drivers:
>>     * drivers/iio/accel/bmc150-accel.c
>>     * drivers/iio/accel/kxcjk-1013.c
>>     * drivers/iio/accel/mma9553.c
>>     * drivers/iio/gyro/bmg160.c
>>     * drivers/iio/imu/kmx61.c
>>     * drivers/iio/proximity/sx9500.c,
>>
>> something like this:
>>
>> <code>
>>     ret = gpiod_to_irq(gpio);
>>
>>     dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
>>
>>     return ret;
>> </code>
> 
> Only slightly related, but why are these drivers even using GPIOs to
> get the IRQs. As far as I can see the GPIOs are not used otherwise in
> which case they should rather request the IRQ directly than going
> making the detour via the GPIO.
My understanding of this is that it's down to the ACPI provided data
which gives us a gpio rather than the more correct irqs. I don't know
if there is a simple way of avoiding this silliness and getting the irq
directly.  We keep ending up with the same bit of code so certainly
feels like there should be (whatever ACPI itself is providing).

Jonathan
> 
> - Lars
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

