Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:61838 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752867AbbBLVAa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Feb 2015 16:00:30 -0500
Received: by mail-wg0-f41.google.com with SMTP id b13so12816084wgh.0
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2015 13:00:29 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com, octavian.purdila@intel.com,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 1/2] iio: light: jsa1212: Select REGMAP_I2C
Date: Thu, 12 Feb 2015 23:00:14 +0200
Message-Id: <1423774815-26816-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds missing 'select' statement for jsa1212 driver.
Without regmap_i2c, we get the following error when loading the module:
Unknown symbol devm_regmap_init_i2c.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index ae68c64..e0ed374 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -126,6 +126,7 @@ config HID_SENSOR_PROX
 config JSA1212
 	tristate "JSA1212 ALS and proximity sensor driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	 Say Y here if you want to build a IIO driver for JSA1212
 	 proximity & ALS sensor device.
-- 
1.9.1

