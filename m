Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33746 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbbG0Nyw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 09:54:52 -0400
Received: by padck2 with SMTP id ck2so52102969pad.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 06:54:51 -0700 (PDT)
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH] tools: iio: remove unnecessary define guard from iio_utils.c
Date: Mon, 27 Jul 2015 23:54:38 +1000
Message-Id: <1438005278-3439-1-git-send-email-jasaw@dius.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Joo Aun Saw <jasaw@dius.com.au>

_IIO_UTILS_H_ define guard is unnecessary in iio_utils.c

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

