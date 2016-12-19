Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0068.outbound.protection.outlook.com ([104.47.37.68]:13661
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752073AbcLSMm6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Dec 2016 07:42:58 -0500
From: <michael.hennerich@analog.com>
To: <linux-iio@vger.kernel.org>, <jic23@kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/2] iio: dac: ad5593r: Add ACPI support
Date: Mon, 19 Dec 2016 13:10:39 +0100
Message-ID: <1482149439-16327-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1482149439-16327-1-git-send-email-michael.hennerich@analog.com>
References: <1482149439-16327-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

This patch adds the ACPI/PNP ID. The AD5592/3 driver core is already
designed around the unified device property API.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/dac/ad5593r.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/dac/ad5593r.c b/drivers/iio/dac/ad5593r.c
index dca158a..fc11ea0 100644
--- a/drivers/iio/dac/ad5593r.c
+++ b/drivers/iio/dac/ad5593r.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/acpi.h>
 
 #define AD5593R_MODE_CONF		(0 << 4)
 #define AD5593R_MODE_DAC_WRITE		(1 << 4)
@@ -115,10 +116,17 @@ static const struct of_device_id ad5593r_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ad5593r_of_match);
 
+static const struct acpi_device_id ad5593r_acpi_match[] = {
+	{"ADS5593", },
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ad5593r_acpi_match);
+
 static struct i2c_driver ad5593r_driver = {
 	.driver = {
 		.name = "ad5593r",
 		.of_match_table = of_match_ptr(ad5593r_of_match),
+		.acpi_match_table = ACPI_PTR(ad5593r_acpi_match),
 	},
 	.probe = ad5593r_i2c_probe,
 	.remove = ad5593r_i2c_remove,
-- 
2.7.4

