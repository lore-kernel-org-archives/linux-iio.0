Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34542 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718AbbHGJha (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Aug 2015 05:37:30 -0400
Received: by lbbtg9 with SMTP id tg9so19772081lbb.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2015 02:37:29 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: generic_buffer: be helpful about enabling channels
Date: Fri,  7 Aug 2015 11:37:25 +0200
Message-Id: <1438940245-18998-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently if generic_buffer is invoked without first enabling any
channels in scan_elements/*_en, it will fail unable to enable the
buffer because bytes_per_datum inside the kernel will be zero if
no channels are available.

It is implied that the user of the program should enable channels
manually or with a script before executing generic_buffer.

Be more helpful by stopping execution if no enabled channels can
be found, and print a helptext that will tell you what is wrong
and what needs to be done.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/iio/generic_buffer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 4eebb6616e5c..10a74ca6818b 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -299,6 +299,13 @@ int main(int argc, char **argv)
 		printf("diag %s\n", dev_dir_name);
 		goto error_free_triggername;
 	}
+	if (!num_channels) {
+		printf("No channels are enabled, we have nothing to scan.\n");
+		printf("Enable channels manually in " FORMAT_SCAN_ELEMENTS_DIR
+		       "/*_en and try again.\n", dev_dir_name);
+		ret = -ENOENT;
+		goto error_free_triggername;
+	}
 
 	/*
 	 * Construct the directory name for the associated buffer.
-- 
2.4.3

