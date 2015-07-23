Return-Path: <jasaw@dius.com.au>
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH] tools: iio: make scale and offset files optional
Date: Thu, 23 Jul 2015 12:53:47 +1000
Message-Id: <1437620027-24635-1-git-send-email-jasaw@dius.com.au>
List-ID: <linux-iio@vger.kernel.org>

From: Joo Aun Saw <jasaw@dius.com.au>

Make scale and offset optional by adding -ENOENT check as not all
drivers implement them.

Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
---
 tools/iio/iio_utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index c3f9e37..1dcdf03 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -487,7 +487,7 @@ int build_channel_array(const char *device_dir,
 						       device_dir,
 						       current->name,
 						       current->generic_name);
-			if (ret < 0)
+			if ((ret < 0) && (ret != -ENOENT))
 				goto error_cleanup_array;
 
 			ret = iioutils_get_param_float(&current->offset,
@@ -495,7 +495,7 @@ int build_channel_array(const char *device_dir,
 						       device_dir,
 						       current->name,
 						       current->generic_name);
-			if (ret < 0)
+			if ((ret < 0) && (ret != -ENOENT))
 				goto error_cleanup_array;
 
 			ret = iioutils_get_type(&current->is_signed,
-- 
1.9.1
