Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:55543 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753286Ab3HaRMy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 31 Aug 2013 13:12:54 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so3092613pdj.22
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 10:12:53 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, sachin.kamat@linaro.org
Subject: [PATCH 2/9] staging: iio: ad7280a: Use devm_iio_device_alloc
Date: Sat, 31 Aug 2013 22:42:32 +0530
Message-Id: <1377969159-2491-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/adc/ad7280a.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index c19618b..e7191e4 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -835,8 +835,9 @@ static int ad7280_probe(struct spi_device *spi)
 	int ret;
 	const unsigned short tACQ_ns[4] = {465, 1010, 1460, 1890};
 	const unsigned short nAVG[4] = {1, 2, 4, 8};
-	struct iio_dev *indio_dev = iio_device_alloc(sizeof(*st));
+	struct iio_dev *indio_dev;
 
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 
@@ -860,7 +861,7 @@ static int ad7280_probe(struct spi_device *spi)
 
 	ret = ad7280_chain_setup(st);
 	if (ret < 0)
-		goto error_free_device;
+		return ret;
 
 	st->slave_num = ret;
 	st->scan_cnt = (st->slave_num + 1) * AD7280A_NUM_CH;
@@ -891,7 +892,7 @@ static int ad7280_probe(struct spi_device *spi)
 
 	ret = ad7280_channel_init(st);
 	if (ret < 0)
-		goto error_free_device;
+		return ret;
 
 	indio_dev->num_channels = ret;
 	indio_dev->channels = st->channels;
@@ -940,9 +941,6 @@ error_free_attr:
 error_free_channels:
 	kfree(st->channels);
 
-error_free_device:
-	iio_device_free(indio_dev);
-
 	return ret;
 }
 
@@ -960,7 +958,6 @@ static int ad7280_remove(struct spi_device *spi)
 
 	kfree(st->channels);
 	kfree(st->iio_attr);
-	iio_device_free(indio_dev);
 
 	return 0;
 }
-- 
1.7.4.1

