Return-Path: <SRS0=b3IJ=CT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DF9C433E2
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:40:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DB2206A1
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599759619;
	bh=GxZXgF6f/3dyZnrz6XrKc4XzhvZ3y+tvtUmumqeMtDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=puzmeFl56vdvUVos60Agbm+64Bh+CJfyUU4hSJMTjSN3dt4dTz/Bx4fWtblL4v3Jx
	 gm/OXY5thEhhbHuhk3whzdTFmtsrG0Gt6U4VoYkU2y0WusAdiU3ion87pLRlHjUoRZ
	 L0AkkDJWxFcmjdEoVR4ZEO93AEe8JMohw45UPs7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgIJRkO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:40:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726612AbgIJRf2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:28 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBF121D81;
        Thu, 10 Sep 2020 17:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759316;
        bh=GxZXgF6f/3dyZnrz6XrKc4XzhvZ3y+tvtUmumqeMtDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9i4d4Pr33GCdHgaZApLs8ovxNptKI4GN59SEoSzLP4nFlYJ59C7UVm0BZsTh/11p
         Yl/+1cDGLEN4h3VehYbCfjGACt+wcIj+XmRBvDIxBJF1vm1awVLNGpsb9587RFgSA0
         +o9oTWZ6nTphPn5AoCVW7UXtXVsFsl9n8Vg0rvUE=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 03/38] iio:potentiometer:max5432: Drop of_match_ptr and use generic fw accessors
Date:   Thu, 10 Sep 2020 18:32:07 +0100
Message-Id: <20200910173242.621168-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910173242.621168-1-jic23@kernel.org>
References: <20200910173242.621168-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These prevent use of this driver with ACPI via PRP0001 and are
an example of an anti pattern I'm trying to remove from IIO.
Drop them to remove this restriction.

Also switch headers to reflect this change.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Martin Kaiser <martin@kaiser.cx>
---
 drivers/iio/potentiometer/max5432.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/potentiometer/max5432.c b/drivers/iio/potentiometer/max5432.c
index 280de9c54471..aed3b6ab82a2 100644
--- a/drivers/iio/potentiometer/max5432.c
+++ b/drivers/iio/potentiometer/max5432.c
@@ -11,8 +11,8 @@
 #include <linux/iio/iio.h>
 #include <linux/limits.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
 
 /* All chip variants have 32 wiper positions. */
 #define MAX5432_MAX_POS 31
@@ -100,7 +100,7 @@ static int max5432_probe(struct i2c_client *client,
 
 	data = iio_priv(indio_dev);
 	data->client = client;
-	data->ohm = (unsigned long)of_device_get_match_data(dev);
+	data->ohm = (unsigned long)device_get_match_data(dev);
 
 	indio_dev->info = &max5432_info;
 	indio_dev->channels = max5432_channels;
@@ -122,7 +122,7 @@ MODULE_DEVICE_TABLE(of, max5432_dt_ids);
 static struct i2c_driver max5432_driver = {
 	.driver = {
 		.name = "max5432",
-		.of_match_table = of_match_ptr(max5432_dt_ids),
+		.of_match_table = max5432_dt_ids,
 	},
 	.probe = max5432_probe,
 };
-- 
2.28.0

