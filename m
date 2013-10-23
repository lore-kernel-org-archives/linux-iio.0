Return-Path: <bigeasy@linutronix.de>
Date: Wed, 23 Oct 2013 21:36:20 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2 v2] iio: adc: ti_am335x_adc: do not free the kfifo twice
Message-ID: <20131023193620.GA5874@linutronix.de>
References: <1382547624-15256-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1382547624-15256-1-git-send-email-bigeasy@linutronix.de>
List-ID: <linux-iio@vger.kernel.org>

Since commit 9e69c9 ("iio: Add reference counting for buffers") the iio
core frees the buffer. So if the driver does it as well then bad things
will happen.

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1=E2=80=A6v2: make it compile after removal of error_kfifo_free label. Grm=
l.
       I tested it before I removed the same thing from
       tiadc_iio_buffered_hardware_setup()

 drivers/iio/adc/ti_am335x_adc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_ad=
c.c
index f974dea..4f6e0ce 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -239,7 +239,7 @@ static int tiadc_iio_buffered_hardware_setup(struct iio=
_dev *indio_dev,
 	ret =3D request_threaded_irq(irq,	pollfunc_th, pollfunc_bh,
 				flags, indio_dev->name, indio_dev);
 	if (ret)
-		goto error_kfifo_free;
+		return ret;
=20
 	indio_dev->setup_ops =3D setup_ops;
 	indio_dev->modes |=3D INDIO_BUFFER_HARDWARE;
@@ -254,8 +254,6 @@ static int tiadc_iio_buffered_hardware_setup(struct iio=
_dev *indio_dev,
=20
 error_free_irq:
 	free_irq(irq, indio_dev);
-error_kfifo_free:
-	iio_kfifo_free(indio_dev->buffer);
 	return ret;
 }
=20
@@ -264,7 +262,6 @@ static void tiadc_iio_buffered_hardware_remove(struct i=
io_dev *indio_dev)
 	struct tiadc_device *adc_dev =3D iio_priv(indio_dev);
=20
 	free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
-	iio_kfifo_free(indio_dev->buffer);
 	iio_buffer_unregister(indio_dev);
 }
=20
--=20
1.8.4.rc3
