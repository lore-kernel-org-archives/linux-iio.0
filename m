Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33050 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753668AbdA3N7G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Jan 2017 08:59:06 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] iio: stx104: Remove unneeded struct stx104_dev code
Date: Mon, 30 Jan 2017 08:58:50 -0500
Message-Id: <20170130135850.28274-1-vilhelm.gray@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The stx104_dev structure was used to hold private data for use in the
stx104_remove function. Now that the stx104_remove function is gone, the
stx104_dev structure and relevant code is no longer needed. This patch
removes the unnecessary code.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/adc/stx104.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index c56ff286695d..fcfad51cc4fb 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -76,16 +76,6 @@ struct stx104_gpio {
 	unsigned int out_state;
 };
 
-/**
- * struct stx104_dev - STX104 device private data structure
- * @indio_dev:	IIO device
- * @chip:	instance of the gpio_chip
- */
-struct stx104_dev {
-	struct iio_dev *indio_dev;
-	struct gpio_chip *chip;
-};
-
 static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -271,7 +261,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	struct iio_dev *indio_dev;
 	struct stx104_iio *priv;
 	struct stx104_gpio *stx104gpio;
-	struct stx104_dev *stx104dev;
 	int err;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
@@ -282,10 +271,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	if (!stx104gpio)
 		return -ENOMEM;
 
-	stx104dev = devm_kzalloc(dev, sizeof(*stx104dev), GFP_KERNEL);
-	if (!stx104dev)
-		return -ENOMEM;
-
 	if (!devm_request_region(dev, base[id], STX104_EXTENT,
 		dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -335,10 +320,6 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	spin_lock_init(&stx104gpio->lock);
 
-	stx104dev->indio_dev = indio_dev;
-	stx104dev->chip = &stx104gpio->chip;
-	dev_set_drvdata(dev, stx104dev);
-
 	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
 	if (err) {
 		dev_err(dev, "GPIO registering failed (%d)\n", err);
-- 
2.11.0

