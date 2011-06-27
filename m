Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/54] staging:iio:accel:sca3000: allocate state in iio_dev and use iio_priv to access.
Date: Mon, 27 Jun 2011 11:04:21 +0100
Message-Id: <1309169104-22139-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Mechanical change.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000.h      |    1 -
 drivers/staging/iio/accel/sca3000_core.c |   99 ++++++++++++++----------------
 drivers/staging/iio/accel/sca3000_ring.c |   14 ++--
 3 files changed, 52 insertions(+), 62 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.h b/drivers/staging/iio/accel/sca3000.h
index cf0751d..1e396ce 100644
--- a/drivers/staging/iio/accel/sca3000.h
+++ b/drivers/staging/iio/accel/sca3000.h
@@ -173,7 +173,6 @@
 struct sca3000_state {
 	struct spi_device		*us;
 	const struct sca3000_chip_info	*info;
-	struct iio_dev			*indio_dev;
 	struct work_struct		interrupt_handler_ws;
 	s64				last_timestamp;
 	int				mo_det_use_count;
diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index f213b86..4313f73 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -242,7 +242,7 @@ static int sca3000_check_status(struct device *dev)
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_STATUS, 1);
@@ -269,7 +269,7 @@ static ssize_t sca3000_show_rev(struct device *dev,
 {
 	int len = 0, ret;
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = dev_info->dev_data;
+	struct sca3000_state *st = iio_priv(dev_info);
 
 	mutex_lock(&st->lock);
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_REVID, 1);
@@ -297,7 +297,7 @@ sca3000_show_available_measurement_modes(struct device *dev,
 					 char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = dev_info->dev_data;
+	struct sca3000_state *st = iio_priv(dev_info);
 	int len = 0;
 
 	len += sprintf(buf + len, "0 - normal mode");
@@ -329,7 +329,7 @@ sca3000_show_measurement_mode(struct device *dev,
 			      char *buf)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = dev_info->dev_data;
+	struct sca3000_state *st = iio_priv(dev_info);
 	int len = 0, ret;
 
 	mutex_lock(&st->lock);
@@ -380,7 +380,7 @@ sca3000_store_measurement_mode(struct device *dev,
 			       size_t len)
 {
 	struct iio_dev *dev_info = dev_get_drvdata(dev);
-	struct sca3000_state *st = dev_info->dev_data;
+	struct sca3000_state *st = iio_priv(dev_info);
 	int ret;
 	int mask = 0x03;
 	long val;
@@ -453,7 +453,7 @@ static int sca3000_read_raw(struct iio_dev *indio_dev,
 			    int *val2,
 			    long mask)
 {
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	u8 address;
 
@@ -500,7 +500,7 @@ static ssize_t sca3000_read_av_freq(struct device *dev,
 			     char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int len = 0, ret, val;
 
 	mutex_lock(&st->lock);
@@ -571,7 +571,7 @@ static ssize_t sca3000_read_frequency(struct device *dev,
 			       char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, len = 0, base_freq = 0, val;
 
 	mutex_lock(&st->lock);
@@ -613,7 +613,7 @@ static ssize_t sca3000_set_frequency(struct device *dev,
 			      size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, base_freq = 0;
 	int ctrlval;
 	long val;
@@ -673,7 +673,7 @@ static ssize_t sca3000_read_temp(struct device *dev,
 				 char *buf)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	int val;
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_TEMP_MSB, 2);
@@ -699,7 +699,7 @@ static int sca3000_read_thresh(struct iio_dev *indio_dev,
 			       int *val)
 {
 	int ret, i;
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
 	mutex_lock(&st->lock);
 	ret = sca3000_read_ctrl_reg(st, sca3000_addresses[num][1]);
@@ -726,7 +726,7 @@ static int sca3000_write_thresh(struct iio_dev *indio_dev,
 				    int e,
 				    int val)
 {
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
 	int ret;
 	int i;
@@ -798,11 +798,10 @@ static const struct attribute_group sca3000_attribute_group_with_temp = {
 static irqreturn_t sca3000_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct sca3000_state *st;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, val;
 	s64 last_timestamp = iio_get_time_ns();
 
-	st = indio_dev->dev_data;
 	/* Could lead if badly timed to an extra read of status reg,
 	 * but ensures no interrupt is missed.
 	 */
@@ -813,10 +812,10 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 	if (ret)
 		goto done;
 
-	sca3000_ring_int_process(val, st->indio_dev->ring);
+	sca3000_ring_int_process(val, indio_dev->ring);
 
 	if (val & SCA3000_INT_STATUS_FREE_FALL)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_X_AND_Y_AND_Z,
@@ -825,7 +824,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 			       last_timestamp);
 
 	if (val & SCA3000_INT_STATUS_Y_TRIGGER)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Y,
@@ -834,7 +833,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 			       last_timestamp);
 
 	if (val & SCA3000_INT_STATUS_X_TRIGGER)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_X,
@@ -843,7 +842,7 @@ static irqreturn_t sca3000_event_handler(int irq, void *private)
 			       last_timestamp);
 
 	if (val & SCA3000_INT_STATUS_Z_TRIGGER)
-		iio_push_event(st->indio_dev, 0,
+		iio_push_event(indio_dev, 0,
 			       IIO_MOD_EVENT_CODE(IIO_EV_CLASS_ACCEL,
 						  0,
 						  IIO_EV_MOD_Z,
@@ -861,7 +860,7 @@ done:
 static int sca3000_read_event_config(struct iio_dev *indio_dev,
 				     int e)
 {
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	u8 protect_mask = 0x03;
 	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
@@ -895,7 +894,7 @@ static ssize_t sca3000_query_free_fall_mode(struct device *dev,
 {
 	int ret, len;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int val;
 
 	mutex_lock(&st->lock);
@@ -923,7 +922,7 @@ static ssize_t sca3000_set_free_fall_mode(struct device *dev,
 					  size_t len)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	long val;
 	int ret;
 	u8 protect_mask = SCA3000_FREE_FALL_DETECT;
@@ -965,7 +964,7 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 				      int e,
 				      int state)
 {
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, ctrlval;
 	u8 protect_mask = 0x03;
 	int num = IIO_EVENT_CODE_EXTRACT_MODIFIER(e);
@@ -1126,42 +1125,37 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 {
 	int ret, regdone = 0;
 	struct sca3000_state *st;
+	struct iio_dev *indio_dev;
 
-	st = kzalloc(sizeof(struct sca3000_state), GFP_KERNEL);
-	if (st == NULL) {
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	spi_set_drvdata(spi, st);
 
+	spi_set_drvdata(spi, indio_dev);
 	st->us = spi;
 	mutex_init(&st->lock);
 	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
 					      ->driver_data];
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_clear_st;
-	}
-	st->indio_dev->dev.parent = &spi->dev;
-	st->indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->name = spi_get_device_id(spi)->name;
 	if (st->info->temp_output)
-		st->indio_dev->info = &sca3000_info_with_temp;
+		indio_dev->info = &sca3000_info_with_temp;
 	else {
-		st->indio_dev->info = &sca3000_info;
-		st->indio_dev->channels = sca3000_channels;
-		st->indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
+		indio_dev->info = &sca3000_info;
+		indio_dev->channels = sca3000_channels;
+		indio_dev->num_channels = ARRAY_SIZE(sca3000_channels);
 	}
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	sca3000_configure_ring(st->indio_dev);
-	ret = iio_device_register(st->indio_dev);
+	sca3000_configure_ring(indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret < 0)
 		goto error_free_dev;
 	regdone = 1;
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
 					  sca3000_channels,
 					  ARRAY_SIZE(sca3000_channels));
 	if (ret < 0)
@@ -1172,11 +1166,11 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 					   &sca3000_event_handler,
 					   IRQF_TRIGGER_FALLING,
 					   "sca3000",
-					   st->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_unregister_ring;
 	}
-	sca3000_register_ring_funcs(st->indio_dev);
+	sca3000_register_ring_funcs(indio_dev);
 	ret = sca3000_clean_setup(st);
 	if (ret)
 		goto error_free_irq;
@@ -1184,17 +1178,16 @@ static int __devinit sca3000_probe(struct spi_device *spi)
 
 error_free_irq:
 	if (spi->irq && gpio_is_valid(irq_to_gpio(spi->irq)) > 0)
-		free_irq(spi->irq, st->indio_dev);
+		free_irq(spi->irq, indio_dev);
 error_unregister_ring:
-	iio_ring_buffer_unregister(st->indio_dev->ring);
+	iio_ring_buffer_unregister(indio_dev->ring);
 error_unregister_dev:
 error_free_dev:
 	if (regdone)
-		iio_device_unregister(st->indio_dev);
+		iio_device_unregister(indio_dev);
 	else
-		iio_free_device(st->indio_dev);
-error_clear_st:
-	kfree(st);
+		iio_free_device(indio_dev);
+
 error_ret:
 	return ret;
 }
@@ -1219,8 +1212,8 @@ error_ret:
 
 static int sca3000_remove(struct spi_device *spi)
 {
-	struct sca3000_state *st =  spi_get_drvdata(spi);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 	/* Must ensure no interrupts can be generated after this!*/
 	ret = sca3000_stop_all_interrupts(st);
@@ -1232,8 +1225,6 @@ static int sca3000_remove(struct spi_device *spi)
 	sca3000_unconfigure_ring(indio_dev);
 	iio_device_unregister(indio_dev);
 
-	kfree(st);
-
 	return 0;
 }
 
diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 7c4ff0b..a704c75 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -89,7 +89,7 @@ static int sca3000_read_first_n_hw_rb(struct iio_ring_buffer *r,
 {
 	struct iio_hw_ring_buffer *hw_ring = iio_to_hw_ring_buf(r);
 	struct iio_dev *indio_dev = hw_ring->private;
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	u8 *rx;
 	int ret, i, num_available, num_read = 0;
 	int bytes_per_sample = 1;
@@ -168,7 +168,7 @@ static ssize_t sca3000_query_ring_int(struct device *dev,
 	int ret, val;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_INT_MASK, 1);
@@ -190,7 +190,7 @@ static ssize_t sca3000_set_ring_int(struct device *dev,
 {
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	long val;
 	int ret;
@@ -240,7 +240,7 @@ static ssize_t sca3000_show_ring_bpse(struct device *dev,
 	int len = 0, ret;
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
 	ret = sca3000_read_data_short(st, SCA3000_REG_ADDR_MODE, 1);
@@ -270,7 +270,7 @@ static ssize_t sca3000_store_ring_bpse(struct device *dev,
 {
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&st->lock);
@@ -300,7 +300,7 @@ static ssize_t sca3000_show_buffer_scale(struct device *dev,
 {
 	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
 	struct iio_dev *indio_dev = ring->indio_dev;
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 
 	return sprintf(buf, "0.%06d\n", 4*st->info->scale);
 }
@@ -397,7 +397,7 @@ void sca3000_unconfigure_ring(struct iio_dev *indio_dev)
 static inline
 int __sca3000_hw_ring_state_set(struct iio_dev *indio_dev, bool state)
 {
-	struct sca3000_state *st = indio_dev->dev_data;
+	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&st->lock);
-- 
1.7.3.4
