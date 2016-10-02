Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33964 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751271AbcJBRsV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2016 13:48:21 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        devicetree@vger.kernel.org
Subject: [PATCH v2 0/2] add support to STM HTS221 humidity + temperature sensor
Date: Sun,  2 Oct 2016 19:48:15 +0200
Message-Id: <1475430497-7861-1-git-send-email-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
 drivers/iio/humidity/hts221/hts221.h               | 100 +++
 drivers/iio/humidity/hts221/hts221_buffer.c        | 191 ++++++
 drivers/iio/humidity/hts221/hts221_core.c          | 687 +++++++++++++++++++++
 drivers/iio/humidity/hts221/hts221_i2c.c           | 119 ++++
 drivers/iio/humidity/hts221/hts221_spi.c           | 134 ++++
 10 files changed, 1282 insertions(+)
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

