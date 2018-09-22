Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33931 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725726AbeIWEQT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Sep 2018 00:16:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id t15so8188929wrx.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Sep 2018 15:21:11 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/3] meson-saradc: small code improvements
Date: Sun, 23 Sep 2018 00:20:59 +0200
Message-Id: <20180922222102.12023-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The goal of this series is to simplify the code a bit.
This is a first preparation step for adding support for the temperature
sensor on the 32-bit Meson8, Meson8b and Meson8m2 SoCs later.


Martin Blumenstingl (3):
  iio: adc: meson-saradc: remove #define
    MESON_SAR_ADC_DELTA_10_TS_C_SHIFT
  iio: adc: meson-saradc: use of_device_get_match_data
  iio: adc: meson-saradc: simplify access to meson_sar_adc_param

 drivers/iio/adc/meson_saradc.c | 37 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 19 deletions(-)

-- 
2.19.0
