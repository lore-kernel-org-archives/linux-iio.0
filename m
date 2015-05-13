Return-Path: <mfuzzey@parkeon.com>
Subject: [PATCH V4 2/7] iio: mma8452: Add access to registers via DebugFS
To: Peter Meerwald <pmeerw@pmeerw.net>, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>
Date: Wed, 13 May 2015 12:26:40 +0200
Message-ID: <20150513102640.27803.39257.stgit@localhost>
In-Reply-To: <20150513102635.27803.99054.stgit@localhost>
References: <20150513102635.27803.99054.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |   25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 001a7db..877ce29 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -34,6 +34,8 @@
 #define MMA8452_CTRL_REG2 0x2b
 #define MMA8452_CTRL_REG2_RST		BIT(6)
 
+#define MMA8452_MAX_REG 0x31
+
 #define MMA8452_STATUS_DRDY (BIT(2) | BIT(1) | BIT(0))
 
 #define MMA8452_CTRL_DR_MASK (BIT(5) | BIT(4) | BIT(3))
@@ -292,6 +294,28 @@ done:
 	return IRQ_HANDLED;
 }
 
+static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
+				  unsigned reg, unsigned writeval,
+				  unsigned *readval)
+{
+	int ret;
+	struct mma8452_data *data = iio_priv(indio_dev);
+
+	if (reg > MMA8452_MAX_REG)
+		return -EINVAL;
+
+	if (!readval)
+		return mma8452_change_config(data, reg, writeval);
+
+	ret = i2c_smbus_read_byte_data(data->client, reg);
+	if (ret < 0)
+		return ret;
+
+	*readval = ret;
+
+	return 0;
+}
+
 #define MMA8452_CHANNEL(axis, idx) { \
 	.type = IIO_ACCEL, \
 	.modified = 1, \
@@ -331,6 +355,7 @@ static const struct iio_info mma8452_info = {
 	.attrs = &mma8452_group,
 	.read_raw = &mma8452_read_raw,
 	.write_raw = &mma8452_write_raw,
+	.debugfs_reg_access = &mma8452_reg_access_dbg,
 	.driver_module = THIS_MODULE,
 };
 
