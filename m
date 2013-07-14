Return-Path: <josh.wu@atmel.com>
From: Josh Wu <josh.wu@atmel.com>
To: jic23@cam.ac.uk
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
        nicolas.ferre@atmel.com, Josh Wu <josh.wu@atmel.com>
Subject: [PATCH 0/5] iio: at91: Add touch screen support in at91 adc
Date: Sun, 14 Jul 2013 16:04:24 +0800
Message-Id: <1373789069-11604-1-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch series will add touch screen support for at91 adc driver.
To enable touch screen you need add the touch screen related dt properties.

Josh Wu (5):
  iio: at91: use adc_clk_khz to make the calculation not easy to large
    than u32.
  iio: at91: Use different prescal, startup mask in MR for different IP
  iio: at91: ADC start-up time calculation changed since at91sam9x5
  iio: at91: add an optional dt property for for adc clock hz.
  iio: at91: introduce touch screen support in iio adc driver

 .../devicetree/bindings/arm/atmel-adc.txt          |   15 +
 arch/arm/mach-at91/include/mach/at91_adc.h         |   43 +-
 drivers/iio/adc/at91_adc.c                         |  492 ++++++++++++++++++--
 3 files changed, 511 insertions(+), 39 deletions(-)

-- 
1.7.10
