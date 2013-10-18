Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46731 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab3JRMF4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 18 Oct 2013 08:05:56 -0400
Received: by mail-pa0-f42.google.com with SMTP id kx10so4481121pab.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Oct 2013 05:05:55 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 4/4] iio: light: gp2ap020a00f: Include linux/of.h header
Date: Fri, 18 Oct 2013 17:34:57 +0530
Message-Id: <1382097897-12818-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
References: <1382097897-12818-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'of_match_ptr' is defined in linux/of.h. Include it explicitly to
avoid build breakage in the future.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/light/gp2ap020a00f.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index b1e4615..478eae1 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -42,6 +42,7 @@
 #include <linux/irq_work.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-- 
1.7.9.5

