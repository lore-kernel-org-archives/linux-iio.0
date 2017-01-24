Return-Path: <SRS0=ho3l=ZG=gmail.com=vilhelm.gray@kernel.org>
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH] iio: stx104: Utilize devm_ functions in driver probe callback
Date: Tue, 24 Jan 2017 15:26:17 -0500
Message-Id: <20170124202617.15512-1-vilhelm.gray@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The devm_ resource manager functions allow memory to be automatically
released when a device is unbound. This patch takes advantage of the
resource manager functions and replaces the gpiochip_add_data call and
iio_device_register call with the devm_gpiochip_add_data call and
devm_iio_device_register call respectively. In addition, the
stx104_remove function has been removed as no longer necessary due to
the use of the relevant devm_ resource manager functions.

Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/iio/adc/stx104.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/adc/stx104.c b/drivers/iio/adc/stx104.c
index 7e3645749eaf..c56ff286695d 100644
--- a/drivers/iio/adc/stx104.c
+++ b/drivers/iio/adc/stx104.c
@@ -339,30 +339,13 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	stx104dev->chip = &stx104gpio->chip;
 	dev_set_drvdata(dev, stx104dev);
 
-	err = gpiochip_add_data(&stx104gpio->chip, stx104gpio);
+	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
 	if (err) {
 		dev_err(dev, "GPIO registering failed (%d)\n", err);
 		return err;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err) {
-		dev_err(dev, "IIO device registering failed (%d)\n", err);
-		gpiochip_remove(&stx104gpio->chip);
-		return err;
-	}
-
-	return 0;
-}
-
-static int stx104_remove(struct device *dev, unsigned int id)
-{
-	struct stx104_dev *const stx104dev = dev_get_drvdata(dev);
-
-	iio_device_unregister(stx104dev->indio_dev);
-	gpiochip_remove(stx104dev->chip);
-
-	return 0;
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static struct isa_driver stx104_driver = {
@@ -370,7 +353,6 @@ static struct isa_driver stx104_driver = {
 	.driver = {
 		.name = "stx104"
 	},
-	.remove = stx104_remove
 };
 
 module_isa_driver(stx104_driver, num_stx104);
-- 
2.11.0
