Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:56669 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab1LJPjs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2011 10:39:48 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/2] staging:iio: Make sure all triggers have a trigger_ops for the owner field.
Date: Sat, 10 Dec 2011 15:39:47 +0000
Message-Id: <1323531588-23293-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1323531588-23293-1-git-send-email-jic23@kernel.org>
References: <1323531588-23293-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The core needs the owner field to prevent module removal whilst in use and
uses it without confirming that the trigger_ops structure actually exists.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/adc/ad7192.c |    6 +++++-
 drivers/staging/iio/adc/ad7793.c |    5 +++++
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 66cc507..6114601 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -609,6 +609,10 @@ static irqreturn_t ad7192_data_rdy_trig_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static struct iio_trigger_ops ad7192_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
 static int ad7192_probe_trigger(struct iio_dev *indio_dev)
 {
 	struct ad7192_state *st = iio_priv(indio_dev);
@@ -621,7 +625,7 @@ static int ad7192_probe_trigger(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-
+	st->trig->ops = &ad7192_trigger_ops;
 	ret = request_irq(st->spi->irq,
 			  ad7192_data_rdy_trig_poll,
 			  IRQF_TRIGGER_LOW,
diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 4047c5d..f33feee 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -475,6 +475,10 @@ static irqreturn_t ad7793_data_rdy_trig_poll(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
+static struct iio_trigger_ops = {
+	.owner = THIS_MODULE,
+};
+
 static int ad7793_probe_trigger(struct iio_dev *indio_dev)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
@@ -487,6 +491,7 @@ static int ad7793_probe_trigger(struct iio_dev *indio_dev)
 		ret = -ENOMEM;
 		goto error_ret;
 	}
+	st->trig->ops = &ad7793_trigger_ops;
 
 	ret = request_irq(st->spi->irq,
 			  ad7793_data_rdy_trig_poll,
-- 
1.7.7.4

