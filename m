Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33042 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbcHSUqa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Aug 2016 16:46:30 -0400
Received: by mail-pf0-f195.google.com with SMTP id i6so1951581pfe.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Aug 2016 13:44:56 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH RESEND] iio: iio-utils: use channel modifier scaling if it exists
Date: Fri, 19 Aug 2016 13:44:52 -0700
Message-Id: <1471639492-23531-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Now there are channel modifiers with their own scaling those should be
used when possible over the generic channel type scaling.

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

