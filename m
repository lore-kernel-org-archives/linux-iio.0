Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32779 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeKQJJ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Nov 2018 04:09:59 -0500
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] Staging: iio: adt7316: Add of_device_id table
Date: Sat, 17 Nov 2018 04:25:37 +0530
Message-Id: <20181116225537.24723-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When the kernel starts up, it kicks off compiled-in drivers
that match “compatible” entries it finds in the device tree.
At a later stage (when /lib/modules is available), all kernel modules
that match “compatible” entries in the device tree are loaded.
Hence to be able to use device tree for ADT7316, add of_device_id
table which specifies the supported devices through compatible
property.
Note that there is a fall back path in i2c that will result
in i2c_device_id table being used if there is no of_devcie_id table.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 473e5e34ec00..d4b5060c18ee 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -126,6 +126,18 @@ static const struct i2c_device_id adt7316_i2c_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, adt7316_i2c_id);
 
+static const struct of_device_id adt7316_of_match[] = {
+	{ .compatible = "adi,adt7316" },
+	{ .compatible = "adi,adt7317" },
+	{ .compatible = "adi,adt7318" },
+	{ .compatible = "adi,adt7516" },
+	{ .compatible = "adi,adt7517" },
+	{ .compatible = "adi,adt7519" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, adt7316_of_match);
+
 static struct i2c_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
-- 
2.17.1
