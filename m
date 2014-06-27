Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:38626 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750990AbaF0EaT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jun 2014 00:30:19 -0400
From: Chanwoo Choi <cw00.choi@samsung.com>
To: jic23@kernel.org, ch.naveen@samsung.com, t.figa@samsung.com,
	kgene.kim@samsung.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
	rdunlap@infradead.org, sachin.kamat@linaro.org,
	kyungmin.park@samsung.com, linux-iio@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCHv5 0/4] iio: adc: exynos_adc: Support Exynos3250 ADC and code
 clean
Date: Fri, 27 Jun 2014 13:30:02 +0900
Message-id: <1403843406-28229-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes from v4:
- Use 'exynos_adc_data' structure instead of 'exynos_adc_ops' structure
  and remove enum variable of ADC version
- Fix wrong name of special clock (sclk_tsadc -> sclk_adc)
- Add reviewed message by Naveen Krishna Chatradhi
- Add functions for ADC clock control

Changes from v3:
- Add new 'exynos_adc_ops' structure to improve readability according to
 Tomasz Figa comment[1]
 [1] https://lkml.org/lkml/2014/4/16/238
- Add new 'exynos3250-adc-v2' compatible string to support Exynos3250 ADC
- Fix wrong compaitlbe string of ADC in Exynos3250 dtsi file

Changes from v2:
- Check return value of clock function to deal with error exception
- Fix minor coding style to improve readability

Changes from v1:
- Add new "samsung,exynos-adc-v3" compatible to support Exynos3250 ADC
- Add a patch about DT binding documentation

Chanwoo Choi (4):
  iio: adc: exynos_adc: Add exynos_adc_data structure to improve readability
  iio: adc: exynos_adc: Control special clock of ADC to support Exynos3250 ADC
  iio: devicetree: Add DT binding documentation for Exynos3250 ADC
  ARM: dts: Fix wrong compatible string for Exynos3250 ADC

 .../devicetree/bindings/arm/samsung/exynos-adc.txt |  26 +-
 arch/arm/boot/dts/exynos3250.dtsi                  |   4 +-
 drivers/iio/adc/exynos_adc.c                       | 326 +++++++++++++++------
 3 files changed, 268 insertions(+), 88 deletions(-)

-- 
1.8.0

