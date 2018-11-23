Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38660 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbeKXKiV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Nov 2018 05:38:21 -0500
Date: Fri, 23 Nov 2018 21:51:59 -0200
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad5933: finalized device-tree support
Message-ID: <20181123235159.hh43xnvvwsil4on2@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added a of_device_id struct variable and subsequent call to
MODULE_DEVICE_TABLE macro to complete device-tree support for this
driver.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index edb8b540bbf1..19e8b6d2865c 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -771,9 +771,18 @@ static const struct i2c_device_id ad5933_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, ad5933_id);
 
+static const struct of_device_id ad5933_of_match[] = {
+	{ .compatible = "analog-devices,ad5933" },
+	{ .compatible = "analog-devices,ad5934" },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(of, ad5933_of_match);
+
 static struct i2c_driver ad5933_driver = {
 	.driver = {
 		.name = "ad5933",
+		.of_match_table = ad5933_of_match,
 	},
 	.probe = ad5933_probe,
 	.remove = ad5933_remove,
-- 
2.17.1
