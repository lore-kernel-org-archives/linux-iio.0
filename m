Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io: accel: kxcjk1013: Remove redundant assignment
Date: Fri, 22 Aug 2014 10:35:56 +0300
Message-Id: <1408692956-11379-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

data->range is already set by kxcjk1013_set_range.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 70a5679..01e86d0 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -239,9 +239,6 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	if (ret < 0)
 		return ret;
 
-	data->range = KXCJK1013_RANGE_4G;
-
-
 	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_DATA_CTRL);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_data_ctrl\n");
-- 
1.9.1
