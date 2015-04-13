Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 01/17] iio: accel: mma9553: fix endianness issue when reading status
Date: Mon, 13 Apr 2015 18:40:48 +0300
Message-Id: <1428939664-12503-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Refactor code for simplicity and clarity.

This also fixes an endianness issue with the original code.
When reading multiple registers, the received buffer of
16-bytes words is little endian (status, step count). On
big endian machines, casting them to u32 would result in
reversed order in the buffer (step count, status) leading
to incorrect values for step count and activity.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reported-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9553.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 2df1af7..607dbfc 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -316,22 +316,19 @@ static int mma9553_set_config(struct mma9553_data *data, u16 reg,
 static int mma9553_read_activity_stepcnt(struct mma9553_data *data,
 					 u8 *activity, u16 *stepcnt)
 {
-	u32 status_stepcnt;
-	u16 status;
+	u16 buf[2];
 	int ret;
 
 	ret = mma9551_read_status_words(data->client, MMA9551_APPID_PEDOMETER,
-					MMA9553_REG_STATUS, sizeof(u32),
-					(u16 *) &status_stepcnt);
+					MMA9553_REG_STATUS, sizeof(u32), buf);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
 			"error reading status and stepcnt\n");
 		return ret;
 	}
 
-	status = status_stepcnt & MMA9553_MASK_CONF_WORD;
-	*activity = mma9553_get_bits(status, MMA9553_MASK_STATUS_ACTIVITY);
-	*stepcnt = status_stepcnt >> 16;
+	*activity = mma9553_get_bits(buf[0], MMA9553_MASK_STATUS_ACTIVITY);
+	*stepcnt = buf[1];
 
 	return 0;
 }
-- 
1.9.1
