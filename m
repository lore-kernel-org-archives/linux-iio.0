Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:36392 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757531AbbE3IUX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2015 04:20:23 -0400
Received: by lagv1 with SMTP id v1so70673220lag.3
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2015 01:20:22 -0700 (PDT)
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: sudipm.mukherjee@gmail.com, jic23@kernel.org,
	daniel.baluta@intel.com, dan.carpenter@oracle.com,
	gregkh@linuxfoundation.org
Cc: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org, linux-iio@vger.kernel.org,
	Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Subject: [PATCH v3 1/3] staging: iio_simple_dummy: fix init function
Date: Sat, 30 May 2015 11:20:15 +0300
Message-Id: <1432974017-24547-2-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432974017-24547-1-git-send-email-rodriguez.twister@gmail.com>
References: <1432974017-24547-1-git-send-email-rodriguez.twister@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes the init function for the iio_simple_dummy driver.
The main issues were absence of kfree for the allocated array, and no
devices being removed in case the probe function fails, running in a loop.

Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
---
 drivers/staging/iio/iio_simple_dummy.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index b47bf9f..d0a9963 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -722,9 +722,16 @@ static __init int iio_dummy_init(void)
 	for (i = 0; i < instances; i++) {
 		ret = iio_dummy_probe(i);
 		if (ret < 0)
-			return ret;
+			goto error_remove_devs;
 	}
 	return 0;
+
+error_remove_devs:
+	while (i--)
+		iio_dummy_remove(i);
+
+	kfree(iio_dummy_devs);
+	return ret;
 }
 module_init(iio_dummy_init);
 
-- 
2.4.1

