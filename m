Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 1/2] staging:iio:Documentation: cleanup properly in buffer handling code
Date: Sun, 27 Nov 2011 11:46:04 +0000
Message-Id: <1322394365-3214-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1322394365-3214-1-git-send-email-jic23@kernel.org>
References: <1322394365-3214-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@cam.ac.uk>

Eating the endian description for now.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/iio_utils.h |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index dbbad8a..986889b 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -145,9 +145,17 @@ inline int iioutils_get_type(unsigned *is_signed,
 				ret = -errno;
 				goto error_free_filename;
 			}
-			fscanf(sysfsfp,
-			       "%c%u/%u>>%u", &signchar, bits_used,
-			       &padint, shift);
+
+			ret = fscanf(sysfsfp,
+				     "%ce:%c%u/%u>>%u",
+				     &endianchar,
+				     &signchar,
+				     bits_used,
+				     &padint, shift);
+			if (ret < 0) {
+				printf("failed to pass scan type description\n");
+				return ret;
+			}
 			*bytes = padint / 8;
 			if (*bits_used == 64)
 				*mask = ~0;
@@ -157,6 +165,10 @@ inline int iioutils_get_type(unsigned *is_signed,
 				*is_signed = 1;
 			else
 				*is_signed = 0;
+			fclose(sysfsfp);
+			free(filename);
+
+			filename = 0;
 		}
 error_free_filename:
 	if (filename)
-- 
1.7.7.3
