Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm1-f52.google.com ([209.85.128.52]:38640 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727834AbeKDXy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 18:54:28 -0500
Received: by mail-wm1-f52.google.com with SMTP id l2-v6so5655353wmh.3
        for <linux-iio@vger.kernel.org>; Sun, 04 Nov 2018 06:39:13 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 0/7] add i2c controller support to st_lsm6dsx driver
Date: Sun,  4 Nov 2018 15:38:59 +0100
Message-Id: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce i2c controller support to st_lsm6dsx driver for lsm6dso sensor.
Add register map for lis2mdl magnetometer sensor.
Add hw FIFO support to st_lsm6dsx sensorhub driver.

Lorenzo Bianconi (7):
  iio: imu: st_lsm6dsx: introduce locked read/write utility routines
  iio: imu: st_lsm6dsx: reboot memory content after reset
  iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
  iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
  iio: imu: st_lsm6dsx: add i2c embedded controller support
  iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
  dt-bindings: iio: imu: st_lsm6dsx: add support to i2c pullup resistors

 .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
 drivers/iio/imu/st_lsm6dsx/Makefile           |   3 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 167 +++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 169 ++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 273 +++++--
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 753 ++++++++++++++++++
 .../linux/platform_data/st_sensors_pdata.h    |   2 +
 7 files changed, 1226 insertions(+), 142 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c

-- 
2.19.1
