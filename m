Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56559 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753290Ab2F3Wro (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 30 Jun 2012 18:47:44 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio staging: missing newline in printf
Date: Sun,  1 Jul 2012 00:47:41 +0200
Message-Id: <1341096463-13789-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_utils.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 5244fa0..cf32ae0 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -453,7 +453,7 @@ inline int find_type_by_name(const char *name, const char *type)
 
 	dp = opendir(iio_dir);
 	if (dp == NULL) {
-		printf("No industrialio devices available");
+		printf("No industrialio devices available\n");
 		return -ENODEV;
 	}
 
-- 
1.7.9.5

