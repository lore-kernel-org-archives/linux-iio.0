Return-Path: <SRS0=NC80=CQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C69C433E2
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFEB121532
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495925;
	bh=oQutU7eoT4DFfkecRuD/WmWdYMLZJlQ9/R4YqBUhAgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b3bDF0vGNPSVJYXLECmnqdWyd73vaP8N0CE0FGcUOyPsmceNDJd8q7kqbmAaiz4P0
	 uyhUf7GDwDFGDGORTlop6C0qh/r29/OWX/xfTYQdq5iQGbSUeTQdTUVsUUg6y3R9pF
	 gmNInRdvvDMrolYo9rShXKdJ2X0Ki64qKtFCu0EY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgIGQZR (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:32814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730333AbgIGQMn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:12:43 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 18BEF207DE;
        Mon,  7 Sep 2020 16:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495163;
        bh=oQutU7eoT4DFfkecRuD/WmWdYMLZJlQ9/R4YqBUhAgU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHYWhNyqz/iY+3timtuojVIEZ3CNEAJ+Fr/n8RMz5apc1CZua9Lz/KBPEpWoebFc+
         wqfw7dVGNSrjBREcVT7le9oozJm/yf9NOkC3Q8aCVrwq2/zxX2eXAqymf4ddfPDUAY
         49a7cLoKYppZ3Wm0viNQsmDEMfAN10/9l+TW4jjw=
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
Cc:     stable@vger.kernel.org
Subject: [PATCH 04/25] ARM: dts: s5pv210: fix pinctrl property of "vibrator-en" regulator in Aries
Date:   Mon,  7 Sep 2020 18:11:20 +0200
Message-Id: <20200907161141.31034-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fix typo in pinctrl property of "vibrator-en" fixed regulator in Aries
family of boards.  The error caused lack of pin configuration for the
GPIO used in vibrator.

Fixes: 04568cb58a43 ("ARM: dts: s5pv210: Disable pull for vibrator enable GPIO on Aries boards")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-aries.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
index a3f83f668ce1..6ba23562da46 100644
--- a/arch/arm/boot/dts/s5pv210-aries.dtsi
+++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
@@ -59,7 +59,7 @@
 		gpio = <&gpj1 1 GPIO_ACTIVE_HIGH>;
 
 		pinctrl-names = "default";
-		pinctr-0 = <&vibrator_ena>;
+		pinctrl-0 = <&vibrator_ena>;
 	};
 
 	touchkey_vdd: regulator-fixed-1 {
-- 
2.17.1

