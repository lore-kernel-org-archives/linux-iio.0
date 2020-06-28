Return-Path: <SRS0=lSA7=AJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37553C433DF
	for <linux-iio@archiver.kernel.org>; Sun, 28 Jun 2020 12:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1144D20738
	for <linux-iio@archiver.kernel.org>; Sun, 28 Jun 2020 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593347964;
	bh=q1EvbuzQoy5OKP0mE0v4r5NANIrUtq18Zv+nJ4pvmTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ax7nB5ODD+4pWYYl8Cfnb7cHGNWkCpEeY8LC4Qwc5UbJQgq4b+O8WN/S9FJxqaPTq
	 WIiXwK3zfFg5OLO3mnvPYlzBYFULrXEBIB9tR7eopHz6VEeTzc3q96IjJyVZFrr271
	 KOkjt1CNCtYYYKMw+3r6vuQMROKd1ShntHi1Sid8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgF1MjX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 28 Jun 2020 08:39:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbgF1MjW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:22 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6ECE52076E;
        Sun, 28 Jun 2020 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347962;
        bh=q1EvbuzQoy5OKP0mE0v4r5NANIrUtq18Zv+nJ4pvmTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvyX8YZqz+PXYbkHVGiFvfzEjRcVwdzoszKooBVMbnXonjbtNMyC4yfvkM7/b8iGZ
         nyGQBGu2wbzIkcAuh+NV3Bna1zd4nENSDwNl//kv6CyCuHbLAXgPbtbQNAL1FTYRoe
         Rk1o+ujc1UKPgCBXViHAiWOTN7+vi6sxvFUAzsi4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 16/23] iio:adc:ti-adc0832: drop CONFIG_OF and of_match_ptr protections
Date:   Sun, 28 Jun 2020 13:36:47 +0100
Message-Id: <20200628123654.32830-17-jic23@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200628123654.32830-1-jic23@kernel.org>
References: <20200628123654.32830-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These just prevent the driver being used with ACPI PRP0001.

I am also trying to remove these from IIO in general to avoid
them being coppied into new drivers.

Also include the mod_devicetable.h header as we are using
of_device_id which is defined in there.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/adc/ti-adc0832.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
index 3eb3ba5fb610..05061dc05b32 100644
--- a/drivers/iio/adc/ti-adc0832.c
+++ b/drivers/iio/adc/ti-adc0832.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/regulator/consumer.h>
@@ -313,8 +314,6 @@ static int adc0832_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_OF
-
 static const struct of_device_id adc0832_dt_ids[] = {
 	{ .compatible = "ti,adc0831", },
 	{ .compatible = "ti,adc0832", },
@@ -324,8 +323,6 @@ static const struct of_device_id adc0832_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, adc0832_dt_ids);
 
-#endif
-
 static const struct spi_device_id adc0832_id[] = {
 	{ "adc0831", adc0831 },
 	{ "adc0832", adc0832 },
@@ -338,7 +335,7 @@ MODULE_DEVICE_TABLE(spi, adc0832_id);
 static struct spi_driver adc0832_driver = {
 	.driver = {
 		.name = "adc0832",
-		.of_match_table = of_match_ptr(adc0832_dt_ids),
+		.of_match_table = adc0832_dt_ids,
 	},
 	.probe = adc0832_probe,
 	.remove = adc0832_remove,
-- 
2.27.0

