Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:9700 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757431AbaFZMWb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jun 2014 08:22:31 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, cpgs@samsung.com
Subject: [PATCH 0/3] ARM: DTS: create common dtsi for Peach pit and pi boards
Date: Thu, 26 Jun 2014 17:49:05 +0530
Message-id: <1403785148-20792-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset does the following
1. Create a common dtsi file cros-exynos-peach.dtsi for
   exynos5420-peach-pit.dts and exynos5800-peach-pi.dts
2. Adds the ADC based Thermistor nodes and enables them in peach_pit.dts
   and peach_pi.dts
3. Adds the ADC based Thermistor nodes for Exynos5250 based Snow
4. Corrects the vendor prefix for thermistors in exynos4412-trats2.dts

Naveen Krishna Chatradhi (3):
  ARM: DTS: use new compatible string for thermistors in trats2
  ARM: DTS: Add NTC thermistor nodes to Exynos5250 based Snow
  ARM: DTS: Add common dts file for Peach PIT and PI along with ADC
    nodes

 arch/arm/boot/dts/cros-exynos-peach.dtsi   |   41 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts    |    4 +--
 arch/arm/boot/dts/exynos5250-snow.dts      |   34 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5420-peach-pit.dts |    6 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts  |    6 ++++
 5 files changed, 89 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/cros-exynos-peach.dtsi

-- 
1.7.9.5

