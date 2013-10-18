Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36807 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab3JRMFt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2013 08:05:49 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so4569320pdi.33
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2013 05:05:49 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 1/4] iio: adc: mcp3422: Include linux/of.h header
Date: Fri, 18 Oct 2013 17:34:54 +0530
Message-Id: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly to
avoid build breakage in the future.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/adc/mcp3422.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index bc93f53..1294832 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/delay.h>
 #include <linux/sysfs.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
1.7.9.5

