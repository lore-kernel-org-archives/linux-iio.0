Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:33631 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512AbbG1BqY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jul 2015 21:46:24 -0400
Received: by pdbnt7 with SMTP id nt7so61244981pdb.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2015 18:46:24 -0700 (PDT)
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH v2] tools: iio: iio_utils: Make calc_digits static
Date: Tue, 28 Jul 2015 11:46:13 +1000
Message-Id: <1438047973-5635-1-git-send-email-jasaw@dius.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Joo Aun Saw <jasaw@dius.com.au>

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

