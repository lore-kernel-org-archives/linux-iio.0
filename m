Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:10440 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751170AbcDZMga (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 26 Apr 2016 08:36:30 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lucas.demarchi@intel.com, daniel.baluta@intel.com
Subject: [RFT PATCH] iio: magn: Add support for BMM150 magnetometer
Date: Tue, 26 Apr 2016 15:39:58 +0300
Message-Id: <1461674398-18374-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

BMM150 is register compatible with magnetometer part of
BMC156.

Datasheet is at:
http://www.mouser.com/ds/2/783/BST-BMM150-DS001-01-786480.pdf

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
Lucas let me know if it works for you. I don't have yet the BMM150 evaluation
board. It should be available in few weeks.

I'll just leave this patch here in case anyone steps in to test it.

 drivers/iio/magnetometer/bmc150_magn_i2c.c | 3 +++
 drivers/iio/magnetometer/bmc150_magn_spi.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index eddc7f0..ee05722 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -2,6 +2,7 @@
  * 3-axis magnetometer driver supporting following I2C Bosch-Sensortec chips:
  *  - BMC150
  *  - BMC156
+ *  - BMM150
  *
  * Copyright (c) 2016, Intel Corporation.
  *
@@ -49,6 +50,7 @@ static int bmc150_magn_i2c_remove(struct i2c_client *client)
 static const struct acpi_device_id bmc150_magn_acpi_match[] = {
 	{"BMC150B", 0},
 	{"BMC156B", 0},
+	{"BMM150B", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
@@ -56,6 +58,7 @@ MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
 static const struct i2c_device_id bmc150_magn_i2c_id[] = {
 	{"bmc150_magn",	0},
 	{"bmc156_magn", 0},
+	{"bmm150_magn", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
diff --git a/drivers/iio/magnetometer/bmc150_magn_spi.c b/drivers/iio/magnetometer/bmc150_magn_spi.c
index c4c738a..7d4152d 100644
--- a/drivers/iio/magnetometer/bmc150_magn_spi.c
+++ b/drivers/iio/magnetometer/bmc150_magn_spi.c
@@ -2,6 +2,7 @@
  * 3-axis magnetometer driver support following SPI Bosch-Sensortec chips:
  *  - BMC150
  *  - BMC156
+ *  - BMM150
  *
  * Copyright (c) 2016, Intel Corporation.
  *
@@ -41,6 +42,7 @@ static int bmc150_magn_spi_remove(struct spi_device *spi)
 static const struct spi_device_id bmc150_magn_spi_id[] = {
 	{"bmc150_magn", 0},
 	{"bmc156_magn", 0},
+	{"bmm150_magn", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
@@ -48,6 +50,7 @@ MODULE_DEVICE_TABLE(spi, bmc150_magn_spi_id);
 static const struct acpi_device_id bmc150_magn_acpi_match[] = {
 	{"BMC150B", 0},
 	{"BMC156B", 0},
+	{"BMM150B", 0},
 	{},
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_magn_acpi_match);
-- 
2.5.0

