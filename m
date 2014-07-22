Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:11640 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824AbaGVCLT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jul 2014 22:11:19 -0400
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org
Cc: ch.naveen@samsung.com, arnd@arndb.de, kgene.kim@samsung.com,
	kyungmin.park@samsung.com, t.figa@samsung.com,
	linux-iio@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/2] iio: adc: exynos_adc: Add support for s3c64xx/s3c24xx ADC
Date: Tue, 22 Jul 2014 11:11:12 +0900
Message-id: <1405995074-3271-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add support for s3c64xx/s3c24xx ADC. s3c64xx/s3c24xx is alomost same
as ADCv1. But, s3c64xx/s3c24xx has a little difference from ADCv1 as following:
- ADCMUX register address to select channel
- ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)

This patchset is implemented based on exynos3250 ADC patchset[1].
 [1] http://www.spinics.net/lists/kernel/msg1791299.html

Arnd Bergmann (1):
  iio: adc: exynos_adc: add support for s3c64xx adc

Chanwoo Choi (1):
  iio: adc: exynos_adc: Add support for S3C24xx ADC

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  12 +-
 drivers/iio/adc/exynos_adc.c                       | 121 ++++++++++++++++++++-
 2 files changed, 129 insertions(+), 4 deletions(-)

-- 
1.8.0

