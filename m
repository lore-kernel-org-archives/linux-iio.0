Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33653 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750968AbdCaCrJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2017 22:47:09 -0400
Date: Fri, 31 Mar 2017 08:17:03 +0530
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: lars@metafoo.de
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: meter: Replace mlock with driver private
 buf_lock
Message-ID: <20170331024702.GA18533@arushi-HP-Pavilion-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver needs to insure atomicity during frequency
changes of bus and device. The iiodev->mlock as used
was not doing that. Replace it with the drivers existing
buffer lock and execute spi_write directly.

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
 drivers/staging/iio/meter/ade7759.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 0b65f1847510..a5ee4501d30a 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -429,7 +429,7 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&indio_dev->mlock);
+	mutex_lock(&st->buf_lock);
 
 	t = 27900 / val;
 	if (t > 0)
@@ -447,10 +447,13 @@ static ssize_t ade7759_write_frequency(struct device *dev,
 	reg &= ~(3 << 13);
 	reg |= t << 13;
 
-	ret = ade7759_spi_write_reg_16(dev, ADE7759_MODE, reg);
+	st->tx[0] = ADE7759_WRITE_REG(ADE7759_MODE);
+	st->tx[1] = reg;
+
+	ret = spi_write(st->us, st->tx, 2);
 
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&st->buf_lock);
 
 	return ret ? ret : len;
 }
-- 
2.11.0

