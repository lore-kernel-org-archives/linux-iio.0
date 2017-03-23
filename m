Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33354 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932128AbdCWSfZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 23 Mar 2017 14:35:25 -0400
Date: Fri, 24 Mar 2017 00:05:20 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH v4] staging: iio: ade7753: Replace mlock with driver private
 lock
Message-ID: <20170323183520.GA9871@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---

 v4:
   -Add mutex_init

 drivers/staging/iio/meter/ade7753.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index b71fbd3..30aebaf 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -80,11 +80,13 @@
  * @us:         actual spi_device
  * @tx:         transmit buffer
  * @rx:         receive buffer
+ * @lock:       protect sensor state
  * @buf_lock:       mutex to protect tx and rx
  **/
 struct ade7753_state {
 	struct spi_device   *us;
 	struct mutex        buf_lock;
+	struct mutex	    lock;  /* protect sensor state */
 	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
 	u8          rx[ADE7753_MAX_RX];
 };
@@ -484,7 +486,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->lock);
 
 	t = 27900 / val;
 	if (t > 0)
@@ -505,7 +507,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
 	ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->lock);
 
 	return ret ? ret : len;
 }
@@ -581,6 +583,7 @@ static int ade7753_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->us = spi;
 	mutex_init(&st->buf_lock);
+	mutex_init(&st->lock);
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->dev.parent = &spi->dev;
-- 
2.7.4

