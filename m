Return-Path: <cw00.choi@samsung.com>
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org, ch.naveen@samsung.com, kgene.kim@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
 ijc+devicetree@hellion.org.uk, galak@codeaurora.org, rdunlap@infradead.org,
 t.figa@samsung.com, linux-iio@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv2 0/2] iio: adc: exynos_adc: Support Exynos3250 ADC
Date: Mon, 14 Apr 2014 18:07:04 +0900
Message-id: <1397466426-13870-1-git-send-email-cw00.choi@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset support Exynos3250 ADC (Analog Digital Converter) because
Exynos3250 has additional special clock for ADC IP.

Changes from v1:
- Add new "samsung,exynos-adc-v3" compatible to support Exynos3250 ADC
- Add a patch about DT binding documentation

Chanwoo Choi (2):
  iio: adc: exynos_adc: Control special clock of ADC to support Exynos3250 ADC
  iio: devicetree: Add DT binding documentation for Exynos3250 ADC

 .../devicetree/bindings/arm/samsung/exynos-adc.txt | 20 ++++++++
 drivers/iio/adc/exynos_adc.c                       | 54 ++++++++++++++++------
 2 files changed, 61 insertions(+), 13 deletions(-)

-- 
1.8.0
