Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:34241 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345AbcGYTLW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2016 15:11:22 -0400
Date: Mon, 25 Jul 2016 12:11:20 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: accel: bma180: use iio helper function to guarantee
 direct mode
Message-ID: <20160725191109.GA10048@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
Changes in v2:
 - put back private data lock I had removed in v1.

 drivers/iio/accel/bma180.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index e3f88ba..0890934 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -469,13 +469,14 @@ static int bma180_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
+
 		mutex_lock(&data->mutex);
-		if (iio_buffer_enabled(indio_dev)) {
-			mutex_unlock(&data->mutex);
-			return -EBUSY;
-		}
 		ret = bma180_get_data_reg(data, chan->scan_index);
 		mutex_unlock(&data->mutex);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = sign_extend32(ret >> chan->scan_type.shift,
-- 
2.1.4

