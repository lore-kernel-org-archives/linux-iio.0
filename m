Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32803 "EHLO
	mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753261AbcGSQZH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 12:25:07 -0400
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v2 1/3] iio: stx104: Unregister IIO device on remove callback
Date: Tue, 19 Jul 2016 12:25:00 -0400
Message-Id: <704fdc7b267770e76b061943da02b8a93fa37c3b.1468944073.git.vilhelm.gray@gmail.com>
In-Reply-To: <cover.1468944073.git.vilhelm.gray@gmail.com>
References: <cover.1468944073.git.vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The devm_iio_device_register function should not be used if custom
operations must be performed in the remove callback. This patch replaces
the dem_iio_device_register call with a iio_device_register call and
respective iio_device_unregister call in the remove callback.

Fixes: 765550e4d98d ("iio: stx104: Add GPIO support for the Apex Embedded Systems STX104")
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/dac/stx104.c | 38 +++++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/dac/stx104.c b/drivers/iio/dac/stx104.c
index 792a971..bebbd00 100644
--- a/drivers/iio/dac/stx104.c
+++ b/drivers/iio/dac/stx104.c
@@ -65,6 +65,16 @@ struct stx104_gpio {
 	unsigned int out_state;
 };
 
+/**
+ * struct stx104_dev - STX104 device private data structure
+ * @indio_dev:	IIO device
+ * @chip:	instance of the gpio_chip
+ */
+struct stx104_dev {
+	struct iio_dev *indio_dev;
+	struct gpio_chip *chip;
+};
+
 static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -107,6 +117,7 @@ static const struct iio_chan_spec stx104_channels[STX104_NUM_CHAN] = {
 static int stx104_gpio_get_direction(struct gpio_chip *chip,
 	unsigned int offset)
 {
+	/* GPIO 0-3 are input only, while the rest are output only */
 	if (offset < 4)
 		return 1;
 
@@ -169,6 +180,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	struct iio_dev *indio_dev;
 	struct stx104_iio *priv;
 	struct stx104_gpio *stx104gpio;
+	struct stx104_dev *stx104dev;
 	int err;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
@@ -179,6 +191,10 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	if (!stx104gpio)
 		return -ENOMEM;
 
+	stx104dev = devm_kzalloc(dev, sizeof(*stx104dev), GFP_KERNEL);
+	if (!stx104dev)
+		return -ENOMEM;
+
 	if (!devm_request_region(dev, base[id], STX104_EXTENT,
 		dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -199,12 +215,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	outw(0, base[id] + 4);
 	outw(0, base[id] + 6);
 
-	err = devm_iio_device_register(dev, indio_dev);
-	if (err) {
-		dev_err(dev, "IIO device registering failed (%d)\n", err);
-		return err;
-	}
-
 	stx104gpio->chip.label = dev_name(dev);
 	stx104gpio->chip.parent = dev;
 	stx104gpio->chip.owner = THIS_MODULE;
@@ -220,7 +230,9 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	spin_lock_init(&stx104gpio->lock);
 
-	dev_set_drvdata(dev, stx104gpio);
+	stx104dev->indio_dev = indio_dev;
+	stx104dev->chip = &stx104gpio->chip;
+	dev_set_drvdata(dev, stx104dev);
 
 	err = gpiochip_add_data(&stx104gpio->chip, stx104gpio);
 	if (err) {
@@ -228,14 +240,22 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return err;
 	}
 
+	err = iio_device_register(indio_dev);
+	if (err) {
+		dev_err(dev, "IIO device registering failed (%d)\n", err);
+		gpiochip_remove(&stx104gpio->chip);
+		return err;
+	}
+
 	return 0;
 }
 
 static int stx104_remove(struct device *dev, unsigned int id)
 {
-	struct stx104_gpio *const stx104gpio = dev_get_drvdata(dev);
+	struct stx104_dev *const stx104dev = dev_get_drvdata(dev);
 
-	gpiochip_remove(&stx104gpio->chip);
+	iio_device_unregister(stx104dev->indio_dev);
+	gpiochip_remove(stx104dev->chip);
 
 	return 0;
 }
-- 
2.7.3

