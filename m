Return-Path: <SRS0=axia=LA=gmail.com=dpfrey@kernel.org>
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	himanshujha199640@gmail.com,
	David Frey <dpfrey@gmail.com>
Subject: [PATCH v3 4/7] iio: chemical: bme680: change MSK->MASK in #defines
Date: Fri, 17 Aug 2018 12:03:16 -0700
Message-Id: <20180817190319.13119-5-dpfrey@gmail.com>
In-Reply-To: <20180817190319.13119-1-dpfrey@gmail.com>
References: <20180817190319.13119-1-dpfrey@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Convert all defines to use "MASK" instead of a mix of "MSK" and "MASK"

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680.h      | 6 +++---
 drivers/iio/chemical/bme680_core.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index dd4247d364a0..437d75c2bad5 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -39,13 +39,13 @@
 
 #define BME680_MAX_OVERFLOW_VAL			0x40000000
 #define BME680_HUM_REG_SHIFT_VAL		4
-#define BME680_BIT_H1_DATA_MSK			0x0F
+#define BME680_BIT_H1_DATA_MASK			0x0F
 
 #define BME680_REG_RES_HEAT_RANGE		0x02
-#define   BME680_RHRANGE_MSK			0x30
+#define   BME680_RHRANGE_MASK			0x30
 #define BME680_REG_RES_HEAT_VAL			0x00
 #define BME680_REG_RANGE_SW_ERR			0x04
-#define   BME680_RSERROR_MSK			0xF0
+#define   BME680_RSERROR_MASK			0xF0
 #define BME680_REG_RES_HEAT_0			0x5A
 #define BME680_REG_GAS_WAIT_0			0x64
 #define BME680_ADC_GAS_RES_SHIFT		6
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index cde08d57e7d5..7c7df40b615f 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -206,7 +206,7 @@ static int bme680_read_calib(struct bme680_data *data,
 		return ret;
 	}
 	calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
-	                (tmp_lsb & BME680_BIT_H1_DATA_MSK);
+	                (tmp_lsb & BME680_BIT_H1_DATA_MASK);
 
 	ret = regmap_read(data->regmap, BME680_H2_MSB_REG, &tmp_msb);
 	if (ret < 0) {
@@ -285,7 +285,7 @@ static int bme680_read_calib(struct bme680_data *data,
 		dev_err(dev, "failed to read resistance heat range\n");
 		return ret;
 	}
-	calib->res_heat_range = (tmp & BME680_RHRANGE_MSK) / 16;
+	calib->res_heat_range = (tmp & BME680_RHRANGE_MASK) / 16;
 
 	ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_VAL, &tmp);
 	if (ret < 0) {
@@ -299,7 +299,7 @@ static int bme680_read_calib(struct bme680_data *data,
 		dev_err(dev, "failed to read range software error\n");
 		return ret;
 	}
-	calib->range_sw_err = (tmp & BME680_RSERROR_MSK) / 16;
+	calib->range_sw_err = (tmp & BME680_RSERROR_MASK) / 16;
 
 	return 0;
 }
-- 
2.11.0
