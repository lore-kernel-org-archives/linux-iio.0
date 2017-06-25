Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35006 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdFYPYR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jun 2017 11:24:17 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH v2 0/4] Add OF support to ST sensor framework
Date: Sun, 25 Jun 2017 17:24:09 +0200
Message-Id: <20170625152413.22325-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since v1:
- add missing devices to {accel, magn, gyro, press} of_device_id table

Lorenzo Bianconi (4):
  iio: accel: st_accel_spi: add OF capability to st_accel_spi
  iio: magnetometer: st_magn_spi: add OF capability to st_magn_spi
  iio: gyro: st_gyro_spi: add OF capability to st_gyro_spi
  iio: pressure: st_pressure_spi: add OF capability to st_pressure_spi

 drivers/iio/accel/st_accel_spi.c       | 67 ++++++++++++++++++++++++++++++----
 drivers/iio/gyro/st_gyro_spi.c         | 53 +++++++++++++++++++++++++++
 drivers/iio/magnetometer/st_magn_spi.c | 25 +++++++++++++
 drivers/iio/pressure/st_pressure_spi.c | 33 +++++++++++++++++
 4 files changed, 170 insertions(+), 8 deletions(-)

-- 
2.13.1

