Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35548 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbbG1Blp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 21:41:45 -0400
Received: by pabkd10 with SMTP id kd10so60818250pab.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 18:41:44 -0700 (PDT)
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH v2] tools: iio: iio_utils: remove unnecessary define guard
Date: Tue, 28 Jul 2015 11:41:35 +1000
Message-Id: <1438047695-5248-1-git-send-email-jasaw@dius.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Joo Aun Saw <jasaw@dius.com.au>

Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
---
 tools/iio/iio_utils.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 1dcdf03..e9fbaf8 100644
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
@@ -991,4 +988,3 @@ error_free:
 	return ret;
 }
 
-#endif /* _IIO_UTILS_H */
-- 
1.9.1

