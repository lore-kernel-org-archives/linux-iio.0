Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34186 "EHLO
	mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753244AbcGYSuP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 14:50:15 -0400
Date: Mon, 25 Jul 2016 11:50:12 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: humidity: hdc100x: add HDC1000 and HDC1008 to Kconfig
Message-ID: <20160725185001.GA5322@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

hdc100x supports Texas Instruments HDC1000 and HDC1008 relative
humidity and temperature sensors. Add these product names to
Kconfig.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
Changes in v2:
 - removed names from i2c_device_id struct. (keep as hdc100x only)
 - updated commit msg and changelog

drivers/iio/humidity/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 738a86d..f155386 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -26,11 +26,11 @@ config HDC100X
 	tristate "TI HDC100x relative humidity and temperature sensor"
 	depends on I2C
 	help
-	 Say yes here to build support for the TI HDC100x series of
-	 relative humidity and temperature sensors.
+	  Say yes here to build support for the Texas Instruments
+	  HDC1000 and HDC1008 relative humidity and temperature sensors.
 
-	 To compile this driver as a module, choose M here: the module
-	 will be called hdc100x.
+	  To compile this driver as a module, choose M here: the module
+	  will be called hdc100x.
 
 config HTU21
 	tristate "Measurement Specialties HTU21 humidity & temperature sensor"
-- 
2.1.4

