Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:12974 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbaG1MoI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Jul 2014 08:44:08 -0400
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org
Cc: ch.naveen@samsung.com, arnd@arndb.de, kgene.kim@samsung.com,
	kyungmin.park@samsung.com, heiko@sntech.de, knaack.h@gmx.de,
	t.figa@samsung.com, linux-iio@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 0/3] iio: adc: exynos_adc: Add support for s3c64xx/s3c24xx ADC
Date: Mon, 28 Jul 2014 21:43:59 +0900
Message-id: <1406551442-15186-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch add support for s3c64xx/s3c24xx ADC. s3c64xx/s3c24xx is alomost same
as ADCv1. But, s3c64xx/s3c24xx has a little difference from ADCv1 as following:
- ADCMUX register address to select channel
- ADCDAT mask (10bit or 12bit ADC resolution according to SoC version)
- s3c24xx/s3c64xx has not included ADC_PHY enable register

Changes from v1:
- Fix minor coding style.
- Remove the sentence which reading DATY register.
- Add ARCH_S3C24XX / ARCH_S3C64XX dependency for EXYNOS_ADC to Kconfig.
- Remove the function pointer of 'clear_irq' for s3c24xx becase s3c24xx
  has not included ADC_V1_INTCLR register.
- Remove un-necessary white-space in dt-binding documentation

Arnd Bergmann (1):
  iio: adc: exynos_adc: add support for s3c64xx adc

Chanwoo Choi (2):
  iio: adc: exynos_adc: Add support for s3c24xx ADC
  dt-bindings: samsung: exynos_adc: Remove un-necessary white-sapce

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  20 ++-
 drivers/iio/adc/Kconfig                            |   2 +-
 drivers/iio/adc/exynos_adc.c                       | 137 +++++++++++++++++++--
 3 files changed, 144 insertions(+), 15 deletions(-)

-- 
1.8.0

