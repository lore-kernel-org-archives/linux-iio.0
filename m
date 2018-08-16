Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45562 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeHPVwD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2018 17:52:03 -0400
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jic23@kernel.org
Subject: [PATCH] iio: pressure: ms5611: remove deprecated compatible strings
Date: Thu, 16 Aug 2018 20:49:15 +0200
Message-Id: <20180816184915.32138-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Compatible strings tend to follow manufacturer,model format.
In case one wants to do a matching with manufacturer stripped
off he can still do so since SPI/I2C core will try id_table
based matching anyway.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611_i2c.c | 2 --
 drivers/iio/pressure/ms5611_spi.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 55fb5fc0b6ea..0469c8ae1134 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -117,9 +117,7 @@ static int ms5611_i2c_remove(struct i2c_client *client)
 #if defined(CONFIG_OF)
 static const struct of_device_id ms5611_i2c_matches[] = {
 	{ .compatible = "meas,ms5611" },
-	{ .compatible = "ms5611" },
 	{ .compatible = "meas,ms5607" },
-	{ .compatible = "ms5607" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ms5611_i2c_matches);
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index 932e05001e1a..cd11d022208e 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -119,9 +119,7 @@ static int ms5611_spi_remove(struct spi_device *spi)
 #if defined(CONFIG_OF)
 static const struct of_device_id ms5611_spi_matches[] = {
 	{ .compatible = "meas,ms5611" },
-	{ .compatible = "ms5611" },
 	{ .compatible = "meas,ms5607" },
-	{ .compatible = "ms5607" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ms5611_spi_matches);
-- 
2.18.0
