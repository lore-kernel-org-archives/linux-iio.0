Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V5 1/7] iio: mma8452: Initialise before activating
To: Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org
Date: Mon, 01 Jun 2015 15:39:45 +0200
Message-ID: <20150601133945.24925.52404.stgit@localhost>
In-Reply-To: <20150601133943.24925.83080.stgit@localhost>
References: <20150601133943.24925.83080.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Many of the hardware configuration registers may only be modified while the
device is inactive.

Currently the probe code first activates the device and then modifies the
registers (eg to set the scale). This doesn't actually work but is not
noticed since the scale used is the default value.

While at it also issue a hardware reset command at probe time.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |   37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 5b80657..001a7db 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -32,6 +32,7 @@
 #define MMA8452_OFF_Z 0x31
 #define MMA8452_CTRL_REG1 0x2a
 #define MMA8452_CTRL_REG2 0x2b
+#define MMA8452_CTRL_REG2_RST		BIT(6)
 
 #define MMA8452_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
 
@@ -335,6 +336,30 @@ static const struct iio_info mma8452_info = {
 
 static const unsigned long mma8452_scan_masks[] = {0x7, 0};
 
+static int mma8452_reset(struct i2c_client *client)
+{
+	int i;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
+					MMA8452_CTRL_REG2_RST);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < 10; i++) {
+		usleep_range(100, 200);
+		ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG2);
+		if (ret == -EIO)
+			continue; /* I2C comm reset */
+		if (ret < 0)
+			return ret;
+		if (!(ret & MMA8452_CTRL_REG2_RST))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
 static int mma8452_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -365,10 +390,7 @@ static int mma8452_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(mma8452_channels);
 	indio_dev->available_scan_masks = mma8452_scan_masks;
 
-	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
-		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
-	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
-		data->ctrl_reg1);
+	ret = mma8452_reset(client);
 	if (ret < 0)
 		return ret;
 
@@ -378,6 +400,13 @@ static int mma8452_probe(struct i2c_client *client,
 	if (ret < 0)
 		return ret;
 
+	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
+		(MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
+	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
+					data->ctrl_reg1);
+	if (ret < 0)
+		return ret;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		mma8452_trigger_handler, NULL);
 	if (ret < 0)
