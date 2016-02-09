Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33568 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbcBIFbR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Feb 2016 00:31:17 -0500
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, shawnguo@kernel.org, stefan@agner.ch,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v1 0/2] Add DAC driver support for Vybrid SoC
Date: Tue,  9 Feb 2016 10:56:04 +0530
Message-Id: <cover.1454939346.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patchset adds support for the DAC peripheral on Vybrid SoC.
Patchset is based on top of shawn's for-next branch and has been
tested on a Toradex Colibri VF50 module.

I had one query as to whether my implementation under the
IIO_CHAN_INFO_SCALE correct? I am not clear on exactly on how
the voltage_scale parameter is suppose to be set and used.

Feedbacks and comments most welcome.

Thanks & Regards,
Sanchayan.


Sanchayan Maity (2):
  ARM: dts: vfxxx: Add DAC node for Vybrid SoC
  iio: dac: vf610_dac: Add IIO DAC driver for Vybrid SoC

 .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  18 ++
 drivers/iio/dac/Kconfig                            |   8 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/vf610_dac.c                        | 302 +++++++++++++++++++++
 5 files changed, 349 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
 create mode 100644 drivers/iio/dac/vf610_dac.c

-- 
2.7.1

