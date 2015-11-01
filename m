Return-Path: <ciorneiioana@gmail.com>
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: outreachy-kernel@googlegroups.com,
	Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 1/2] iio: gyro: check sscanf return value
Date: Sun,  1 Nov 2015 14:58:44 +0200
Message-Id: <1446382725-11765-1-git-send-email-ciorneiioana@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the checkpatch warnings:
WARNING: unchecked sscanf return value

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---

based on linux-iio/testing branch

 drivers/iio/gyro/adis16136.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 26de876..bb09bff 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -435,7 +435,9 @@ static int adis16136_initial_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	sscanf(indio_dev->name, "adis%u\n", &device_id);
+	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
+	if (ret != 1)
+		return -EINVAL;
 
 	if (prod_id != device_id)
 		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
-- 
2.1.4
