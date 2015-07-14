Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35623 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbbGNN40 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Jul 2015 09:56:26 -0400
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org
Cc: shawn.guo@linaro.org, kernel@pengutronix.de, robh+dt@kernel.org,
	pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stefan@agner.ch,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v3 0/2] Implement sample time consideration for Vybrid's ADC
Date: Tue, 14 Jul 2015 19:23:21 +0530
Message-Id: <cover.1436880513.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patchset adds a dt binding for specifying sample time
for the vybrid adc driver and takes this into account for
sampling frequency calculation and related configuration in
the driver.

The patchset is based on top of Stefan's patches here
http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html

which got recently applied.

Changes since v2:

- Use a default value of 1000ns for sample time in the driver
  if the property is not specified in the device tree.
- Specify the min-sample-time property in the board device tree
  file instead of the top level vfxxx.dtsi file for Vybrid

Changes since v1:

Change from a vendor specific fsl,min-sample-time to non vendor
specific min-sample-time.

Version 2 of the patchset can be found here
https://lkml.org/lkml/2015/6/24/97

Version 1 of the patchset can be found here
http://lkml.iu.edu/hypermail/linux/kernel/1506.1/00026.html

- Sanchayan.

Sanchayan Maity (2):
  iio: adc: vf610: Determine sampling frequencies by using minimum
    sample time
  ARM: dts: vf-colibri: Add property for minimum sample time

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |  5 ++
 arch/arm/boot/dts/vf-colibri.dtsi                  |  2 +
 drivers/iio/adc/vf610_adc.c                        | 79 ++++++++++++++++++++--
 3 files changed, 82 insertions(+), 4 deletions(-)

-- 
2.4.5

