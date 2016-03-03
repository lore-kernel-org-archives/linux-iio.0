Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 2/4] iio: mma8452: avoid switching to active because of config change
Date: Thu,  3 Mar 2016 09:24:02 +0100
Message-Id: <1456993444-21320-3-git-send-email-martink@posteo.de>
In-Reply-To: <1456993444-21320-1-git-send-email-martink@posteo.de>
References: <1456993444-21320-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

The devices' config registers can only be changed in standby mode.
Up until now the driver just held the device *always* active, so for
changing a config it was *always* necessary to switch to standby.

For upcoming support for runtime pm, the device can as well be in standby
mode. Instead of putting runtime pm functions in there, just keep the
device in standby if it already is. This section is protected by a lock
after all.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 17d72bc..9c4a84a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -393,24 +393,47 @@ static int mma8452_active(struct mma8452_data *data)
 					 data->ctrl_reg1);
 }
 
+/* returns >0 if active, 0 if in standby and <0 on error */
+static int mma8452_is_active(struct mma8452_data *data)
+{
+	int reg;
+
+	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG1);
+	if (reg < 0)
+		return reg;
+
+	return reg & MMA8452_CTRL_ACTIVE;
+}
+
 static int mma8452_change_config(struct mma8452_data *data, u8 reg, u8 val)
 {
 	int ret;
+	int is_active;
 
 	mutex_lock(&data->lock);
 
-	/* config can only be changed when in standby */
-	ret = mma8452_standby(data);
-	if (ret < 0)
+	is_active = mma8452_is_active(data);
+	if (is_active < 0) {
+		ret = is_active;
 		goto fail;
+	}
+
+	/* config can only be changed when in standby */
+	if (is_active > 0) {
+		ret = mma8452_standby(data);
+		if (ret < 0)
+			goto fail;
+	}
 
 	ret = i2c_smbus_write_byte_data(data->client, reg, val);
 	if (ret < 0)
 		goto fail;
 
-	ret = mma8452_active(data);
-	if (ret < 0)
-		goto fail;
+	if (is_active > 0) {
+		ret = mma8452_active(data);
+		if (ret < 0)
+			goto fail;
+	}
 
 	ret = 0;
 fail:
-- 
2.1.4
