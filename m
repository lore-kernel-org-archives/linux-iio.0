Return-Path: <maitysanchayan@gmail.com>
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: jic23@kernel.org
Cc: shawn.guo@linaro.org,
	kernel@pengutronix.de,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	B38611@freescale.com,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stefan@agner.ch,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH v2 0/2] Implement sample time consideration for Vybrid's ADC
Date: Wed, 24 Jun 2015 14:03:39 +0530
Message-Id: <cover.1435134626.git.maitysanchayan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hello,

This patchset adds a dt binding for specifying sample time
for the vybrid adc driver and takes this into account for
sampling frequency calculation and related configuration in
the driver.

The patchset is based on top of Stefan's patches here
http://lkml.iu.edu/hypermail/linux/kernel/1505.3/02043.html

which got recently applied. Tested with shawn's for-next
branch.

Changes since v1:

Change from a vendor specific fsl,min-sample-time to non vendor
specific min-sample-time.

Version 1 of the patchset can be found here
http://lkml.iu.edu/hypermail/linux/kernel/1506.1/00026.html

- Sanchayan.

Sanchayan Maity (2):
  iio: adc: Determine sampling frequencies by using minimum sample time
  ARM: dts: vfxxx: Add property for minimum sample time

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |  6 ++
 arch/arm/boot/dts/vfxxx.dtsi                       |  2 +
 drivers/iio/adc/vf610_adc.c                        | 74 ++++++++++++++++++++--
 3 files changed, 78 insertions(+), 4 deletions(-)

-- 
2.4.4
