Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36628 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOX3V (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 19:29:21 -0400
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@vger.kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 4/7] iio: chemical: bme680: change MSK->MASK in #defines
Date: Wed, 15 Aug 2018 13:38:32 -0700
Message-Id: <20180815203835.21079-5-dpfrey@gmail.com>
In-Reply-To: <20180815203835.21079-1-dpfrey@gmail.com>
References: <20180815203835.21079-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Convert all defines to use "MASK" instead of a mix of "MSK" and "MASK"

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680.h      | 6 +++---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

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
index 49bb6b84f181..d62cb88af481 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
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
