Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:58458 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751956AbdGFW4g (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Jul 2017 18:56:36 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v2 1/9] staging: iio: tsl2x7x: add of_match table for device tree support
Date: Thu,  6 Jul 2017 18:56:18 -0400
Message-Id: <20170706225626.6716-2-masneyb@onstation.org>
In-Reply-To: <20170706225626.6716-1-masneyb@onstation.org>
References: <20170706225626.6716-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add device tree support for the tsl2x7x IIO driver with no custom
properties. The device tree documentation is in a separate commit so
that the changes to trivial-devices.txt can go in via the device
tree subsystem.

Signed-off-by: Brian Masney <masneyb@onstation.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
---
 drivers/staging/iio/light/tsl2x7x.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 1467199..8148986 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -2026,6 +2026,21 @@ static struct i2c_device_id tsl2x7x_idtable[] = {
 
 MODULE_DEVICE_TABLE(i2c, tsl2x7x_idtable);
 
+static const struct of_device_id tsl2x7x_of_match[] = {
+	{ .compatible = "amstaos,tsl2571" },
+	{ .compatible = "amstaos,tsl2671" },
+	{ .compatible = "amstaos,tmd2671" },
+	{ .compatible = "amstaos,tsl2771" },
+	{ .compatible = "amstaos,tmd2771" },
+	{ .compatible = "amstaos,tsl2572" },
+	{ .compatible = "amstaos,tsl2672" },
+	{ .compatible = "amstaos,tmd2672" },
+	{ .compatible = "amstaos,tsl2772" },
+	{ .compatible = "amstaos,tmd2772" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tsl2x7x_of_match);
+
 static const struct dev_pm_ops tsl2x7x_pm_ops = {
 	.suspend = tsl2x7x_suspend,
 	.resume  = tsl2x7x_resume,
@@ -2035,6 +2050,7 @@ static const struct dev_pm_ops tsl2x7x_pm_ops = {
 static struct i2c_driver tsl2x7x_driver = {
 	.driver = {
 		.name = "tsl2x7x",
+		.of_match_table = tsl2x7x_of_match,
 		.pm = &tsl2x7x_pm_ops,
 	},
 	.id_table = tsl2x7x_idtable,
-- 
2.9.4

