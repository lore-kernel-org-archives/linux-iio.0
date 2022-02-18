Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A77C433F5
	for <linux-iio@archiver.kernel.org>; Fri, 18 Feb 2022 09:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiBRJGB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Feb 2022 04:06:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbiBRJF6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 04:05:58 -0500
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Feb 2022 01:05:40 PST
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2F2B3AE7;
        Fri, 18 Feb 2022 01:05:39 -0800 (PST)
Received: from twspam01.aspeedtech.com (localhost [127.0.0.2] (may be forged))
        by twspam01.aspeedtech.com with ESMTP id 21I8nNN3034493;
        Fri, 18 Feb 2022 16:49:23 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 21I8lrmY034381;
        Fri, 18 Feb 2022 16:47:53 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Feb
 2022 16:56:33 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <billy_tsai@aspeedtech.com>,
        <colin.king@canonical.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     Konstantin Klubnichkin <kitsok@yandex-team.ru>
Subject: [PATCH] iio: adc: aspeed: Add divider flag to fix incorrect voltage reading.
Date:   Fri, 18 Feb 2022 16:57:08 +0800
Message-ID: <20220218085708.8194-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 21I8lrmY034381
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The formula for the ADC sampling period in ast2400/ast2500 is:
ADC clock period = PCLK * 2 * (ADC0C[31:17] + 1) * (ADC0C[9:0])
When ADC0C[9:0] is set to 0 the sampling voltage will be lower than
expected, because the hardware may not have enough time to
charge/discharge to a stable voltage.

Reported-by: Konstantin Klubnichkin <kitsok@yandex-team.ru>
Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/iio/adc/aspeed_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index a957cad1bfab..ffae64f39221 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -539,7 +539,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 	data->clk_scaler = devm_clk_hw_register_divider(
 		&pdev->dev, clk_name, clk_parent_name, scaler_flags,
 		data->base + ASPEED_REG_CLOCK_CONTROL, 0,
-		data->model_data->scaler_bit_width, 0, &data->clk_lock);
+		data->model_data->scaler_bit_width,
+		data->model_data->need_prescaler ? CLK_DIVIDER_ONE_BASED : 0,
+		&data->clk_lock);
 	if (IS_ERR(data->clk_scaler))
 		return PTR_ERR(data->clk_scaler);
 
-- 
2.25.1

