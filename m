Return-Path: <SRS0=butv=EK=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FAC2D0A3
	for <linux-iio@archiver.kernel.org>; Wed,  4 Nov 2020 19:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B89D205ED
	for <linux-iio@archiver.kernel.org>; Wed,  4 Nov 2020 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730781AbgKDT2z (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 4 Nov 2020 14:28:55 -0500
Received: from aposti.net ([89.234.176.197]:42020 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725889AbgKDT2z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Nov 2020 14:28:55 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Artur Rojek <contact@artur-rojek.eu>
Cc:     od@zcrc.me, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        stable@vger.kernel.org
Subject: [PATCH] iio/adc: ingenic: Fix battery VREF for JZ4770 SoC
Date:   Wed,  4 Nov 2020 19:28:43 +0000
Message-Id: <20201104192843.67187-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The reference voltage for the battery is clearly marked as 1.2V in the
programming manual. With this fixed, the battery channel now returns
correct values.

Fixes: a515d6488505 ("IIO: Ingenic JZ47xx: Add support for JZ4770 SoC ADC.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/iio/adc/ingenic-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ingenic-adc.c b/drivers/iio/adc/ingenic-adc.c
index ecaff6a9b716..19b95905a45c 100644
--- a/drivers/iio/adc/ingenic-adc.c
+++ b/drivers/iio/adc/ingenic-adc.c
@@ -71,7 +71,7 @@
 #define JZ4725B_ADC_BATTERY_HIGH_VREF_BITS	10
 #define JZ4740_ADC_BATTERY_HIGH_VREF		(7500 * 0.986)
 #define JZ4740_ADC_BATTERY_HIGH_VREF_BITS	12
-#define JZ4770_ADC_BATTERY_VREF			6600
+#define JZ4770_ADC_BATTERY_VREF			1200
 #define JZ4770_ADC_BATTERY_VREF_BITS		12
 
 #define JZ_ADC_IRQ_AUX			BIT(0)
-- 
2.28.0

