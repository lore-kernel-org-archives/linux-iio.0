Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:56078 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751247AbeDXPGV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Apr 2018 11:06:21 -0400
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <jic23@kernel.org>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>
Subject: [PATCH RESEND] iio: accel: bcm150: Remove handling for regmap raw_read_max
Date: Tue, 24 Apr 2018 16:05:51 +0100
Message-ID: <20180424150551.14847-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The regmap core now handles splitting up transactions according to
max_raw_read, so this code is no longer required in client drivers.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

The necessary changes to support this are available in Linus's tree now.

Thanks,
Charles

 drivers/iio/accel/bmc150-accel-core.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 208f2d9f0e8a..383c802eb5b8 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -837,29 +837,12 @@ static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
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

