Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>, Jean Delvare <khali@linux-fr.org>,
	Grant Likely <grant.likely@secretlab.ca>
CC: Jonathan Cameron <jic23@kernel.org>, Michael Hennerich
	<Michael.Hennerich@analog.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>,
	<spi-devel-general@lists.sourceforge.net>, Lars-Peter Clausen
	<lars@metafoo.de>
Subject: [PATCH 3/5] SPI: Add helper macro for spi_driver boilerplate
Date: Wed, 16 Nov 2011 10:13:37 +0100
Message-ID: <1321434819-23678-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1321434819-23678-1-git-send-email-lars@metafoo.de>
References: <1321434819-23678-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

This patch introduces the module_spi_driver macro which is a convenience macro
for SPI driver modules similar to module_platform_driver. It is intended to be
used by drivers which init/exit section does nothing but register/unregister
the SPI driver. By using this macro it is possible to eliminate a few lines of
boilerplate code per SPI driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/linux/spi/spi.h |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index bb4f5fb..176fce9 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -200,6 +200,17 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
 		driver_unregister(&sdrv->driver);
 }
 
+/**
+ * module_spi_driver() - Helper macro for registering a SPI driver
+ * @__spi_driver: spi_driver struct
+ *
+ * Helper macro for SPI drivers which do not do anything special in module
+ * init/exit. This eliminates a lot of boilerplate. Each module may only
+ * use this macro once, and calling it replaces module_init() and module_exit()
+ */
+#define module_spi_driver(__spi_driver) \
+	module_driver(__spi_driver, spi_register_driver, \
+			spi_unregister_driver)
 
 /**
  * struct spi_master - interface to SPI master controller
-- 
1.7.7.1
