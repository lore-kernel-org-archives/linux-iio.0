Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21431 "EHLO
        sender-of-o52.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKUAa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Sep 2018 16:00:30 -0400
From: Afonso Bordado <afonsobordado@az8.co>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 2/5] iio: gyro: add device tree support for fxas21002c
Date: Tue, 11 Sep 2018 16:00:08 +0100
Message-Id: <20180911150011.31964-2-afonsobordado@az8.co>
In-Reply-To: <20180911150011.31964-1-afonsobordado@az8.co>
References: <20180911150011.31964-1-afonsobordado@az8.co>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds device tree support for the fxas21002c driver.

Signed-off-by: Afonso Bordado <afonsobordado@az8.co>
---
 drivers/iio/gyro/fxas21002c.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
index 649316c26f5b..e2ce0622944b 100644
--- a/drivers/iio/gyro/fxas21002c.c
+++ b/drivers/iio/gyro/fxas21002c.c
@@ -8,7 +8,6 @@
  * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
  * TODO:
  *        ODR / Scale Support
- *        Devicetree
  *        Scale Boost Mode
  *        Power management
  *        GPIO Reset
@@ -357,6 +356,12 @@ static int fxas21002c_probe(struct i2c_client *client,
 	return ret;
 }
 
+static const struct of_device_id fxas21002c_of_ids[] = {
+	{.compatible = "fsl,fxas21002c"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, fxas21002c_of_ids);
+
 static const struct i2c_device_id fxas21002c_id[] = {
 	{"fxas21002c", ID_FXAS21002C},
 	{}
@@ -366,6 +371,7 @@ MODULE_DEVICE_TABLE(i2c, fxas21002c_id);
 static struct i2c_driver fxas21002c_driver = {
 	.driver = {
 		.name = FXAS21002C_DRV_NAME,
+		.of_match_table = fxas21002c_of_ids,
 	},
 	.probe		= fxas21002c_probe,
 	.id_table	= fxas21002c_id,
-- 
2.18.0
