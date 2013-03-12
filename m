Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gg0-f202.google.com ([209.85.161.202]:43501 "EHLO
	mail-gg0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933392Ab3CLXTL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Mar 2013 19:19:11 -0400
Received: by mail-gg0-f202.google.com with SMTP id l4so49444ggi.3
        for <linux-iio@vger.kernel.org>; Tue, 12 Mar 2013 16:19:10 -0700 (PDT)
From: Doug Anderson <dianders@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Olof Johansson <olof@lixom.net>,
	Doug Anderson <dianders@chromium.org>,
	Russell King <linux@arm.linux.org.uk>,
	Rob Landley <rob@landley.net>,
	Rahul Sharma <rahul.sharma@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-iio@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Abraham <thomas.abraham@linaro.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Jingoo Han <jg1.han@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Padmavathi Venna <padma.v@samsung.com>,
	Rob Herring <rob.herring@calxeda.com>
Subject: [PATCH 0/4] Get exynos adc driver running on on exynos5250-snow
Date: Tue, 12 Mar 2013 16:13:10 -0700
Message-Id: <1363129994-10438-1-git-send-email-dianders@chromium.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This set of patches is based on Naveen Krishna Chatradhi's recent work
(some of which is still in-flight) and does the final touches to get
things working on exynos5250-snow (the ARM Chromebook).

These patches were tested on next-20130312 (which includes support for
the common clock framework on exynos) plus the current linux-iio/togreg:
  95783f2 iio: adc: add exynos adc driver under iio framwork
  298489f iio:common: Use spi_sync_transfer() in STMicroelectronics ...
  1d9a4cb IIO ADC support for AD7923
  9a282b0 iio: Add OF support
  3d277fc3 staging:iio: Remove adt7410 driver

...plus Naveen's recent ADC cleanup and NTC thermistor patch.

Doug Anderson (4):
  iio: adc: Document the regulator/clocks for exynos-adc
  iio: adc: Add dt support for turning on the phy in exynos-adc
  ARM: dts: Add adc to exynos5250 device tree file
  ARM: dts: Add adc and thermistors for exynos5250-snow

 .../devicetree/bindings/arm/samsung/exynos-adc.txt | 12 +++++++--
 arch/arm/boot/dts/cros5250-common.dtsi             |  4 +++
 arch/arm/boot/dts/exynos5250-snow.dts              | 31 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  | 11 ++++++++
 drivers/iio/adc/exynos_adc.c                       | 14 +++++++++-
 5 files changed, 69 insertions(+), 3 deletions(-)

-- 
1.8.1.3

