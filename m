Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/1] IIO-onwards: ADC: AD799x: Use private data space from iio_allocate_device
Date: Mon, 18 Apr 2011 17:30:39 +0200
Message-ID: <1303140639-3306-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Use private data space from iio_allocate_device
Fix typo in pollfunc name

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad799x.h      |    1 -
 drivers/staging/iio/adc/ad799x_core.c |   77 +++++++++++++++------------------
 drivers/staging/iio/adc/ad799x_ring.c |    9 ++--
 3 files changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 2e1506b..ae049f4 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -103,7 +103,6 @@ struct ad799x_chip_info {
 };
 
 struct ad799x_state {
-	struct iio_dev			*indio_dev;
 	struct i2c_client		*client;
 	const struct ad799x_chip_info	*chip_info;
 	size_t				d_size;
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 10185c4..ceb75a3 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -638,14 +638,15 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 {
 	int ret, regdone = 0;
 	struct ad799x_platform_data *pdata = client->dev.platform_data;
-	struct ad799x_state *st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	struct ad799x_state *st;
+	struct iio_dev *indio_dev = iio_allocate_device(sizeof(*st));
+
+	if (indio_dev == NULL)
+		return -ENOMEM;
 
+	st = iio_priv(indio_dev);
 	/* this is only used for device removal purposes */
-	i2c_set_clientdata(client, st);
+	i2c_set_clientdata(client, indio_dev);
 
 	st->id = id->driver_data;
 	st->chip_info = &ad799x_chip_info_tbl[st->id];
@@ -666,35 +667,29 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 	}
 	st->client = client;
 
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_disable_reg;
-	}
-
-	st->indio_dev->dev.parent = &client->dev;
-	st->indio_dev->name = id->name;
-	st->indio_dev->event_attrs = st->chip_info->event_attrs;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->driver_module = THIS_MODULE;
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
-	st->indio_dev->num_interrupt_lines = 1;
-	st->indio_dev->channels = st->chip_info->channel;
-	st->indio_dev->num_channels = st->chip_info->num_channels;
-	st->indio_dev->read_raw = &ad799x_read_raw;
-
-	ret = ad799x_register_ring_funcs_and_init(st->indio_dev);
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = id->name;
+	indio_dev->event_attrs = st->chip_info->event_attrs;
+	indio_dev->dev_data = (void *)(st);
+	indio_dev->driver_module = THIS_MODULE;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_interrupt_lines = 1;
+	indio_dev->channels = st->chip_info->channel;
+	indio_dev->num_channels = st->chip_info->num_channels;
+	indio_dev->read_raw = &ad799x_read_raw;
+
+	ret = ad799x_register_ring_funcs_and_init(indio_dev);
 	if (ret)
-		goto error_free_device;
+		goto error_disable_reg;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_cleanup_ring;
 	regdone = 1;
 
-	ret = iio_ring_buffer_register_ex(st->indio_dev->ring, 0,
-					  st->indio_dev->channels,
-					  st->indio_dev->num_channels);
+	ret = iio_ring_buffer_register_ex(indio_dev->ring, 0,
+					  indio_dev->channels,
+					  indio_dev->num_channels);
 	if (ret)
 		goto error_cleanup_ring;
 
@@ -705,46 +700,44 @@ static int __devinit ad799x_probe(struct i2c_client *client,
 					   IRQF_TRIGGER_FALLING |
 					   IRQF_ONESHOT,
 					   client->name,
-					   st->indio_dev);
+					   indio_dev);
 		if (ret)
 			goto error_cleanup_ring;
 	}
 
 	return 0;
+
 error_cleanup_ring:
-	ad799x_ring_cleanup(st->indio_dev);
-error_free_device:
-	if (!regdone)
-		iio_free_device(st->indio_dev);
-	else
-		iio_device_unregister(st->indio_dev);
+	ad799x_ring_cleanup(indio_dev);
 error_disable_reg:
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 error_put_reg:
 	if (!IS_ERR(st->reg))
 		regulator_put(st->reg);
-	kfree(st);
-error_ret:
+	if (regdone)
+		iio_device_unregister(indio_dev);
+	else
+		iio_free_device(indio_dev);
+
 	return ret;
 }
 
 static __devexit int ad799x_remove(struct i2c_client *client)
 {
-	struct ad799x_state *st = i2c_get_clientdata(client);
-	struct iio_dev *indio_dev = st->indio_dev;
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+	struct ad799x_state *st = iio_priv(indio_dev);
 
 	if (client->irq > 0 && st->chip_info->monitor_mode)
 		free_irq(client->irq, indio_dev);
 
 	iio_ring_buffer_unregister(indio_dev->ring);
 	ad799x_ring_cleanup(indio_dev);
-	iio_device_unregister(indio_dev);
 	if (!IS_ERR(st->reg)) {
 		regulator_disable(st->reg);
 		regulator_put(st->reg);
 	}
-	kfree(st);
+	iio_device_unregister(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index a82461f..3804265 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -29,7 +29,7 @@
 
 int ad799x_single_channel_from_ring(struct ad799x_state *st, long mask)
 {
-	struct iio_ring_buffer *ring = st->indio_dev->ring;
+	struct iio_ring_buffer *ring = iio_priv_to_dev(st)->ring;
 	int count = 0, ret;
 	u16 *ring_data;
 
@@ -72,7 +72,7 @@ error_ret:
 static int ad799x_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	struct ad799x_state *st = indio_dev->dev_data;
+	struct ad799x_state *st = iio_dev_get_devdata(indio_dev);
 
 	/*
 	 * Need to figure out the current mode based upon the requested
@@ -166,7 +166,6 @@ out:
 
 int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 {
-	struct ad799x_state *st = indio_dev->dev_data;
 	int ret = 0;
 
 	indio_dev->ring = iio_sw_rb_allocate(indio_dev);
@@ -175,7 +174,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 		goto error_ret;
 	}
 	/* Effectively select the ring buffer implementation */
-	iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
+	iio_ring_sw_register_funcs(&indio_dev->ring->access);
 	indio_dev->pollfunc = kzalloc(sizeof(*indio_dev->pollfunc), GFP_KERNEL);
 	if (indio_dev->pollfunc == NULL) {
 		ret = -ENOMEM;
@@ -185,7 +184,7 @@ int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	indio_dev->pollfunc->thread = &ad799x_trigger_handler;
 	indio_dev->pollfunc->type = IRQF_ONESHOT;
 	indio_dev->pollfunc->name =
-		kasprintf(GFP_KERNEL, "adis16203_consumer%d", indio_dev->id);
+		kasprintf(GFP_KERNEL, "ad799x_consumer%d", indio_dev->id);
 	if (indio_dev->pollfunc->name == NULL) {
 		ret = -ENOMEM;
 		goto error_free_poll_func;
-- 
1.6.0.2
