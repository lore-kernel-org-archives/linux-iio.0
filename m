Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] staging:iio: move kconfig symbol from IIO to IIO_ST to make space.
Date: Mon,  7 Nov 2011 14:31:28 +0000
Message-Id: <1320676288-11395-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1320676288-11395-1-git-send-email-jic23@kernel.org>
References: <1320676288-11395-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/Makefile     |    2 +-
 drivers/staging/iio/Kconfig  |    6 +++---
 drivers/staging/iio/Makefile |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index 936b7c2..22c3074 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_VT6656)		+= vt6656/
 obj-$(CONFIG_HYPERV)		+= hv/
 obj-$(CONFIG_VME_BUS)		+= vme/
 obj-$(CONFIG_DX_SEP)            += sep/
-obj-$(CONFIG_IIO)		+= iio/
+obj-$(CONFIG_IIO_ST)		+= iio/
 obj-$(CONFIG_ZRAM)		+= zram/
 obj-$(CONFIG_XVMALLOC)		+= zram/
 obj-$(CONFIG_ZCACHE)		+= zcache/
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 4ec9118..064dd78 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -2,7 +2,7 @@
 # Industrial I/O subsytem configuration
 #
 
-menuconfig IIO
+menuconfig IIO_ST
 	tristate "Industrial I/O support"
 	depends on GENERIC_HARDIRQS
 	help
@@ -10,7 +10,7 @@ menuconfig IIO
 	  drivers for many different types of embedded sensors using a
 	  number of different physical interfaces (i2c, spi, etc). See
 	  drivers/staging/iio/Documentation for more information.
-if IIO
+if IIO_ST
 
 config IIO_BUFFER
 	bool "Enable buffer support within IIO"
@@ -98,4 +98,4 @@ config IIO_SIMPLE_DUMMY_BUFFER
 
 endif # IIO_SIMPLE_DUMMY
 
-endif # IIO
+endif # IIO_ST
diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
index 1340aea..ad783e0 100644
--- a/drivers/staging/iio/Makefile
+++ b/drivers/staging/iio/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the industrial I/O core.
 #
 
-obj-$(CONFIG_IIO) += industrialio.o
+obj-$(CONFIG_IIO_ST) += industrialio.o
 industrialio-y := industrialio-core.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
 industrialio-$(CONFIG_IIO_TRIGGER) += industrialio-trigger.o
-- 
1.7.7.2
