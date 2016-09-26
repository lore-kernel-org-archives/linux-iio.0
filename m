Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36049 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936198AbcIZTsV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2016 15:48:21 -0400
Received: by mail-lf0-f65.google.com with SMTP id s29so10642496lfg.3
        for <linux-iio@vger.kernel.org>; Mon, 26 Sep 2016 12:48:08 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 0/2] add support to STM LSM6DS3-LSM6DSM 6-axis Mems sensor
Date: Mon, 26 Sep 2016 21:48:02 +0200
Message-Id: <1474919284-20898-1-git-send-email-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (2):
  iio: imu: add support to lsm6dsx driver
  Documentation: dt: iio: add st_lsm6dsx sensor device binding

 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  20 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   1 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |  23 +
 drivers/iio/imu/st_lsm6dsx/Makefile                |   6 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            | 105 +++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c     | 241 +++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 705 +++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        | 137 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        | 155 +++++
 10 files changed, 1394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Kconfig
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Makefile
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c

-- 
2.7.4

