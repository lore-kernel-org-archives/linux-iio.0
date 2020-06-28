Return-Path: <SRS0=lSA7=AJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F5AC433DF
	for <linux-iio@archiver.kernel.org>; Sun, 28 Jun 2020 12:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51816208B6
	for <linux-iio@archiver.kernel.org>; Sun, 28 Jun 2020 12:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593347970;
	bh=vwQW7FDmT1YTvO3DuZTf8cH5c6+6KYXMKhSmm5sMUAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Olsy7NKdp3lHNh7wzNE0th9annmQ2n9I3AYjxiwzMUgVkIjhwW9++gND84SHpIbNK
	 xcq3t1f+XM8WUs+Y8lCuBmE22gtuxUqtjGT6TYUWVk5TXtpA9ksRYsGVLi3ej+DaNZ
	 pV5d5WvmIwN2lwSTfGxELfDjpjjkHW8EmNaXCTw4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgF1Mj3 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 28 Jun 2020 08:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgF1Mj3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Jun 2020 08:39:29 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A9B320885;
        Sun, 28 Jun 2020 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593347969;
        bh=vwQW7FDmT1YTvO3DuZTf8cH5c6+6KYXMKhSmm5sMUAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtF5a68I7QIXvzz1z7EuGu08iW7wADFUt6ISUUj04GdgLp1qQ+iWulz8nNSdASXNJ
         6t8rXOEjqnTDBM5Yxi1R3M/5fPwLiSWo3XNHXEexG0Qr90Q10s5wXxI7oSlVX8IcR5
         JYV/oEwpYdYZAitUPKy9QtUyMQAA6riGmflCpO2A=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     alexandru.Ardelean@analog.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Phil Reid <preid@electromag.com.au>
Subject: [PATCH 21/23] iio:adc:ti-tlc4541: Drop CONFIG_OF and of_match_ptr protections.
Date:   Sun, 28 Jun 2020 13:36:52 +0100
Message-Id: <20200628123654.32830-22-jic23@kernel.org>
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

These stop us using ACPI PRP0001 to instantiate the device.
I am slowly clearly out use of these in IIO to avoid this being coppied
into new drivers.

Here I also included mod_devicetable.h as we are using of_match_id
which is defined in there and hence it is best practice to include
it directly.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/adc/ti-tlc4541.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-tlc4541.c b/drivers/iio/adc/ti-tlc4541.c
index 432238246519..53359a2e5bea 100644
--- a/drivers/iio/adc/ti-tlc4541.c
+++ b/drivers/iio/adc/ti-tlc4541.c
@@ -24,6 +24,7 @@
 #include <linux/iio/triggered_buffer.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/spi/spi.h>
@@ -235,14 +236,12 @@ static int tlc4541_remove(struct spi_device *spi)
 	return 0;
 }
 
-#ifdef CONFIG_OF
 static const struct of_device_id tlc4541_dt_ids[] = {
 	{ .compatible = "ti,tlc3541", },
 	{ .compatible = "ti,tlc4541", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, tlc4541_dt_ids);
-#endif
 
 static const struct spi_device_id tlc4541_id[] = {
 	{"tlc3541", TLC3541},
@@ -254,7 +253,7 @@ MODULE_DEVICE_TABLE(spi, tlc4541_id);
 static struct spi_driver tlc4541_driver = {
 	.driver = {
 		.name   = "tlc4541",
-		.of_match_table = of_match_ptr(tlc4541_dt_ids),
+		.of_match_table = tlc4541_dt_ids,
 	},
 	.probe          = tlc4541_probe,
 	.remove         = tlc4541_remove,
-- 
2.27.0

