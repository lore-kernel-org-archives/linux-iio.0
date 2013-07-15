Return-Path: <otavio.salvador@gmail.com>
Sender: Otavio Salvador <otavio.salvador@gmail.com>
From: Otavio Salvador <otavio@ossystems.com.br>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: Otavio Salvador <otavio@ossystems.com.br>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	linux-iio@vger.kernel.org
Subject: [PATCH 5/5] iio: add configuration option for debug support
Date: Mon, 15 Jul 2013 11:22:40 -0300
Message-Id: <1373898160-8460-5-git-send-email-otavio@ossystems.com.br>
In-Reply-To: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
References: <1373898160-8460-1-git-send-email-otavio@ossystems.com.br>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
 drivers/iio/Kconfig  | 7 +++++++
 drivers/iio/Makefile | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 9af763a..d1f06f2 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -12,6 +12,13 @@ menuconfig IIO
 
 if IIO
 
+config IIO_DEBUG
+	boolean "Debug support for Industrial I/O"
+	depends on DEBUG_KERNEL
+	help
+	  Say "yes" to enable debug messaging (like dev_dbg and pr_debug),
+	  sysfs, and debugfs support in Industrial I/O subsystem and drivers.
+
 config IIO_BUFFER
 	bool "Enable buffer support within IIO"
 	help
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 7a3866c..6e43e5b 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the industrial I/O core.
 #
 
+ccflags-$(CONFIG_IIO_DEBUG) := -DDEBUG
+
 obj-$(CONFIG_IIO) += industrialio.o
 industrialio-y := industrialio-core.o industrialio-event.o inkern.o
 industrialio-$(CONFIG_IIO_BUFFER) += industrialio-buffer.o
-- 
1.8.3.2
