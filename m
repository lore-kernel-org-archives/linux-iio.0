Return-Path: <lorenzo.bianconi83@gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 0/2] add support to STM HTS221 humidity + temperature sensor
Date: Mon, 26 Sep 2016 21:55:39 +0200
Message-Id: <1474919741-21316-1-git-send-email-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Lorenzo Bianconi (2):
  iio: humidity: add support to hts221 rh/temp combo device
  Documentation: dt: iio: humidity: add hts221 sensor device binding

 .../devicetree/bindings/iio/humidity/hts221.txt    |  19 +
 drivers/iio/humidity/Kconfig                       |   2 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hts221/Kconfig                |  23 +
 drivers/iio/humidity/hts221/Makefile               |   6 +
 drivers/iio/humidity/hts221/hts221.h               | 106 +++
 drivers/iio/humidity/hts221/hts221_buffer.c        | 227 ++++++
 drivers/iio/humidity/hts221/hts221_core.c          | 804 +++++++++++++++++++++
 drivers/iio/humidity/hts221/hts221_i2c.c           | 135 ++++
 drivers/iio/humidity/hts221/hts221_spi.c           | 148 ++++
 10 files changed, 1471 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt
 create mode 100644 drivers/iio/humidity/hts221/Kconfig
 create mode 100644 drivers/iio/humidity/hts221/Makefile
 create mode 100644 drivers/iio/humidity/hts221/hts221.h
 create mode 100644 drivers/iio/humidity/hts221/hts221_buffer.c
 create mode 100644 drivers/iio/humidity/hts221/hts221_core.c
 create mode 100644 drivers/iio/humidity/hts221/hts221_i2c.c
 create mode 100644 drivers/iio/humidity/hts221/hts221_spi.c

-- 
2.7.4
