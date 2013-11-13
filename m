Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56482 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756842Ab3KMT0y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Nov 2013 14:26:54 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: frank@zago.net, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:accel:kxsd9 fix missing mutex unlock
Date: Wed, 13 Nov 2013 20:27:50 +0000
Message-Id: <1384374470-3188-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Frank Zago <frank@zago.net>

This will leave a lock held after reading from the device, preventing
any further reads.

Signed-off-by: Frank Zago <frank@zago.net>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
I have reworked this from a patch sent to me by Frank and put it
into the correct format.

Frank, do you mind me adding your sign off on this. It's shorter
than your patch, but the effect is the same.  This approach of unlocking
before checking a return value is a common kernel idiom.

Jonathan

 drivers/iio/accel/kxsd9.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index d72118d1189c..12df91986dd2 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -112,6 +112,7 @@ static int kxsd9_read(struct iio_dev *indio_dev, u8 address)
 	mutex_lock(&st->buf_lock);
 	st->tx[0] = KXSD9_READ(address);
 	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
+	mutex_unlock(&st->buf_lock);
 	if (ret)
 		return ret;
 	return (((u16)(st->rx[0])) << 8) | (st->rx[1] & 0xF0);
-- 
1.8.4.2

