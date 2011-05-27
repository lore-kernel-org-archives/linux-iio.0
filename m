Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 41/50] staging:iio:meter:ade7854: Allocate buffers in state and state with iio_dev.
Date: Fri, 27 May 2011 19:36:21 +0100
Message-Id: <1306521390-24897-42-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Requires moving a few things around, but should be no functional changes.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/meter/ade7854-i2c.c |   41 ++++++++---------
 drivers/staging/iio/meter/ade7854-spi.c |   40 ++++++++--------
 drivers/staging/iio/meter/ade7854.c     |   76 ++++++++++---------------------
 drivers/staging/iio/meter/ade7854.h     |   36 +++++++-------
 4 files changed, 82 insertions(+), 111 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 4578e7b..9b25ba2 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -20,7 +20,7 @@ static int ade7854_i2c_write_reg_8(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
@@ -39,7 +39,7 @@ static int ade7854_i2c_write_reg_16(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
@@ -59,7 +59,7 @@ static int ade7854_i2c_write_reg_24(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
@@ -80,7 +80,7 @@ static int ade7854_i2c_write_reg_32(struct device *dev,
 {
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = (reg_address >> 8) & 0xFF;
@@ -101,7 +101,7 @@ static int ade7854_i2c_read_reg_8(struct device *dev,
 		u8 *val)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&st->buf_lock);
@@ -127,7 +127,7 @@ static int ade7854_i2c_read_reg_16(struct device *dev,
 		u16 *val)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&st->buf_lock);
@@ -153,7 +153,7 @@ static int ade7854_i2c_read_reg_24(struct device *dev,
 		u32 *val)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&st->buf_lock);
@@ -179,7 +179,7 @@ static int ade7854_i2c_read_reg_32(struct device *dev,
 		u32 *val)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&st->buf_lock);
@@ -204,13 +204,14 @@ static int __devinit ade7854_i2c_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	int ret;
-	struct ade7854_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
-		return ret;
-	}
-
-	i2c_set_clientdata(client, st);
+	struct ade7854_state *st;
+	struct iio_dev *indio_dev;
+
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+	st = iio_priv(indio_dev);
+	i2c_set_clientdata(client, indio_dev);
 	st->read_reg_8 = ade7854_i2c_read_reg_8;
 	st->read_reg_16 = ade7854_i2c_read_reg_16;
 	st->read_reg_24 = ade7854_i2c_read_reg_24;
@@ -222,12 +223,10 @@ static int __devinit ade7854_i2c_probe(struct i2c_client *client,
 	st->i2c = client;
 	st->irq = client->irq;
 
-	ret = ade7854_probe(st, &client->dev);
-	if (ret) {
-		kfree(st);
-		return ret;
-	}
-
+	ret = ade7854_probe(indio_dev, &client->dev);
+	if (ret)
+		iio_free_device(indio_dev);
+	
 	return ret;
 }
 
