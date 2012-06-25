Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55281 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756160Ab2FYVMT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jun 2012 17:12:19 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/7] iio staging: fix generic_buffer print2byte()
Date: Mon, 25 Jun 2012 23:12:11 +0200
Message-Id: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

drop extra argument, move cast

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index bf55335..361e481 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -72,8 +72,7 @@ void print2byte(int input, struct iio_channel_info *info)
 		val &= (1 << info->bits_used) - 1;
 		val = (int16_t)(val << (16 - info->bits_used)) >>
 			(16 - info->bits_used);
-		printf("%05f  ", val,
-		       (float)(val + info->offset)*info->scale);
+		printf("%05f ", ((float)val + info->offset)*info->scale);
 	} else {
 		uint16_t val = input;
 		val &= (1 << info->bits_used) - 1;
-- 
1.7.9.5

