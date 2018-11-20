Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43826 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeKUDWo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2018 22:22:44 -0500
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] Staging: iio: adt7316: Add of_device_id table
Date: Tue, 20 Nov 2018 22:22:30 +0530
Message-Id: <20181120165230.7079-1-shreeya.patel23498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When the kernel starts up, it kicks off compiled-in drivers
that match “compatible” entries it finds in the device tree.
At a later stage (when /lib/modules is available), all kernel modules
that match “compatible” entries in the device tree are loaded.

But if there is no dt table then there should be a fall back path
with which desired kernel modules can be loaded. Hence, add
of_device_id table in the i2c driver to be able to use when there
is no dt table.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v2:
  - Make the commit message appropriate and assign of_match_table
in the driver structure.

 drivers/staging/iio/addac/adt7316-i2c.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 473e5e34ec00..41bc4ca008bc 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -126,9 +126,22 @@ static const struct i2c_device_id adt7316_i2c_id[] = {
 
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
+		.of_match_table = adt7316_of_match,
 		.pm = ADT7316_PM_OPS,
 	},
 	.probe = adt7316_i2c_probe,
-- 
2.17.1
