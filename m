Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36533 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751281AbcGaFLt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 31 Jul 2016 01:11:49 -0400
Received: by mail-pa0-f66.google.com with SMTP id ez1so7606643pab.3
        for <linux-iio@vger.kernel.org>; Sat, 30 Jul 2016 22:11:49 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Matt Ranostay <mranostay@gmail.com>, Marek Vasut <marex@denx.de>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: iio-utils: use channel modifier scaling if it exists
Date: Sat, 30 Jul 2016 22:11:45 -0700
Message-Id: <1469941905-2600-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now there are channel modifiers with their own scaling those should be
used when possible over the generic channel type scaling.

Cc: Marek Vasut <marex@denx.de>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 tools/iio/iio_utils.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 5eb6793f3972..7a6d61c6c012 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -121,10 +121,6 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 
 	ret = -ENOENT;
 	while (ent = readdir(dp), ent)
-		/*
-		 * Do we allow devices to override a generic name with
-		 * a specific one?
-		 */
 		if ((strcmp(builtname, ent->d_name) == 0) ||
 		    (strcmp(builtname_generic, ent->d_name) == 0)) {
 			ret = asprintf(&filename,
@@ -178,6 +174,13 @@ int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
 			sysfsfp = 0;
 			free(filename);
 			filename = 0;
+
+			/*
+			 * Avoid having a more generic entry overwriting
+			 * the settings.
+			 */
+			if (strcmp(builtname, ent->d_name) == 0)
+				break;
 		}
 
 error_close_sysfsfp:
-- 
2.7.4

