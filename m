Return-Path: <SRS0=wIp7=35=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: pressure: Fix name of BME280 part in Kconfig
Date: Fri, 21 Apr 2017 22:58:36 +0200
Message-Id: <20170421205836.19144-1-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Bosch BME280 is a combined pressure and humidity sensor

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/iio/pressure/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index 5d16b252ab6b..eaa7cfcb4c2a 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -23,7 +23,7 @@ config BMP280
 	select BMP280_SPI if (SPI_MASTER)
 	help
 	  Say yes here to build support for Bosch Sensortec BMP180 and BMP280
-	  pressure and temperature sensors. Also supports the BE280 with
+	  pressure and temperature sensors. Also supports the BME280 with
 	  an additional humidity sensor channel.
 
 	  To compile this driver as a module, choose M here: the core module
-- 
2.11.0
