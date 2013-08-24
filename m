Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36037 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3HXSsp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 24 Aug 2013 14:48:45 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so1908093pdj.22
        for <linux-iio@vger.kernel.org>; Sat, 24 Aug 2013 11:48:44 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk, jic23@kernel.org, sachin.kamat@linaro.org,
	lars@metafoo.de
Subject: [PATCH 7/8] staging: iio: lis3l02dq: Use devm_iio_device_alloc
Date: Sun, 25 Aug 2013 00:18:11 +0530
Message-Id: <1377370092-2436-7-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
References: <1377370092-2436-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Using devm_iio_device_alloc makes code simpler.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   15 ++++-----------
 1 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 8ed75a9..bb852dc 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -668,11 +668,9 @@ static int lis3l02dq_probe(struct spi_device *spi)
 	struct lis3l02dq_state *st;
 	struct iio_dev *indio_dev;
 
-	indio_dev = iio_device_alloc(sizeof *st);
-	if (indio_dev == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	/* this is only used for removal purposes */
 	spi_set_drvdata(spi, indio_dev);
@@ -690,7 +688,7 @@ static int lis3l02dq_probe(struct spi_device *spi)
 
 	ret = lis3l02dq_configure_buffer(indio_dev);
 	if (ret)
-		goto error_free_dev;
+		return ret;
 
 	ret = iio_buffer_register(indio_dev,
 				  lis3l02dq_channels,
@@ -736,9 +734,6 @@ error_uninitialize_buffer:
 	iio_buffer_unregister(indio_dev);
 error_unreg_buffer_funcs:
 	lis3l02dq_unconfigure_buffer(indio_dev);
-error_free_dev:
-	iio_device_free(indio_dev);
-error_ret:
 	return ret;
 }
 
@@ -786,8 +781,6 @@ static int lis3l02dq_remove(struct spi_device *spi)
 	iio_buffer_unregister(indio_dev);
 	lis3l02dq_unconfigure_buffer(indio_dev);
 
-	iio_device_free(indio_dev);
-
 	return 0;
 }
 
-- 
1.7.4.1

