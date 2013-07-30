Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59641 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757125Ab3G3Djl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jul 2013 23:39:41 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so3155240lbf.4
        for <linux-iio@vger.kernel.org>; Mon, 29 Jul 2013 20:39:39 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 30 Jul 2013 15:39:37 +1200
Message-ID: <CAFBKNSRAqprfNZzBVvPR3tqMPip4G9mz3nNDFqUkRB71MqR48w@mail.gmail.com>
Subject: iio_trigger_alloc fails on Raspberry pi
From: Jonathan Clapson <jonathan.clapson@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hey

I'm trying to write a driver to interact with the mpu6000 imu sensor
on the raspberry pi.
I've modified the mpu6050 i2c driver in the linux kernel to use the
mpu6000's spi interface. Calls of iio_trigger_alloc fail. I've added
some debugging info to industrialio-trigger.c and from this have
narrowed it down to the irq_alloc_descs function failing to allocate
any irq's.

cat /proc/interrupts returns:
           CPU0
  3:      21114   ARMCTRL  BCM2708 Timer Tick
 32:     986019   ARMCTRL  dwc_otg, dwc_otg_pcd, dwc_otg_hcd:usb1
 65:          7   ARMCTRL  ARM Mailbox IRQ
 66:          1   ARMCTRL  VCHIQ doorbell
 75:          1   ARMCTRL
 77:       6801   ARMCTRL  bcm2708_sdhci (dma)
 80:         30   ARMCTRL  bcm2708_spi.0
 83:         20   ARMCTRL  uart-pl011
 84:      11002   ARMCTRL  mmc0
FIQ:              usb_fiq
Err:          0

The call to irq_alloc_descs seems to be trying to allocate *any* two
consecutive irq's (two being the value of
CONFIG_IIO_CONSUMERS_PER_TRIGGER), the above i believe shows that this
should be possible?

Any idea's why irq_alloc_descs is failing?

Thanks
