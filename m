Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:33162 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756976AbcCXJ3p (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 24 Mar 2016 05:29:45 -0400
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Octavian Purdila <octavian.purdila@intel.com>,
	Markus Pargmann <mpa@pengutronix.de>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/6] iio: accel: bmc150: use available_scan_masks
Date: Thu, 24 Mar 2016 11:29:26 +0200
Message-Id: <1458811771-25217-2-git-send-email-irina.tirdea@intel.com>
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
 drivers/iio/accel/bmc150-accel-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index c73331f7..cc52366 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -138,6 +138,7 @@ enum bmc150_accel_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 enum bmc150_power_modes {
@@ -1104,6 +1105,10 @@ static const struct iio_info bmc150_accel_info_fifo = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long bmc150_accel_scan_masks[] = {
+					BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z),
+					0};
+
 static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -1113,8 +1118,7 @@ static irqreturn_t bmc150_accel_trigger_handler(int irq, void *p)
 	unsigned int raw_val;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = regmap_bulk_read(data->regmap,
 				       BMC150_ACCEL_AXIS_TO_REG(bit), &raw_val,
 				       2);
@@ -1574,6 +1578,7 @@ int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
 	indio_dev->channels = data->chip_info->channels;
 	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->name = name ? name : data->chip_info->name;
+	indio_dev->available_scan_masks = bmc150_accel_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmc150_accel_info;
 
-- 
1.9.1

