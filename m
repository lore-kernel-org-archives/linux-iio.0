Return-Path: <bankarsandhya512@gmail.com>
Date: Sun, 25 Sep 2016 00:46:21 +0530
From: Sandhya Bankar <bankarsandhya512@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com
Subject: [PATCH] drivers: iio: chemical: Fix sparse endianness warnings cast
 to restricted __be16
Message-ID: <20160924191621.GA18812@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Fix the following sparse endianness warnings:

drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16
drivers/iio/chemical/atlas-ph-sensor.c:215:9: warning: cast to restricted __be16

Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
---
 drivers/iio/chemical/atlas-ph-sensor.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 407f141..a3fbdb7 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -207,13 +207,14 @@ static int atlas_check_ec_calibration(struct atlas_data *data)
 	struct device *dev = &data->client->dev;
 	int ret;
 	unsigned int val;
+	__be16	rval;
 
-	ret = regmap_bulk_read(data->regmap, ATLAS_REG_EC_PROBE, &val, 2);
+	ret = regmap_bulk_read(data->regmap, ATLAS_REG_EC_PROBE, &rval, 2);
 	if (ret)
 		return ret;
 
-	dev_info(dev, "probe set to K = %d.%.2d", be16_to_cpu(val) / 100,
-						 be16_to_cpu(val) % 100);
+	val = be16_to_cpu(rval);
+	dev_info(dev, "probe set to K = %d.%.2d", val / 100, val % 100);
 
 	ret = regmap_read(data->regmap, ATLAS_REG_EC_CALIB_STATUS, &val);
 	if (ret)
-- 
1.8.3.1
