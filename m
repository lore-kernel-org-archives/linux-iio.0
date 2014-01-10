Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58102 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753722AbaAJV7Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jan 2014 16:59:25 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/5] iio:magnetometer:mag3110: Fix output of decimal digits in show_int_plus_micros()
Date: Fri, 10 Jan 2014 22:59:20 +0100
Message-Id: <1389391163-9622-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net>
References: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

need to print leading zeros, hence "%d.%06d"

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/mag3110.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index b88cb44..f66955f 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -106,7 +106,7 @@ static ssize_t mag3110_show_int_plus_micros(char *buf,
 
 	while (n-- > 0)
 		len += scnprintf(buf + len, PAGE_SIZE - len,
-			"%d.%d ", vals[n][0], vals[n][1]);
+			"%d.%06d ", vals[n][0], vals[n][1]);
 
 	/* replace trailing space by newline */
 	buf[len - 1] = '\n';
-- 
1.8.3.2

