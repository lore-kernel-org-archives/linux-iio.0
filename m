Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37269 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbeEOOdE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 May 2018 10:33:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id l1-v6so1565461wmb.2
        for <linux-iio@vger.kernel.org>; Tue, 15 May 2018 07:33:03 -0700 (PDT)
Message-ID: <1526394782.32235.3.camel@gmail.com>
Subject: [PATCH] iio: dac: fix missing of_match_table assignment in LTC2632
 device
From: Silvan Murer <silvan.murer@gmail.com>
To: lars@metafoo.de
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Date: Tue, 15 May 2018 16:33:02 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fix a missing og_match_table assignment in the LTC2632 device

Signed-off-by: Silvan Murer <silvan.murer@gmail.com>
---
 drivers/iio/dac/ltc2632.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index ac5e05f..d322b78 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -276,15 +276,6 @@ static const struct spi_device_id ltc2632_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ltc2632_id);
 
-static struct spi_driver ltc2632_driver = {
-	.driver		= {
-		.name	= "ltc2632",
-	},
-	.probe		= ltc2632_probe,
-	.id_table	= ltc2632_id,
-};
-module_spi_driver(ltc2632_driver);
-
 static const struct of_device_id ltc2632_of_match[] = {
 	{
 		.compatible = "lltc,ltc2632-l12",
@@ -309,6 +300,16 @@ static const struct of_device_id ltc2632_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ltc2632_of_match);
 
+static struct spi_driver ltc2632_driver = {
+	.driver		= {
+		.name	= "ltc2632",
+		.of_match_table = of_match_ptr(ltc2632_of_match),
+	},
+	.probe		= ltc2632_probe,
+	.id_table	= ltc2632_id,
+};
+module_spi_driver(ltc2632_driver);
+
 MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>");
 MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4
