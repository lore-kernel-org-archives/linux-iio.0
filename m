Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-249.synserver.de ([212.40.185.249]:1134 "EHLO
	smtp-out-245.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751241AbbCBLSy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Mar 2015 06:18:54 -0500
Message-ID: <54F4471E.1090705@metafoo.de>
Date: Mon, 02 Mar 2015 12:18:54 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	jic23@kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
	vlad.dogaru@intel.com
Subject: Re: [PATCH] iio: accel: mma9551: Check gpiod_to_irq return value
References: <1425292752-7768-1-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1425292752-7768-1-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/02/2015 11:39 AM, Roberta Dobrescu wrote:
> The return value of gpiod_to_irq should be checked before giving
> it to devm_request_threaded_irq in order to not pass an error
> code in case it fails.
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
> Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
> ---
> gpiod_to_irq also appears in the following drivers:
> 	* drivers/iio/accel/bmc150-accel.c
> 	* drivers/iio/accel/kxcjk-1013.c
> 	* drivers/iio/accel/mma9553.c
> 	* drivers/iio/gyro/bmg160.c
> 	* drivers/iio/imu/kmx61.c
> 	* drivers/iio/proximity/sx9500.c,
>
> something like this:
>
> <code>
> 	ret = gpiod_to_irq(gpio);
>
> 	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
>
> 	return ret;
> </code>

Only slightly related, but why are these drivers even using GPIOs to get the 
IRQs. As far as I can see the GPIOs are not used otherwise in which case 
they should rather request the IRQ directly than going making the detour via 
the GPIO.

- Lars

