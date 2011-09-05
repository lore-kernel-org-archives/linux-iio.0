Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:47766 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750950Ab1IEQZE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2011 12:25:04 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org, broonie@opensource.wolfsonmicro.com
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] staging:iio:accel:lis3l02dq use regmap.
Date: Mon,  5 Sep 2011 17:33:15 +0100
Message-Id: <1315240395-6623-2-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1315240395-6623-1-git-send-email-jic23@cam.ac.uk>
References: <1315240395-6623-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

First driver conversion.
Side effect - now have a lot more use of spi_write_then_read.

May benefit from a gather read of registers function in regmap.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/Kconfig          |    1 +
 drivers/staging/iio/accel/lis3l02dq.h      |    9 +-
 drivers/staging/iio/accel/lis3l02dq_core.c |  221 ++++++++++++++++------------
 drivers/staging/iio/accel/lis3l02dq_ring.c |  115 ++++-----------
 4 files changed, 162 insertions(+), 184 deletions(-)

diff --git a/drivers/staging/iio/accel/Kconfig b/drivers/staging/iio/accel/Kconfig
index 81a33b6..083680b 100644
--- a/drivers/staging/iio/accel/Kconfig
+++ b/drivers/staging/iio/accel/Kconfig
@@ -66,6 +66,7 @@ config LIS3L02DQ
 	tristate "ST Microelectronics LIS3L02DQ Accelerometer Driver"
 	depends on SPI
 	select IIO_TRIGGER if IIO_RING_BUFFER
+	select REGMAP_SPI
 	depends on !IIO_RING_BUFFER || IIO_KFIFO_BUF || IIO_SW_RING
 	help
 	  Say yes here to build SPI support for the ST microelectronics
diff --git a/drivers/staging/iio/accel/lis3l02dq.h b/drivers/staging/iio/accel/lis3l02dq.h
index 18b23ac..07a2e03 100644
--- a/drivers/staging/iio/accel/lis3l02dq.h
+++ b/drivers/staging/iio/accel/lis3l02dq.h
@@ -146,22 +146,19 @@ Form of high byte dependent on justification set in ctrl reg */
 
 #define LIS3L02DQ_MAX_TX 12
 #define LIS3L02DQ_MAX_RX 12
