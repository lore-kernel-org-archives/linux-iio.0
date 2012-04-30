Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:54332 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751500Ab2D3OMe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 Apr 2012 10:12:34 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: call iio_device_unregister() in max517_remove()
Date: Mon, 30 Apr 2012 16:12:32 +0200
Message-Id: <1335795152-14507-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1335795152-14507-1-git-send-email-pmeerw@pmeerw.net>
References: <4F9E686F.3090703@metafoo.de>
 <1335795152-14507-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/dac/max517.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index 60aef18..672fa51 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -264,6 +264,7 @@ exit:
 
 static int max517_remove(struct i2c_client *client)
 {
+	iio_device_unregister(i2c_get_clientdata(client));
 	iio_device_free(i2c_get_clientdata(client));
 
 	return 0;
-- 
1.7.9.5

