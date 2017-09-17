Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37116 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbdIQQRQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2017 12:17:16 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        devicetree@vger.kernel.org
Subject: [PATCH 0/4] Add support to LIS3DHH accel sensor
Date: Sun, 17 Sep 2017 18:17:08 +0200
Message-Id: <20170917161712.14645-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Separate data-ready open-drain configuration parameters for
INT1 and INT2

This patchset depends on 'Add support to LIS2DW12 accel sensor' patchset
not yet applied on testing branch

Lorenzo Bianconi (4):
  iio: st_sensors: split open-drain parameters for irq1 and irq2
  iio: common: st_sensors: check odr address value in
    st_sensors_set_odr()
  iio: accel: add support to LIS3DHH
  dt-bindings: iio: accel: add LIS3DHH device bindings

 .../devicetree/bindings/iio/st-sensors.txt         |  1 +
 drivers/iio/accel/st_accel.h                       |  2 +
 drivers/iio/accel/st_accel_core.c                  | 70 ++++++++++++++++++++--
 drivers/iio/accel/st_accel_spi.c                   |  5 ++
 drivers/iio/common/st_sensors/st_sensors_core.c    | 24 ++++++--
 drivers/iio/pressure/st_pressure_core.c            | 14 +++--
 include/linux/iio/common/st_sensors.h              | 28 +++++----
 7 files changed, 115 insertions(+), 29 deletions(-)

-- 
2.14.1

