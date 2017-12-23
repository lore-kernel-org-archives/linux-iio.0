Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42827 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752902AbdLWRQf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 23 Dec 2017 12:16:35 -0500
Received: by mail-wm0-f68.google.com with SMTP id b199so26825397wme.1
        for <linux-iio@vger.kernel.org>; Sat, 23 Dec 2017 09:16:35 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/2] add regmap API support to hts221 iio driver
Date: Sat, 23 Dec 2017 18:16:19 +0100
Message-Id: <cover.1514042380.git.lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (2):
  iio: humidity: hts221: move common code in hts221_core
  iio: humidity: hts221: add regmap API support

 drivers/iio/humidity/Kconfig         |  2 +
 drivers/iio/humidity/hts221.h        | 28 ++++-------
 drivers/iio/humidity/hts221_buffer.c | 20 +++-----
 drivers/iio/humidity/hts221_core.c   | 96 ++++++++++++++----------------------
 drivers/iio/humidity/hts221_i2c.c    | 76 +++++++---------------------
 drivers/iio/humidity/hts221_spi.c    | 95 +++++++----------------------------
 6 files changed, 90 insertions(+), 227 deletions(-)

-- 
2.13.6

