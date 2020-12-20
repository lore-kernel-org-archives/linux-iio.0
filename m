Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B1DC4361B
	for <linux-iio@archiver.kernel.org>; Sun, 20 Dec 2020 01:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E4123AC0
	for <linux-iio@archiver.kernel.org>; Sun, 20 Dec 2020 01:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgLTBwM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 19 Dec 2020 20:52:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726660AbgLTBwM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Dec 2020 20:52:12 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F2CC0613CF;
        Sat, 19 Dec 2020 17:51:27 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id x12so3618473plr.10;
        Sat, 19 Dec 2020 17:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMEfLBWoIp7OwRZhC3MXdh4+fV0q2Jqz8suvTSU9g7Q=;
        b=in3HcGYjy8UKlzXf+PLrKZwg+zQVtsDfmeFRTANZbhvEJy+G5o29W+yed0e3rEhyJQ
         rMT3g8hNY6/iGm/VhrLYKVyXGWTRDdS0kDYY1ykPdk+woOFaazRpiFXLgHx9OWJlaINO
         W0U4Z/GOOB2UoEd8e+6ppNGMs2U7xZIzmuY6WF0dVm0kfbDCjmzyEytDy8OPRFW/Rv39
         eMGLag6xd1bxwdUxDMejl0/xj7BJ//JMB1nBhVYJvg5KUxr5Em4OaBbkRnnVvyScRtI8
         GAo/07/ZJ3avs5Z5YZ97HQB48inRUctOgmQDi4x2RMJURNfSd7QLEcfWMDmHIR5h3sTW
         jxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hMEfLBWoIp7OwRZhC3MXdh4+fV0q2Jqz8suvTSU9g7Q=;
        b=hdm0mGaWWWV7mESuwreibCmpCL8zDLr5xHE+D4mFFCZxTQCQk8P71MgT9le3n5X/UT
         dyB2R4vIy4i1yk2J2bNsyd0n9yx+QIYRrCkPG2e9NOe2nqj0s69vo6n8QjZQJ6qIiaXr
         y4MUjIrJ3nOArkof9gdrW9kbJztri2YKqNtSBFslOVxkvkIzfGqVA4hXOErhPL1uxo78
         tKhY03yHJvtrtWa6H6zYjFb6mbkjJQtRKFOLzsBqQiGHkcr93G4TzeP/TNZtoThPjZt/
         43kPp6rQTPgBWVz3cGCzhuefoL9YWuBemqfoRcLI2OXKWrXy+LYW9xafHbFR3qYsuekk
         Wq/w==
X-Gm-Message-State: AOAM531Z9zIkxFfhsBPJj92VRLigTS2o4YH4+by8e9WZhEmmx176E2f1
        Ux2Bmp56+xSHgRehTd0b8dccPIAr6SoLFQp4
X-Google-Smtp-Source: ABdhPJz8YzwHPjAPP3NjeGZO/cc0UDuyz73QK4rLo10pHU4W61/9rJBY4Db5S8tv/22fwGhuS60tfw==
X-Received: by 2002:a17:90a:394f:: with SMTP id n15mr11312605pjf.121.1608429087231;
        Sat, 19 Dec 2020 17:51:27 -0800 (PST)
Received: from max-surface.hsd1.ca.comcast.net ([2601:647:5680:1d90:ed06:7751:4b34:9d75])
        by smtp.gmail.com with ESMTPSA id js9sm12368718pjb.2.2020.12.19.17.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 17:51:26 -0800 (PST)
From:   Max Leiter <maxwell.leiter@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     blaz@mxxn.io, matt.ranostay@konsulko.com,
        Max Leiter <maxwell.leiter@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio:light:apds9960 add detection for MSHW0184 ACPI device in apds9960 driver
Date:   Sat, 19 Dec 2020 17:50:55 -0800
Message-Id: <20201220015057.107246-1-maxwell.leiter@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The device is used in the Microsoft Surface Book 3 and Surface Pro 7

Signed-off-by: Max Leiter <maxwell.leiter@gmail.com>
---
 drivers/iio/light/apds9960.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index 9afb3fcc74e6..20719141c03a 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -8,6 +8,7 @@
  * TODO: gesture + proximity calib offsets
  */
 
+#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -1113,6 +1114,12 @@ static const struct i2c_device_id apds9960_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, apds9960_id);
 
+static const struct acpi_device_id apds9960_acpi_match[] = {
+	{ "MSHW0184" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, apds9960_acpi_match);
+
 static const struct of_device_id apds9960_of_match[] = {
 	{ .compatible = "avago,apds9960" },
 	{ }
@@ -1124,6 +1131,7 @@ static struct i2c_driver apds9960_driver = {
 		.name	= APDS9960_DRV_NAME,
 		.of_match_table = apds9960_of_match,
 		.pm	= &apds9960_pm_ops,
+		.acpi_match_table = apds9960_acpi_match,
 	},
 	.probe		= apds9960_probe,
 	.remove		= apds9960_remove,
-- 
2.29.2

