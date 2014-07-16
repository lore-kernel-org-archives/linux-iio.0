Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41225 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934930AbaGPSdG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:06 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 09/13] iio:bma180: Introduce part_info to differentiate further chip variants
Date: Wed, 16 Jul 2014 20:32:52 +0200
Message-Id: <1405535576-26482-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 5838318..fc7c7b8 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -26,6 +26,19 @@
 #define BMA180_DRV_NAME "bma180"
 #define BMA180_IRQ_NAME "bma180_event"
 
+enum {
+	BMA180,
+};
+
+struct bma180_part_info {
+	const struct iio_chan_spec *channels;
+	unsigned num_channels;
+	const int *scale_table;
+	unsigned num_scales;
+	const int *bw_table;
+	unsigned num_bw;
+};
+
 /* Register set */
 #define BMA180_CHIP_ID		0x00 /* Need to distinguish BMA180 from other */
 #define BMA180_ACC_X_LSB	0x02 /* First of 6 registers of accel data */
@@ -77,6 +90,7 @@
 struct bma180_data {
 	struct i2c_client *client;
 	struct iio_trigger *trig;
+	const struct bma180_part_info *part_info;
 	struct mutex mutex;
 	bool sleep_state;
 	int scale;
@@ -193,8 +207,8 @@ static int bma180_set_bw(struct bma180_data *data, int val)
 	if (data->sleep_state)
 		return -EBUSY;
 
-	for (i = 0; i < ARRAY_SIZE(bma180_bw_table); ++i) {
-		if (bma180_bw_table[i] == val) {
+	for (i = 0; i < data->part_info->num_bw; ++i) {
+		if (data->part_info->bw_table[i] == val) {
 			ret = bma180_set_bits(data,
 					BMA180_BW_TCS, BMA180_BW, i);
 			if (ret) {
@@ -217,8 +231,8 @@ static int bma180_set_scale(struct bma180_data *data, int val)
 	if (data->sleep_state)
 		return -EBUSY;
 
-	for (i = 0; i < ARRAY_SIZE(bma180_scale_table); ++i)
-		if (bma180_scale_table[i] == val) {
+	for (i = 0; i < data->part_info->num_scales; ++i)
+		if (data->part_info->scale_table[i] == val) {
 			ret = bma180_set_bits(data,
 					BMA180_OFFSET_LSB1, BMA180_RANGE, i);
 			if (ret) {
@@ -488,6 +502,14 @@ static const struct iio_chan_spec bma180_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(4),
 };
 
+static const struct bma180_part_info bma180_part_info[] = {
+	[BMA180] = {
+		bma180_channels, ARRAY_SIZE(bma180_channels),
+		bma180_scale_table, ARRAY_SIZE(bma180_scale_table),
+		bma180_bw_table, ARRAY_SIZE(bma180_bw_table),
+	},
+};
+
 static irqreturn_t bma180_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -554,6 +576,7 @@ static int bma180_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
+	data->part_info = &bma180_part_info[id->driver_data];
 
 	ret = bma180_chip_init(data);
 	if (ret < 0)
@@ -562,8 +585,8 @@ static int bma180_probe(struct i2c_client *client,
 	mutex_init(&data->mutex);
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->channels = bma180_channels;
-	indio_dev->num_channels = ARRAY_SIZE(bma180_channels);
+	indio_dev->channels = data->part_info->channels;
+	indio_dev->num_channels = data->part_info->num_channels;
 	indio_dev->name = BMA180_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bma180_info;
@@ -674,8 +697,8 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 #define BMA180_PM_OPS NULL
 #endif
 
-static struct i2c_device_id bma180_id[] = {
-	{ BMA180_DRV_NAME, 0 },
+static struct i2c_device_id bma180_ids[] = {
+	{ BMA180_DRV_NAME, BMA180 },
 	{ }
 };
 
@@ -689,7 +712,7 @@ static struct i2c_driver bma180_driver = {
 	},
 	.probe		= bma180_probe,
 	.remove		= bma180_remove,
-	.id_table	= bma180_id,
+	.id_table	= bma180_ids,
 };
 
 module_i2c_driver(bma180_driver);
-- 
1.9.1

