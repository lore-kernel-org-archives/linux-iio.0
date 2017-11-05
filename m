Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:49558 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750750AbdKEXZD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Nov 2017 18:25:03 -0500
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v2 0/2] ZOPT2210 ambient light and UVB sensor driver
Date: Mon,  6 Nov 2017 00:24:58 +0100
Message-Id: <1509924300-14634-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver for 20-bit ALS and UV B sensor with I2C interface exposing
the following API:
  in_uvindex_input
  in_illuminance_raw
  in_illuminance_scale
  in_illuminance_scale_available
  in_intensity_uv_raw
  in_intensity_uv_scale
  in_intensity_uv_scale_available
  integration_time
  integration_time_available

v2: (thanks Jonathan)
* remove duplicate new lines as suggested
* split write functions as suggested
* reformatting error path as suggested
* drop _mode enum and use register address directly instead
* the intensity_uv channel now reports in SI units: W/m^2 (as suggested),
   the illuminance channel reports in lux (after application of _SCALE)
* add unrelated patch to fix a typo in documentation

Peter Meerwald-Stadler (2):
  iio: light: Add driver for IDT ZOPT2201 ambient light and UVB sensor
  Documentation: iio: Fix typo

 Documentation/ABI/testing/sysfs-bus-iio |   2 +-
 drivers/iio/light/Kconfig               |  10 +
 drivers/iio/light/Makefile              |   1 +
 drivers/iio/light/zopt2201.c            | 568 ++++++++++++++++++++++++++++++++
 4 files changed, 580 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/light/zopt2201.c

-- 
2.7.4

