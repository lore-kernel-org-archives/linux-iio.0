Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33981 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756927AbcCXIjW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Mar 2016 04:39:22 -0400
Received: by mail-lf0-f54.google.com with SMTP id c62so25946676lfc.1
        for <linux-iio@vger.kernel.org>; Thu, 24 Mar 2016 01:39:21 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: tools: make generic_buffer look for "-trigger"
Date: Thu, 24 Mar 2016 09:39:14 +0100
Message-Id: <1458808754-31088-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

All the ST Sensors use the old "<foo>-trigger" rather than the
standard "<foo>-devN" new standard suffix for triggers. Now much
to do about it since it is ABI, but make the testing tools
recognize it too.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 tools/iio/generic_buffer.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 01c4f67801e0..c42b7f836b48 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -304,7 +304,19 @@ int main(int argc, char **argv)
 			}
 		}
 
-		/* Verify the trigger exists */
+		/* Look for this "-devN" trigger */
+		trig_num = find_type_by_name(trigger_name, "trigger");
+		if (trig_num < 0) {
+			/* OK try the simpler "-trigger" suffix instead */
+			free(trigger_name);
+			ret = asprintf(&trigger_name,
+				       "%s-trigger", device_name);
+			if (ret < 0) {
+				ret = -ENOMEM;
+				goto error_free_dev_dir_name;
+			}
+		}
+
 		trig_num = find_type_by_name(trigger_name, "trigger");
 		if (trig_num < 0) {
 			fprintf(stderr, "Failed to find the trigger %s\n",
-- 
2.4.3

