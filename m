Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: jic23@cam.ac.uk, gregkh@suse.de
CC: linux-iio@vger.kernel.org, Barry Song <21cnbao@gmail.com>
Subject: [PATCH v3] iio-utils: fix memory overflow for dynamically allocateded memory to hold filename
Date: Tue, 25 May 2010 17:40:04 +0800
Message-ID: <1274780404-17963-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/Documentation/iio_utils.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index a4555e6..014f668 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -62,9 +62,8 @@ inline int find_type_by_name(const char *name, const char *type)
 					1) != 0) {
 				filename = malloc(strlen(iio_dir)
 						+ strlen(type)
-						+ 1
 						+ numstrlen
-						+ 1);
+						+ 6);
 				if (filename == NULL)
 					return -ENOMEM;
 				sprintf(filename, "%s%s%d/name",
-- 
1.5.6.3
