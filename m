Return-Path: <SRS0=W4DQ=5M=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/2] Add support for falling-low_level interrupts
Date: Wed,  7 Jun 2017 20:17:09 +0200
Message-Id: <20170607181711.16195-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: support active-low interrupts
  Documentation: dt: iio: imu: st_lsm6dsx: support active-low interrupts

 Documentation/devicetree/bindings/iio/imu/st_lsm6dsx.txt |  3 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c           | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
2.12.2
