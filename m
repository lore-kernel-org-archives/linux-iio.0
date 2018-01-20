Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45324 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754742AbeATPoz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Jan 2018 10:44:55 -0500
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH] Staging: iio: ade7758: Replace mlock with buf_lock
Date: Sat, 20 Jan 2018 21:14:48 +0530
Message-Id: <1516463088-2514-1-git-send-email-shreeya.patel23498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

iio_dev->mlock is to be used only by the IIO core for protecting
device mode changes between INDIO_DIRECT and INDIO_BUFFER.

This patch replaces the use of mlock with the already established
buf_lock mutex.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/meter/ade7758_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 7b7ffe5..1a866cc 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -523,12 +523,13 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	int ret;
+	struct ade7758_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->buf_lock);
 		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->buf_lock);
 		return ret;
 	default:
 		return -EINVAL;
@@ -542,14 +543,15 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
 			     int val, int val2, long mask)
 {
 	int ret;
+	struct ade7758_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->buf_lock);
 		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->buf_lock);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.7.4

