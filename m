Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:34626 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbG1PMg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2015 11:12:36 -0400
Received: by pdbbh15 with SMTP id bh15so72314533pdb.1
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2015 08:12:35 -0700 (PDT)
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH v3] tools: iio: iio_utils: remove unnecessary define guard
Date: Wed, 29 Jul 2015 01:12:24 +1000
Message-Id: <1438096344-7448-1-git-send-email-jasaw@dius.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Joo Aun Saw <jasaw@dius.com.au>

Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
---
 tools/iio/iio_utils.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 1dcdf03..86e15c7 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -6,9 +6,6 @@
  * under the terms of the GNU General Public License version 2 as published by
  * the Free Software Foundation.
  */
-#ifndef _IIO_UTILS_H
-#define _IIO_UTILS_H
-
 #include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
@@ -990,5 +987,3 @@ error_free:
 
 	return ret;
 }
-
-#endif /* _IIO_UTILS_H */
-- 
1.9.1

