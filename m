Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:45778 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752690AbdJ0TaO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Oct 2017 15:30:14 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 06/13] iio: health: max30102: Add check for part ID
Date: Fri, 27 Oct 2017 21:29:46 +0200
Message-Id: <1509132593-1815-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 389a483..c43957e 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -32,6 +32,7 @@
 
 #define MAX30102_REGMAP_NAME	"max30102_regmap"
 #define MAX30102_DRV_NAME	"max30102"
+#define MAX30102_PART_NUMBER	0x15
 
 #define MAX30102_REG_INT_STATUS			0x00
 #define MAX30102_REG_INT_STATUS_PWR_RDY		BIT(0)
@@ -83,6 +84,9 @@
 #define MAX30102_REG_TEMP_INTEGER		0x1f
 #define MAX30102_REG_TEMP_FRACTION		0x20
 
+#define MAX30102_REG_REV_ID			0xfe
+#define MAX30102_REG_PART_ID			0xff
+
 struct max30102_data {
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
@@ -391,6 +395,7 @@ static int max30102_probe(struct i2c_client *client,
 	struct iio_buffer *buffer;
 	struct iio_dev *indio_dev;
 	int ret;
+	unsigned int reg;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -424,6 +429,19 @@ static int max30102_probe(struct i2c_client *client,
 		return PTR_ERR(data->regmap);
 	}
 
+	/* check part ID */
+	ret = regmap_read(data->regmap, MAX30102_REG_PART_ID, &reg);
+	if (ret)
+		return ret;
+	if (reg != MAX30102_PART_NUMBER)
+		return -ENODEV;
+
+	/* show revision ID */
+	ret = regmap_read(data->regmap, MAX30102_REG_REV_ID, &reg);
+	if (ret)
+		return ret;
+	dev_dbg(&client->dev, "max3010x revision %02x\n", reg);
+
 	ret = max30102_set_powermode(data, false);
 	if (ret)
 		return ret;
-- 
2.7.4

