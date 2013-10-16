Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:49257 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760834Ab3JPWTV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Oct 2013 18:19:21 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v4 11/11] staging:iio:hmc5843: Trivial cleanup
Date: Thu, 17 Oct 2013 00:19:14 +0200
Message-Id: <1381961954-25596-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net>
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 7e688dd..99421f9 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -587,7 +587,7 @@ static int hmc5843_remove(struct i2c_client *client)
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 
-	 /*  sleep mode to save power */
+	/*  sleep mode to save power */
 	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
 
 	return 0;
-- 
1.8.4

