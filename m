Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] IIO: Documentation: iio_utils: fix mask generation
Date: Thu, 24 Feb 2011 13:41:16 +0100
Message-ID: <1298551276-20564-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Variable sizeint is used uninitialized.
Remove sizeint completely and use bits_used instead.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/Documentation/iio_utils.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index bde2313..1b33c04 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -113,7 +113,7 @@ inline int iioutils_get_type(unsigned *is_signed,
 	DIR *dp;
 	char *scan_el_dir, *builtname, *builtname_generic, *filename = 0;
 	char signchar;
-	unsigned sizeint, padint;
+	unsigned padint;
 	const struct dirent *ent;
 
 	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
@@ -159,7 +159,7 @@ inline int iioutils_get_type(unsigned *is_signed,
 			fscanf(sysfsfp,
 			       "%c%u/%u", &signchar, bits_used, &padint);
 			*bytes = padint / 8;
-			if (sizeint == 64)
+			if (*bits_used == 64)
 				*mask = ~0;
 			else
 				*mask = (1 << *bits_used) - 1;
-- 
1.6.0.2
