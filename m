Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 43/50] staging:iio:resolver:ad2s120x cleanup.
Date: Fri, 27 May 2011 19:36:23 +0100
Message-Id: <1306521390-24897-44-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
References: <1306521390-24897-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I've currently squashed the vel + pos combined attribute.  If people need them
precisely paired I doubt they will get them from the sysfs interface anyway.
If that is a requirement it should come via a buffer implementation.

Note this patch leaves the completely non standard interface alone.
That will get fixed later.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/resolver/ad2s120x.c |  196 +++++--------------------------
 1 files changed, 31 insertions(+), 165 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s120x.c b/drivers/staging/iio/resolver/ad2s120x.c
index f83e142..bed4c72 100644
--- a/drivers/staging/iio/resolver/ad2s120x.c
+++ b/drivers/staging/iio/resolver/ad2s120x.c
@@ -32,161 +32,46 @@
 
 struct ad2s120x_state {
 	struct mutex lock;
-	struct iio_dev *idev;
 	struct spi_device *sdev;
-	unsigned short sample;
-	unsigned short rdvel;
-	u8 rx[2];
-	u8 tx[2];
+	int sample;
+	int rdvel;
+	u8 rx[2] ____cacheline_aligned;
 };
 
-static ssize_t ad2s120x_show_pos_vel(struct device *dev,
+static ssize_t ad2s120x_show_val(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
-	struct spi_message msg;
-	struct spi_transfer xfer;
 	int ret = 0;
 	ssize_t len = 0;
 	u16 pos;
 	s16 vel;
 	u8 status;
-	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad2s120x_state *st = idev->dev_data;
+	struct ad2s120x_state *st = iio_priv(dev_get_drvdata(dev));
+	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
 
-	xfer.len = 1;
-	xfer.tx_buf = st->tx;
-	xfer.rx_buf = st->rx;
 	mutex_lock(&st->lock);
 
 	gpio_set_value(st->sample, 0);
 	/* delay (6 * AD2S120X_TSCLK + 20) nano seconds */
 	udelay(1);
 	gpio_set_value(st->sample, 1);
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
-		goto error_ret;
-	status = st->rx[1];
-	pos = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-	len = sprintf(buf, "%d %c%c%c%c ", pos,
-				(status & 0x8) ? 'P' : 'V',
-				(status & 0x4) ? 'd' : '_',
-				(status & 0x2) ? 'l' : '_',
-				(status & 0x1) ? '1' : '0');
-
-	/* delay 18 ns */
-	/* ndelay(18); */
-
-	gpio_set_value(st->rdvel, 0);
-	/* ndelay(5);*/
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
+	gpio_set_value(st->rdvel, iattr->address);
+	ret = spi_read(st->sdev, st->rx, 2);
+	if (ret < 0)
 		goto error_ret;
 	status = st->rx[1];
-	vel = (st->rx[0] & 0x80) ? 0xf000 : 0;
-	vel |= (((s16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-	len += sprintf(buf + len, "%d %c%c%c%c\n", vel,
-				(status & 0x8) ? 'P' : 'V',
-				(status & 0x4) ? 'd' : '_',
-				(status & 0x2) ? 'l' : '_',
-				(status & 0x1) ? '1' : '0');
-error_ret:
-	gpio_set_value(st->rdvel, 1);
-	/* delay (2 * AD2S120X_TSCLK + 20) ns for sample pulse */
-	udelay(1);
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
-static ssize_t ad2s120x_show_pos(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct spi_message msg;
-	struct spi_transfer xfer;
-	int ret = 0;
-	ssize_t len = 0;
-	u16 pos;
-	u8 status;
-	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad2s120x_state *st = idev->dev_data;
-
-	xfer.len = 1;
-	xfer.tx_buf = st->tx;
-	xfer.rx_buf = st->rx;
-	mutex_lock(&st->lock);
-
-	gpio_set_value(st->sample, 0);
-	/* delay (6 * AD2S120X_TSCLK + 20) nano seconds */
-	udelay(1);
-	gpio_set_value(st->sample, 1);
-	gpio_set_value(st->rdvel, 1);
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
-		goto error_ret;
-	status = st->rx[1];
-	pos = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-	len = sprintf(buf, "%d %c%c%c%c ", pos,
-				(status & 0x8) ? 'P' : 'V',
-				(status & 0x4) ? 'd' : '_',
-				(status & 0x2) ? 'l' : '_',
-				(status & 0x1) ? '1' : '0');
-error_ret:
-	/* delay (2 * AD2S120X_TSCLK + 20) ns for sample pulse */
-	udelay(1);
-	mutex_unlock(&st->lock);
-
-	return ret ? ret : len;
-}
-
-static ssize_t ad2s120x_show_vel(struct device *dev,
-			struct device_attribute *attr, char *buf)
-{
-	struct spi_message msg;
-	struct spi_transfer xfer;
-	int ret = 0;
-	ssize_t len = 0;
-	s16 vel;
-	u8 status;
-	struct iio_dev *idev = dev_get_drvdata(dev);
-	struct ad2s120x_state *st = idev->dev_data;
-
-	xfer.len = 1;
-	xfer.tx_buf = st->tx;
-	xfer.rx_buf = st->rx;
-	mutex_lock(&st->lock);
-
-	gpio_set_value(st->sample, 0);
-	/* delay (6 * AD2S120X_TSCLK + 20) nano seconds */
-	udelay(1);
-	gpio_set_value(st->sample, 1);
-
-	gpio_set_value(st->rdvel, 0);
-	/* ndelay(5);*/
-
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfer, &msg);
-	ret = spi_sync(st->sdev, &msg);
-	if (ret)
-		goto error_ret;
-	status = st->rx[1];
-	vel = (st->rx[0] & 0x80) ? 0xf000 : 0;
-	vel |= (((s16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
-	len += sprintf(buf + len, "%d %c%c%c%c\n", vel,
+	if (iattr->address)
+		pos = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+	else {
+		vel = (st->rx[0] & 0x80) ? 0xf000 : 0;
+		vel |= (((s16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
+	}
+	len = sprintf(buf, "%d %c%c%c%c ", iattr->address ? pos : vel,
 				(status & 0x8) ? 'P' : 'V',
 				(status & 0x4) ? 'd' : '_',
 				(status & 0x2) ? 'l' : '_',
 				(status & 0x1) ? '1' : '0');
 error_ret:
-	gpio_set_value(st->rdvel, 1);
 	/* delay (2 * AD2S120X_TSCLK + 20) ns for sample pulse */
 	udelay(1);
 	mutex_unlock(&st->lock);
@@ -194,15 +79,10 @@ error_ret:
 	return ret ? ret : len;
 }
 
-static IIO_CONST_ATTR(description,
-	"12-Bit R/D Converter with Reference Oscillator");
-static IIO_DEVICE_ATTR(pos_vel, S_IRUGO, ad2s120x_show_pos_vel, NULL, 0);
-static IIO_DEVICE_ATTR(pos, S_IRUGO, ad2s120x_show_pos, NULL, 0);
-static IIO_DEVICE_ATTR(vel, S_IRUGO, ad2s120x_show_vel, NULL, 0);
+static IIO_DEVICE_ATTR(pos, S_IRUGO, ad2s120x_show_val, NULL, 1);
+static IIO_DEVICE_ATTR(vel, S_IRUGO, ad2s120x_show_val, NULL, 0);
 
 static struct attribute *ad2s120x_attributes[] = {
-	&iio_const_attr_description.dev_attr.attr,
-	&iio_dev_attr_pos_vel.dev_attr.attr,
 	&iio_dev_attr_pos.dev_attr.attr,
 	&iio_dev_attr_vel.dev_attr.attr,
 	NULL,
@@ -220,42 +100,33 @@ static const struct iio_info ad2s120x_info = {
 static int __devinit ad2s120x_probe(struct spi_device *spi)
 {
 	struct ad2s120x_state *st;
+	struct iio_dev *indio_dev;
 	int pn, ret = 0;
 	unsigned short *pins = spi->dev.platform_data;
 
-	for (pn = 0; pn < AD2S120X_PN; pn++) {
-		if (gpio_request(pins[pn], DRV_NAME)) {
+	for (pn = 0; pn < AD2S120X_PN; pn++)
+		if (gpio_request_one(pins[pn], GPIOF_DIR_OUT, DRV_NAME)) {
 			pr_err("%s: request gpio pin %d failed\n",
 						DRV_NAME, pins[pn]);
 			goto error_ret;
 		}
-		gpio_direction_output(pins[pn], 1);
-	}
-
-	st = kzalloc(sizeof(*st), GFP_KERNEL);
-	if (st == NULL) {
+	indio_dev = iio_allocate_device(sizeof(*st));
+	if (indio_dev == NULL) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-	spi_set_drvdata(spi, st);
-
+	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
 	st->sdev = spi;
 	st->sample = pins[0];
 	st->rdvel = pins[1];
 
-	st->idev = iio_allocate_device(0);
-	if (st->idev == NULL) {
-		ret = -ENOMEM;
-		goto error_free_st;
-	}
-	st->idev->dev.parent = &spi->dev;
+	indio_dev->dev.parent = &spi->dev;
+	indio_dev->info = &ad2s120x_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	st->idev->info = &ad2s120x_info;
-	st->idev->dev_data = (void *)(st);
-	st->idev->modes = INDIO_DIRECT_MODE;
-
-	ret = iio_device_register(st->idev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_free_dev;
 
@@ -266,9 +137,7 @@ static int __devinit ad2s120x_probe(struct spi_device *spi)
 	return 0;
 
 error_free_dev:
-	iio_free_device(st->idev);
-error_free_st:
-	kfree(st);
+	iio_free_device(indio_dev);
 error_ret:
 	for (--pn; pn >= 0; pn--)
 		gpio_free(pins[pn]);
@@ -277,10 +146,7 @@ error_ret:
 
 static int __devexit ad2s120x_remove(struct spi_device *spi)
 {
-	struct ad2s120x_state *st = spi_get_drvdata(spi);
-
-	iio_device_unregister(st->idev);
-	kfree(st);
+	iio_device_unregister(spi_get_drvdata(spi));
 
 	return 0;
 }
-- 
1.7.3.4
