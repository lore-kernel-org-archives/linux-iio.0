Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:35839 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751603AbdAWSIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2017 13:08:47 -0500
Received: by mail-ot0-f195.google.com with SMTP id 65so16321747otq.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Jan 2017 10:08:41 -0800 (PST)
From: =?UTF-8?q?Juli=C3=A1n=20de=20Gortari?= <kiototeko@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        =?UTF-8?q?Juli=C3=A1n=20de=20Gortari?= <kiototeko@gmail.com>
Subject: [PATCH] Staging: iio: adc: fix symbolic permissions coding style issue
Date: Mon, 23 Jan 2017 12:08:29 -0600
Message-Id: <1485194909-12453-1-git-send-email-kiototeko@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Octal permissions should be used instead of symbolic ones for easier
reading.

Signed-off-by: Julián de Gortari <kiototeko@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 72551f8..17d2805 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -139,7 +139,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(mode, 0644,
 		ad7816_show_mode,
 		ad7816_store_mode,
 		0);
@@ -151,7 +151,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
 	return sprintf(buf, "full\npower-save\n");
 }
 
-static IIO_DEVICE_ATTR(available_modes, S_IRUGO, ad7816_show_available_modes,
+static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
 			NULL, 0);
 
 static ssize_t ad7816_show_channel(struct device *dev,
@@ -197,7 +197,7 @@ static ssize_t ad7816_store_channel(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(channel, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(channel, 0644,
 		ad7816_show_channel,
 		ad7816_store_channel,
 		0);
@@ -228,7 +228,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 	return sprintf(buf, "%u\n", data);
 }
 
-static IIO_DEVICE_ATTR(value, S_IRUGO, ad7816_show_value, NULL, 0);
+static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
 
 static struct attribute *ad7816_attributes[] = {
 	&iio_dev_attr_available_modes.dev_attr.attr,
@@ -319,7 +319,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR(oti, S_IRUGO | S_IWUSR,
+static IIO_DEVICE_ATTR(oti, 0644,
 		       ad7816_show_oti, ad7816_set_oti, 0);
 
 static struct attribute *ad7816_event_attributes[] = {
-- 
2.7.4

