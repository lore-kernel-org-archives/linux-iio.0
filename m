Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34015 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966678Ab3DRPjH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 18 Apr 2013 11:39:07 -0400
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Shawn Guo <shawn.guo@linaro.org>,
	Grant Likely <grant.likely@secretlab.ca>
Cc: jimwall@q.com, brian@crystalfontz.com,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree-discuss@lists.ozlabs.org,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Rob Landley <rob@landley.net>,
	Rob Herring <rob.herring@calxeda.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 0/3] Add support for the Nuvoton NAU7802 ADC to the cfa10049
Date: Thu, 18 Apr 2013 17:38:53 +0200
Message-Id: <1366299536-18353-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

This patchset adds support for the 3 Nuvoton NAU7802 ADCs presetn on the
CFA-10049 board from Crystalfontz. The first patch adds the driver, the next
ones are adding them in the DT after switching the second i2c bus to bitbanging
following a lot of timeout issues we have on that bus.

Regards,

Alexandre Belloni (1):
  iio: Add Nuvoton NAU7802 ADC driver

Maxime Ripard (2):
  ARM: mxs: cfa10049: Switch bus i2c1 to bitbanging
  ARM: mxs: cfa10049: Add NAU7802 ADCs to the device tree

 .../bindings/iio/adc/nuvoton-nau7802.txt           |   17 +
 arch/arm/boot/dts/imx28-cfa10049.dts               |  126 ++--
 drivers/iio/adc/Kconfig                            |    9 +
 drivers/iio/adc/Makefile                           |    1 +
 drivers/iio/adc/nau7802.c                          |  644 ++++++++++++++++++++
 5 files changed, 754 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/nuvoton-nau7802.txt
 create mode 100644 drivers/iio/adc/nau7802.c

-- 
1.7.10.4

