Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E8FC4338F
	for <linux-iio@archiver.kernel.org>; Fri, 23 Jul 2021 08:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED21460F02
	for <linux-iio@archiver.kernel.org>; Fri, 23 Jul 2021 08:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbhGWHfO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:35:14 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29928 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbhGWHfO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Jul 2021 03:35:14 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 16N7x5V1041949;
        Fri, 23 Jul 2021 15:59:05 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 23 Jul
 2021 16:15:39 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <robh+dt@kernel.org>, <joel@jms.id.au>, <andrew@aj.id.au>,
        <p.zabel@pengutronix.de>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v2 1/8] dt-bindings: iio: adc: rename the aspeed adc yaml
Date:   Fri, 23 Jul 2021 16:16:14 +0800
Message-ID: <20210723081621.29477-2-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
References: <20210723081621.29477-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 16N7x5V1041949
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The aspeed,ast2400-adc.yaml not only descriptor the bindings of ast2400.
Rename it to aspeed,adc.yaml for all of the aspeed adc bindings.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 .../iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml}        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename Documentation/devicetree/bindings/iio/adc/{aspeed,ast2400-adc.yaml => aspeed,adc.yaml} (93%)

diff --git a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
rename to Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
index 7f534a933e92..23f3da1ffca3 100644
--- a/Documentation/devicetree/bindings/iio/adc/aspeed,ast2400-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/aspeed,adc.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/iio/adc/aspeed,ast2400-adc.yaml#
+$id: http://devicetree.org/schemas/iio/adc/aspeed,adc.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: ADC that forms part of an ASPEED server management processor.
-- 
2.25.1

