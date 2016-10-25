Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39936 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbcJYVJI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Oct 2016 17:09:08 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 0/2] add support to lng2dm accel sensor
Date: Tue, 25 Oct 2016 23:09:02 +0200
Message-Id: <1477429744-27713-1-git-send-email-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (2):
  iio: accel: st_accel: add support to lng2dm
  Documentation: dt: iio: accel: add lng2dm sensor device binding

 .../devicetree/bindings/iio/st-sensors.txt         |  1 +
 drivers/iio/accel/Kconfig                          |  3 +-
 drivers/iio/accel/st_accel.h                       |  1 +
 drivers/iio/accel/st_accel_core.c                  | 73 ++++++++++++++++++++++
 drivers/iio/accel/st_accel_i2c.c                   |  5 ++
 drivers/iio/accel/st_accel_spi.c                   |  1 +
 6 files changed, 83 insertions(+), 1 deletion(-)

-- 
2.7.4

