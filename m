Return-Path: <leed.aguilar@ti.com>
From: Leed Aguilar <leed.aguilar@ti.com>
To: <linux-iio@vger.kernel.org>
CC: Leed Aguilar <leed.aguilar@ti.com>, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:magnetometer:ak8975: set power-down mode after reading fuse ROM data
Date: Wed, 30 May 2012 21:52:17 -0400
Message-ID: <1338429137-27059-1-git-send-email-leed.aguilar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Fuse ROM data access mode is the only mode which does not
transition to power-down mode automatically.

As per the AK8975 data sheet, it is recomended to set the
power-down mode first before attempting to change into
another mode.

Change-Id: I4013c7963b19b3fe4b67553521b1083f018507bb
Signed-off-by: Leed Aguilar <leed.aguilar@ti.com>
Cc: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/ak8975.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
index 52833cd..b06bd2d 100644
--- a/drivers/staging/iio/magnetometer/ak8975.c
+++ b/drivers/staging/iio/magnetometer/ak8975.c
@@ -194,6 +194,17 @@ static int ak8975_setup(struct i2c_client *client)
 		return ret;
 	}
 
+	/* After reading fuse ROM data set power-down mode */
+	ret = ak8975_write_data(client,
+				AK8975_REG_CNTL,
+				AK8975_REG_CNTL_MODE_POWER_DOWN,
+				AK8975_REG_CNTL_MODE_MASK,
+				AK8975_REG_CNTL_MODE_SHIFT);
+	if (ret < 0) {
+		dev_err(&client->dev, "Error in setting power-down mode\n");
+		return ret;
+	}
+
 /*
  * Precalculate scale factor (in Gauss units) for each axis and
  * store in the device data.
-- 
1.7.1
