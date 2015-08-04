Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24864 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965194AbbHDOFG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 4 Aug 2015 10:05:06 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v4 6/8] iio: gyro: bmg160: optimize i2c transfers in trigger handler
Date: Tue,  4 Aug 2015 17:04:14 +0300
Message-Id: <1438697056-2946-7-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
References: <1438697056-2946-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
enable/disable the bus at each i2c transfer and must wait for
the enable/disable to happen before sending the data.

When reading data in the trigger handler, the bmg160 driver does
one i2c transfer for each axis. This has an impact on the frequency
of the gyroscope at high sample rates due to additional delays
introduced by the i2c bus at each transfer.

Reading all axis values in one i2c transfer reduces the delays
introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emulated
that will fallback to reading each axis as a separate word in case i2c
block read is not supported.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/gyro/bmg160.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index b2a6ccb..1ff306d 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -772,6 +772,7 @@ static const struct iio_event_spec bmg160_event = {
 		.sign = 's',						\
 		.realbits = 16,					\
 		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &bmg160_event,					\
 	.num_event_specs = 1						\
@@ -809,19 +810,16 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmg160_data *data = iio_priv(indio_dev);
-	int bit, ret, i = 0;
+	int ret = 0;
 
 	mutex_lock(&data->mutex);
-	for (bit = 0; bit < AXIS_MAX; bit++) {
-		ret = i2c_smbus_read_word_data(data->client,
-					       BMG160_AXIS_TO_REG(bit));
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			goto err;
-		}
-		data->buffer[i++] = ret;
-	}
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
+							BMG160_REG_XOUT_L,
+							AXIS_MAX * 2,
+							(u8 *)data->buffer);
 	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		goto err;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   pf->timestamp);
-- 
1.9.1

