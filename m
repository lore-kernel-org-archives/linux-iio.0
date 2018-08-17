Return-Path: <SRS0=axia=LA=gmail.com=dpfrey@kernel.org>
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	himanshujha199640@gmail.com,
	David Frey <dpfrey@gmail.com>
Subject: [PATCH v3 5/7] iio: chemical: bme680: use GENMASK macro
Date: Fri, 17 Aug 2018 12:03:17 -0700
Message-Id: <20180817190319.13119-6-dpfrey@gmail.com>
In-Reply-To: <20180817190319.13119-1-dpfrey@gmail.com>
References: <20180817190319.13119-1-dpfrey@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Replace hardcoded bit masks with GENMASK macro

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index 437d75c2bad5..a9f2a9a6abc5 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -18,7 +18,7 @@
 #define BME680_REG_GAS_MSB			0x2A
 #define BME680_REG_GAS_R_LSB			0x2B
 #define   BME680_GAS_STAB_BIT			BIT(4)
-#define   BME680_GAS_RANGE_MASK			0x0F
+#define   BME680_GAS_RANGE_MASK			GENMASK(3, 0)
 
 #define BME680_REG_CTRL_HUMIDITY		0x72
 #define   BME680_OSRS_HUMIDITY_MASK		GENMASK(2, 0)
@@ -39,13 +39,13 @@
 
 #define BME680_MAX_OVERFLOW_VAL			0x40000000
 #define BME680_HUM_REG_SHIFT_VAL		4
-#define BME680_BIT_H1_DATA_MASK			0x0F
+#define BME680_BIT_H1_DATA_MASK			GENMASK(3, 0)
 
 #define BME680_REG_RES_HEAT_RANGE		0x02
-#define   BME680_RHRANGE_MASK			0x30
+#define   BME680_RHRANGE_MASK			GENMASK(5, 4)
 #define BME680_REG_RES_HEAT_VAL			0x00
 #define BME680_REG_RANGE_SW_ERR			0x04
-#define   BME680_RSERROR_MASK			0xF0
+#define   BME680_RSERROR_MASK			GENMASK(7, 4)
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
 #define BME680_ADC_GAS_RES_SHIFT		6
-- 
2.11.0
