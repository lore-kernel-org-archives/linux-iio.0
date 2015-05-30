Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:34540 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757571AbbE3IU2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 May 2015 04:20:28 -0400
Received: by laat2 with SMTP id t2so70659590laa.1
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2015 01:20:26 -0700 (PDT)
From: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
To: sudipm.mukherjee@gmail.com, jic23@kernel.org,
	daniel.baluta@intel.com, dan.carpenter@oracle.com,
	gregkh@linuxfoundation.org
Cc: cristina.opriceana@gmail.com,
	driverdev-devel@linuxdriverproject.org, linux-iio@vger.kernel.org,
	Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Subject: [PATCH v3 3/3] staging: iio_simple_dummy: fix module_param type
Date: Sat, 30 May 2015 11:20:17 +0300
Message-Id: <1432974017-24547-4-git-send-email-rodriguez.twister@gmail.com>
In-Reply-To: <1432974017-24547-1-git-send-email-rodriguez.twister@gmail.com>
References: <1432974017-24547-1-git-send-email-rodriguez.twister@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the module_param "instances" type to uint, since the variable type
holding the value is unsigned.

Signed-off-by: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
---
 drivers/staging/iio/iio_simple_dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index dc9482c7..1629a8a 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -30,7 +30,7 @@
  * dummy devices are registered.
  */
 static unsigned instances = 1;
-module_param(instances, int, 0);
+module_param(instances, uint, 0);
 
 /* Pointer array used to fake bus elements */
 static struct iio_dev **iio_dummy_devs;
-- 
2.4.1

