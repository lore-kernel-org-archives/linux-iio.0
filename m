Return-Path: <SRS0=b3IJ=CT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3864CC433E2
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBE19206A1
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599759593;
	bh=SgAGLStXgQ7w2KnWMGzPUyRVQ4AEGbSy8kysWBWhcJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sTdYtmmtqXDLN+PrTZVH38zAvwLjrV3xOJQy/YfhFzQRvKaDDJWEqtkqS2qXsGdsY
	 GQerYpnn2H/czx7X3fVdB8CiLPgyPg2u0ddBJVwc9lZasdcz/mJJgAkq4RFzny1rlN
	 gSCZSGoJJ5rvRAKds8CX7bnoMDx6szszTnhduFvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIJRjr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgIJRhL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA8921D40;
        Thu, 10 Sep 2020 17:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759357;
        bh=SgAGLStXgQ7w2KnWMGzPUyRVQ4AEGbSy8kysWBWhcJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k/BP6CCPPFG+dhwkfNZbRoHkLpcp/X1bgo+IhSygxd/TuSTvBrVobBAADk0PsCWW2
         BZ0N0wFDGzalfLzVSX1jwXIkadDtfDe79w1yHQT1abB9jvqVzeaC2TOLwku50PMECY
         crAHsg3IDAXx8L3qkqVqOfw2EAt1Woyh2AzJBpsk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 33/38] iio:proximity:pulsedlight: Drop of_match_ptr protection
Date:   Thu, 10 Sep 2020 18:32:37 +0100
Message-Id: <20200910173242.621168-34-jic23@kernel.org>
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

This prevents use of this driver with ACPI via PRP0001 and is
an example of an anti pattern I'm trying to remove from IIO.
Hence drop from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index a8e716dbd24e..c685f10b5ae4 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -13,6 +13,7 @@
 #include <linux/i2c.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/pm_runtime.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -360,7 +361,7 @@ static const struct dev_pm_ops lidar_pm_ops = {
 static struct i2c_driver lidar_driver = {
 	.driver = {
 		.name	= LIDAR_DRV_NAME,
-		.of_match_table	= of_match_ptr(lidar_dt_ids),
+		.of_match_table	= lidar_dt_ids,
 		.pm	= &lidar_pm_ops,
 	},
 	.probe		= lidar_probe,
-- 
2.28.0

