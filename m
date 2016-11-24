Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:40069 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933142AbcKXJIY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2016 04:08:24 -0500
From: Shrirang Bagul <shrirang.bagul@canonical.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lorenzo.bianconi83@gmail.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shrirang Bagul <shrirang.bagul@canonical.com>
Subject: [PATCH] iio: humidity: Support acpi probe for hts211
Date: Thu, 24 Nov 2016 17:07:54 +0800
Message-Id: <20161124090754.20427-1-shrirang.bagul@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Support driver probe by reading unique HID on systems based on ACPI instead
of DT compatible strings.

Signed-off-by: Shrirang Bagul <shrirang.bagul@canonical.com>
---
 drivers/iio/humidity/hts221_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 367ecd5..8333c02 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -10,6 +10,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/acpi.h>
 #include <linux/i2c.h>
 #include <linux/slab.h>
 #include "hts221.h"
@@ -83,6 +84,12 @@ static int hts221_i2c_probe(struct i2c_client *client,
 	return hts221_probe(iio_dev);
 }
 
+static const struct acpi_device_id hts221_acpi_match[] = {
+	{"SMO9100", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, hts221_acpi_match);
+
 static const struct of_device_id hts221_i2c_of_match[] = {
 	{ .compatible = "st,hts221", },
 	{},
@@ -99,6 +106,7 @@ static struct i2c_driver hts221_driver = {
 	.driver = {
 		.name = "hts221_i2c",
 		.of_match_table = of_match_ptr(hts221_i2c_of_match),
+		.acpi_match_table = ACPI_PTR(hts221_acpi_match),
 	},
 	.probe = hts221_i2c_probe,
 	.id_table = hts221_i2c_id_table,
-- 
2.9.3

