Return-Path: <SRS0=OkIe=7N=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gregor.boirie@parrot.com,
	denis.ciocca@st.com,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/2] iio: st_sensors: fix data-ready pin configuration
Date: Fri, 11 Aug 2017 21:44:12 +0200
Message-Id: <20170811194414.20741-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: pressure: st_pressure: fix drdy configuration for LPS22HB and
    LPS25H
  iio: accel: st_accel: fix data-ready line configuration

 drivers/iio/accel/st_accel_core.c       | 4 ++--
 drivers/iio/pressure/st_pressure_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.14.0
