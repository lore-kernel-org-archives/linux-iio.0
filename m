Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19827 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757020AbcCXJ3s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Mar 2016 05:29:48 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 2/6] iio: accel: bmc150: optimize transfers in trigger handler
Date: Thu, 24 Mar 2016 11:29:27 +0200
Message-Id: <1458811771-25217-3-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
References: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
enable/disable the bus at each i2c transfer and must wait for
the enable/disable to happen before sending the data.

When reading data in the trigger handler, the bmc150 accel driver does
one bus transfer for each axis. This has an impact on the frequency
of the accelerometer at high sample rates due to additional delays
introduced by the bus at each transfer.

Reading all axis values in one bus transfer reduces the delays
introduced by the bus.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index cc52366..58df97d 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -989,6 +989,7 @@ static const struct iio_event_spec bmc150_accel_event = {
 		.realbits = (bits),					\
 		.storagebits = 16,					\
 		.shift = 16 - (bits),					\
+		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &bmc150_accel_event,				\
 	.num_event_specs = 1						\
@@ -1114,21 +1115,14 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
-	int bit, ret, i = 0;
-	unsigned int raw_val;
+	int ret;
 
 	mutex_lock(&data->mutex);
-	for (bit = 0; bit < AXIS_MAX; bit++) {
-		ret = regmap_bulk_read(data->regmap,
-				       BMC150_ACCEL_AXIS_TO_REG(bit), &raw_val,
-				       2);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			goto err_read;
-		}
-		data->buffer[i++] = raw_val;
-	}
+	ret = regmap_bulk_read(data->regmap, BMC150_ACCEL_REG_XOUT_L,
+			       data->buffer, AXIS_MAX * 2);
 	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		goto err_read;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   pf->timestamp);
-- 
1.9.1

