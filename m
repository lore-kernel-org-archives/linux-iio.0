Return-Path: <SRS0=bXW4=LD=gmail.com=dpfrey@kernel.org>
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	himanshujha199640@gmail.com,
	David Frey <dpfrey@gmail.com>
Subject: [PATCH] iio: chemical: bme680: Remove field value defines
Date: Mon, 20 Aug 2018 10:39:59 -0700
Message-Id: <20180820173959.22380-1-dpfrey@gmail.com>
In-Reply-To: <20180819201439.30d318c7@archlinux>
References: <20180819201439.30d318c7@archlinux>
List-ID: <linux-iio@vger.kernel.org>

Remove BME680_RUN_GAS_EN_BIT and BME680_NB_CONV_0_VAL field value
definitions because the fields are simply boolean and integer
respectively.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
This patch applies on top of my "indent #defines consistently" v3 patch.
Appologies if I should have submitted this patch in a different way.  If
I should have submitted this differently, I would appreciate a pointer
on what I should have done in this case.

BME680_RUN_GAS_EN_BIT was indeed somewhat wrongly formatted, but the
issue was not the indentation level, but rather that I should have
followed immediately after BME680_RUN_GAS_MASK.  Once I moved it there,
I realized that neither this definition nor BME680_NB_CONV_0_VAL really
added any value and hence I removed both in this patch.

 drivers/iio/chemical/bme680.h      | 2 --
 drivers/iio/chemical/bme680_core.c | 5 +++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/bme680.h b/drivers/iio/chemical/bme680.h
index dd4247d364a0..48dc9e50e017 100644
--- a/drivers/iio/chemical/bme680.h
+++ b/drivers/iio/chemical/bme680.h
@@ -54,8 +54,6 @@
 #define BME680_REG_CTRL_GAS_1			0x71
 #define   BME680_RUN_GAS_MASK			BIT(4)
 #define   BME680_NB_CONV_MASK			GENMASK(3, 0)
-#define     BME680_RUN_GAS_EN_BIT		BIT(4)
-#define     BME680_NB_CONV_0_VAL		0
 
 #define BME680_REG_MEAS_STAT_0			0x1D
 #define   BME680_GAS_MEAS_BIT			BIT(6)
diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index cde08d57e7d5..01ca7ba64ea0 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -566,10 +566,11 @@ static int bme680_gas_config(struct bme680_data *data)
 		return ret;
 	}
 
-	/* Selecting the runGas and NB conversion settings for the sensor */
+	/* Enable the gas sensor and select heater profile set-point 0 */
 	ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_GAS_1,
 				 BME680_RUN_GAS_MASK | BME680_NB_CONV_MASK,
-				 BME680_RUN_GAS_EN_BIT | BME680_NB_CONV_0_VAL);
+				 FIELD_PREP(BME680_RUN_GAS_MASK, 1) |
+				 FIELD_PREP(BME680_NB_CONV_MASK, 0));
 	if (ret < 0)
 		dev_err(dev, "failed to write ctrl_gas_1 register\n");
 
-- 
2.11.0
