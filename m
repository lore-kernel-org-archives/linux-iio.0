Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34728 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbdHBLkr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2017 07:40:47 -0400
Received: by mail-wr0-f195.google.com with SMTP id o33so3459517wrb.1
        for <linux-iio@vger.kernel.org>; Wed, 02 Aug 2017 04:40:47 -0700 (PDT)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, daniel.baluta@gmail.com, amsfield22@gmail.com
Cc: linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH] iio: chemical: ccs811: Add ACPI support
Date: Wed,  2 Aug 2017 14:40:36 +0300
Message-Id: <1501674036-24605-1-git-send-email-narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ACPI ID to enable ACPI support.

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Alison Schofield <amsfield22@gmail.com>
Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
This patch depends on "iio: chemical: ccs811: Add triggered buffer support"

Note: The ACPI ID is not yet registered at
http://www.uefi.org/PNP_ACPI_Registry. This vendor doesn't have a
registered ID yet.

 drivers/iio/chemical/ccs811.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 8dbb5ed..8a4160e 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -18,6 +18,7 @@
  * 4. Read error register and put the information in logs
  */

+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
@@ -324,9 +325,16 @@ static int ccs811_remove(struct i2c_client *client)
 };
 MODULE_DEVICE_TABLE(i2c, ccs811_id);

+static const struct acpi_device_id ccs811_acpi_match[] = {
+	{"CCS0811", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ccs811_acpi_match);
+
 static struct i2c_driver ccs811_driver = {
 	.driver = {
 		.name = "ccs811",
+		.acpi_match_table = ACPI_PTR(ccs811_acpi_match),
 	},
 	.probe = ccs811_probe,
 	.remove = ccs811_remove,
--
1.9.1

