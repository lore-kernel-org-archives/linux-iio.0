Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7044AC433FE
	for <linux-iio@archiver.kernel.org>; Wed, 16 Nov 2022 11:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbiKPLOa (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 16 Nov 2022 06:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbiKPLOJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Nov 2022 06:14:09 -0500
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5358BDC;
        Wed, 16 Nov 2022 03:01:40 -0800 (PST)
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id BA7DB5F84B;
        Wed, 16 Nov 2022 11:45:17 +0100 (CET)
From:   Edmund Berenson <edmund.berenson@emlix.com>
Cc:     Edmund Berenson <edmund.berenson@emlix.com>,
        Lukasz Zemla <Lukasz.Zemla@woodward.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio/adc: add ad7927 compatibility to ad7923 drivers
Date:   Wed, 16 Nov 2022 11:44:52 +0100
Message-Id: <20221116104453.3207-1-edmund.berenson@emlix.com>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The ADC ad7927 is compatible with ad7923 driver,
add explicit compatible and select appropriate
channel configuration.

Suggested-by: Lukasz Zemla <Lukasz.Zemla@woodward.com>
Signed-off-by: Edmund Berenson <edmund.berenson@emlix.com>
---
 drivers/iio/adc/ad7923.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 9d6bf6d0927a..df72e97dc331 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7928 SPI ADC driver
+ * AD7904/AD7914/AD7923/AD7924/AD7908/AD7918/AD7927/AD7928 SPI ADC driver
  *
  * Copyright 2011 Analog Devices Inc (from AD7923 Driver)
  * Copyright 2012 CS Systemes d'Information
@@ -367,6 +367,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{"ad7924", AD7924},
 	{"ad7908", AD7908},
 	{"ad7918", AD7918},
+	{"ad7927", AD7928},
 	{"ad7928", AD7928},
 	{}
 };
@@ -379,6 +380,7 @@ static const struct of_device_id ad7923_of_match[] = {
 	{ .compatible = "adi,ad7924", },
 	{ .compatible = "adi,ad7908", },
 	{ .compatible = "adi,ad7918", },
+	{ .compatible = "adi,ad7927", },
 	{ .compatible = "adi,ad7928", },
 	{ },
 };
-- 
2.37.4

