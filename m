Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:55290 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757215Ab2FYVMU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 Jun 2012 17:12:20 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 6/7] iio staging: use PRId64 format specifier for int64_t
Date: Mon, 25 Jun 2012 23:12:16 +0200
Message-Id: <1340658737-5529-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
References: <1340658737-5529-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/Documentation/generic_buffer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index b89b7218..b16c4b2 100644
--- a/drivers/staging/iio/Documentation/generic_buffer.c
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -29,6 +29,7 @@
 #include <string.h>
 #include <poll.h>
 #include <endian.h>
+#include <inttypes.h>
 #include "iio_utils.h"
 
 /**
@@ -111,7 +112,7 @@ void process_scan(char *data,
 				/* special case for timestamp */
 				if (channels[k].scale == 1.0f &&
 				    channels[k].offset == 0.0f)
-					printf(" %lld", val);
+					printf("%" PRId64 " ", val);
 				else
 					printf("%05f ", ((float)val +
 							 channels[k].offset)*
-- 
1.7.9.5

