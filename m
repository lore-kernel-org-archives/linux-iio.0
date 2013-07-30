Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40508 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870Ab3G3Vc1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Jul 2013 17:32:27 -0400
Message-ID: <51F83F01.4070509@kernel.org>
Date: Tue, 30 Jul 2013 23:32:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jonathan Clapson <jonathan.clapson@gmail.com>
CC: linux-iio@vger.kernel.org
Subject: Re: iio_trigger_alloc fails on Raspberry pi
References: <CAFBKNSRAqprfNZzBVvPR3tqMPip4G9mz3nNDFqUkRB71MqR48w@mail.gmail.com>
In-Reply-To: <CAFBKNSRAqprfNZzBVvPR3tqMPip4G9mz3nNDFqUkRB71MqR48w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/13 04:39, Jonathan Clapson wrote:
> Hey
> 
> I'm trying to write a driver to interact with the mpu6000 imu sensor
> on the raspberry pi.
> I've modified the mpu6050 i2c driver in the linux kernel to use the
> mpu6000's spi interface. Calls of iio_trigger_alloc fail. I've added
> some debugging info to industrialio-trigger.c and from this have
> narrowed it down to the irq_alloc_descs function failing to allocate
> any irq's.
> 
> cat /proc/interrupts returns:
>            CPU0
>   3:      21114   ARMCTRL  BCM2708 Timer Tick
>  32:     986019   ARMCTRL  dwc_otg, dwc_otg_pcd, dwc_otg_hcd:usb1
>  65:          7   ARMCTRL  ARM Mailbox IRQ
>  66:          1   ARMCTRL  VCHIQ doorbell
>  75:          1   ARMCTRL
>  77:       6801   ARMCTRL  bcm2708_sdhci (dma)
>  80:         30   ARMCTRL  bcm2708_spi.0
>  83:         20   ARMCTRL  uart-pl011
>  84:      11002   ARMCTRL  mmc0
> FIQ:              usb_fiq
> Err:          0
> 
> The call to irq_alloc_descs seems to be trying to allocate *any* two
> consecutive irq's (two being the value of
> CONFIG_IIO_CONSUMERS_PER_TRIGGER), the above i believe shows that this
> should be possible?
> 
> Any idea's why irq_alloc_descs is failing?
It has been a while since I last came across anything similar but this is probably
due to the underlying raspberry pi kernel restricting your available interrupts.
In at least some boards it is still necessary to explicitly allocate a few more
in the board config file or equivalent.



> 
> Thanks
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
