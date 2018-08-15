Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45647 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbeHOX3Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 19:29:24 -0400
From: David Frey <dpfrey@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@vger.kernel.org, himanshujha199640@gmail.com,
        David Frey <dpfrey@gmail.com>
Subject: [PATCH v2 6/7] iio: chemical: bme680: use FIELD_GET macro
Date: Wed, 15 Aug 2018 13:38:34 -0700
Message-Id: <20180815203835.21079-7-dpfrey@gmail.com>
In-Reply-To: <20180815203835.21079-1-dpfrey@gmail.com>
References: <20180815203835.21079-1-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the FIELD_GET macro instead of explicit mask and shift.

Signed-off-by: David Frey <dpfrey@gmail.com>
---
 drivers/iio/chemical/bme680_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index d62cb88af481..c96e4a991a61 100644
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
