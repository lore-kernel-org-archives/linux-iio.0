Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:58510 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753625AbaGCGlu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Jul 2014 02:41:50 -0400
Received: by mail-pa0-f44.google.com with SMTP id rd3so13937153pab.31
        for <linux-iio@vger.kernel.org>; Wed, 02 Jul 2014 23:41:50 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, spk.linux@gmail.com,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 4/5] iio: ad5686: Remove redundant variable
Date: Thu,  3 Jul 2014 12:08:04 +0530
Message-Id: <1404369485-1903-4-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
References: <1404369485-1903-1-git-send-email-sachin.kamat@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

‘regdone’ is not used in the function. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/iio/dac/ad5686.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 17aca4d..f57562a 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -313,7 +313,7 @@ static int ad5686_probe(struct spi_device *spi)
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	int ret, regdone = 0, voltage_uv = 0;
+	int ret, voltage_uv = 0;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
@@ -355,7 +355,6 @@ static int ad5686_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channel;
 	indio_dev->num_channels = AD5686_DAC_CHANNELS;
 
-	regdone = 1;
 	ret = ad5686_spi_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
 				!!voltage_uv, 0);
 	if (ret)
-- 
1.7.9.5

