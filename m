Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34857 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbcBOGry (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2016 01:47:54 -0500
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, shawnguo@kernel.org, stefan@agner.ch,
	pmeerw@pmeerw.net, Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v2 0/2] Add DAC driver support for Vybrid SoC
Date: Mon, 15 Feb 2016 12:12:31 +0530
Message-Id: <cover.1455516083.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patchset adds support for the DAC peripheral on Vybrid SoC.
Patchset is based on top of shawn's for-next branch and has been
tested on a Toradex Colibri VF50 module.

@Jonathan
I kept the IIO_SHARED_BY_DIR instead of using IIO_SHARED_BY_ALL
since this gives "out_conversion_mode" allowing me to distinguish
this in the ABI documentation, that this is explicitly for the DAC.

Since 4.5-rc4 was released recently and assuming this makes it with
this or next version, I assumed the target kernel version would be
4.6 and used that in ABI documentation.

Feedbacks and comments most welcome.

Changes since v1:
1. Fix return type of vf610_dac_init function
2. Document conversion modes in sysfs-bus-iio-vf610
3. Remove "indexed" specification from iio_chan_spec
4. Use "return" directly from default case in switch
5. Remove DRIVER_NAME
6. Call vf610_dac_init before iio device registration
7. Define and use vf610_dac_exit function in remove and suspend
8. Add sysfs ABI documentation

v1 of the patchset:
http://www.spinics.net/lists/arm-kernel/msg481190.html

Thanks & Regards,
Sanchayan Maity.

Sanchayan Maity (2):
  ARM: dts: vfxxx: Add DAC node for Vybrid SoC
  iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC

 Documentation/ABI/testing/sysfs-bus-iio-vf610      |   9 +
 .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  18 ++
 drivers/iio/dac/Kconfig                            |   8 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/vf610_dac.c                        | 298 +++++++++++++++++++++
 6 files changed, 354 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
 create mode 100644 drivers/iio/dac/vf610_dac.c

-- 
2.7.1

