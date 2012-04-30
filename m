Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:54333 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432Ab2D3OMe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 Apr 2012 10:12:34 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: replace strict_strtol() with kstrtol() in max517 driver
Date: Mon, 30 Apr 2012 16:12:31 +0200
Message-Id: <1335795152-14507-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <4F9E686F.3090703@metafoo.de>
References: <4F9E686F.3090703@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/dac/max517.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/dac/max517.c b/drivers/staging/iio/dac/max517.c
index a3f588df..60aef18 100644
--- a/drivers/staging/iio/dac/max517.c
+++ b/drivers/staging/iio/dac/max517.c
@@ -67,7 +67,7 @@ static ssize_t max517_set_value(struct device *dev,
 	int res;
 	long val;
 
-	res = strict_strtol(buf, 10, &val);
+	res = kstrtol(buf, 10, &val);
 
 	if (res)
 		return res;
-- 
1.7.9.5

