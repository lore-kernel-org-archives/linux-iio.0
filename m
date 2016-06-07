Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36517 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbcFGFIg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2016 01:08:36 -0400
Date: Mon, 6 Jun 2016 22:08:33 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: isl29125: use iio helper function to guarantee
 direct mode
Message-ID: <20160607050823.GA26908@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace the code that guarantees the device stays in direct mode
with iio_device_claim_direct_mode() which does same.  This allows
removal of an unused lock in the device private global data.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/light/isl29125.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/isl29125.c b/drivers/iio/light/isl29125.c
index e2945a2..a6b9d66 100644
--- a/drivers/iio/light/isl29125.c
+++ b/drivers/iio/light/isl29125.c
@@ -50,7 +50,6 @@
 
 struct isl29125_data {
 	struct i2c_client *client;
-	struct mutex lock;
 	u8 conf1;
 	u16 buffer[8]; /* 3x 16-bit, padding, 8 bytes timestamp */
 };
@@ -128,11 +127,11 @@ static int isl29125_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
-		mutex_lock(&data->lock);
+		ret = iio_device_claim_direct_mode(indio_dev);
+		if (ret)
+			return ret;
 		ret = isl29125_read_data(data, chan->scan_index);
-		mutex_unlock(&data->lock);
+		iio_device_release_direct_mode(indio_dev);
 		if (ret < 0)
 			return ret;
 		*val = ret;
@@ -259,7 +258,6 @@ static int isl29125_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	mutex_init(&data->lock);
 
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &isl29125_info;
-- 
2.1.4

