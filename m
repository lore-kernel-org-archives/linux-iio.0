Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35875 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbbGXPXq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 24 Jul 2015 11:23:46 -0400
Received: by pdjr16 with SMTP id r16so15345000pdj.3
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2015 08:23:46 -0700 (PDT)
From: Joo Aun Saw <jasaw@dius.com.au>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Joo Aun Saw <jasaw@dius.com.au>
Subject: [PATCH 1/2] tools: iio: Set caller's ci_array pointer to NULL after free
Date: Sat, 25 Jul 2015 01:23:28 +1000
Message-Id: <1437751409-28837-2-git-send-email-jasaw@dius.com.au>
In-Reply-To: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
References: <1437751409-28837-1-git-send-email-jasaw@dius.com.au>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Joo Aun Saw <jasaw@dius.com.au>

On error, caller's ci_array is freed and set to NULL to avoid
potential double free. Counter is reset to zero for consistency.

Signed-off-by: Joo Aun Saw <jasaw@dius.com.au>
---
 tools/iio/iio_utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 1dcdf03..8731905 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -529,6 +529,8 @@ error_cleanup_array:
 		free((*ci_array)[i].generic_name);
 	}
 	free(*ci_array);
+	*ci_array = NULL;
+	*counter = 0;
 error_close_dir:
 	if (dp)
 		if (closedir(dp) == -1)
-- 
1.9.1

