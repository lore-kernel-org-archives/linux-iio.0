Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v3 5/8] iio: gyro: bmg160: use available_scan_masks
Date: Fri,  3 Jul 2015 12:33:34 +0300
Message-Id: <1435916017-12859-6-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Use available_scan_masks to allow the iio core to select
the data to send to userspace depending on which axes are
enabled, instead of doing this in the driver's interrupt
handler.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/gyro/bmg160.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
index 4415f55..4b423f2 100644
--- a/drivers/iio/gyro/bmg160.c
+++ b/drivers/iio/gyro/bmg160.c
@@ -115,6 +115,7 @@ enum bmg160_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
+	AXIS_MAX,
 };
 
 static const struct {
@@ -814,6 +815,8 @@ static const struct iio_info bmg160_info = {
 	.driver_module		= THIS_MODULE,
 };
 
+static const unsigned long bmg160_scan_masks[] = {0x7, 0};
+
 static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -822,8 +825,7 @@ static irqreturn_t bmg160_trigger_handler(int irq, void *p)
 	int bit, ret, i = 0;
 
 	mutex_lock(&data->mutex);
-	for_each_set_bit(bit, indio_dev->active_scan_mask,
-			 indio_dev->masklength) {
+	for (bit = 0; bit < AXIS_MAX; bit++) {
 		ret = i2c_smbus_read_word_data(data->client,
 					       BMG160_AXIS_TO_REG(bit));
 		if (ret < 0) {
@@ -1056,6 +1058,7 @@ static int bmg160_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = bmg160_channels;
 	indio_dev->num_channels = ARRAY_SIZE(bmg160_channels);
+	indio_dev->available_scan_masks = bmg160_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmg160_info;
-- 
1.9.1
