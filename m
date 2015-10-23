Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59954 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751846AbbJWN7V (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 23 Oct 2015 09:59:21 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Mark Brown <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <alsa-devel@alsa-project.org>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	"Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/2] spi: Add THIS_MODULE to spi_driver in SPI core
Date: Fri, 23 Oct 2015 08:59:10 -0500
Message-ID: <1445608751-8432-2-git-send-email-afd@ti.com>
In-Reply-To: <1445608751-8432-1-git-send-email-afd@ti.com>
References: <1445608751-8432-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add spi_register_driver helper macro that adds THIS_MODULE to
spi_driver for the registering driver. We rename and modify
the existing spi_register_driver to enable this.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/spi/spi.c       | 7 ++++---
 include/linux/spi/spi.h | 6 +++++-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 3abb390..51e33db 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -305,12 +305,13 @@ static void spi_drv_shutdown(struct device *dev)
 }
 
 /**
- * spi_register_driver - register a SPI driver
+ * __spi_register_driver - register a SPI driver
  * @sdrv: the driver to register
  * Context: can sleep
  */
-int spi_register_driver(struct spi_driver *sdrv)
+int __spi_register_driver(struct module *owner, struct spi_driver *sdrv)
 {
+	sdrv->driver.owner = owner;
 	sdrv->driver.bus = &spi_bus_type;
 	if (sdrv->probe)
 		sdrv->driver.probe = spi_drv_probe;
@@ -320,7 +321,7 @@ int spi_register_driver(struct spi_driver *sdrv)
 		sdrv->driver.shutdown = spi_drv_shutdown;
 	return driver_register(&sdrv->driver);
 }
-EXPORT_SYMBOL_GPL(spi_register_driver);
+EXPORT_SYMBOL_GPL(__spi_register_driver);
 
 /*-------------------------------------------------------------------------*/
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 269e8af..e2da17b 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -250,7 +250,7 @@ static inline struct spi_driver *to_spi_driver(struct device_driver *drv)
 	return drv ? container_of(drv, struct spi_driver, driver) : NULL;
 }
 
-extern int spi_register_driver(struct spi_driver *sdrv);
+extern int __spi_register_driver(struct module *owner, struct spi_driver *sdrv);
 
 /**
  * spi_unregister_driver - reverse effect of spi_register_driver
@@ -263,6 +263,10 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 		driver_unregister(&sdrv->driver);
 }
 
+/* use a define to avoid include chaining to get THIS_MODULE */
+#define spi_register_driver(driver) \
+	__spi_register_driver(THIS_MODULE, driver)
+
 /**
  * module_spi_driver() - Helper macro for registering a SPI driver
  * @__spi_driver: spi_driver struct
-- 
1.9.1

