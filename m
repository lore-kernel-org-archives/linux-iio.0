Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34042 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbcFHATH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2016 20:19:07 -0400
Date: Tue, 7 Jun 2016 17:19:05 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: j.anaszewski@samsung.com, pmeerw@pmeerw.net, knaack.h@gmx.de,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: gp2ap020a00f: use iio helper function to lock
 direct mode
Message-ID: <20160608001856.GA15114@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.  Includes a
tiny bit of refactoring (single case -> if) and simplified return
flow.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/light/gp2ap020a00f.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 6d41086..af73af3 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -1287,22 +1287,14 @@ static int gp2ap020a00f_read_raw(struct iio_dev *indio_dev,
 	struct gp2ap020a00f_data *data = iio_priv(indio_dev);
 	int err = -EINVAL;
 
-	mutex_lock(&data->lock);
-
-	switch (mask) {
-	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev)) {
-			err = -EBUSY;
-			goto error_unlock;
-		}
+	if (mask == IIO_CHAN_INFO_RAW) {
+		err = iio_device_claim_direct_mode(indio_dev);
+		if (err)
+			return err;
 
 		err = gp2ap020a00f_read_channel(data, chan, val);
-		break;
+		iio_device_release_direct_mode(indio_dev);
 	}
-
-error_unlock:
-	mutex_unlock(&data->lock);
-
 	return err < 0 ? err : IIO_VAL_INT;
 }
 
-- 
2.1.4

