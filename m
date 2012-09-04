Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-217.synserver.de ([212.40.185.217]:1511 "EHLO
	smtp-out-217.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756622Ab2IDJFf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Sep 2012 05:05:35 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/2] iio:ad5446: Add device ids for ad5301/ad5311/ad5321
Date: Tue,  4 Sep 2012 11:10:16 +0200
Message-Id: <1346749816-22877-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1346749816-22877-1-git-send-email-lars@metafoo.de>
References: <1346749816-22877-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ad5301/ad5311/ad5321 are software compatible to the ad5602/ad5612/ad5622.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/Kconfig  |    8 ++++----
 drivers/iio/dac/ad5446.c |    3 +++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 7599d62..7845263 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -59,10 +59,10 @@ config AD5446
 	tristate "Analog Devices AD5446 and similar single channel DACs driver"
 	depends on (SPI_MASTER || I2C)
 	help
-	  Say yes here to build support for Analog Devices AD5300, AD5310, AD5320,
-	  AD5444, AD5446, AD5450, AD5451, AD5452, AD5453, AD5512A, AD5541A, AD5542A,
-	  AD5543, AD5553, AD5601, AD5602, AD5611, AD5612, AD5620, AD5621, AD5622,
-	  AD5640, AD5660, AD5662 DACs.
+	  Say yes here to build support for Analog Devices AD5300, AD5301, AD5310,
+	  AD5311, AD5320, AD5321, AD5444, AD5446, AD5450, AD5451, AD5452, AD5453,
+	  AD5512A, AD5541A, AD5542A, AD5543, AD5553, AD5601, AD5602, AD5611, AD5612,
+	  AD5620, AD5621, AD5622, AD5640, AD5660, AD5662 DACs.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad5446.
diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 2b0968f..3310cbb 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -552,6 +552,9 @@ static int __devexit ad5446_i2c_remove(struct i2c_client *i2c)
 }
 
 static const struct i2c_device_id ad5446_i2c_ids[] = {
+	{"ad5301", ID_AD5602},
+	{"ad5311", ID_AD5612},
+	{"ad5321", ID_AD5622},
 	{"ad5602", ID_AD5602},
 	{"ad5612", ID_AD5612},
 	{"ad5622", ID_AD5622},
-- 
1.7.10.4

