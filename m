Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33162 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757051AbcCXJ3u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Mar 2016 05:29:50 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 3/6] iio: gyro: bmg160: use available_scan_masks
Date: Thu, 24 Mar 2016 11:29:28 +0200
Message-Id: <1458811771-25217-4-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
References: <1458811771-25217-1-git-send-email-irina.tirdea@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use available_scan_masks to allow the iio core to select
the data to send to userspace depending on which axes are
enabled, instead of doing this in the driver's interrupt
handler.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/gyro/bmg160_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index bbce3b0..8d6e5b1 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -116,6 +116,7 @@ enum bmg160_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 static const struct {
@@ -763,6 +764,10 @@ static const struct iio_info bmg160_info = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long bmg160_accel_scan_masks[] = {
+					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+					0};
+
 static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -772,8 +777,7 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	unsigned int val;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(bit),
 				       &val, 2);
 		if (ret < 0) {
@@ -1019,6 +1023,7 @@ int bmg160_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->channels = bmg160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmg160_channels);
 	indio_dev->name = name;
+	indio_dev->available_scan_masks = bmg160_accel_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmg160_info;
 
-- 
1.9.1

