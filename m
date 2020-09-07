Return-Path: <SRS0=NC80=CQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04708C43461
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B730C207DE
	for <linux-iio@archiver.kernel.org>; Mon,  7 Sep 2020 16:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599495860;
	bh=yx/xrKwi3d342OuVJ6+t5DVvoWKbXVtqclPlrgpbk3Y=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QHoXwm4TScqM19K6xmwLdh4yix7IfbB+pGPqYUZumwda7karkaLUfSXK+H3BNtCZp
	 ZFOWwe2o2v0aAoTqdgmvIyQqNJ9LO7rOEO4qN/VOP7BRJnxkETyBzpRK0UjZ4UOxXe
	 nAEXJur+eXlZFMkGciaM+bLNhsik4lQCd62hbv24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgIGQYB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:24:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:33292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729937AbgIGQNS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Sep 2020 12:13:18 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39503207DE;
        Mon,  7 Sep 2020 16:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599495197;
        bh=yx/xrKwi3d342OuVJ6+t5DVvoWKbXVtqclPlrgpbk3Y=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AvZnRTKZawYE3HQooBh8Fj2d4hN/5dCV9Kt4ZgIPQouJdeq/+bazDiPaEgGeCW4V2
         ZAPxuKbRNKpo88YfNvxNxs0DB2HO8xoKg2K9Yvv9rJ/EMc0EeuadiOKjDZxKkZJb3v
         EoDlBPgID3PfgjjKpnCeqwOFOa7Y0cgpEF6mPfNc=
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
Subject: [PATCH 12/25] ARM: dts: s5pv210: add RTC 32 KHz clock in Goni
Date:   Mon,  7 Sep 2020 18:11:28 +0200
Message-Id: <20200907161141.31034-13-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200907161141.31034-1-krzk@kernel.org>
References: <20200907161141.31034-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The S3C RTC requires 32768 Hz clock as input which is provided by PMIC.
However there is no such clock provider but rather a regulator driver
which registers the clock as a regulator.  This is an old driver which
will not be updated so add a workaround - a fixed-clock to fill missing
clock phandle reference in S3C RTC.

This fixes dtbs_check warnings:

  rtc@e2800000: clocks: [[2, 145]] is too short
  rtc@e2800000: clock-names: ['rtc'] is too short

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/s5pv210-goni.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/s5pv210-goni.dts b/arch/arm/boot/dts/s5pv210-goni.dts
index fbbd93707404..c8714bf0b6e4 100644
--- a/arch/arm/boot/dts/s5pv210-goni.dts
+++ b/arch/arm/boot/dts/s5pv210-goni.dts
@@ -33,6 +33,13 @@
 			0x50000000 0x08000000>;
 	};
 
+	pmic_ap_clk: clock-0 {
+		/* Workaround for missing clock on PMIC */
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <32768>;
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -224,6 +231,11 @@
 					regulator-max-microvolt = <1200000>;
 					regulator-always-on;
 				};
+
+				ap32khz_reg: EN32KHz-AP {
+					regulator-name = "32KHz AP";
+					regulator-always-on;
+				};
 			};
 		};
 	};
@@ -308,6 +320,11 @@
 	status = "okay";
 };
 
+&rtc {
+	clocks = <&clocks CLK_RTC>, <&pmic_ap_clk>;
+	clock-names = "rtc", "rtc_src";
+};
+
 &sdhci0 {
 	bus-width = <4>;
 	non-removable;
-- 
2.17.1

