Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-va3.bigfish.com ([216.32.180.10]:47953 "EHLO
	VA3EHSOBE010.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751318Ab1KVMoT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Nov 2011 07:44:19 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio: Remove redundant spi driver bus initialization
Date: Tue, 22 Nov 2011 13:39:47 +0100
Message-ID: <1321965587-21234-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In ancient times it was necessary to manually initialize the bus field of a
spi_driver to spi_bus_type. These days this is done in spi_register_driver() so
we can drop the manual assignment.

The patch was generated using the following coccinelle semantic patch:
// <smpl>
@@
identifier _driver;
@@
 struct spi_driver _driver = {
 	.driver = {
-		.bus = &spi_bus_type,
 	},
 };
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7280a.c       |    1 -
 drivers/staging/iio/adc/ad7298_core.c   |    1 -
 drivers/staging/iio/adc/ad7476_core.c   |    1 -
 drivers/staging/iio/adc/ad7606_spi.c    |    1 -
 drivers/staging/iio/adc/ad7780.c        |    1 -
 drivers/staging/iio/adc/ad7793.c        |    1 -
 drivers/staging/iio/adc/ad7816.c        |    1 -
 drivers/staging/iio/adc/ad7887_core.c   |    1 -
 drivers/staging/iio/adc/adt7310.c       |    1 -
 drivers/staging/iio/addac/adt7316-spi.c |    1 -
 drivers/staging/iio/dac/ad5446.c        |    1 -
 drivers/staging/iio/dds/ad9832.c        |    1 -
 drivers/staging/iio/dds/ad9834.c        |    1 -
 13 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 1af4194..80cbdcf 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -975,7 +975,6 @@ MODULE_DEVICE_TABLE(spi, ad7280_id);
 static struct spi_driver ad7280_driver = {
 	.driver = {
 		.name	= "ad7280",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7280_probe,
diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
index 093b2b2..4df0b99 100644
--- a/drivers/staging/iio/adc/ad7298_core.c
+++ b/drivers/staging/iio/adc/ad7298_core.c
@@ -275,7 +275,6 @@ MODULE_DEVICE_TABLE(spi, ad7298_id);
 static struct spi_driver ad7298_driver = {
 	.driver = {
 		.name	= "ad7298",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7298_probe,
diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index 93b2bef..a42dd19 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(spi, ad7476_id);
 static struct spi_driver ad7476_driver = {
 	.driver = {
 		.name	= "ad7476",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7476_probe,
diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
index c88d97a..98e6e49 100644
--- a/drivers/staging/iio/adc/ad7606_spi.c
+++ b/drivers/staging/iio/adc/ad7606_spi.c
@@ -102,7 +102,6 @@ MODULE_DEVICE_TABLE(spi, ad7606_id);
 static struct spi_driver ad7606_driver = {
 	.driver = {
 		.name = "ad7606",
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 		.pm    = AD7606_SPI_PM_OPS,
 	},
diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index 635c7ba..5665dee 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -277,7 +277,6 @@ MODULE_DEVICE_TABLE(spi, ad7780_id);
 static struct spi_driver ad7780_driver = {
 	.driver = {
 		.name	= "ad7780",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7780_probe,
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 362cc31..a70e53a 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -1041,7 +1041,6 @@ MODULE_DEVICE_TABLE(spi, ad7793_id);
 static struct spi_driver ad7793_driver = {
 	.driver = {
 		.name	= "ad7793",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7793_probe,
diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 7a344a2..a38a1a9 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -460,7 +460,6 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
 static struct spi_driver ad7816_driver = {
 	.driver = {
 		.name = "ad7816",
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 	.probe = ad7816_probe,
diff --git a/drivers/staging/iio/adc/ad7887_core.c b/drivers/staging/iio/adc/ad7887_core.c
index 8f48659..ab7a5a2 100644
--- a/drivers/staging/iio/adc/ad7887_core.c
+++ b/drivers/staging/iio/adc/ad7887_core.c
@@ -251,7 +251,6 @@ MODULE_DEVICE_TABLE(spi, ad7887_id);
 static struct spi_driver ad7887_driver = {
 	.driver = {
 		.name	= "ad7887",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad7887_probe,
diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index c937ac1..ea9fd43 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -877,7 +877,6 @@ MODULE_DEVICE_TABLE(spi, adt7310_id);
 static struct spi_driver adt7310_driver = {
 	.driver = {
 		.name = "adt7310",
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 	.probe = adt7310_probe,
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 369d4d0..1f75e1b 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -151,7 +151,6 @@ static int adt7316_spi_resume(struct spi_device *spi_dev)
 static struct spi_driver adt7316_driver = {
 	.driver = {
 		.name = "adt7316",
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 	.probe = adt7316_spi_probe,
diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index ef1ad11..f9bcb63 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -446,7 +446,6 @@ MODULE_DEVICE_TABLE(spi, ad5446_id);
 static struct spi_driver ad5446_driver = {
 	.driver = {
 		.name	= "ad5446",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad5446_probe,
diff --git a/drivers/staging/iio/dds/ad9832.c b/drivers/staging/iio/dds/ad9832.c
index 1c87820..d612d3d 100644
--- a/drivers/staging/iio/dds/ad9832.c
+++ b/drivers/staging/iio/dds/ad9832.c
@@ -349,7 +349,6 @@ MODULE_DEVICE_TABLE(spi, ad9832_id);
 static struct spi_driver ad9832_driver = {
 	.driver = {
 		.name	= "ad9832",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9832_probe,
diff --git a/drivers/staging/iio/dds/ad9834.c b/drivers/staging/iio/dds/ad9834.c
index cd10479..59a2813 100644
--- a/drivers/staging/iio/dds/ad9834.c
+++ b/drivers/staging/iio/dds/ad9834.c
@@ -440,7 +440,6 @@ MODULE_DEVICE_TABLE(spi, ad9834_id);
 static struct spi_driver ad9834_driver = {
 	.driver = {
 		.name	= "ad9834",
-		.bus	= &spi_bus_type,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= ad9834_probe,
-- 
1.7.7.1


