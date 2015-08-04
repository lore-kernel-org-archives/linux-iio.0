Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24864 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934352AbbHDOFN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Aug 2015 10:05:13 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Adriana Reus <adriana.reus@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v4 8/8] iio: accel: kxcjk-1013: optimize i2c transfers in trigger handler
Date: Tue,  4 Aug 2015 17:04:16 +0300
Message-Id: <1438697056-2946-9-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
References: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Adriana Reus <adriana.reus@intel.com>

Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
enable/disable the bus at each i2c transfer and must wait for
the enable/disable to happen before sending the data.

When reading data in the trigger handler, the kxcjk-1013 accel driver
does one i2c transfer for each axis. This has an impact on the
frequency of the accelerometer at high sample rates due to additional
delays introduced by the i2c bus at each transfer.

Reading all axis values in one i2c transfer reduces the delays
introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emulated
that will fallback to reading each axis as a separate word in case i2c
block read is not supported.

Signed-off-by: Adriana Reus <adriana.reus@intel.com>
Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index d4b80e7..e8f7b45 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -926,7 +926,7 @@ static const struct iio_event_spec kxcjk1013_event = {
 		.realbits = 12,						\
 		.storagebits = 16,					\
 		.shift = 4,						\
-		.endianness = IIO_CPU,					\
+		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &kxcjk1013_event,				\
 	.num_event_specs = 1						\
@@ -964,19 +964,16 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct kxcjk1013_data *data = iio_priv(indio_dev);
-	int bit, ret, i = 0;
+	int ret;
 
 	mutex_lock(&data->mutex);
-
-	for (bit = 0; bit < AXIS_MAX; bit++) {
-		ret = kxcjk1013_get_acc_reg(data, bit);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			goto err;
-		}
-		data->buffer[i++] = ret;
-	}
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
+							KXCJK1013_REG_XOUT_L,
+							AXIS_MAX * 2,
+							(u8 *)data->buffer);
 	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		goto err;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   data->timestamp);
-- 
1.9.1

