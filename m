Return-Path: <SRS0=b3IJ=CT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AD7C43461
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802A821D40
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599759613;
	bh=bNmhDRiZo3c3p++zFV+W+5Voj9Iev+vd6lt+Nd7U4hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TjsImStu4DmM2fQIJvZ8wXzWxSVZdzmE9sHOKmyc14+8bYAXy392273Y45XDcYgf8
	 zBUA38dMIKO+39QPEdvfyNtwZ4pxhXHgz4XzLhxvp8MzK9aPpSiN0rrWJtaQH4jYSL
	 KopzkBEw9ChBWBUZ56UyL9op5vzd2Lb7M9RvG0Cs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgIJRkM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:40:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgIJRfs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:35:48 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B81221D92;
        Thu, 10 Sep 2020 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759319;
        bh=bNmhDRiZo3c3p++zFV+W+5Voj9Iev+vd6lt+Nd7U4hc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bvu2moA8fF2HVqw4mz45yQmF0LgnddR7/DyCGqiLGiycrQrx194NnZUywaPqgYerk
         W3A65sQEhD0pMXZZ2umgownvGalhzQxtfggySyO60f7JZXhXVb4SIiHSGQ/0P746bD
         DCBjKBOFGqzaX6fTzbwrNoySGONdPEnTjZNFoZdI=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maury Anderson <maury.anderson@rockwellcollins.com>,
        Matthew Weber <matthew.weber@rockwellcollins.com>,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 05/38] iio:potentiometer:max5481: Drop invalid ACPI binding.
Date:   Thu, 10 Sep 2020 18:32:09 +0100
Message-Id: <20200910173242.621168-6-jic23@kernel.org>
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

Given that an ACPI binding must start with 3 or 4 capitals,
this cannot represent a valid binding.

It seems unlikely anything out there is using it.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Maury Anderson <maury.anderson@rockwellcollins.com>
Cc: Matthew Weber <matthew.weber@rockwellcollins.com>
Cc: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/potentiometer/max5481.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/iio/potentiometer/max5481.c b/drivers/iio/potentiometer/max5481.c
index 6d1e1a57cba1..a88ed0eb3adc 100644
--- a/drivers/iio/potentiometer/max5481.c
+++ b/drivers/iio/potentiometer/max5481.c
@@ -7,7 +7,6 @@
  * https://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
  */
 
-#include <linux/acpi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/module.h>
@@ -182,22 +181,10 @@ static const struct spi_device_id max5481_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, max5481_id_table);
 
-#if defined(CONFIG_ACPI)
-static const struct acpi_device_id max5481_acpi_match[] = {
-	{ "max5481", max5481 },
-	{ "max5482", max5482 },
-	{ "max5483", max5483 },
-	{ "max5484", max5484 },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, max5481_acpi_match);
-#endif
-
 static struct spi_driver max5481_driver = {
 	.driver = {
 		.name  = "max5481",
 		.of_match_table = max5481_match,
-		.acpi_match_table = ACPI_PTR(max5481_acpi_match),
 	},
 	.probe = max5481_probe,
 	.remove = max5481_remove,
-- 
2.28.0

