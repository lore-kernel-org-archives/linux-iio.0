Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:33124 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107AbaG2JBe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 29 Jul 2014 05:01:34 -0400
Subject: [PATCH V2 1/8] iio: mma8452: Initialise before activating
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: pmeerw@pmeerw.net
Date: Tue, 29 Jul 2014 11:01:31 +0200
Message-ID: <20140729090131.4618.11083.stgit@localhost>
In-Reply-To: <20140729090128.4618.92936.stgit@localhost>
References: <20140729090128.4618.92936.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Many of the hardware configuration registers may only be modified while the
device is inactive.

Currently the probe code first activates the device and then modifies the
registers (eg to set the scale). This doesn't actually work but is not
noticed since the scale used is the default value.

While at it also issue a hardware reset command at probe time.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 3c12d49..04a4f34 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -32,6 +32,7 @@
 #define MMA8452_OFF_Z 0x31
 #define MMA8452_CTRL_REG1 0x2a
 #define MMA8452_CTRL_REG2 0x2b
+#define MMA8452_CTRL_REG2_RST		BIT(6)
 
 #define MMA8452_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
 
@@ -111,7 +112,7 @@ static const int mma8452_samp_freq[8][2] = {
 	{6, 250000}, {1, 560000}
 };
 
-/* 
+/*
  * Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
  * The userspace interface uses m/s^2 and we declare micro units
  * So scale factor is given by:
@@ -335,6 +336,30 @@ static const struct iio_info mma8452_info = {
 
 static const unsigned long mma8452_scan_masks[] = {0x7, 0};
 
+static int mma8452_reset(struct i2c_client *client)
+{
+	int i;
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client,	MMA8452_CTRL_REG2,
+						MMA8452_CTRL_REG2_RST);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < 10; i++) {
+		udelay(100);
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
+		data->ctrl_reg1);
+	if (ret < 0)
+		return ret;
+
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		mma8452_trigger_handler, NULL);
 	if (ret < 0)

