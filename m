Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 105/111] staging:iio:accel:lis3l02dq make write_reg_8 take value not a pointer to value.
Date: Wed, 18 May 2011 14:42:35 +0100
Message-Id: <1305726161-5606-106-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Silliness that has been there a long time.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/lis3l02dq.h      |    2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |   30 ++++++++++++++--------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |   10 ++++----
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 94d9869..18b23ac 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -170,7 +170,7 @@ int lis3l02dq_spi_read_reg_8(struct iio_dev *indio_dev,
 
 int lis3l02dq_spi_write_reg_8(struct iio_dev *indio_dev,
 			      u8 reg_address,
-			      u8 *val);
+			      u8 val);
 
 int lis3l02dq_disable_all_events(struct iio_dev *indio_dev);
 
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 6b5414c..942139a 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -82,14 +82,14 @@ int lis3l02dq_spi_read_reg_8(struct iio_dev *indio_dev,
  **/
 int lis3l02dq_spi_write_reg_8(struct iio_dev *indio_dev,
 			      u8 reg_address,
-			      u8 *val)
+			      u8 val)
 {
 	int ret;
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = LIS3L02DQ_WRITE_REG(reg_address);
-	st->tx[1] = *val;
+	st->tx[1] = val;
 	ret = spi_write(st->us, st->tx, 2);
 	mutex_unlock(&st->buf_lock);
 
@@ -232,14 +232,14 @@ static int lis3l02dq_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		sval = val;
 		reg = lis3l02dq_axis_map[LIS3L02DQ_BIAS][chan->address];
-		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, (u8 *)&sval);
+		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, sval);
 		break;
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
 		if (val & ~0xFF)
 			return -EINVAL;
 		uval = val;
 		reg = lis3l02dq_axis_map[LIS3L02DQ_GAIN][chan->address];
-		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, &uval);
+		ret = lis3l02dq_spi_write_reg_8(indio_dev, reg, uval);
 		break;
 	}
 	return ret;
@@ -367,7 +367,7 @@ static ssize_t lis3l02dq_write_frequency(struct device *dev,
 
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
-					&t);
+					t);
 
 error_ret_mutex:
 	mutex_unlock(&indio_dev->mlock);
@@ -389,7 +389,7 @@ static int lis3l02dq_initial_setup(struct iio_dev *indio_dev)
 	/* Write suitable defaults to ctrl1 */
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
-					&val);
+					val);
 	if (ret) {
 		dev_err(&st->us->dev, "problem with setup control register 1");
 		goto err_ret;
@@ -397,7 +397,7 @@ static int lis3l02dq_initial_setup(struct iio_dev *indio_dev)
 	/* Repeat as sometimes doesn't work first time?*/
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
-					&val);
+					val);
 	if (ret) {
 		dev_err(&st->us->dev, "problem with setup control register 1");
 		goto err_ret;
@@ -418,7 +418,7 @@ static int lis3l02dq_initial_setup(struct iio_dev *indio_dev)
 	val = LIS3L02DQ_DEFAULT_CTRL2;
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_2_ADDR,
-					&val);
+					val);
 	if (ret) {
 		dev_err(&st->us->dev, "problem with setup control register 2");
 		goto err_ret;
@@ -427,7 +427,7 @@ static int lis3l02dq_initial_setup(struct iio_dev *indio_dev)
 	val = LIS3L02DQ_REG_WAKE_UP_CFG_LATCH_SRC;
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
-					&val);
+					val);
 	if (ret)
 		dev_err(&st->us->dev, "problem with interrupt cfg register");
 err_ret:
@@ -564,7 +564,7 @@ int lis3l02dq_disable_all_events(struct iio_dev *indio_dev)
 	control &= ~LIS3L02DQ_REG_CTRL_2_ENABLE_INTERRUPT;
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_2_ADDR,
-					&control);
+					control);
 	if (ret)
 		goto error_ret;
 	/* Also for consistency clear the mask */
@@ -577,7 +577,7 @@ int lis3l02dq_disable_all_events(struct iio_dev *indio_dev)
 
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
-					&val);
+					val);
 	if (ret)
 		goto error_ret;
 
@@ -623,7 +623,7 @@ static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 	if (changed) {
 		ret = lis3l02dq_spi_write_reg_8(indio_dev,
 						LIS3L02DQ_REG_WAKE_UP_CFG_ADDR,
-						&val);
+						val);
 		if (ret)
 			goto error_ret;
 		control = val & 0x3f ?
@@ -631,7 +631,7 @@ static int lis3l02dq_write_event_config(struct iio_dev *indio_dev,
 			(control & ~LIS3L02DQ_REG_CTRL_2_ENABLE_INTERRUPT);
 		ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					       LIS3L02DQ_REG_CTRL_2_ADDR,
-					       &control);
+					       control);
 		if (ret)
 			goto error_ret;
 	}
@@ -750,7 +750,7 @@ static int lis3l02dq_stop_device(struct iio_dev *indio_dev)
 	mutex_lock(&indio_dev->mlock);
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
-					&val);
+					val);
 	if (ret) {
 		dev_err(&st->us->dev, "problem with turning device off: ctrl1");
 		goto err_ret;
@@ -758,7 +758,7 @@ static int lis3l02dq_stop_device(struct iio_dev *indio_dev)
 
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_2_ADDR,
-					&val);
+					val);
 	if (ret)
 		dev_err(&st->us->dev, "problem with turning device off: ctrl2");
 err_ret:
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index c8f29bc..1c208d2 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -220,12 +220,12 @@ __lis3l02dq_write_data_ready_config(struct device *dev, bool state)
 		/* The double write is to overcome a hardware bug?*/
 		ret = lis3l02dq_spi_write_reg_8(indio_dev,
 						LIS3L02DQ_REG_CTRL_2_ADDR,
-						&valold);
+						valold);
 		if (ret)
 			goto error_ret;
 		ret = lis3l02dq_spi_write_reg_8(indio_dev,
 						LIS3L02DQ_REG_CTRL_2_ADDR,
-						&valold);
+						valold);
 		if (ret)
 			goto error_ret;
 		st->trigger_on = false;
@@ -243,7 +243,7 @@ __lis3l02dq_write_data_ready_config(struct device *dev, bool state)
 		st->trigger_on = true;
 		ret = lis3l02dq_spi_write_reg_8(indio_dev,
 						LIS3L02DQ_REG_CTRL_2_ADDR,
-						&valold);
+						valold);
 		if (ret)
 			goto error_ret;
 	}
@@ -382,7 +382,7 @@ static int lis3l02dq_ring_postenable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
-					&t);
+					t);
 	if (ret)
 		goto error_ret;
 
@@ -412,7 +412,7 @@ static int lis3l02dq_ring_predisable(struct iio_dev *indio_dev)
 
 	ret = lis3l02dq_spi_write_reg_8(indio_dev,
 					LIS3L02DQ_REG_CTRL_1_ADDR,
-					&t);
+					t);
 
 error_ret:
 	return ret;
-- 
1.7.3.4