+struct regmap;
 /**
  * struct lis3l02dq_state - device instance specific data
  * @us:			actual spi_device
  * @trig:		data ready trigger registered with iio
- * @tx:			transmit buffer
- * @rx:			receive buffer
- * @buf_lock:		mutex to protect tx and rx
+ * @regmap:		register map
  **/
 struct lis3l02dq_state {
 	struct spi_device		*us;
 	struct iio_trigger		*trig;
 	struct mutex			buf_lock;
 	bool				trigger_on;
-
-	u8	tx[LIS3L02DQ_MAX_RX] ____cacheline_aligned;
-	u8	rx[LIS3L02DQ_MAX_RX] ____cacheline_aligned;
+	struct regmap *regmap;
 };
 
 int lis3l02dq_spi_read_reg_8(struct iio_dev *indio_dev,
diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index ee91cc7..55330c2 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -22,6 +22,8 @@
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/err.h>
 
 #include "../iio.h"
 #include "../sysfs.h"
@@ -29,10 +31,6 @@
 
 #include "lis3l02dq.h"
 
-/* At the moment the spi framework doesn't allow global setting of cs_change.
- * It's in the likely to be added comment at the top of spi.h.
- * This means that use cannot be made of spi_write etc.
- */
 /* direct copy of the irq_default_primary_handler */
 #ifndef CONFIG_IIO_RING_BUFFER
 static irqreturn_t lis3l02dq_noring(int irq, void *private)
@@ -50,27 +48,17 @@ static irqreturn_t lis3l02dq_noring(int irq, void *private)
 int lis3l02dq_spi_read_reg_8(struct iio_dev *indio_dev,
 			     u8 reg_address, u8 *val)
 {
-	struct lis3l02dq_state *st = iio_priv(indio_dev);
-	struct spi_message msg;
 	int ret;
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
+	struct lis3l02dq_state *st = iio_priv(indio_dev);
+	unsigned int value;
 
-	return ret;
+	ret = regmap_read(st->regmap, reg_address, &value);
+
+	if (ret < 0)
+		return ret;
+
+	*val = value;
+	return 0;
 }
 
 /**
@@ -83,16 +71,9 @@ int lis3l02dq_spi_write_reg_8(struct iio_dev *indio_dev,
 			      u8 reg_address,
 			      u8 val)
 {
-	int ret;
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
 
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = LIS3L02DQ_WRITE_REG(reg_address);
-	st->tx[1] = val;
-	ret = spi_write(st->us, st->tx, 2);
-	mutex_unlock(&st->buf_lock);
-
-	return ret;
+	return regmap_write(st->regmap, reg_address, val);
 }
 
 /**
@@ -107,31 +88,14 @@ static int lis3l02dq_spi_write_reg_s16(struct iio_dev *indio_dev,
 				       s16 value)
 {
 	int ret;
-	struct spi_message msg;
-	struct lis3l02dq_state *st = iio_priv(indio_dev);
-	struct spi_transfer xfers[] = { {
-			.tx_buf = st->tx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		}, {
-			.tx_buf = st->tx + 2,
-			.bits_per_word = 8,
-			.len = 2,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = LIS3L02DQ_WRITE_REG(lower_reg_address);
-	st->tx[1] = value & 0xFF;
-	st->tx[2] = LIS3L02DQ_WRITE_REG(lower_reg_address + 1);
-	st->tx[3] = (value >> 8) & 0xFF;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
-	mutex_unlock(&st->buf_lock);
+	ret = lis3l02dq_spi_write_reg_8(indio_dev,
+					lower_reg_address,
+					value & 0xFF);
+	if (ret)
+		return ret;
+	ret = lis3l02dq_spi_write_reg_8(indio_dev,
+					lower_reg_address + 1,
+					(value >> 8) & 0xFF);
 
 	return ret;
 }
@@ -140,44 +104,23 @@ static int lis3l02dq_read_reg_s16(struct iio_dev *indio_dev,
 				  u8 lower_reg_address,
 				  int *val)
 {
-	struct lis3l02dq_state *st = iio_priv(indio_dev);
-
-	struct spi_message msg;
 	int ret;
 	s16 tempval;
-	struct spi_transfer xfers[] = { {
-			.tx_buf = st->tx,
-			.rx_buf = st->rx,
-			.bits_per_word = 8,
-			.len = 2,
-			.cs_change = 1,
-		}, {
-			.tx_buf = st->tx + 2,
-			.rx_buf = st->rx + 2,
-			.bits_per_word = 8,
-			.len = 2,
-		},
-	};
-
-	mutex_lock(&st->buf_lock);
-	st->tx[0] = LIS3L02DQ_READ_REG(lower_reg_address);
-	st->tx[1] = 0;
-	st->tx[2] = LIS3L02DQ_READ_REG(lower_reg_address + 1);
-	st->tx[3] = 0;
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(st->us, &msg);
-	if (ret) {
-		dev_err(&st->us->dev, "problem when reading 16 bit register");
-		goto error_ret;
-	}
-	tempval = (s16)(st->rx[1]) | ((s16)(st->rx[3]) << 8);
+	u8 value;
 
+	ret = lis3l02dq_spi_read_reg_8(indio_dev,
+				       lower_reg_address,
+				       &value);
+	if (ret < 0)
+		return ret;
+	tempval = value;
+	ret = lis3l02dq_spi_read_reg_8(indio_dev,
+				       lower_reg_address + 1,
+				       &value);
+	if (ret < 0)
+		return ret;
+	tempval |= ((u16)(value) << 8);
 	*val = tempval;
-error_ret:
-	mutex_unlock(&st->buf_lock);
 	return ret;
 }
 
@@ -661,6 +604,90 @@ static const struct iio_info lis3l02dq_info = {
 	.attrs = &lis3l02dq_attribute_group,
 };
 
+static struct reg_default lis3l02dq_reg_defaults[] = {
+	{ 
+		.reg = LIS3L02DQ_REG_CTRL_1_ADDR,
+		.def = LIS3L02DQ_REG_CTRL_1_AXES_Z_ENABLE |
+		LIS3L02DQ_REG_CTRL_1_AXES_Y_ENABLE |
+		LIS3L02DQ_REG_CTRL_1_AXES_X_ENABLE,
+	}, {
+		.reg = LIS3L02DQ_REG_CTRL_2_ADDR,
+		.def = 0x00,
+	},
+};
+
+static bool lis3l02dq_reg_writeable(struct device *dev, unsigned int reg)
+{
+	return (reg == LIS3L02DQ_REG_OFFSET_X_ADDR ||
+		reg == LIS3L02DQ_REG_OFFSET_Y_ADDR ||
+		reg == LIS3L02DQ_REG_OFFSET_Z_ADDR ||
+		reg == LIS3L02DQ_REG_GAIN_X_ADDR ||
+		reg == LIS3L02DQ_REG_GAIN_Y_ADDR ||
+		reg == LIS3L02DQ_REG_CTRL_1_ADDR ||
+		reg == LIS3L02DQ_REG_CTRL_2_ADDR ||
+		reg == LIS3L02DQ_REG_STATUS_ADDR ||
+		reg == LIS3L02DQ_REG_THS_L_ADDR ||
+		reg == LIS3L02DQ_REG_THS_H_ADDR ||
+		reg == LIS3L02DQ_REG_WAKE_UP_CFG_ADDR);
+}
+
+static bool lis3l02dq_reg_readable(struct device *dev, unsigned int reg)
+{
+	return (reg == LIS3L02DQ_REG_OFFSET_X_ADDR ||
+		reg == LIS3L02DQ_REG_OFFSET_Y_ADDR ||
+		reg == LIS3L02DQ_REG_OFFSET_Z_ADDR ||
+		reg == LIS3L02DQ_REG_GAIN_X_ADDR ||
+		reg == LIS3L02DQ_REG_GAIN_Y_ADDR ||
+		reg == LIS3L02DQ_REG_GAIN_Z_ADDR ||
+		reg == LIS3L02DQ_REG_CTRL_1_ADDR ||
+		reg == LIS3L02DQ_REG_CTRL_2_ADDR ||
+		reg == LIS3L02DQ_REG_WAKE_UP_CFG_ADDR ||
+		reg == LIS3L02DQ_REG_WAKE_UP_SRC_ADDR ||
+		reg == LIS3L02DQ_REG_WAKE_UP_ACK_ADDR ||
+		reg == LIS3L02DQ_REG_STATUS_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_X_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_X_H_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Y_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Y_H_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Z_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Z_H_ADDR);
+}
+
+static bool lis3l02dq_reg_volatile(struct device *dev, unsigned int reg)
+{
+	return (reg == LIS3L02DQ_REG_WAKE_UP_ACK_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_X_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_X_H_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Y_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Y_H_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Z_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Z_H_ADDR);	
+}
+/* Read the data registers might result in unexpected datardy signal
+ * so they have to be marked precious */
+static bool lis3l02dq_reg_precious(struct device *dev, unsigned int reg)
+{
+	return (reg == LIS3L02DQ_REG_WAKE_UP_ACK_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_X_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_X_H_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Y_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Y_H_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Z_L_ADDR ||
+		reg == LIS3L02DQ_REG_OUT_Z_H_ADDR);
+}
+
+static struct regmap_config lis3l02dq_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.reg_defaults = lis3l02dq_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(lis3l02dq_reg_defaults),
+	.writeable_reg = &lis3l02dq_reg_writeable,
+	.readable_reg = &lis3l02dq_reg_readable,
+	.precious_reg = &lis3l02dq_reg_precious,
+	.volatile_reg = &lis3l02dq_reg_volatile,
+	.max_register = 0x2F,
+};
+
 static int __devinit lis3l02dq_probe(struct spi_device *spi)
 {
 	int ret;
@@ -673,11 +700,15 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 		goto error_ret;
 	}
 	st = iio_priv(indio_dev);
