Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:51624 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbaIPJDh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Sep 2014 05:03:37 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cw00.choi@samsung.com,
	gregkh@linuxfoundation.org, naveenkrishna.ch@gmail.com,
	lars@metafoo.de, cpgs@samsung.com, grundler@chromium.org,
	jic23@kernel.org
Subject: [PATCH v2 0/3] iio: exynos-adc: use syscon instead of ioremap
Date: Tue, 16 Sep 2014 14:28:48 +0530
Message-id: <1410857931-4980-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
1. Rebased on top of togreg branch of IIO git.

This patch set does the following
1. Use the syscon and Regmap API instead of ioremappaing the
   ADC_PHY register from PMU.
2. Updates the Documentation in exynos-adc.txt with syscon phandle
   for the ADC nodes.
3. Updates the Dts files for Exynos3250, Exynos4x12, Exynos5250,
   Exynos5420 with the syscon phandle.

Tested on Exynos5420 based Peach PIT and Exynos5800 based Peach PI
by verifying sysfs entries provided by HWMON based NTC thermistors.

Tested-By for Exynos3250, Exynos4x12 would be appreciated.

Naveen Krishna Chatradhi (3):
  iio: exyno-adc: use syscon for PMU register access
  Documentation: dt-bindings: update exynos-adc.txt with syscon handle
  ARM: dts: exynos: Add sysreg phandle to ADC node

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |    9 ++++--
 arch/arm/boot/dts/exynos3250.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos5250.dtsi                  |    3 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |    3 +-
 drivers/iio/adc/exynos_adc.c                       |   30 ++++++++++++++------
 6 files changed, 36 insertions(+), 15 deletions(-)

-- 
1.7.9.5

