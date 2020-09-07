Return-Path: <SRS0=NC80=CQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F9C43461
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55520207DE
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495559;
	bh=XaZQTe1g93YjbbwMKI+XDVCFTgySS4Ksy5Om23OC0Sg=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WBbIzNCtUBewYwsIxex1mL5hpGIkm54b9pQHqSB4puomiUpU367rANk+pirEDYY3R
	 bYFl4ky0ObE1yqKz5MKp/kvaFiByPSOh+eA+DePlYJdw8pgapNnV+mtVbjxJME+3cP
	 av0cLR+JYyyxzAK6IoLx8jRA71PGMZCiA2J26pRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730432AbgIGQNw (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbgIGQNs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:48 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F05FA21775;
        Mon,  7 Sep 2020 16:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495225;
        bh=XaZQTe1g93YjbbwMKI+XDVCFTgySS4Ksy5Om23OC0Sg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cADlHFa1clb9r2CudarorQbJiQnfvy8IcyJTuV37YA6y1mAxT+rAm4gz+OWOUv0Lv
         9+Z1xZtPk5tdhH8pY7JcoZOiAssfgP1mXbGt/qGsEIibtx2k42B0eJTEZT4B8d4gjg
         cDM2NpsUEhXBfmhPo0F2p0XxPan/kiuTVoNIk2h0=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Bakker <xc-racer2@live.ca>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 19/25] ARM: dts: s5pv210: use defines for IRQ flags in Goni
Date:   Mon,  7 Sep 2020 18:11:35 +0200
Message-Id: <20200907161141.31034-20-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace hard-coded flags with defines for readability.  No functional
change.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-goni.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index 77d1c5144afd..20f1c2773805 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -12,6 +12,7 @@
 
 /dts-v1/;
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
 #include "s5pv210.dtsi"
 
@@ -366,7 +367,7 @@
 		compatible = "atmel,maxtouch";
 		reg = <0x4a>;
 		interrupt-parent = <&gpj0>;
-		interrupts = <5 2>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
 
 		atmel,x-line = <17>;
 		atmel,y-line = <11>;
-- 
2.17.1

