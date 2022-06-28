Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FFFCCA47E
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jun 2022 15:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348067AbiF1PPy (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 28 Jun 2022 11:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347320AbiF1PPc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 11:15:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F83207A;
        Tue, 28 Jun 2022 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656429324; x=1687965324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3OJtEvPYzAYaQ9cBfqpENBUtWhD2jyInXWYtSigki0o=;
  b=LH7C4iFuy8jLqJBzkk1beg1s3ht6sl46YKYmquiR+/Q7W6j4kkV7Q8ut
   yQlQpticITTblmBBaPorJnSu9nPMKOXJbt75BsZxbHMlNuNCWacOS9RGn
   j3UJ0YvNkExtSyLMztJpRsPGsCN/xiw1KXFum0P6zVOq1Vkit+4WEHXHw
   pdQAjB3iTXDgXnYil9alVdGWg3uRcvaUt216wNnf5Rb8GmDhUrCPM3rxU
   sIfv1Z/5TH4ibxilhNyYMiNSJc/XxeA7mSZYjS5p1uneDqhRG50g97nap
   DGxDAzaHooxayO8gt2UQCk0YbOrmQaQPTNLnysJvCpxs3CZcgdcYB4lyd
   g==;
X-IronPort-AV: E=Sophos;i="5.92,229,1650956400"; 
   d="scan'208";a="165465605"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 08:15:23 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 08:15:16 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 28 Jun 2022 08:15:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <eugen.hristev@microchip.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>
CC:     <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 18/19] iio: adc: at91-sama5d2_adc: add empty line after functions
Date:   Tue, 28 Jun 2022 18:16:30 +0300
Message-ID: <20220628151631.3116454-19-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
References: <20220628151631.3116454-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add empty line after function.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 0e2dab544311..3f47ca643496 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1367,6 +1367,7 @@ static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *indio,
 
 	return trig;
 }
+
 static void at91_adc_trigger_handler_nodma(struct iio_dev *indio_dev,
 					   struct iio_poll_func *pf)
 {
-- 
2.34.1

