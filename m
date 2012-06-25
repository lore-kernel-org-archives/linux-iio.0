Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/3] iio staging: fix potential resource leak in generic_buffer
Date: Mon, 25 Jun 2012 23:13:24 +0200
Message-Id: <1340658806-5609-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/Documentation/iio_utils.h |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index c0448b3..9241288 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -158,7 +158,8 @@ inline int iioutils_get_type(unsigned *is_signed,
 				     &padint, shift);
 			if (ret < 0) {
 				printf("failed to pass scan type description\n");
-				return ret;
+				ret = -errno;
+				goto error_close_sysfsfp;
 			}
 			*be = (endianchar == 'b');
 			*bytes = padint / 8;
@@ -174,7 +175,11 @@ inline int iioutils_get_type(unsigned *is_signed,
 			free(filename);
 
 			filename = 0;
+			sysfsfp = 0;
 		}
+error_close_sysfsfp:
+	if (sysfsfp)
+		fclose(sysfsfp);
 error_free_filename:
 	if (filename)
 		free(filename);
-- 
1.7.9.5
