Return-Path: <SRS0=5ifT=52=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/2] Add open drain support to st_lsm6dsx
Date: Wed, 21 Jun 2017 21:21:27 +0200
Message-Id: <20170621192129.10226-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: imu: st_lsm6dsx: support open drain mode
  dt-bindings: iio: imu: st_lsm6dsx: support open drain mode

 .../devicetree/bindings/iio/imu/st_lsm6dsx.txt          |  8 ++++++++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c          | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

-- 
2.13.1
