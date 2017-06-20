Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36280 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751118AbdFTTwP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Jun 2017 15:52:15 -0400
Received: by mail-wr0-f195.google.com with SMTP id 77so20111078wrb.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Jun 2017 12:52:14 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH 0/5] Add OF support in spi code for accel/magn/gyro ST devices
Date: Tue, 20 Jun 2017 21:52:07 +0200
Message-Id: <20170620195212.23213-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (5):
  iio: common: st_sensors: move st_sensors_of_i2c_probe() in common code
  iio: accel: st_accel_spi: rename of_device_id table in
    st_accel_of_match
  iio: accel: st_accel_spi: add OF capability to st_accel_spi
  iio: magnetometer: st_magn_spi: add OF capability to st_magn_spi
  iio: gyro: st_gyro_spi: add OF capability to st_gyro_spi

 drivers/iio/accel/st_accel_i2c.c                |  3 ++-
 drivers/iio/accel/st_accel_spi.c                | 28 +++++++++++++++-------
 drivers/iio/common/st_sensors/st_sensors_core.c | 31 +++++++++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_i2c.c  | 29 -----------------------
 drivers/iio/gyro/st_gyro_i2c.c                  |  3 ++-
 drivers/iio/gyro/st_gyro_spi.c                  | 16 +++++++++++++
 drivers/iio/magnetometer/st_magn_i2c.c          |  3 ++-
 drivers/iio/magnetometer/st_magn_spi.c          | 16 +++++++++++++
 drivers/iio/pressure/st_pressure_i2c.c          |  3 ++-
 include/linux/iio/common/st_sensors.h           | 12 ++++++++++
 include/linux/iio/common/st_sensors_i2c.h       | 10 --------
 11 files changed, 102 insertions(+), 52 deletions(-)

-- 
2.13.1

