Return-Path: <Cliff.Cai@analog.com>
From: Cliff Cai <cliff.cai@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/3] IIO: GYRO: IIO driver for Analog Devices Digital Output Gyroscope ADXRS450
Date: Wed, 6 Apr 2011 10:39:20 +0200
Message-ID: <1302079160-2881-3-git-send-email-cliff.cai@analog.com>
In-Reply-To: <1302079160-2881-1-git-send-email-cliff.cai@analog.com>
References: <1302079160-2881-1-git-send-email-cliff.cai@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add new IIO driver for Analog Devices digital output gyroscope ADXRS450

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/Kconfig  |   10 ++++++++++
 drivers/staging/iio/gyro/Makefile |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index 8b78fa0..ae2e7d3 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -35,3 +35,13 @@ config ADIS16260

 	  This driver can also be built as a module.  If so, the module
 	  will be called adis16260.
+
+config ADXRS450
+	tristate "Analog Devices ADXRS450 Digital Output Gyroscope SPI driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices ADXRS450 programmable
+	  digital output gyroscope.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called adxrs450.
diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 2764c15..2212240 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -17,3 +17,6 @@ obj-$(CONFIG_ADIS16260) += adis16260.o

 adis16251-y             := adis16251_core.o
 obj-$(CONFIG_ADIS16251) += adis16251.o
+
+adxrs450-y             := adxrs450_core.o
+obj-$(CONFIG_ADXRS450) += adxrs450.o
--
1.6.0.2
