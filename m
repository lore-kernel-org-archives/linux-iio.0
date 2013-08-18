Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55570 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755306Ab3HRM7S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 18 Aug 2013 08:59:18 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: adjd_s311: Fix non-scan mode data read
Date: Sun, 18 Aug 2013 14:59:12 +0200
Message-Id: <1376830753-2430-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

forgot to convert channel index to data register

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/adjd_s311.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 55b9e18..c4b730d 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -232,7 +232,8 @@ static int adjd_s311_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		ret = adjd_s311_read_data(indio_dev, chan->address, val);
+		ret = adjd_s311_read_data(indio_dev,
+			ADJD_S311_DATA_REG(chan->address), val);
 		if (ret < 0)
 			return ret;
 		return IIO_VAL_INT;
-- 
1.8.3.4

