Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [v2 2/9] iio:adc:at91: Use new triggered buffer setup helper
Date: Fri,  8 Jun 2012 10:48:45 +0200
Message-Id: <1339145332-26811-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1339145332-26811-1-git-send-email-lars@metafoo.de>
References: <1339145332-26811-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Use the new triggered buffer setup helper function to allocate and register
buffer and pollfunc.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/Kconfig    |    3 +--
 drivers/iio/adc/at91_adc.c |   51 ++++----------------------------------------
 2 files changed, 5 insertions(+), 49 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 9a0df81..4f7f584 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -7,8 +7,7 @@ config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on ARCH_AT91
 	select IIO_BUFFER
-	select IIO_KFIFO_BUF
-	select IIO_TRIGGER
+	select IIO_TRIGGERED_BUFFER
 	select SYSFS
 	help
 	  Say yes here to build support for Atmel AT91 ADC.
diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index f18a95d..6a08469 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -26,9 +26,9 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include <mach/at91_adc.h>
 
@@ -318,58 +318,15 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
 	}
 }
 
-static const struct iio_buffer_setup_ops at91_adc_buffer_ops = {
-	.preenable = &iio_sw_buffer_preenable,
-	.postenable = &iio_triggered_buffer_postenable,
-	.predisable = &iio_triggered_buffer_predisable,
-};
-
 static int at91_adc_buffer_init(struct iio_dev *idev)
 {
-	int ret;
-
-	idev->buffer = iio_kfifo_allocate(idev);
-	if (!idev->buffer) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	idev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
-					    &at91_adc_trigger_handler,
-					    IRQF_ONESHOT,
-					    idev,
-					    "%s-consumer%d",
-					    idev->name,
-					    idev->id);
-	if (idev->pollfunc == NULL) {
-		ret = -ENOMEM;
-		goto error_pollfunc;
-	}
-
-	idev->setup_ops = &at91_adc_buffer_ops;
-	idev->modes |= INDIO_BUFFER_TRIGGERED;
-
-	ret = iio_buffer_register(idev,
-				  idev->channels,
-				  idev->num_channels);
-	if (ret)
-		goto error_register;
-
-	return 0;
-
-error_register:
-	iio_dealloc_pollfunc(idev->pollfunc);
-error_pollfunc:
-	iio_kfifo_free(idev->buffer);
-error_ret:
-	return ret;
+	return iio_triggered_buffer_setup(idev, &iio_pollfunc_store_time,
+		&at91_adc_trigger_handler, NULL);
 }
 
 static void at91_adc_buffer_remove(struct iio_dev *idev)
 {
-	iio_buffer_unregister(idev);
-	iio_dealloc_pollfunc(idev->pollfunc);
-	iio_kfifo_free(idev->buffer);
+	iio_triggered_buffer_cleanup(idev);
 }
 
 static int at91_adc_read_raw(struct iio_dev *idev,
-- 
1.7.10
