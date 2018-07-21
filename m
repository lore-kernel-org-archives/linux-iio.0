Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50588 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbeGUUet (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jul 2018 16:34:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id v25-v6so12378192wmc.0
        for <linux-iio@vger.kernel.org>; Sat, 21 Jul 2018 12:40:56 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-amlogic@lists.infradead.org,
        linux-iio@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 0/2] meson-saradc: add support for the Meson8m2 SoC
Date: Sat, 21 Jul 2018 21:40:47 +0200
Message-Id: <20180721194049.23265-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a trivial series which adds Meson8m2 support to the Meson
SAR ADC driver.
A separate compatible string is required because typically Meson8m2
inherits all IP blocks from Meson8. The ADC part of the SAR ADC is
indeed compatible, but the temperature calibration logic (not
supported yet, but I am working on this) is incompatible with
the Meson8 implementation (instead it uses the same variant as
Meson8m2).


Martin Blumenstingl (2):
  dt-bindings: iio: adc: add Meson8m2 support
  iio: adc: meson-saradc: add support for the Meson8m2 SoCs

 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
 drivers/iio/adc/meson_saradc.c                           | 9 +++++++++
 2 files changed, 10 insertions(+)

-- 
2.18.0

