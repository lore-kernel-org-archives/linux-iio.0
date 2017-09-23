Return-Path: <SRS0=28vm=AY=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/2] Remove unnecessary FIFO configurations
Date: Sat, 23 Sep 2017 21:10:50 +0200
Message-Id: <20170923191052.14419-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: remove LIR configuration
  iio: imu: st_lsm6dsx: remove rounding configuration

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 ---------------
 1 file changed, 15 deletions(-)

-- 
2.14.1
