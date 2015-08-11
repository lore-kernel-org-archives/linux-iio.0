Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:33183 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965005AbbHKOcT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Aug 2015 10:32:19 -0400
Received: by wijp15 with SMTP id p15so179072723wij.0
        for <linux-iio@vger.kernel.org>; Tue, 11 Aug 2015 07:32:18 -0700 (PDT)
From: Crt Mori <cmo@melexis.com>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Subject: [PATCH] iio: base: Adding flags to regmap_i2c
Date: Tue, 11 Aug 2015 16:32:04 +0200
Message-Id: <1439303524-30801-1-git-send-email-cmo@melexis.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Providing access to i2c flags within regmap i2c functions.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 drivers/base/regmap/regmap-i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-i2c.c b/drivers/base/regmap/regmap-i2c.c
index fa6bf52..33e5229 100644
--- a/drivers/base/regmap/regmap-i2c.c
+++ b/drivers/base/regmap/regmap-i2c.c
@@ -46,12 +46,12 @@ static int regmap_i2c_gather_write(void *context,
 		return -ENOTSUPP;
 
 	xfer[0].addr = i2c->addr;
-	xfer[0].flags = 0;
+	xfer[0].flags = i2c->flags;
 	xfer[0].len = reg_size;
 	xfer[0].buf = (void *)reg;
 
 	xfer[1].addr = i2c->addr;
-	xfer[1].flags = I2C_M_NOSTART;
+	xfer[1].flags = i2c->flags | I2C_M_NOSTART;
 	xfer[1].len = val_size;
 	xfer[1].buf = (void *)val;
 
@@ -74,12 +74,12 @@ static int regmap_i2c_read(void *context,
 	int ret;
 
 	xfer[0].addr = i2c->addr;
-	xfer[0].flags = 0;
+	xfer[0].flags = i2c->flags;
 	xfer[0].len = reg_size;
 	xfer[0].buf = (void *)reg;
 
 	xfer[1].addr = i2c->addr;
-	xfer[1].flags = I2C_M_RD;
+	xfer[1].flags = i2c->flags | I2C_M_RD;
 	xfer[1].len = val_size;
 	xfer[1].buf = val;
 
-- 
2.1.4

