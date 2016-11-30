Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36012 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751583AbcK3UGF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 30 Nov 2016 15:06:05 -0500
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v2 0/2] add support to STM LSM6DS3-LSM6DSM 6-axis Mems sensor
Date: Wed, 30 Nov 2016 21:05:57 +0100
Message-Id: <20161130200559.29910-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
- add sw fifo support
- drop trigger dependency
- use iio_claim_direct_mode() routine instead of grabbing the mutex directly
- use more unique prefix for all defines
- use info_mask_shared_by_all element for sampling_frequency
- use devm_iio_* routines
- use of_match_ptr instead of access directly to of_match_table
- fix device tree binding
- rename st_lsm6dsx_dev in st_lsm6dsx_hw
- cosmetics

Lorenzo Bianconi (2):
  iio: imu: add support to lsm6dsx driver
  Documentation: dt: iio: add st_lsm6dsx sensor device binding

 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  24 +
 drivers/iio/imu/Kconfig                            |   1 +
 drivers/iio/imu/Makefile                           |   2 +
 drivers/iio/imu/st_lsm6dsx/Kconfig                 |  23 +
 drivers/iio/imu/st_lsm6dsx/Makefile                |   6 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h            | 107 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 696 +++++++++++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c        | 111 ++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_ring.c       | 401 ++++++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c        | 129 ++++
 10 files changed, 1500 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Kconfig
 create mode 100644 drivers/iio/imu/st_lsm6dsx/Makefile
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_ring.c
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c

-- 
2.9.3

