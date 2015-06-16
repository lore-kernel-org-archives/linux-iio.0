Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: pressure: Fix Measurement Specialties vendor name
Date: Tue, 16 Jun 2015 21:27:03 +0200
Message-Id: <1434482823-24065-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/pressure/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index fa62950..b13ea6f 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -53,9 +53,9 @@ config MPL3115
           will be called mpl3115.
 
 config MS5611
-	tristate "Measurement Specialities MS5611 pressure sensor driver"
+	tristate "Measurement Specialties MS5611 pressure sensor driver"
 	help
-	  Say Y here to build support for the Measurement Specialities
+	  Say Y here to build support for the Measurement Specialties
 	  MS5611 pressure and temperature sensor.
 
 	  To compile this driver as a module, choose M here: the module will
-- 
1.9.1
