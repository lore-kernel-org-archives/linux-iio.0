Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36332 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdIQPUv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2017 11:20:51 -0400
Received: by mail-wr0-f194.google.com with SMTP id g50so3756007wra.3
        for <linux-iio@vger.kernel.org>; Sun, 17 Sep 2017 08:20:50 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 0/3] add SPI-3wire support to ST gyro/magn/pressure framework
Date: Sun, 17 Sep 2017 17:20:44 +0200
Message-Id: <20170917152047.12631-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset depends on 'iio: st_sensors: add register mask for status
register' patch of 'Add support to LIS2DW12 accel sensor' patchset not yet
applied on testing branch

Lorenzo Bianconi (3):
  iio: gyro: st_gyro: add SPI-3wire support to st_gyro framework
  iio: magnetometer: st_magn: add SPI-3wire support to LIS3MDL
  iio: pressure: st_pressure: add SPI-3wire support to st_pressure
    framework

 drivers/iio/gyro/st_gyro_core.c         | 12 ++++++++++++
 drivers/iio/magnetometer/st_magn_core.c |  4 ++++
 drivers/iio/pressure/st_pressure_core.c | 16 ++++++++++++++++
 3 files changed, 32 insertions(+)

-- 
2.14.1

