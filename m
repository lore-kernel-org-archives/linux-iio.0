Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: iio_utils: accept channels with no offset
Date: Fri,  7 Aug 2015 11:21:56 +0200
Message-Id: <1438939316-1809-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

The function build_channel_array() will currently bail out
if the IIO device does not have a *_offset sysfs file. However
this offset is not compulsory, see
Documentation/ABI/testing/sysfs-bus-iio, and the ST sensors
does not provide an offset so the functions fail with these
sensors.

Fix this by alloing the offset check to return -ENOENT and if
it does, assume the offset is zero as per the ABI.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/iio/iio_utils.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index ec9ab7f9ae4c..9ea4b7c79558 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -479,7 +479,10 @@ int build_channel_array(const char *device_dir,
 						       device_dir,
 						       current->name,
 						       current->generic_name);
-			if (ret < 0)
+			if (ret == -ENOENT) {
+				/* Assume zero offset if not present */
+				current->offset = 0.0;
+			} else if (ret < 0)
 				goto error_cleanup_array;
 			ret = iioutils_get_type(&current->is_signed,
 						&current->bytes,
-- 
2.4.3
