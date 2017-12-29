Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:42569 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdL2XdR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Dec 2017 18:33:17 -0500
Received: by mail-wr0-f193.google.com with SMTP id w107so16861578wrb.9
        for <linux-iio@vger.kernel.org>; Fri, 29 Dec 2017 15:33:16 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] add regmap API support to hts221 iio driver
Date: Sat, 30 Dec 2017 00:33:03 +0100
Message-Id: <cover.1514588903.git.lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
- add missing flag to read_flag_mask in hts221_spi_regmap_config
- drop hts221_write_with_mask() and always use regmap_update_bits()

Lorenzo Bianconi (2):
  iio: humidity: hts221: move common code in hts221_core
  iio: humidity: hts221: add regmap API support

 drivers/iio/humidity/Kconfig         |   2 +
 drivers/iio/humidity/hts221.h        |  22 +-----
 drivers/iio/humidity/hts221_buffer.c |  37 +++++-----
 drivers/iio/humidity/hts221_core.c   | 127 +++++++++++++++--------------------
 drivers/iio/humidity/hts221_i2c.c    |  76 +++++----------------
 drivers/iio/humidity/hts221_spi.c    |  93 +++++--------------------
 6 files changed, 115 insertions(+), 242 deletions(-)

-- 
2.13.6

