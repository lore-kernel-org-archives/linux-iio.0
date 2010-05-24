Return-Path: <21cnbao@gmail.com>
From: Barry Song <21cnbao@gmail.com>
To: gregkh@suse.de, jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
        Barry Song <21cnbao@gmail.com>
Subject: [PATCH] iio-utils: fix memory overflow for dynamically allocateded memory to hold filename
Date: Mon, 24 May 2010 17:30:18 +0800
Message-ID: <1274693418-23372-1-git-send-email-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Barry Song <21cnbao@gmail.com>
---
 drivers/staging/iio/Documentation/iio_utils.h |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 6411bf9..a4555e6 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -64,8 +64,7 @@ inline int find_type_by_name(const char *name, const char *type)
 						+ strlen(type)
 						+ 1
 						+ numstrlen
-						+ 1
-						+ IIO_MAX_NAME_LENGTH);
+						+ 1);
 				if (filename == NULL)
 					return -ENOMEM;
 				sprintf(filename, "%s%s%d/name",
-- 
1.5.6.3
