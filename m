Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38898 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758581AbbJ3NLJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Oct 2015 09:11:09 -0400
Received: by wicll6 with SMTP id ll6so10344138wic.1
        for <linux-iio@vger.kernel.org>; Fri, 30 Oct 2015 06:11:08 -0700 (PDT)
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: linux-iio@vger.kernel.org
Cc: mranostay@gmail.com, Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH] tools: iio: avoid returning error when channel does not have an offset
Date: Fri, 30 Oct 2015 15:11:01 +0200
Message-Id: <1446210662-10370-1-git-send-email-ciorneiioana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch avoids getting an error and aborting when a channel does not have a
specific parameter like 'offset' and the file associated with it is not present.
When none of the files from the device folder does not matches the desired channel's
param function iioutils_get_param_float should return 0.

This change is safe previous to calling the function the parameters are set to
their defaults, 0 in case of 'offset'

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
not tested

 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 5eb6793..cbaf696 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -241,7 +241,7 @@ int iioutils_get_param_float(float *output, const char *param_name,
 		goto error_free_builtname_generic;
 	}
 
-	ret = -ENOENT;
+	ret = 0;
 	while (ent = readdir(dp), ent)
 		if ((strcmp(builtname, ent->d_name) == 0) ||
 		    (strcmp(builtname_generic, ent->d_name) == 0)) {
-- 
2.1.4

