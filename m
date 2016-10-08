Return-Path: <lorenzo.bianconi83@gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v3 0/2] add support to STM HTS221 humidity + temperature sensor
Date: Sat,  8 Oct 2016 09:45:50 +0200
Message-Id: <1475912752-6444-1-git-send-email-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Changes since v2:
- fix endianness issue in hts221_parse_caldata()
- make dev->buffer large enough to avoid the memcpy() in
  hts221_buffer_handler_thread()
- remove trigger top half routine and move timestamp sampling in
  hts221_buffer_handler_thread()
- use devm_iio_* routines to register iio_device/trigger and setup
  iio_triggered_buffer
- reduce spi max read/write size
- cosmetics

Changes since v1:
- use single iio_device for both humidity and temperature sensors
- use iio_claim_direct_mode() routine instead of grabbing the mutex directly
- use more unique prefix for all defines
- remove useless dev_info()
- use of_match_ptr instead of access directly to of_match_table
- use devm_iio_* routines
- use info_mask_shared_by_all element for sampling_frequency
- use oversampling ABI for humidityrelative_avg_sample and temp_avg_sample

Lorenzo Bianconi (2):
  iio: humidity: add support to hts221 rh/temp combo device
  Documentation: dt: iio: humidity: add hts221 sensor device binding

 .../devicetree/bindings/iio/humidity/hts221.txt    |  19 +
 drivers/iio/humidity/Kconfig                       |   2 +
 drivers/iio/humidity/Makefile                      |   1 +
 drivers/iio/humidity/hts221/Kconfig                |  23 +
 drivers/iio/humidity/hts221/Makefile               |   6 +
 drivers/iio/humidity/hts221/hts221.h               |  78 +++
 drivers/iio/humidity/hts221/hts221_buffer.c        | 168 +++++
 drivers/iio/humidity/hts221/hts221_core.c          | 684 +++++++++++++++++++++
 drivers/iio/humidity/hts221/hts221_i2c.c           | 110 ++++
 drivers/iio/humidity/hts221/hts221_spi.c           | 125 ++++
 10 files changed, 1216 insertions(+)
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
