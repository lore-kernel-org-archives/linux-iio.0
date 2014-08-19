Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:59551 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbaHSWnc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Aug 2014 18:43:32 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH v2 06/11] iio:bma180: Drop _update_scan_mode()
Date: Wed, 20 Aug 2014 00:43:21 +0200
Message-Id: <1408488206-2633-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
References: <1408488206-2633-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

statically allocate maximum size

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 91260a0..5838318 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -82,7 +82,7 @@ struct bma180_data {
 	int scale;
 	int bw;
 	bool pmode;
-	char *buff;
+	u8 buff[16]; /* 3x 16-bit + 8-bit + padding + timestamp */
 };
 
 enum bma180_chan {
@@ -408,26 +408,10 @@ static int bma180_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int bma180_update_scan_mode(struct iio_dev *indio_dev,
-		const unsigned long *scan_mask)
-{
-	struct bma180_data *data = iio_priv(indio_dev);
-
-	if (data->buff)
-		devm_kfree(&indio_dev->dev, data->buff);
-	data->buff = devm_kzalloc(&indio_dev->dev,
-			indio_dev->scan_bytes, GFP_KERNEL);
-	if (!data->buff)
-		return -ENOMEM;
-
-	return 0;
-}
-
 static const struct iio_info bma180_info = {
 	.attrs			= &bma180_attrs_group,
 	.read_raw		= bma180_read_raw,
 	.write_raw		= bma180_write_raw,
-	.update_scan_mode	= bma180_update_scan_mode,
 	.driver_module		= THIS_MODULE,
 };
 
-- 
1.9.1

