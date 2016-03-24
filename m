Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:11670 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757063AbcCXJ3y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Mar 2016 05:29:54 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 4/6] iio: accel: bmg160: optimize transfers in trigger handler
Date: Thu, 24 Mar 2016 11:29:29 +0200
Message-Id: <1458811771-25217-5-git-send-email-irina.tirdea@intel.com>
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
 drivers/iio/gyro/bmg160_core.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 8d6e5b1..43570b8 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -734,6 +734,7 @@ static const struct iio_event_spec bmg160_event = {
 		.sign = 's',						\
 		.realbits = 16,					\
 		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &bmg160_event,					\
 	.num_event_specs = 1						\
@@ -773,20 +774,14 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmg160_data *data = iio_priv(indio_dev);
-	int bit, ret, i = 0;
-	unsigned int val;
+	int ret;
 
 	mutex_lock(&data->mutex);
-	for (bit = 0; bit < AXIS_MAX; bit++) {
-		ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(bit),
-				       &val, 2);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			goto err;
-		}
-		data->buffer[i++] = ret;
-	}
+	ret = regmap_bulk_read(data->regmap, BMG160_REG_XOUT_L,
+			       data->buffer, AXIS_MAX * 2);
 	mutex_unlock(&data->mutex);
+	if (ret < 0)
+		goto err;
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
 					   pf->timestamp);
-- 
1.9.1

