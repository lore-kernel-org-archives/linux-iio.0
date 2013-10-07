Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-020.synserver.de ([212.40.185.20]:1051 "EHLO
	smtp-out-017.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753350Ab3JGOJr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Oct 2013 10:09:47 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 08/20] staging:iio:lis3l02dq: Switch to new event config interface
Date: Mon,  7 Oct 2013 16:11:22 +0200
Message-Id: <1381155094-20166-8-git-send-email-lars@metafoo.de>
In-Reply-To: <1381155094-20166-1-git-send-email-lars@metafoo.de>
References: <1381155094-20166-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Switch the lis3l02dq driver to the new IIO event config interface as the old one
is going to be removed.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/lis3l02dq_core.c | 64 ++++++++++++++++++++----------
 1 file changed, 43 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index bb852dc..78187f1 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -190,15 +190,26 @@ static u8 lis3l02dq_axis_map[3][3] = {
 };
 
 static int lis3l02dq_read_thresh(struct iio_dev *indio_dev,
-				 u64 e,
-				 int *val)
+				 const struct iio_chan_spec *chan,
+				 enum iio_event_type type,
+				 enum iio_event_direction dir,
+				 enum iio_event_info info,
+				 int *val, int *val2)
 {
-	return lis3l02dq_read_reg_s16(indio_dev, LIS3L02DQ_REG_THS_L_ADDR, val);
+	int ret;
+
+	ret = lis3l02dq_read_reg_s16(indio_dev, LIS3L02DQ_REG_THS_L_ADDR, val);
+	if (ret)
+		return ret;
+	return IIO_VAL_INT;
 }
 
 static int lis3l02dq_write_thresh(struct iio_dev *indio_dev,
-				  u64 event_code,
-				  int val)
+				  const struct iio_chan_spec *chan,
+				  enum iio_event_type type,
+				  enum iio_event_direction dir,
+				  enum iio_event_info info,
+				  int val, int val2)
 {
 	u16 value = val;
 	return lis3l02dq_spi_write_reg_s16(indio_dev,
@@ -503,9 +514,19 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-#define LIS3L02DQ_EVENT_MASK					\
-	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |	\
-	 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
+static const struct iio_event_spec lis3l02dq_event[] = {
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
+	}
+};
 
 #define LIS3L02DQ_CHAN(index, mod)				\
 	{							\
@@ -523,7 +544,8 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 			.realbits = 12,				\
 			.storagebits = 16,			\
 		},						\
-		.event_mask = LIS3L02DQ_EVENT_MASK,		\
+		.event_spec = lis3l02dq_event,			\
+		.num_event_specs = ARRAY_SIZE(lis3l02dq_event),	\
 	 }
 
 static const struct iio_chan_spec lis3l02dq_channels[] = {
@@ -535,14 +557,14 @@ static const struct iio_chan_spec lis3l02dq_channels[] = {
 
 
 static int lis3l02dq_read_event_config(struct iio_dev *indio_dev,
-					   u64 event_code)
+				       const struct iio_chan_spec *chan,
+				       enum iio_event_type type,
+				       enum iio_event_direction dir)
 {
 
 	u8 val;
 	int ret;
-	u8 mask = (1 << (IIO_EVENT_CODE_EXTRACT_MODIFIER(event_code)*2 +
-			 (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			  IIO_EV_DIR_RISING)));
+	u8 mask = (1 << (chan->channel2*2 + (dir == IIO_EV_DIR_RISING)));
 	ret = lis3l02dq_spi_read_reg_8(indio_dev,
 				       LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
 				       &val);
@@ -587,16 +609,16 @@ error_ret:
 }
 
 static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
-					u64 event_code,
+					const struct iio_chan_spec *chan,
+					enum iio_event_type type,
+					enum iio_event_direction dir,
 					int state)
 {
 	int ret = 0;
 	u8 val, control;
 	u8 currentlyset;
 	bool changed = false;
-	u8 mask = (1 << (IIO_EVENT_CODE_EXTRACT_MODIFIER(event_code)*2 +
-			 (IIO_EVENT_CODE_EXTRACT_DIR(event_code) ==
-			  IIO_EV_DIR_RISING)));
+	u8 mask = (1 << (chan->channel2*2 + (dir == IIO_EV_DIR_RISING)));
 
 	mutex_lock(&indio_dev->mlock);
 	/* read current control */
@@ -654,10 +676,10 @@ static const struct attribute_group lis3l02dq_attribute_group = {
 static const struct iio_info lis3l02dq_info = {
 	.read_raw = &lis3l02dq_read_raw,
 	.write_raw = &lis3l02dq_write_raw,
-	.read_event_value = &lis3l02dq_read_thresh,
-	.write_event_value = &lis3l02dq_write_thresh,
-	.write_event_config = &lis3l02dq_write_event_config,
-	.read_event_config = &lis3l02dq_read_event_config,
+	.read_event_value_new = &lis3l02dq_read_thresh,
+	.write_event_value_new = &lis3l02dq_write_thresh,
+	.write_event_config_new = &lis3l02dq_write_event_config,
+	.read_event_config_new = &lis3l02dq_read_event_config,
 	.driver_module = THIS_MODULE,
 	.attrs = &lis3l02dq_attribute_group,
 };
-- 
1.8.0

