Return-Path: <SRS0=axia=LA=gmail.com=dpfrey@kernel.org>
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	himanshujha199640@gmail.com,
	David Frey <dpfrey@gmail.com>
Subject: [PATCH v3 6/7] iio: chemical: bme680: use FIELD_GET macro
Date: Fri, 17 Aug 2018 12:03:18 -0700
Message-Id: <20180817190319.13119-7-dpfrey@gmail.com>
In-Reply-To: <20180817190319.13119-1-dpfrey@gmail.com>
References: <20180817190319.13119-1-dpfrey@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use the FIELD_GET macro instead of explicit mask and shift.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 7c7df40b615f..46afc93041f5 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -285,7 +285,7 @@ static int bme680_read_calib(struct bme680_data *data,
 		dev_err(dev, "failed to read resistance heat range\n");
 		return ret;
 	}
-	calib->res_heat_range = (tmp & BME680_RHRANGE_MASK) / 16;
+	calib->res_heat_range = FIELD_GET(BME680_RHRANGE_MASK, tmp);
 
 	ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_VAL, &tmp);
 	if (ret < 0) {
@@ -299,7 +299,7 @@ static int bme680_read_calib(struct bme680_data *data,
 		dev_err(dev, "failed to read range software error\n");
 		return ret;
 	}
-	calib->range_sw_err = (tmp & BME680_RSERROR_MASK) / 16;
+	calib->range_sw_err = FIELD_GET(BME680_RSERROR_MASK, tmp);
 
 	return 0;
 }
-- 
2.11.0