diff --git a/drivers/staging/iio/meter/ade7854-spi.c b/drivers/staging/iio/meter/ade7854-spi.c
index 84da8fb..e0d1086 100644
--- a/drivers/staging/iio/meter/ade7854-spi.c
+++ b/drivers/staging/iio/meter/ade7854-spi.c
@@ -21,7 +21,7 @@ static int ade7854_spi_write_reg_8(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx,
 		.bits_per_word = 8,
@@ -49,7 +49,7 @@ static int ade7854_spi_write_reg_16(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx,
 		.bits_per_word = 8,
@@ -78,7 +78,7 @@ static int ade7854_spi_write_reg_24(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx,
 		.bits_per_word = 8,
@@ -108,7 +108,7 @@ static int ade7854_spi_write_reg_32(struct device *dev,
 	int ret;
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	struct spi_transfer xfer = {
 		.tx_buf = st->tx,
 		.bits_per_word = 8,
@@ -138,7 +138,7 @@ static int ade7854_spi_read_reg_8(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -180,7 +180,7 @@ static int ade7854_spi_read_reg_16(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -221,7 +221,7 @@ static int ade7854_spi_read_reg_24(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -263,7 +263,7 @@ static int ade7854_spi_read_reg_32(struct device *dev,
 {
 	struct spi_message msg;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	int ret;
 	struct spi_transfer xfers[] = {
 		{
@@ -302,13 +302,14 @@ error_ret:
 static int __devinit ade7854_spi_probe(struct spi_device *spi)
 {
 	int ret;
-	struct ade7854_state *st = kzalloc(sizeof *st, GFP_KERNEL);
-	if (!st) {
-		ret =  -ENOMEM;
-		return ret;
-	}
-
-	spi_set_drvdata(spi, st);
+	struct ade7854_state *st;
+	struct iio_dev *indio_dev;
+
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL)
+		return -ENOMEM;
+	st = iio_priv(indio_dev);
+	spi_set_drvdata(spi, indio_dev);
 	st->read_reg_8 = ade7854_spi_read_reg_8;
 	st->read_reg_16 = ade7854_spi_read_reg_16;
 	st->read_reg_24 = ade7854_spi_read_reg_24;
@@ -320,11 +321,10 @@ static int __devinit ade7854_spi_probe(struct spi_device *spi)
 	st->irq = spi->irq;
 	st->spi = spi;
 
-	ret = ade7854_probe(st, &spi->dev);
-	if (ret) {
-		kfree(st);
-		return ret;
-	}
+
+	ret = ade7854_probe(indio_dev, &spi->dev);
+	if (ret)
+		iio_free_device(indio_dev);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 44cd3ec..b82659f 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -29,7 +29,7 @@ static ssize_t ade7854_read_8bit(struct device *dev,
 	int ret;
 	u8 val = 0;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_8(dev, this_attr->address, &val);
@@ -46,7 +46,7 @@ static ssize_t ade7854_read_16bit(struct device *dev,
 	int ret;
 	u16 val = 0;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_16(dev, this_attr->address, &val);
@@ -63,7 +63,7 @@ static ssize_t ade7854_read_24bit(struct device *dev,
 	int ret;
 	u32 val;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
 	ret = st->read_reg_24(dev, this_attr->address, &val);
@@ -81,7 +81,7 @@ static ssize_t ade7854_read_32bit(struct device *dev,
 	u32 val = 0;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	ret = st->read_reg_32(dev, this_attr->address, &val);
 	if (ret)
@@ -97,7 +97,7 @@ static ssize_t ade7854_write_8bit(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	int ret;
 	long val;
@@ -118,7 +118,7 @@ static ssize_t ade7854_write_16bit(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	int ret;
 	long val;
@@ -139,7 +139,7 @@ static ssize_t ade7854_write_24bit(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	int ret;
 	long val;
@@ -160,7 +160,7 @@ static ssize_t ade7854_write_32bit(struct device *dev,
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	int ret;
 	long val;
@@ -177,7 +177,7 @@ error_ret:
 static int ade7854_reset(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	u16 val;
 
 	st->read_reg_16(dev, ADE7854_CONFIG, &val);
@@ -426,7 +426,7 @@ static IIO_DEV_ATTR_CVAHR(ade7854_read_32bit,
 static int ade7854_set_irq(struct device *dev, bool enable)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
-	struct ade7854_state *st = iio_dev_get_devdata(indio_dev);
+	struct ade7854_state *st = iio_priv(indio_dev);
 
 	int ret;
 	u32 irqen;
@@ -449,10 +449,10 @@ error_ret:
 	return ret;
 }
 
-static int ade7854_initial_setup(struct ade7854_state *st)
+static int ade7854_initial_setup(struct iio_dev *indio_dev)
 {
 	int ret;
-	struct device *dev = &st->indio_dev->dev;
+	struct device *dev = &indio_dev->dev;
 
 	/* Disable IRQ */
 	ret = ade7854_set_irq(dev, false);
@@ -556,68 +556,40 @@ static const struct iio_info ade7854_info = {
 	.driver_module = THIS_MODULE,
 };
 
-int ade7854_probe(struct ade7854_state *st, struct device *dev)
+int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
 {
 	int ret;
-
-	/* Allocate the comms buffers */
-	st->rx = kzalloc(sizeof(*st->rx)*ADE7854_MAX_RX, GFP_KERNEL);
-	if (st->rx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->tx = kzalloc(sizeof(*st->tx)*ADE7854_MAX_TX, GFP_KERNEL);
-	if (st->tx == NULL) {
-		ret = -ENOMEM;
-		goto error_free_rx;
-	}
-	mutex_init(&st->buf_lock);
+	struct ade7854_state *st = iio_priv(indio_dev);
 	/* setup the industrialio driver allocated elements */
-	st->indio_dev = iio_allocate_device(0);
-	if (st->indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
+	mutex_init(&st->buf_lock);
 
-	st->indio_dev->dev.parent = dev;
-	st->indio_dev->info = &ade7854_info;
-	st->indio_dev->dev_data = (void *)(st);
-	st->indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = dev;
+	indio_dev->info = &ade7854_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	ret = iio_device_register(st->indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
 	/* Get the device into a sane initial state */
-	ret = ade7854_initial_setup(st);
+	ret = ade7854_initial_setup(indio_dev);
 	if (ret)
 		goto error_unreg_dev;
 
 	return 0;
 
 error_unreg_dev:
-	iio_device_unregister(st->indio_dev);
+	iio_device_unregister(indio_dev);
 error_free_dev:
-	iio_free_device(st->indio_dev);
-error_free_tx:
-	kfree(st->tx);
-error_free_rx:
-	kfree(st->rx);
-error_free_st:
-	kfree(st);
-
+	iio_free_device(indio_dev);
+error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(ade7854_probe);
 
-int ade7854_remove(struct ade7854_state *st)
+int ade7854_remove(struct iio_dev *indio_dev)
 {
-	struct iio_dev *indio_dev = st->indio_dev;
-
 	iio_device_unregister(indio_dev);
-	kfree(st->tx);
-	kfree(st->rx);
-	kfree(st);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/meter/ade7854.h b/drivers/staging/iio/meter/ade7854.h
index 79a2110..2c96e86 100644
--- a/drivers/staging/iio/meter/ade7854.h
+++ b/drivers/staging/iio/meter/ade7854.h
@@ -148,29 +148,29 @@
  * struct ade7854_state - device instance specific data
  * @spi:			actual spi_device
  * @indio_dev:		industrial I/O device structure
+ * @buf_lock:		mutex to protect tx and rx
  * @tx:			transmit buffer
  * @rx:			receive buffer
- * @buf_lock:		mutex to protect tx and rx
  **/
 struct ade7854_state {
-	struct spi_device		*spi;
-	struct i2c_client               *i2c;
-	struct iio_dev			*indio_dev;
-	u8				*tx;
-	u8				*rx;
-	int				(*read_reg_8) (struct device *, u16, u8 *);
-	int				(*read_reg_16) (struct device *, u16, u16 *);
-	int				(*read_reg_24) (struct device *, u16, u32 *);
-	int				(*read_reg_32) (struct device *, u16, u32 *);
-	int				(*write_reg_8) (struct device *, u16, u8);
-	int				(*write_reg_16) (struct device *, u16, u16);
-	int				(*write_reg_24) (struct device *, u16, u32);
-	int				(*write_reg_32) (struct device *, u16, u32);
-	int                             irq;
-	struct mutex			buf_lock;
+	struct spi_device	*spi;
+	struct i2c_client	*i2c;
+	int			(*read_reg_8) (struct device *, u16, u8 *);
+	int			(*read_reg_16) (struct device *, u16, u16 *);
+	int			(*read_reg_24) (struct device *, u16, u32 *);
+	int			(*read_reg_32) (struct device *, u16, u32 *);
+	int			(*write_reg_8) (struct device *, u16, u8);
+	int			(*write_reg_16) (struct device *, u16, u16);
+	int			(*write_reg_24) (struct device *, u16, u32);
+	int			(*write_reg_32) (struct device *, u16, u32);
+	int			irq;
+	struct mutex		buf_lock;
+	u8			tx[ADE7854_MAX_TX] ____cacheline_aligned;
+	u8			rx[ADE7854_MAX_RX];
+
 };
 
-extern int ade7854_probe(struct ade7854_state *st, struct device *dev);
-extern int ade7854_remove(struct ade7854_state *st);
+extern int ade7854_probe(struct iio_dev *indio_dev, struct device *dev);
+extern int ade7854_remove(struct iio_dev *indio_dev);
 
 #endif
-- 
1.7.3.4