+	st->regmap = regmap_init_spi(spi, &lis3l02dq_regmap_config);
+	if (IS_ERR(st->regmap)) {
+		ret = PTR_ERR(st->regmap);
+		goto error_free_dev;
+	}
 	/* this is only used tor removal purposes */
 	spi_set_drvdata(spi, indio_dev);
 
 	st->us = spi;
-	mutex_init(&st->buf_lock);
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->info = &lis3l02dq_info;
@@ -688,7 +719,7 @@ static int __devinit lis3l02dq_probe(struct spi_device *spi)
 
 	ret = lis3l02dq_configure_ring(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		goto error_free_regmap;
 
 	ret = iio_ring_buffer_register(indio_dev,
 				       lis3l02dq_channels,
@@ -734,8 +765,10 @@ error_uninitialize_ring:
 	iio_ring_buffer_unregister(indio_dev);
 error_unreg_ring_funcs:
 	lis3l02dq_unconfigure_ring(indio_dev);
+error_free_regmap:
+	regmap_exit(st->regmap);
 error_free_dev:
-		iio_free_device(indio_dev);
+	iio_free_device(indio_dev);
 error_ret:
 	return ret;
 }
@@ -787,7 +820,7 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	lis3l02dq_remove_trigger(indio_dev);
 	iio_ring_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_ring(indio_dev);
-
+	regmap_exit(st->regmap);
 	iio_device_unregister(indio_dev);
 
 err_ret:
diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
index c816933..da7a434 100644
--- a/drivers/staging/iio/accel/lis3l02dq_ring.c
+++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
@@ -4,6 +4,7 @@
 #include <linux/kernel.h>
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
+#include <linux/regmap.h>
 
 #include "../iio.h"
 #include "../ring_sw.h"
@@ -13,16 +14,6 @@
 #include "lis3l02dq.h"
 
 /**
- * combine_8_to_16() utility function to munge to u8s into u16
- **/
-static inline u16 combine_8_to_16(u8 lower, u8 upper)
-{
-	u16 _lower = lower;
-	u16 _upper = upper;
-	return _lower | (_upper << 8);
-}
-
-/**
  * lis3l02dq_data_rdy_trig_poll() the event handler for the data rdy trig
  **/
 irqreturn_t lis3l02dq_data_rdy_trig_poll(int irq, void *private)
@@ -69,13 +60,10 @@ error_free_data:
 	return ret;
 }
 
