Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1083 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754969Ab3JGOJq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:46 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH v2 07/20] iio:apds9300: Use new event config interface
Date: Mon,  7 Oct 2013 16:11:21 +0200
Message-Id: <1381155094-20166-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the apds9300 driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/light/apds9300.c | 53 ++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 66a58bd..51097bb 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -273,12 +273,14 @@ static int apds9300_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int apds9300_read_thresh(struct iio_dev *indio_dev, u64 event_code,
-		int *val)
+static int apds9300_read_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info,
+		int *val, int *val2)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 
-	switch (IIO_EVENT_CODE_EXTRACT_DIR(event_code)) {
+	switch (dir) {
 	case IIO_EV_DIR_RISING:
 		*val = data->thresh_hi;
 		break;
@@ -289,17 +291,19 @@ static int apds9300_read_thresh(struct iio_dev *indio_dev, u64 event_code,
 		return -EINVAL;
 	}
 
-	return 0;
+	return IIO_VAL_INT;
 }
 
-static int apds9300_write_thresh(struct iio_dev *indio_dev, u64 event_code,
-		int val)
+static int apds9300_write_thresh(struct iio_dev *indio_dev,
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, enum iio_event_info info, int val,
+		int val2)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&data->mutex);
-	if (IIO_EVENT_CODE_EXTRACT_DIR(event_code) == IIO_EV_DIR_RISING)
+	if (dir == IIO_EV_DIR_RISING)
 		ret = apds9300_set_thresh_hi(data, val);
 	else
 		ret = apds9300_set_thresh_low(data, val);
@@ -309,7 +313,9 @@ static int apds9300_write_thresh(struct iio_dev *indio_dev, u64 event_code,
 }
 
 static int apds9300_read_interrupt_config(struct iio_dev *indio_dev,
-		u64 event_code)
+		const struct iio_chan_spec *chan,
+		enum iio_event_type type,
+		enum iio_event_direction dir)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 
@@ -317,7 +323,8 @@ static int apds9300_read_interrupt_config(struct iio_dev *indio_dev,
 }
 
 static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
-		u64 event_code, int state)
+		const struct iio_chan_spec *chan, enum iio_event_type type,
+		enum iio_event_direction dir, int state)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
 	int ret;
@@ -337,10 +344,24 @@ static const struct iio_info apds9300_info_no_irq = {
 static const struct iio_info apds9300_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= apds9300_read_raw,
-	.read_event_value	= apds9300_read_thresh,
-	.write_event_value	= apds9300_write_thresh,
-	.read_event_config	= apds9300_read_interrupt_config,
-	.write_event_config	= apds9300_write_interrupt_config,
+	.read_event_value_new	= apds9300_read_thresh,
+	.write_event_value_new	= apds9300_write_thresh,
+	.read_event_config_new	= apds9300_read_interrupt_config,
+	.write_event_config_new	= apds9300_write_interrupt_config,
+};
+
+static const struct iio_event_spec apds9300_event_spec[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	}, {
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_ENABLE),
+	},
 };
 
 static const struct iio_chan_spec apds9300_channels[] = {
@@ -355,10 +376,8 @@ static const struct iio_chan_spec apds9300_channels[] = {
 		.channel2 = IIO_MOD_LIGHT_BOTH,
 		.indexed = true,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					  IIO_EV_DIR_RISING) |
-			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
-					  IIO_EV_DIR_FALLING)),
+		.event_spec = apds9300_event_spec,
+		.num_event_specs = ARRAY_SIZE(apds9300_event_spec),
 	}, {
 		.type = IIO_INTENSITY,
 		.channel = 1,
-- 
1.8.0

