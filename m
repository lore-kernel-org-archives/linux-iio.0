Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36621 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753881AbbG0OIf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 10:08:35 -0400
Received: by pachj5 with SMTP id hj5so52168287pac.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 07:08:34 -0700 (PDT)
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH] tools: iio: calc_digits is static
Date: Tue, 28 Jul 2015 00:08:19 +1000
Message-Id: <1438006099-3906-1-git-send-email-jasaw@dius.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Joo Aun Saw <jasaw@dius.com.au>

calc_digits is static, make it so.

Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
---
 tools/iio/iio_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index e9fbaf8..563d9f0 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -537,7 +537,7 @@ error_free_name:
 	return ret;
 }
 
-int calc_digits(int num)
+static int calc_digits(int num)
 {
 	int count = 0;
 
-- 
1.9.1

