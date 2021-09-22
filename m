Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC8CC433FE
	for <linux-iio@archiver.kernel.org>; Wed, 22 Sep 2021 08:15:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDE86124A
	for <linux-iio@archiver.kernel.org>; Wed, 22 Sep 2021 08:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbhIVIQo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 22 Sep 2021 04:16:44 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:20672 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhIVIQo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 04:16:44 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 18M7sbNa099780;
        Wed, 22 Sep 2021 15:54:37 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Sep
 2021 16:14:55 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v7 00/11] Add support for ast2600 ADC
Date:   Wed, 22 Sep 2021 16:15:09 +0800
Message-ID: <20210922081520.30580-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 18M7sbNa099780
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch serials make aspeed_adc.c can support ast2600 and backward
compatible.

Change since v6:
aspeed_adc.c:
 - Fix the parameter error for aspeed_adc_unregister_fixed_divider.

Change since v5:
aspeed_adc.c:
  - Use devm_clk_hw_register_divider()
  - Enabling and setting the ADC to normal mode is a necessary flow, so
  take it out of the condition.

Change since v4:
dt-bindings:
  - Add clocks maxItems.
  - Rename the property to meet the property-units.yaml.
  - Add the description for the difference between adc0 and adc1.
aspeed_adc.c:
  - Use new property name to get internal reference voltage: units from mv
  to uv.
  - Fix -Wnonnull warning caused by snprintf parameters.
  - Add suffix mv to the vref parameters.
  - Use ARRAY_SIZE instead of 32.
  - Add a reset action for ADC power down and Use devm_iio_device_register.
  - Fix typo error.
  - Separate the offset interface of ch7 when battery sensing enable

Change since v3:
dt-bindings:
  - Fix properties:aspeed,int_vref_mv type error.

Change since v2:
dt-bindings:
  - Create a new dt-bindings for ast2600 adc
aspeed_adc.c:
  - Splits the patch for more details
  - Remove version enum and use the flags in model data to distinguish
  hardware feature
  - Support trimming data get and set.
  - Use devm_add_action_or_reset to simplify probe error handling.

Changes since v1:
dt-bindings:
  - Fix the aspeed,adc.yaml check error.
  - Add battery-sensing property.
aspeed_adc.c:
  - Change the init flow:
    Clock and reference voltage setting should be completed before adc
    engine enable.
  - Change the default sampling rate to meet most user case.
  - Add patch #8 to suppoert battery sensing mode.

Billy Tsai (11):
  iio: adc: aspeed: Keep model data to driver data.
  iio: adc: aspeed: Restructure the model data
  iio: adc: aspeed: Add vref config function
  iio: adc: aspeed: Use model_data to set clk scaler.
  iio: adc: aspeed: Use devm_add_action_or_reset.
  iio: adc: aspeed: Support ast2600 adc.
  iio: adc: aspeed: Fix the calculate error of clock.
  iio: adc: aspeed: Add func to set sampling rate.
  iio: adc: aspeed: Add compensation phase.
  iio: adc: aspeed: Support battery sensing.
  iio: adc: aspeed: Get and set trimming data.

 drivers/iio/adc/aspeed_adc.c | 554 +++++++++++++++++++++++++++++------
 1 file changed, 459 insertions(+), 95 deletions(-)

-- 
2.25.1

