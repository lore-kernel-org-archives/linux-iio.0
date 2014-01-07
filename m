Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41008 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753596AbaAGW3f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 7 Jan 2014 17:29:35 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: Remove obsolete variable in tcs3472 driver
Date: Tue,  7 Jan 2014 23:29:34 +0100
Message-Id: <1389133774-28091-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389133774-28091-1-git-send-email-pmeerw@pmeerw.net>
References: <1389133774-28091-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

len variable became obsolete with
iio_push_to_buffers_with_timestamp()

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/tcs3472.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 887fecf..fe063a0 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -179,7 +179,6 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct tcs3472_data *data = iio_priv(indio_dev);
-	int len = 0;
 	int i, j = 0;
 
 	int ret = tcs3472_req_data(data);
@@ -194,7 +193,6 @@ static irqreturn_t tcs3472_trigger_handler(int irq, void *p)
 			goto done;
 
 		data->buffer[j++] = ret;
-		len += 2;
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
-- 
1.8.3.2

