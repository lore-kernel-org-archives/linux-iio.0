Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-43.csi.cam.ac.uk ([131.111.8.143]:42615 "EHLO
	ppsw-43.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021Ab3AVQQq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Jan 2013 11:16:46 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, denis.ciocca@st.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 00/10] Some little cleanups and fixlets for the ST sensor drivers
Date: Tue, 22 Jan 2013 16:16:29 +0000
Message-Id: <1358871399-11216-1-git-send-email-jic23@kernel.org>
In-Reply-To: <50FEBB20.7070407@kernel.org>
References: <50FEBB20.7070407@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These are a few remaining little bits and bobs for the driver set under review.


Jonathan Cameron (10):
  iio:st_sensors drop some unused exports
  iio:accel:st_accel move the header from include/iio/common to .
  iio:gyro:st_gyro move header from linux/iio/gyro to .
  iio:magn:st_magn move header from linux/iio/magn/ to .
  iio:accel:st_accel drop unwanted EXPORT_SYMBOLS
  iio:gyro:st_gyro drop unwanted EXPORT_SYMBOLs
  iio:magn:st_magn drop unwanted EXPORT_SYMBOLs
  iio:accel:st_accel drop incorrect line from kconfig comment
  iio:gyro:st_gyro drop incorrect line from kconfig comment
  iio:magn:st_magn drop incorrect line from Kconfig

 drivers/iio/accel/Kconfig                       |  1 -
 drivers/iio/accel/st_accel.h                    | 52 +++++++++++++++++++++++++
 drivers/iio/accel/st_accel_buffer.c             |  6 +--
 drivers/iio/accel/st_accel_core.c               |  6 +--
 drivers/iio/accel/st_accel_i2c.c                |  2 +-
 drivers/iio/accel/st_accel_spi.c                |  2 +-
 drivers/iio/common/st_sensors/st_sensors_core.c |  6 +--
 drivers/iio/gyro/Kconfig                        |  1 -
 drivers/iio/gyro/st_gyro.h                      | 50 ++++++++++++++++++++++++
 drivers/iio/gyro/st_gyro_buffer.c               |  5 +--
 drivers/iio/gyro/st_gyro_core.c                 |  6 +--
 drivers/iio/gyro/st_gyro_i2c.c                  |  2 +-
 drivers/iio/gyro/st_gyro_spi.c                  |  2 +-
 drivers/iio/magnetometer/Kconfig                |  1 -
 drivers/iio/magnetometer/st_magn_buffer.c       |  5 +--
 drivers/iio/magnetometer/st_magn_core.c         |  4 +-
 drivers/iio/magnetometer/st_magn_i2c.c          |  2 +-
 drivers/iio/magnetometer/st_magn_spi.c          |  2 +-
 include/linux/iio/accel/st_accel.h              | 52 -------------------------
 include/linux/iio/common/st_sensors.h           |  6 ---
 include/linux/iio/gyro/st_gyro.h                | 50 ------------------------
 include/linux/iio/magnetometer/st_magn.h        | 47 ----------------------
 22 files changed, 116 insertions(+), 194 deletions(-)
 create mode 100644 drivers/iio/accel/st_accel.h
 create mode 100644 drivers/iio/gyro/st_gyro.h
 delete mode 100644 include/linux/iio/accel/st_accel.h
 delete mode 100644 include/linux/iio/gyro/st_gyro.h
 delete mode 100644 include/linux/iio/magnetometer/st_magn.h

-- 
1.8.1.1

