Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: dds: ad9832: Fix kconfig description
Date: Wed, 1 Dec 2010 17:34:39 +0100
Message-ID: <1291221279-24985-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

The AD9832 driver doesn't support the AD9833 and AD9834

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dds/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/dds/Kconfig b/drivers/staging/iio/dds/Kconfig
index d045ed6..7969be2 100644
--- a/drivers/staging/iio/dds/Kconfig
+++ b/drivers/staging/iio/dds/Kconfig
@@ -11,11 +11,11 @@ config AD5930
 	  ad5930/ad5932, provides direct access via sysfs.

 config AD9832
-	tristate "Analog Devices ad9832/3/4/5 driver"
+	tristate "Analog Devices ad9832/5 driver"
 	depends on SPI
 	help
 	  Say yes here to build support for Analog Devices DDS chip
-	  ad9832/3/4/5, provides direct access via sysfs.
+	  ad9832 and ad9835, provides direct access via sysfs.

 config AD9850
 	tristate "Analog Devices ad9850/1 driver"
--
1.6.0.2
