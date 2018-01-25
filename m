Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:24400
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751707AbeAYMbN (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 25 Jan 2018 07:31:13 -0500
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: <michael.hennerich@analog.com>, <lars@metafoo.de>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] staging: iio: ad5933: switch buffer mode to software
Date: Thu, 25 Jan 2018 14:30:45 +0200
Message-ID: <20180125123045.29550-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since commit 152a6a884ae1 ("staging:iio:accel:sca3000 move
to hybrid hard / soft buffer design.")
the buffer mechanism has changed and the
INDIO_BUFFER_HARDWARE flag has been unused.

Since commit 2d6ca60f3284 ("iio: Add a DMAengine framework
based buffer")
the INDIO_BUFFER_HARDWARE flag has been re-purposed for
DMA buffers.

This driver has lagged behind these changes, and
in order for buffers to work, the INDIO_BUFFER_SOFTWARE
needs to be used.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3d539eeb0e26..6d31001d1825 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -649,8 +649,6 @@ static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
 	/* Ring buffer functions - here trigger setup related */
 	indio_dev->setup_ops = &ad5933_ring_setup_ops;
 
-	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
-
 	return 0;
 }
 
@@ -763,7 +761,7 @@ static int ad5933_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->info = &ad5933_info;
 	indio_dev->name = id->name;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
 	indio_dev->channels = ad5933_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
 
-- 
2.14.1

