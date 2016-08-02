Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36368 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934169AbcHBMVE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Aug 2016 08:21:04 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so12399295pfg.3
        for <linux-iio@vger.kernel.org>; Tue, 02 Aug 2016 05:21:02 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] tools: iio: lsiio: enumerate processed channels
Date: Mon,  1 Aug 2016 19:39:51 -0700
Message-Id: <1470105591-1006-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Enumerate the processed channels (e.g. *_input) as well the raw channels.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 tools/iio/lsiio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index 3d650e668252..ab0f5cf16025 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -51,7 +51,8 @@ static int dump_channels(const char *dev_dir_name)
 
 	while (ent = readdir(dp), ent)
 		if (check_prefix(ent->d_name, "in_") &&
-		    check_postfix(ent->d_name, "_raw"))
+		   (check_postfix(ent->d_name, "_raw") ||
+		    check_postfix(ent->d_name, "_input")))
 			printf("   %-10s\n", ent->d_name);
 
 	return (closedir(dp) == -1) ? -errno : 0;
-- 
2.7.4

