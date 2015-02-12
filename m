Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f178.google.com ([74.125.82.178]:39962 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbBLVAb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 12 Feb 2015 16:00:31 -0500
Received: by mail-we0-f178.google.com with SMTP id w62so12654583wes.9
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2015 13:00:30 -0800 (PST)
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com, octavian.purdila@intel.com,
	jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 2/2] iio: light: gp2ap020a00f: Select REGMAP_I2C
Date: Thu, 12 Feb 2015 23:00:15 +0200
Message-Id: <1423774815-26816-3-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds missing 'select' statement for gp2ap020a00f driver.
Without regmap_i2c, we get the following error when loading the module:
Unknown symbol devm_regmap_init_i2c.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index e0ed374..a224afd 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -73,6 +73,7 @@ config CM36651
 config GP2AP020A00F
 	tristate "Sharp GP2AP020A00F Proximity/ALS sensor"
 	depends on I2C
+	select REGMAP_I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select IRQ_WORK
-- 
1.9.1

