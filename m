Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34928 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752512AbcJMUTV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Oct 2016 16:19:21 -0400
Received: by mail-lf0-f67.google.com with SMTP id x79so14476662lff.2
        for <linux-iio@vger.kernel.org>; Thu, 13 Oct 2016 13:18:26 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v4 0/2] add support to STM HTS221 humidity + temperature sensor
Date: Thu, 13 Oct 2016 22:06:03 +0200
Message-Id: <1476389165-13542-1-git-send-email-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v3:
- fix trigger management according to how humidity and temperature samples
  are computed by the device
- define two separate calibration routines to improve code readability
- fix device tree binding
- move driver in humidity folder
- rename hts221_dev in hts221_hw
- code style fixes

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

 .../devicetree/bindings/iio/humidity/hts221.txt    |  22 +
 drivers/iio/humidity/Kconfig                       |  22 +
 drivers/iio/humidity/Makefile                      |   7 +
 drivers/iio/humidity/hts221.h                      |  73 +++
 drivers/iio/humidity/hts221_buffer.c               | 168 +++++
 drivers/iio/humidity/hts221_core.c                 | 687 +++++++++++++++++++++
 drivers/iio/humidity/hts221_i2c.c                  | 110 ++++
 drivers/iio/humidity/hts221_spi.c                  | 125 ++++
 8 files changed, 1214 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/humidity/hts221.txt
 create mode 100644 drivers/iio/humidity/hts221.h
 create mode 100644 drivers/iio/humidity/hts221_buffer.c
 create mode 100644 drivers/iio/humidity/hts221_core.c
 create mode 100644 drivers/iio/humidity/hts221_i2c.c
 create mode 100644 drivers/iio/humidity/hts221_spi.c

-- 
2.7.4

