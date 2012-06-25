Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 6/7] iio staging: use PRId64 format specifier for int64_t
Date: Mon, 25 Jun 2012 21:11:44 +0200
Message-Id: <1340651505-31081-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
References: <1340651505-31081-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/generic_buffer.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
index ab228b4..1dd0681 100644
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
+					printf(" %" PRId64, val);
 				else
 					printf("%05f ", ((float)val +
 							 channels[k].offset)*
-- 
1.7.9.5
