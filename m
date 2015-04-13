Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 03/17] iio: accel: mma9551_core: prevent buffer overrun
Date: Mon, 13 Apr 2015 18:40:50 +0300
Message-Id: <1428939664-12503-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The mma9551 functions that read/write word arrays from the
device have a limit for the buffer size given by the device
specifications.

Check that the requested buffer length is within required limits
when transferring word arrays. This will prevent buffer overrun
in the mma9551_read/write_*_words functions and also in the
mma9551_transfer call when writing into the MBOX response/request
structure.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reported-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9551_core.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index 7f55a6d..c6d5a3a 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -389,7 +389,12 @@ int mma9551_read_config_words(struct i2c_client *client, u8 app_id,
 {
 	int ret, i;
 	int len_words = len / sizeof(u16);
-	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
+	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
+
+	if (len_words > ARRAY_SIZE(be_buf)) {
+		dev_err(&client->dev, "Invalid buffer size %d\n", len);
+		return -EINVAL;
+	}
 
 	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_CONFIG,
 			       reg, NULL, 0, (u8 *) be_buf, len);
@@ -424,7 +429,12 @@ int mma9551_read_status_words(struct i2c_client *client, u8 app_id,
 {
 	int ret, i;
 	int len_words = len / sizeof(u16);
-	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
+	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS / 2];
+
+	if (len_words > ARRAY_SIZE(be_buf)) {
+		dev_err(&client->dev, "Invalid buffer size %d\n", len);
+		return -EINVAL;
+	}
 
 	ret = mma9551_transfer(client, app_id, MMA9551_CMD_READ_STATUS,
 			       reg, NULL, 0, (u8 *) be_buf, len);
@@ -459,7 +469,12 @@ int mma9551_write_config_words(struct i2c_client *client, u8 app_id,
 {
 	int i;
 	int len_words = len / sizeof(u16);
-	__be16 be_buf[MMA9551_MAX_MAILBOX_DATA_REGS];
+	__be16 be_buf[(MMA9551_MAX_MAILBOX_DATA_REGS - 1) / 2];
+
+	if (len_words > ARRAY_SIZE(be_buf)) {
+		dev_err(&client->dev, "Invalid buffer size %d\n", len);
+		return -EINVAL;
+	}
 
 	for (i = 0; i < len_words; i++)
 		be_buf[i] = cpu_to_be16(buf[i]);
-- 
1.9.1
