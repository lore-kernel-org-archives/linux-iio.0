Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41074 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOX3T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 19:29:19 -0400
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@vger.kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 3/7] iio: chemical: bme680: indent #defines consistently
Date: Wed, 15 Aug 2018 13:38:31 -0700
Message-Id: <20180815203835.21079-4-dpfrey@gmail.com>
In-Reply-To: <20180815203835.21079-1-dpfrey@gmail.com>
References: <20180815203835.21079-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index e049323f209a..dd4247d364a0 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -4,10 +4,10 @@
 
 #define BME680_REG_CHIP_I2C_ID			0xD0
 #define BME680_REG_CHIP_SPI_ID			0x50
-#define BME680_CHIP_ID_VAL			0x61
+#define   BME680_CHIP_ID_VAL			0x61
 #define BME680_REG_SOFT_RESET_I2C		0xE0
 #define BME680_REG_SOFT_RESET_SPI		0x60
-#define BME680_CMD_SOFTRESET			0xB6
+#define   BME680_CMD_SOFTRESET			0xB6
 #define BME680_REG_STATUS			0x73
 #define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
 #define     BME680_SPI_MEM_PAGE_1_VAL		1
@@ -18,6 +18,7 @@
 #define BME680_REG_GAS_MSB			0x2A
 #define BME680_REG_GAS_R_LSB			0x2B
 #define   BME680_GAS_STAB_BIT			BIT(4)
+#define   BME680_GAS_RANGE_MASK			0x0F
 
 #define BME680_REG_CTRL_HUMIDITY		0x72
 #define   BME680_OSRS_HUMIDITY_MASK		GENMASK(2, 0)
@@ -26,9 +27,8 @@
 #define   BME680_OSRS_TEMP_MASK			GENMASK(7, 5)
 #define   BME680_OSRS_PRESS_MASK		GENMASK(4, 2)
 #define   BME680_MODE_MASK			GENMASK(1, 0)
-
-#define BME680_MODE_FORCED			1
-#define BME680_MODE_SLEEP			0
+#define     BME680_MODE_FORCED			1
+#define     BME680_MODE_SLEEP			0
 
 #define BME680_REG_CONFIG			0x75
 #define   BME680_FILTER_MASK			GENMASK(4, 2)
@@ -42,13 +42,12 @@
 #define BME680_BIT_H1_DATA_MSK			0x0F
 
 #define BME680_REG_RES_HEAT_RANGE		0x02
-#define BME680_RHRANGE_MSK			0x30
+#define   BME680_RHRANGE_MSK			0x30
 #define BME680_REG_RES_HEAT_VAL			0x00
 #define BME680_REG_RANGE_SW_ERR			0x04
-#define BME680_RSERROR_MSK			0xF0
+#define   BME680_RSERROR_MSK			0xF0
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
-#define BME680_GAS_RANGE_MASK			0x0F
 #define BME680_ADC_GAS_RES_SHIFT		6
 #define BME680_AMB_TEMP				25
 
-- 
2.11.0
