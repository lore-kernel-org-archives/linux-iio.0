Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34135 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbbHDOV4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 10:21:56 -0400
Received: by labow3 with SMTP id ow3so8417385lab.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2015 07:21:54 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: [PATCH] iio: lsiio: fix error code handling error
Date: Tue,  4 Aug 2015 16:21:49 +0200
Message-Id: <1438698109-12356-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

commit acf50b3586f8d8a7530b905e111dda41876d38f4
"tools:iio:lsiio: add error handling"
introduced error handling of errors returned from
read_sysfs_string(), but with a simple if (retval),
missing the fact that these functions return a positive
value if the read was successful.

As a result lsiio regresses and does not show any
devices on my filesystem. Fix this by checking for
only negative error codes.

Cc: Hartmut Knaack <knaack.h@gmx.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/iio/lsiio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index b59ee1733924..b2c028cc7cac 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -70,7 +70,7 @@ static int dump_one_device(const char *dev_dir_name)
 	if (retval != 1)
 		return -EINVAL;
 	retval = read_sysfs_string("name", dev_dir_name, name);
-	if (retval)
+	if (retval < 0)
 		return retval;
 
 	printf("Device %03d: %s\n", dev_idx, name);
@@ -91,7 +91,7 @@ static int dump_one_trigger(const char *dev_dir_name)
 	if (retval != 1)
 		return -EINVAL;
 	retval = read_sysfs_string("name", dev_dir_name, name);
-	if (retval)
+	if (retval < 0)
 		return retval;
 
 	printf("Trigger %03d: %s\n", dev_idx, name);
-- 
2.4.3

