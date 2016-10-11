Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36431 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752554AbcJKTrc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Oct 2016 15:47:32 -0400
Date: Tue, 11 Oct 2016 12:31:36 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: mma8452: claim direct mode during raw reads
Message-ID: <20161011193127.GA8708@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it.  Use
claim/release helper functions to guarantee the device stays
in direct mode during raw reads.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/accel/mma8452.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 6e82e02..cbbc746 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -459,12 +459,14 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 
 		mutex_lock(&data->lock);
 		ret = mma8452_read(data, buffer);
 		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 
-- 
2.1.4

