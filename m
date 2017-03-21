Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:32924 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756924AbdCUNaq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 09:30:46 -0400
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, outreachy-kernel@googlegroups.com,
        Michael.Hennerich@analog.com, lars@metafoo.de,
        gregkh@linuxfoundation.org, speakup@linux-speakup.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH 1/2] staging: ad7759: Replace mlock with driver private lock
Date: Tue, 21 Mar 2017 19:00:18 +0530
Message-Id: <20170321133021.6737-2-arushisinghal19971997@gmail.com>
In-Reply-To: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
References: <20170321133021.6737-1-arushisinghal19971997@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 4 ++--
 drivers/staging/iio/meter/ade7759.h | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 944ee3401029..1d1e0b33021f 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -381,7 +381,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->buf_lock);
 
 	t = 27900 / val;
 	if (t > 0)
@@ -402,7 +402,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	ret = ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->buf_lock);
 
 	return ret ? ret : len;
 }
diff --git a/drivers/staging/iio/meter/ade7759.h b/drivers/staging/iio/meter/ade7759.h
index f0716d2fdf8e..4f69bb93cc45 100644
--- a/drivers/staging/iio/meter/ade7759.h
+++ b/drivers/staging/iio/meter/ade7759.h
@@ -42,6 +42,7 @@
  * @buf_lock:		mutex to protect tx and rx
  * @tx:			transmit buffer
  * @rx:			receive buffer
+ * @lock		protect sensor state
  **/
 struct ade7759_state {
 	struct spi_device	*us;
-- 
2.11.0

