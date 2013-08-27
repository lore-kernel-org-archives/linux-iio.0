Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:31761 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055Ab3H0L3s (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Aug 2013 07:29:48 -0400
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com,
	Josh Wu <josh.wu@atmel.com>
Subject: [PATCH v3 0/6] iio: at91: Add touch screen support in at91 adc
Date: Tue, 27 Aug 2013 19:28:46 +0800
Message-Id: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch series introduce multiple compatible string for different ip.
So remove some adc dt parameters as it already included in driver code.

It also touch screen support for at91 adc driver.
To enable touch screen you need add the touch screen related dt properties.

v2 --> v3:
  1. move the dt parameters to driver itself.
  2. trival fix in touch driver.

v1 --> v2:
  1. use multiple compatible string for different ADC IP.
  2. drop the patch that add the adc-clock in dt since we will move to clock
     common framework.
  3. don't expose the driver configuration to dt. Such like sample period,
     pen detect debounce time and etc.
  4. add a new dt parameter: ts-pressure-threshold.

Josh Wu (6):
  iio: at91: fix adc_clk overflow
  iio: at91: introduce the multiple compatible string for different
    IPs.
  iio: at91: Use different prescal, startup mask in MR for different IP
  iio: at91: ADC start-up time calculation changed since at91sam9x5
  iio: at91: move the num_channels from DT to driver itself
  iio: at91: introduce touch screen support in iio adc driver

 .../devicetree/bindings/arm/atmel-adc.txt          |   15 +-
 arch/arm/mach-at91/include/mach/at91_adc.h         |   50 +-
 drivers/iio/adc/at91_adc.c                         |  550 +++++++++++++++++---
 include/linux/platform_data/at91_adc.h             |    4 +
 4 files changed, 530 insertions(+), 89 deletions(-)

-- 
1.7.10

