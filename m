Return-Path: <SRS0=hlQU=5L=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	denis.ciocca@st.com
Subject: [PATCH 0/2] Remove LSM303DL series from acc-magn spi_device_id tables
Date: Tue,  6 Jun 2017 22:51:22 +0200
Message-Id: <20170606205124.14905-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: accel: st_accel_spi: fix spi_device_id table
  iio: magnetometer: st_magn_spi: fix spi_device_id table

 drivers/iio/accel/st_accel_spi.c       | 4 ----
 drivers/iio/magnetometer/st_magn_spi.c | 2 --
 2 files changed, 6 deletions(-)

-- 
2.12.2
