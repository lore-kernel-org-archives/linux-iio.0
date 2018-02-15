Return-Path: <SRS0=rlOl=FJ=opensource.cirrus.com=ckeepax@kernel.org>
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 4/5] iio: accel: bcm150: Remove handling for regmap raw_read_max
Date: Thu, 15 Feb 2018 17:52:19 +0000
Message-ID: <20180215175220.2691-4-ckeepax@opensource.cirrus.com>
In-Reply-To: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
References: <20180215175220.2691-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

The regmap core now handles splitting up transactions according to
max_raw_read, so this code is no longer required in client drivers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 870f92ef61c2..3d2e6b501bf9 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -838,29 +838,12 @@ static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
 	int sample_length = 3 * 2;
 	int ret;
 	int total_length = samples * sample_length;
-	int i;
-	size_t step = regmap_get_raw_read_max(data->regmap);
-
-	if (!step || step > total_length)
-		step = total_length;
-	else if (step < total_length)
-		step = sample_length;
-
-	/*
-	 * Seems we have a bus with size limitation so we have to execute
-	 * multiple reads
-	 */
-	for (i = 0; i < total_length; i += step) {
-		ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
-				      &buffer[i], step);
-		if (ret)
-			break;
-	}
 
+	ret = regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
+			      buffer, total_length);
 	if (ret)
 		dev_err(dev,
-			"Error transferring data from fifo in single steps of %zu\n",
-			step);
+			"Error transferring data from fifo: %d\n", ret);
 
 	return ret;
 }
-- 
2.11.0
