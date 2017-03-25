Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33529 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdCYT4L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 15:56:11 -0400
Received: by mail-pg0-f65.google.com with SMTP id 79so3894115pgf.0
        for <linux-iio@vger.kernel.org>; Sat, 25 Mar 2017 12:56:11 -0700 (PDT)
From: Gargi Sharma <gs051095@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        Gargi Sharma <gs051095@gmail.com>
Subject: [RFC] staging: iio: update locking method during frequency writes
Date: Sun, 26 Mar 2017 01:25:17 +0530
Message-Id: <1490471717-1413-1-git-send-email-gs051095@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver needs to insure atomicity during frequency
changes of bus and device. The iiodev->mlock as used
was not doing that. Replace it with the drivers existing
buffer lock and execute spi_write directly.

Signed-off-by: Gargi Sharma <gs051095@gmail.com>
---
ade7754_set_irq() has a similar read then write without any locking
mechanism in place. Do we want to introduce something similar there?
---
 drivers/staging/iio/meter/ade7754.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index c8d2d4c..48339e9a 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -513,7 +513,7 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->buf_lock);
 
 	t = 26000 / val;
 	if (t > 0)
@@ -531,10 +531,13 @@ static ssize_t ade7754_write_frequency(struct device *dev,
 	reg &= ~(3 << 3);
 	reg |= t << 3;
 
-	ret = ade7754_spi_write_reg_8(dev, ADE7754_WAVMODE, reg);
+	st->tx[0] = ADE7754_WRITE_REG(ADE7754_WAVMODE);
+	st->tx[1] = reg;
+
+	ret = spi_write(st->us, st->tx, 2);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->buf_lock);
 
 	return ret ? ret : len;
 }
-- 
2.7.4

