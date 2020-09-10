Return-Path: <SRS0=b3IJ=CT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC15C433E2
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:37:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC41221E3
	for <linux-iio@archiver.kernel.org>; Thu, 10 Sep 2020 17:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599759430;
	bh=MhAGlqNSuC/0Tfio5H1H+dnSh4Jr34KByms28bDFvHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NrkegUAPEwFTftGVo3P16cCqR4TSreFHeP5EgkV91hs2fOE1oyas+GuBK5ElhT4hs
	 PaK4xigL6c/e0Txq7rjtx6ZA8zj7vt1Ml30Clll4NrTMfkOOQYYmidygmve+cmCUTU
	 TOIirNfxU+++T5G/NB03sAy2YQEyrejgOgqFxaCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgIJRhD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 10 Sep 2020 13:37:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgIJRgA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Sep 2020 13:36:00 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC7A8221E5;
        Thu, 10 Sep 2020 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599759324;
        bh=MhAGlqNSuC/0Tfio5H1H+dnSh4Jr34KByms28bDFvHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMDkqL5kTds1YDkaXt4KocfLKid7MYgejane4A4b2pOfnPYfSqiOHTww0oOkm3leQ
         JSLvnYpXVl3x1OysqOOkuPR8RS7Ss7wVXPPZovm4DiD3Z+FB52Cj48OnY3l5AaIlNx
         KG/97cRCesdJDdUB8jhrSXj5+3Avht2kKJHxGzW4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 09/38] iio:dac:ad5446: Drop of_match_ptr and CONFIG_OF protections
Date:   Thu, 10 Sep 2020 18:32:13 +0100
Message-Id: <20200910173242.621168-10-jic23@kernel.org>
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
Hence drop them from this driver.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/dac/ad5446.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
index 935a6177569f..d87e21016863 100644
--- a/drivers/iio/dac/ad5446.c
+++ b/drivers/iio/dac/ad5446.c
@@ -17,6 +17,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/err.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -478,13 +479,11 @@ static const struct spi_device_id ad5446_spi_ids[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5446_spi_ids);
 
-#ifdef CONFIG_OF
 static const struct of_device_id ad5446_of_ids[] = {
 	{ .compatible = "ti,dac7512" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad5446_of_ids);
-#endif
 
 static int ad5446_spi_probe(struct spi_device *spi)
 {
@@ -502,7 +501,7 @@ static int ad5446_spi_remove(struct spi_device *spi)
 static struct spi_driver ad5446_spi_driver = {
 	.driver = {
 		.name	= "ad5446",
-		.of_match_table = of_match_ptr(ad5446_of_ids),
+		.of_match_table = ad5446_of_ids,
 	},
 	.probe		= ad5446_spi_probe,
 	.remove		= ad5446_spi_remove,
-- 
2.28.0

