Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33852 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbcGTEZm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 20 Jul 2016 00:25:42 -0400
Date: Tue, 19 Jul 2016 21:25:37 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: bma180: use iio helper function to guarantee
 direct mode
Message-ID: <20160720042525.GA31927@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
Peter: I was not clear if we want to keep the data->mutex lock
in addition to claiming direct mode.  I see that lock assuring
exclusivity amongst a few other tasks in the driver. Let me 
know if this needs both locks. Thanks!


 drivers/iio/accel/bma180.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index e3f88ba..ce5a476 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -469,13 +469,12 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		mutex_lock(&data->mutex);
-		if (iio_buffer_enabled(indio_dev)) {
-			mutex_unlock(&data->mutex);
-			return -EBUSY;
-		}
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		ret = bma180_get_data_reg(data, chan->scan_index);
-		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = sign_extend32(ret >> chan->scan_type.shift,
-- 
2.1.4

