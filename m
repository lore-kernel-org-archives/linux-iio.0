Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34122 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbFHFom (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jun 2015 01:44:42 -0400
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org, shawn.guo@linaro.org, kernel@pengutronix.de
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	B38611@freescale.com, devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, stefan@agner.ch,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v1 0/2] Implement sample time consideration
Date: Mon,  8 Jun 2015 11:11:59 +0530
Message-Id: <cover.1433740528.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello,

This patchset adds a dt binding for specifying sample time
for the vybrid adc driver and takes this into account for
sampling frequency calculation and related configuration in
the driver.

The patchset is based on top of Stefan's patches here
http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html

which got recently applied. Tested with shawn's for-next
branch.

Regards,
Sanchayan.

Sanchayan Maity (2):
  iio: adc: Determine sampling frequencies by using minimum sample time
  ARM: dts: vfxxx: Add property for minimum sample time

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |  6 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  2 +
 drivers/iio/adc/vf610_adc.c                        | 74 ++++++++++++++++++++--
 3 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.4.2

