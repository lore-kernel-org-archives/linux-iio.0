Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33158 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755747AbdCLNdx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2017 09:33:53 -0400
Date: Sun, 12 Mar 2017 19:02:50 +0530
From: simran singhal <singhalsimran0@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Pete Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] staging: iio: ade7753: replace mlock with driver private lock
Message-ID: <20170312133250.GA7772@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, mlock was being used to protect hardware state
changes.  Replace it with a lock in the devices global data.

Fix some coding style issues related to white space also.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/staging/iio/meter/ade7753.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index dfd8b71..ca99d82 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -81,12 +81,14 @@
  * @tx:         transmit buffer
  * @rx:         receive buffer
  * @buf_lock:       mutex to protect tx and rx
+ * @lock:	protect sensor state
  **/
 struct ade7753_state {
-	    struct spi_device   *us;
-		    struct mutex        buf_lock;
-			    u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
-				    u8          rx[ADE7753_MAX_RX];
+	struct spi_device   *us;
+	struct mutex        buf_lock;
+	struct mutex        lock;	/* protect sensor state */
+	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
+	u8          rx[ADE7753_MAX_RX];
 };
 
 static int ade7753_spi_write_reg_8(struct device *dev,
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
-- 
2.7.4

