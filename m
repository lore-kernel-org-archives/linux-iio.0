Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:29651 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaF0GLX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 02:11:23 -0400
From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
To: linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dianders@chromium.org, gregkh@linuxfoundation.org,
	naveenkrishna.ch@gmail.com, cpgs@samsung.com
Subject: [PATCH 0/2 v2] ARM: DTS: create thermistor fragment dtsi for Peach
 boards
Date: Fri, 27 Jun 2014 11:38:13 +0530
Message-id: <1403849295-29538-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset does the following
1. Create a thermistor dtsi fragment file cros-adc-thermistors.dtsi for
   exynos5420-peach-pit.dts and exynos5800-peach-pi.dts
2. Adds the ADC based Thermistor nodes and enables them in peach_pit.dts
   and peach_pi.dts
3. Corrects the vendor prefix for thermistors in exynos4412-trats2.dts

This patch depends on (1/4 and 2/4 patches of) patchset posted
http://www.spinics.net/lists/linux-iio/msg13486.html
Which were applied on to Guenter Roeck's tree.

cat sysfs entries exported by hwmon for 4 thermistors
and verified the values on Peach pit and pi boards.

Changes since v1:
1. Dropped 2/3 "ARM: DTS: Add NTC thermistor nodes to Exynos5250 based Snow"
   https://lkml.org/lkml/2014/6/26/192
   As large number of Snow boards dint have thermistors.
2. Created a thermistor fragment instead of common dtsi file

Naveen Krishna Chatradhi (2):
  ARM: DTS: use new compatible string for thermistors in trats2
  ARM: DTS: Add thermistor dts fragment needed by exynos based peach
    boards

 arch/arm/boot/dts/cros-adc-thermistors.dtsi |   44 +++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts     |    4 +--
 arch/arm/boot/dts/exynos5420-peach-pit.dts  |    6 ++++
 arch/arm/boot/dts/exynos5800-peach-pi.dts   |    6 ++++
 4 files changed, 58 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/cros-adc-thermistors.dtsi

-- 
1.7.9.5

