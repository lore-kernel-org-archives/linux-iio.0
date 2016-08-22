Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33475 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756291AbcHVWTm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Aug 2016 18:19:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so7043627pfe.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Aug 2016 15:19:41 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v2] iio: iio-utils: use channel modifier scaling if it exists
Date: Mon, 22 Aug 2016 15:19:37 -0700
Message-Id: <1471904377-11228-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now there are channel modifiers with their own scaling those should be
used when possible over the generic channel type scaling.

Examples are of IIO_TEMP channel having a generic scaling value, and
another having IIO_MOD_TEMP_AMBIENT modifier with another scaling value.

Previously the first scaling value for a channel type would be applied
to all channels of like type in iio_generic_buffer

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---

Changes from v1:

* make commit message more verbose

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

