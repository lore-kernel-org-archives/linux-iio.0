Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:34196 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932263Ab3JNVfF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Oct 2013 17:35:05 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v3 10/10] staging:iio:hmc5843: Trivial cleanups
Date: Mon, 14 Oct 2013 23:34:58 +0200
Message-Id: <1381786498-25954-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net>
References: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 74a456b..2c8103fb 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -278,10 +278,9 @@ static int hmc5843_check_int_plus_micros(const int (*vals)[2], int n,
 {
 	int i;
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < n; i++)
 		if (val == vals[i][0] && val2 == vals[i][1])
 			return i;
-	}
 
 	return -EINVAL;
 }
@@ -602,7 +601,7 @@ static int hmc5843_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
-	 /*  sleep mode to save power */
+	/*  sleep mode to save power */
 	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
 
 	return 0;
-- 
1.8.4

