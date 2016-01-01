Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:adc:ti_am335x_adc Fix buffered mode by identifying as software buffer.
Date: Fri,  1 Jan 2016 18:05:34 +0000
Message-Id: <1451671534-23708-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Whilst this part has a hardware buffer, the identifcation that IIO cares
about is the userspace facing end.  It this case we push individual elements
from the hardware fifo into the software interface (specifically a kfifo)
rather than providing direct reads through to a hardware buffer
(as we still do in the sca3000 for example).

Technically the original specification as a hardware buffer could be
considered wrong, but it didn't matter until the patch listed below.

Result is that any attempt to enable the buffer will return -EINVAL

Fixes: 225d59adf1c8 ("iio: Specify supported modes for buffers")
Cc: lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 942320e32753..c1e05532d437 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -289,7 +289,7 @@ static int tiadc_iio_buffered_hardware_setup(struct iio_dev *indio_dev,
 		goto error_kfifo_free;
 
 	indio_dev->setup_ops = setup_ops;
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
+	indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
 
 	return 0;
 
-- 
2.6.4
