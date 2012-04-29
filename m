Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: add Kconfig option and Makefile entry for mcp4725 I2C DAC driver
Date: Sun, 29 Apr 2012 19:13:37 +0200
Message-Id: <1335719618-28295-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 drivers/staging/iio/dac/Kconfig  |   11 +++++++++++
 drivers/staging/iio/dac/Makefile |    1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/staging/iio/dac/Kconfig b/drivers/staging/iio/dac/Kconfig
index a57803a..9308118 100644
--- a/drivers/staging/iio/dac/Kconfig
+++ b/drivers/staging/iio/dac/Kconfig
@@ -118,4 +118,15 @@ config MAX517
 	  This driver can also be built as a module.  If so, the module
 	  will be called max517.
 
+config MCP4725
+	tristate "MCP4725 DAC driver"
+	depends on I2C
+	---help---
+	  Say Y here if you want to build a driver for the Microchip
+	  MCP 4725 12-bit digital-to-analog convertor (DAC) with I2C
+	  interface.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mcp4725.
+
 endmenu
diff --git a/drivers/staging/iio/dac/Makefile b/drivers/staging/iio/dac/Makefile
index 8ab1d26..9ea3cee 100644
--- a/drivers/staging/iio/dac/Makefile
+++ b/drivers/staging/iio/dac/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_AD5764) += ad5764.o
 obj-$(CONFIG_AD5791) += ad5791.o
 obj-$(CONFIG_AD5686) += ad5686.o
 obj-$(CONFIG_MAX517) += max517.o
+obj-$(CONFIG_MCP4725) += mcp4725.o
-- 
1.7.9.5
