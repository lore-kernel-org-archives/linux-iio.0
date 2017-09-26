Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35509 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031141AbdIZO7F (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Sep 2017 10:59:05 -0400
Received: by mail-pg0-f67.google.com with SMTP id j16so6918389pga.2
        for <linux-iio@vger.kernel.org>; Tue, 26 Sep 2017 07:59:05 -0700 (PDT)
From: Aastha Gupta <aastha.gupta4104@gmail.com>
To: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: Aastha Gupta <aastha.gupta4104@gmail.com>
Subject: [PATCH 1/2] staging: iio: adc: ad7192: Replace mlock with driver private lock
Date: Tue, 26 Sep 2017 20:28:36 +0530
Message-Id: <1506437917-7219-2-git-send-email-aastha.gupta4104@gmail.com>
In-Reply-To: <1506437917-7219-1-git-send-email-aastha.gupta4104@gmail.com>
References: <1506437917-7219-1-git-send-email-aastha.gupta4104@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.

Signed-off-by: Aastha Gupta <aastha.gupta4104@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index d11c6de..096d29d 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -162,6 +162,7 @@ struct ad7192_state {
 	u32				scale_avail[8][2];
 	u8				gpocon;
 	u8				devid;
+	struct mutex			lock;
 
 	struct ad_sigma_delta		sd;
 };
@@ -463,10 +464,10 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		switch (chan->type) {
 		case IIO_VOLTAGE:
-			mutex_lock(&indio_dev->mlock);
+			mutex_lock(&st->lock);
 			*val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
 			*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
-			mutex_unlock(&indio_dev->mlock);
+			mutex_unlock(&st->lock);
 			return IIO_VAL_INT_PLUS_NANO;
 		case IIO_TEMP:
 			*val = 0;
@@ -634,6 +635,8 @@ static int ad7192_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	mutex_init(&st->lock);
+
 	st->avdd = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(st->avdd))
 		return PTR_ERR(st->avdd);
-- 
2.7.4

