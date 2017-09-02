Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34689 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752692AbdIBRjU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Sep 2017 13:39:20 -0400
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] Add support to LPS33HW and LPS35HW pressure sensors
Date: Sat,  2 Sep 2017 19:39:13 +0200
Message-Id: <20170902173915.17341-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lorenzo Bianconi (2):
  iio: pressure: add support to LPS33HW and LPS35HW
  dt-bindings: iio: pressure: add LPS33HW and LPS35HW device bindings

 Documentation/devicetree/bindings/iio/st-sensors.txt |  2 ++
 drivers/iio/pressure/st_pressure.h                   |  4 ++++
 drivers/iio/pressure/st_pressure_core.c              |  2 ++
 drivers/iio/pressure/st_pressure_i2c.c               | 10 ++++++++++
 drivers/iio/pressure/st_pressure_spi.c               | 10 ++++++++++
 5 files changed, 28 insertions(+)

-- 
2.14.1

