Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47722 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758483Ab1CCRlJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2011 12:41:09 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/2] staging:iio:lis3l02dq use standard functions where possible.
Date: Thu,  3 Mar 2011 17:41:41 +0000
Message-Id: <1299174101-1030-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1299174101-1030-1-git-send-email-jic23@cam.ac.uk>
References: <1299174101-1030-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>

Cherry picked out of Manuels patch and fixed up.
Original proposal was embedded in a fix patch that needs to go
to stable rather than separated out.

Also didn't take into account that lis3l02dq_spi_read_8 will now
return the value whereas previously returned 0 on success.
Tests of return value need to be updated to take this into account.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   50 ++++++++--------------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |    4 +-
 2 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 575012a..bd378bc 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -48,27 +48,13 @@
 int lis3l02dq_spi_read_reg_8(struct device *dev, u8 reg_address, u8 *val)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_sw_ring_helper_state *h = iio_dev_get_devdata(indio_dev);
 	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
 
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.rx_buf = st->rx,
-		.bits_per_word = 8,
-		.len = 2,
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = LIS3L02DQ_READ_REG(reg_address);
-	st->tx[1] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->us, &msg);
-	*val = st->rx[1];
-	mutex_unlock(&st->buf_lock);
+	ret = spi_w8r8(st->us, LIS3L02DQ_READ_REG(reg_address));
+	if (ret >= 0)
+		*val = ret;
 
 	return ret;
 }
@@ -84,24 +70,17 @@ int lis3l02dq_spi_write_reg_8(struct device *dev,
 			      u8 *val)
 {
 	int ret;
-	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_sw_ring_helper_state *h
 		= iio_dev_get_devdata(indio_dev);
 	struct lis3l02dq_state *st = lis3l02dq_h_to_s(h);
-	struct spi_transfer xfer = {
-		.tx_buf = st->tx,
-		.bits_per_word = 8,
-		.len = 2,
-	};
+
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = LIS3L02DQ_WRITE_REG(reg_address);
 	st->tx[1] = *val;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->us, &msg);
+	ret = spi_write(st->us, st->tx, 2);
 	mutex_unlock(&st->buf_lock);
 
 	return ret;
@@ -133,7 +112,6 @@ static int lis3l02dq_spi_write_reg_s16(struct device *dev,
 			.tx_buf = st->tx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 0,
 		},
 	};
 
@@ -180,7 +158,6 @@ static int lis3l02dq_spi_read_reg_s16(struct device *dev,
 			.rx_buf = st->rx + 2,
 			.bits_per_word = 8,
 			.len = 2,
-			.cs_change = 0,
 		},
 	};
 
@@ -221,7 +198,7 @@ static ssize_t lis3l02dq_read_signed(struct device *dev,
 
 	ret = lis3l02dq_spi_read_reg_8(dev, this_attr->address, (u8 *)&val);
 
-	return ret ? ret : sprintf(buf, "%d\n", val);
+	return (ret < 0) ? ret : sprintf(buf, "%d\n", val);
 }
 
 static ssize_t lis3l02dq_read_unsigned(struct device *dev,
@@ -234,7 +211,7 @@ static ssize_t lis3l02dq_read_unsigned(struct device *dev,
 
 	ret = lis3l02dq_spi_read_reg_8(dev, this_attr->address, &val);
 
-	return ret ? ret : sprintf(buf, "%d\n", val);
+	return (ret < 0) ? ret : sprintf(buf, "%d\n", val);
 }
 
 static ssize_t lis3l02dq_write_signed(struct device *dev,
@@ -338,7 +315,7 @@ static ssize_t lis3l02dq_read_frequency(struct device *dev,
 	ret = lis3l02dq_spi_read_reg_8(dev,
 				       LIS3L02DQ_REG_CTRL_1_ADDR,
 				       (u8 *)&t);
-	if (ret)
+	if (ret < 0)
 		return ret;
 	t &= LIS3L02DQ_DEC_MASK;
 	switch (t) {
@@ -376,7 +353,7 @@ static ssize_t lis3l02dq_write_frequency(struct device *dev,
 	ret = lis3l02dq_spi_read_reg_8(dev,
 				       LIS3L02DQ_REG_CTRL_1_ADDR,
 				       &t);
-	if (ret)
+	if (ret < 0)
 		goto error_ret_mutex;
 	/* Wipe the bits clean */
 	t &= ~LIS3L02DQ_DEC_MASK;
@@ -440,7 +417,7 @@ static int lis3l02dq_initial_setup(struct lis3l02dq_state *st)
 	ret = lis3l02dq_spi_read_reg_8(&st->help.indio_dev->dev,
 				       LIS3L02DQ_REG_CTRL_1_ADDR,
 				       &valtest);
-	if (ret || (valtest != val)) {
+	if ((ret < 0) || (valtest != val)) {
 		dev_err(&st->help.indio_dev->dev, "device not playing ball");
 		ret = -EINVAL;
 		goto err_ret;
@@ -532,7 +509,8 @@ static ssize_t lis3l02dq_read_interrupt_config(struct device *dev,
 				       LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
 				       (u8 *)&val);
 
-	return ret ? ret : sprintf(buf, "%d\n", !!(val & this_attr->mask));
+	return (ret < 0) ?
+		ret : sprintf(buf, "%d\n", !!(val & this_attr->mask));
 }
 
 static ssize_t lis3l02dq_write_interrupt_config(struct device *dev,
@@ -553,14 +531,14 @@ static ssize_t lis3l02dq_write_interrupt_config(struct device *dev,
 	ret = lis3l02dq_spi_read_reg_8(dev->parent,
 				       LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
 				       &valold);
-	if (ret)
+	if (ret < 0)
 		goto error_mutex_unlock;
 
 	/* read current control */
 	ret = lis3l02dq_spi_read_reg_8(dev,
 				       LIS3L02DQ_REG_CTRL_2_ADDR,
 				       &controlold);
-	if (ret)
+	if (ret < 0)
 		goto error_mutex_unlock;
 	currentlyset = !!(valold & this_attr->mask);
 	if (val == false && currentlyset) {
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index 2c461a3..a9896da 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -46,7 +46,7 @@ static int lis3l02dq_scan_el_set_state(struct iio_scan_el *scan_el,
 	ret = lis3l02dq_spi_read_reg_8(&indio_dev->dev,
 				       LIS3L02DQ_REG_CTRL_1_ADDR,
 				       &t);
-	if (ret)
+	if (ret < 0)
 		goto error_ret;
 	switch (scan_el->label) {
 	case LIS3L02DQ_REG_OUT_X_L_ADDR:
@@ -320,7 +320,7 @@ __lis3l02dq_write_data_ready_config(struct device *dev,
 	ret = lis3l02dq_spi_read_reg_8(dev,
 				       LIS3L02DQ_REG_CTRL_2_ADDR,
 				       &valold);
-	if (ret)
+	if (ret < 0)
 		goto error_ret;
 /* Find out if data ready is already on */
 	currentlyset
-- 
1.7.3.4

