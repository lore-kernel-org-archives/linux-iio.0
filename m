Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/22] staging:iio:ad7192: Remove unused platform_data from device state struct
Date: Fri, 10 Aug 2012 18:36:27 +0200
Message-Id: <1344616596-8026-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The platform data for the device is only used from within the drivers probe
callback, so there is no need to keep it around in the devices state struct.

While we are at it mark the platform data struct as const.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7192.c |   11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 405d9a8..cdb4fc4 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -136,7 +136,6 @@ struct ad7192_state {
 	struct spi_device		*spi;
 	struct iio_trigger		*trig;
 	struct regulator		*reg;
-	struct ad7192_platform_data	*pdata;
 	wait_queue_head_t		wq_data_avail;
 	bool				done;
 	bool				irq_dis;
@@ -347,10 +346,10 @@ out:
 	return ret;
 }
 
-static int ad7192_setup(struct ad7192_state *st)
+static int ad7192_setup(struct ad7192_state *st,
+	const struct ad7192_platform_data *pdata)
 {
 	struct iio_dev *indio_dev = spi_get_drvdata(st->spi);
-	struct ad7192_platform_data *pdata = st->pdata;
 	unsigned long long scale_uv;
 	int i, ret, id;
 	u8 ones[6];
@@ -985,7 +984,7 @@ static const struct iio_chan_spec ad7192_channels[] = {
 
 static int __devinit ad7192_probe(struct spi_device *spi)
 {
-	struct ad7192_platform_data *pdata = spi->dev.platform_data;
+	const struct ad7192_platform_data *pdata = spi->dev.platform_data;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	int ret , voltage_uv = 0;
@@ -1015,8 +1014,6 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 		voltage_uv = regulator_get_voltage(st->reg);
 	}
 
-	st->pdata = pdata;
-
 	if (pdata && pdata->vref_mv)
 		st->int_vref_mv = pdata->vref_mv;
 	else if (voltage_uv)
@@ -1047,7 +1044,7 @@ static int __devinit ad7192_probe(struct spi_device *spi)
 	if (ret)
 		goto error_ring_cleanup;
 
-	ret = ad7192_setup(st);
+	ret = ad7192_setup(st, pdata);
 	if (ret)
 		goto error_remove_trigger;
 
-- 
1.7.10.4