-static const u8 read_all_tx_array[] = {
-	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_L_ADDR), 0,
-	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_X_H_ADDR), 0,
-	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_L_ADDR), 0,
-	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Y_H_ADDR), 0,
-	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_L_ADDR), 0,
-	LIS3L02DQ_READ_REG(LIS3L02DQ_REG_OUT_Z_H_ADDR), 0,
+static const u8 lis3l02dq_read_addresses[] = {
+	LIS3L02DQ_REG_OUT_X_L_ADDR, LIS3L02DQ_REG_OUT_X_H_ADDR,
+	LIS3L02DQ_REG_OUT_Y_L_ADDR, LIS3L02DQ_REG_OUT_Y_H_ADDR,
+	LIS3L02DQ_REG_OUT_Z_L_ADDR, LIS3L02DQ_REG_OUT_Z_H_ADDR,
 };
 
 /**
@@ -88,75 +76,29 @@ static int lis3l02dq_read_all(struct iio_dev *indio_dev, u8 *rx_array)
 {
 	struct iio_ring_buffer *ring = indio_dev->ring;
 	struct lis3l02dq_state *st = iio_priv(indio_dev);
-	struct spi_transfer *xfers;
-	struct spi_message msg;
+	
 	int ret, i, j = 0;
+	unsigned int value;
 
-	xfers = kzalloc((ring->scan_count) * 2
-			* sizeof(*xfers), GFP_KERNEL);
-	if (!xfers)
-		return -ENOMEM;
-
-	mutex_lock(&st->buf_lock);
-
-	for (i = 0; i < ARRAY_SIZE(read_all_tx_array)/4; i++)
+	for (i = 0; i < ARRAY_SIZE(lis3l02dq_read_addresses); i++)
 		if (test_bit(i, ring->scan_mask)) {
-			/* lower byte */
-			xfers[j].tx_buf = st->tx + 2*j;
-			st->tx[2*j] = read_all_tx_array[i*4];
-			st->tx[2*j + 1] = 0;
+			ret = regmap_read(st->regmap,
+					  lis3l02dq_read_addresses[i*2],
+					  &value);
+			if (ret < 0)
+				return ret;
 			if (rx_array)
