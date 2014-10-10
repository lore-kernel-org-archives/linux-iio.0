Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] iio: gyro: bmg160: Don't let interrupt mode to be open drain
Date: Fri, 10 Oct 2014 09:30:55 -0700
Message-Id: <1412958656-30834-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412958656-30834-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1412958656-30834-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Change the mode to push/pull type instead of open drain as some
platforms fails to drive the GPIO pin with open drain.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/bmg160.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 3476133..0b9e813 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -67,6 +67,9 @@
 #define BMG160_REG_INT_EN_0		0x15
 #define BMG160_DATA_ENABLE_INT		BIT(7)
 
+#define BMG160_REG_INT_EN_1		0x16
+#define BMG160_INT1_BIT_OD		BIT(1)
+
 #define BMG160_REG_XOUT_L		0x02
 #define BMG160_AXIS_TO_REG(axis)	(BMG160_REG_XOUT_L + (axis * 2))
 
@@ -222,6 +225,19 @@ static int bmg160_chip_init(struct bmg160_data *data)
 	data->slope_thres = ret;
 
 	/* Set default interrupt mode */
+	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_EN_1);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error reading reg_int_en_1\n");
+		return ret;
+	}
+	ret &= ~BMG160_INT1_BIT_OD;
+	ret = i2c_smbus_write_byte_data(data->client,
+					BMG160_REG_INT_EN_1, ret);
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Error writing reg_int_en_1\n");
+		return ret;
+	}
+
 	ret = i2c_smbus_write_byte_data(data->client,
 					BMG160_REG_INT_RST_LATCH,
 					BMG160_INT_MODE_LATCH_INT |
-- 
1.9.3
