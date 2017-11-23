Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39864 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752460AbdKWW7K (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Nov 2017 17:59:10 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] Add support for UVIS25 uv sensor
Date: Thu, 23 Nov 2017 23:59:04 +0100
Message-Id: <20171123225906.31838-1-lorenzo.bianconi83@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
- use regmap API
- rename devicetree binding file to match compatible string
- move buffer/trigger code in st_uvis25_core.c
- improve comments
- fix potential race st_uvis25_read_oneshot()
- address Peter's comments

Lorenzo Bianconi (2):
  iio: light: add support for UVIS25 sensor
  dt-bindings: iio: light: add UVIS25 device bindings

 .../devicetree/bindings/iio/light/uvis25.txt       |  23 ++
 drivers/iio/light/Kconfig                          |  24 ++
 drivers/iio/light/Makefile                         |   3 +
 drivers/iio/light/st_uvis25.h                      |  37 +++
 drivers/iio/light/st_uvis25_core.c                 | 360 +++++++++++++++++++++
 drivers/iio/light/st_uvis25_i2c.c                  |  69 ++++
 drivers/iio/light/st_uvis25_spi.c                  |  68 ++++
 7 files changed, 584 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/uvis25.txt
 create mode 100644 drivers/iio/light/st_uvis25.h
 create mode 100644 drivers/iio/light/st_uvis25_core.c
 create mode 100644 drivers/iio/light/st_uvis25_i2c.c
 create mode 100644 drivers/iio/light/st_uvis25_spi.c

-- 
2.15.0

