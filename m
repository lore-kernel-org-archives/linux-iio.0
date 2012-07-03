Return-Path: <sha@pengutronix.de>
From: Sascha Hauer <s.hauer@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Sonic Zhang <sonic.zhang@analog.com>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH] stagin iio adt7410: use local platformdata if none is specified
Date: Tue,  3 Jul 2012 11:27:53 +0200
Message-Id: <1341307673-7936-1-git-send-email-s.hauer@pengutronix.de>
List-ID: <linux-iio@vger.kernel.org>

The adt7410 expects information about an irq in platform_data.
The driver can work without an irq, so make platform_data optional
by specifying a dummy platform_data if the device has none.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

This should have been part of the other series for the adt7410 I just sent,
but I overlooked this patch.

 drivers/staging/iio/adc/adt7410.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index 917b692..d7d9ad9 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -720,6 +720,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int ret = 0;
 	unsigned long *adt7410_platform_data = client->dev.platform_data;
+	unsigned long local_pdata[] = {0, 0};
 
 	indio_dev = iio_device_alloc(sizeof(*chip));
 	if (indio_dev == NULL) {
@@ -737,6 +738,9 @@ static int __devinit adt7410_probe(struct i2c_client *client,
 	indio_dev->info = &adt7410_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
+	if (!adt7410_platform_data)
+		adt7410_platform_data = local_pdata;
+
 	/* CT critcal temperature event. line 0 */
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq,
-- 
1.7.10
