Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mxout2.idt.com ([157.165.5.26]:60931 "EHLO mxout2.idt.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751272AbdEPJGj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 May 2017 05:06:39 -0400
Subject: Fwd: ltr501 register field mapping als/ps interrupt mode interchanged
References: <6552089e-27f9-efb9-ae51-67f5f05cd9be@idt.com>
To: pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org
From: Franziska Naepelt <franziska.naepelt@idt.com>
Message-ID: <d8f18cdc-7aee-cf56-8045-f9bd2b4c7bfa@idt.com>
Date: Tue, 16 May 2017 10:20:12 +0200
MIME-Version: 1.0
In-Reply-To: <6552089e-27f9-efb9-ae51-67f5f05cd9be@idt.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Hi Peter,

I just studied the ltr501 driver for reference and found the following:

The register mapping for the IIO driver for the Liteon Light and Proximity sensor LTR501 interrupt mode is interchanged (ALS/PS).

There is a register called INTERRUPT register (address 0x8F)
Bit 0 represents PS measurement trigger.
Bit 1 represents ALS measurement trigger.

see datesheet: http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/S_110_LTR-501ALS-01_PrelimDS_ver1%5B1%5D.pdf - page 24

This two bit fields are interchanged within the driver: drivers/iio/light/ltr501.c.

I just refer to the datasheet because I don't have such kind of sensor to test it. The datasheet of the LTR559 which is covered by this driver as well
has the same register mapping like LTR501.

Regards,
Franziska

./-ver_linux
Linux raspberrypi 4.9.25-v7+ #1 SMP Thu May 11 15:56:46 CEST 2017 armv7l GNU/Linux

GNU C               	4.9.2
GNU Make            	4.0
Binutils            	2.25
Util-linux          	2.25.2
Mount               	2.25.2
Module-init-tools   	18
E2fsprogs           	1.42.12
Nfs-utils           	1.2.8
Linux C Library     	2.19
Dynamic linker (ldd)	2.19
Linux C++ Library   	6.0.20
Procps              	3.3.9
Net-tools           	1.60
Kbd                 	1.15.5
Console-tools       	1.15.5
Sh-utils            	8.23
Udev                	215
Wireless-tools      	30
Modules Loaded      	bcm2835_gpiomem bluetooth bnep brcmfmac brcmutil btbcm cfg80211 fixed hci_uart i2c_bcm2835 i2c_dev industrialio industrialio_triggered_buffer ipv6 kfifo_buf rfkill snd snd_bcm2835 snd_pcm snd_timer uio uio_pdrv_genirq

patch:

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 3afc53a..c298fd8 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -74,9 +74,9 @@
  static const struct reg_field reg_field_it =
                                 REG_FIELD(LTR501_ALS_MEAS_RATE, 3, 4);
  static const struct reg_field reg_field_als_intr =
-                               REG_FIELD(LTR501_INTR, 0, 0);
-static const struct reg_field reg_field_ps_intr =
                                 REG_FIELD(LTR501_INTR, 1, 1);
+static const struct reg_field reg_field_ps_intr =
+                               REG_FIELD(LTR501_INTR, 0, 0);
  static const struct reg_field reg_field_als_rate =
                                 REG_FIELD(LTR501_ALS_MEAS_RATE, 0, 2);
  static const struct reg_field reg_field_ps_rate =

