Return-Path: <toralf.foerster@gmx.de>
From: =?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	=?UTF-8?q?Toralf=20F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: [PATCH] fix format string msimatch in staging/iio/Documentation/iio_utils.h
Date: Sat, 24 May 2014 15:25:51 +0200
Message-Id: <1400937951-31693-1-git-send-email-toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

spotted by cppcheck

Signed-off-by: Toralf Förster <toralf.foerster@gmx.de>
---
 drivers/staging/iio/Documentation/iio_utils.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 2064839..a9cfc06 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -318,7 +318,7 @@ inline int build_channel_array(const char *device_dir,
 				free(filename);
 				goto error_close_dir;
 			}
-			fscanf(sysfsfp, "%u", &ret);
+			fscanf(sysfsfp, "%i", &ret);
 			if (ret == 1)
 				(*counter)++;
 			fclose(sysfsfp);
@@ -350,7 +350,7 @@ inline int build_channel_array(const char *device_dir,
 				ret = -errno;
 				goto error_cleanup_array;
 			}
-			fscanf(sysfsfp, "%u", &current_enabled);
+			fscanf(sysfsfp, "%i", &current_enabled);
 			fclose(sysfsfp);
 
 			if (!current_enabled) {
-- 
1.9.3