-				xfers[j].rx_buf = rx_array + j*2;
-			xfers[j].bits_per_word = 8;
-			xfers[j].len = 2;
-			xfers[j].cs_change = 1;
-			j++;
-
-			/* upper byte */
-			xfers[j].tx_buf = st->tx + 2*j;
-			st->tx[2*j] = read_all_tx_array[i*4 + 2];
-			st->tx[2*j + 1] = 0;
+				rx_array[j*2 + 0] = value;
+			ret = regmap_read(st->regmap,
+					  lis3l02dq_read_addresses[i*2 + 1],
+					  &value);
+			if (ret < 0)
+				return ret;
 			if (rx_array)
-				xfers[j].rx_buf = rx_array + j*2;
-			xfers[j].bits_per_word = 8;
-			xfers[j].len = 2;
-			xfers[j].cs_change = 1;
+				rx_array[j*2 + 1] = value;
 			j++;
 		}
-
-	/* After these are transmitted, the rx_buff should have
-	 * values in alternate bytes
-	 */
-	spi_message_init(&msg);
-	for (j = 0; j < ring->scan_count * 2; j++)
-		spi_message_add_tail(&xfers[j], &msg);
-
-	ret = spi_sync(st->us, &msg);
-	mutex_unlock(&st->buf_lock);
-	kfree(xfers);
-
-	return ret;
-}
-
-static int lis3l02dq_get_ring_element(struct iio_dev *indio_dev,
-				u8 *buf)
-{
-	int ret, i;
-	u8 *rx_array ;
-	s16 *data = (s16 *)buf;
-
-	rx_array = kzalloc(4 * (indio_dev->ring->scan_count), GFP_KERNEL);
-	if (rx_array == NULL)
-		return -ENOMEM;
-	ret = lis3l02dq_read_all(indio_dev, rx_array);
-	if (ret < 0)
-		return ret;
-	for (i = 0; i < indio_dev->ring->scan_count; i++)
-		data[i] = combine_8_to_16(rx_array[i*4+1],
-					rx_array[i*4+3]);
-	kfree(rx_array);
-
-	return i*sizeof(data[0]);
+	return 2*j;
 }
 
 static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
@@ -175,7 +117,7 @@ static irqreturn_t lis3l02dq_trigger_handler(int irq, void *p)
 	}
 
 	if (ring->scan_count)
-		len = lis3l02dq_get_ring_element(indio_dev, data);
+		len = lis3l02dq_read_all(indio_dev, data);
 
 	  /* Guaranteed to be aligned with 8 byte boundary */
 	if (ring->scan_timestamp)
@@ -271,11 +213,16 @@ static int lis3l02dq_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		 *  by ensuring outstanding read events are cleared.
 		 */
 		ret = lis3l02dq_read_all(indio_dev, NULL);
+		if (ret < 0)
+			return ret;
 	}
-	lis3l02dq_spi_read_reg_8(indio_dev,
-				 LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
-				 &t);
-	return ret;
+	ret = lis3l02dq_spi_read_reg_8(indio_dev,
+				       LIS3L02DQ_REG_WAKE_UP_SRC_ADDR,
+				       &t);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 /**
-- 
1.7.3.4

