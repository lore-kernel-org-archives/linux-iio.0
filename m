Return-Path: <SRS0=SeY0=ZE=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v2 0/2] iio: imu: st_lsm6dsx: add capability to select interrupt pin
Date: Sun, 22 Jan 2017 19:32:23 +0100
Message-Id: <20170122183225.2539-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Changes since v1:
- rely on the -ENOSYS return value from of_property_read_u32 to check if OF
  has been enabled

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: add possibility to select drdy pin
  Documentation: dt: iio: imu: st_lsm6dsx: add st,drdy-int-pin property

 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt     |  2 +
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c       | 59 +++++++++++++++++++---
 2 files changed, 55 insertions(+), 6 deletions(-)

-- 
2.9.3
