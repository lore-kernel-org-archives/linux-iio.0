Return-Path: <SRS0=KJmS=QT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F16C282C4
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A0520842
	for <linux-iio@archiver.kernel.org>; Tue, 12 Feb 2019 17:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549993581;
	bh=Nz6M9p0Hf+vB9B9GzclwdnE4pHO3RpcI7qWuiVADVvU=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EHVyAGDeQ14O9AO7BajnfRlN6v38/6XkdzrXzoOmOOtkj4ASsNegOWCKaBZum13Hj
	 FRZH3ji2HhCGP2d1OgQ9xyYd5Ov7EXS00qm4x6nKs82NJ5a6vRtTuP8H83A+AUU0uG
	 +Y4j2JbWKJVZQDxvwmYODkD7hMVmVeiR/05EZfV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbfBLRqK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:46:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:50726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727865AbfBLRqK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 12 Feb 2019 12:46:10 -0500
Received: from localhost.localdomain (unknown [194.230.155.153])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49D27222C5;
        Tue, 12 Feb 2019 17:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549993569;
        bh=Nz6M9p0Hf+vB9B9GzclwdnE4pHO3RpcI7qWuiVADVvU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=OmwsR34SU4MNjCW4gH5jzrihCsMZFwQFG5kRa8xMnLLNtV6C6TVglrXOfdBeRx1mi
         3eJCBZyTXa8LObk8Q6IQhEtMML2ZsSr681ua5imQH27bWRawDd3N5NbJFq/vM9gTDr
         9DAimU0mGLoZcfigxBIpC9/FyLXzsBJfAhO3XTNQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: exynos: Use ADC for Exynos4x12 on Exyno4412
Date:   Tue, 12 Feb 2019 18:45:50 +0100
Message-Id: <20190212174550.4383-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212174550.4383-1-krzk@kernel.org>
References: <20190212174550.4383-1-krzk@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Exynos4412 should use "samsung,exynos4212-adc" compatible to report
proper number of (four) channels.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos4412.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index 26ad6ab3c6af..e5c041ec0756 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -274,7 +274,7 @@
 		};
 
 		adc: adc@126c0000 {
-			compatible = "samsung,exynos-adc-v1";
+			compatible = "samsung,exynos4212-adc";
 			reg = <0x126C0000 0x100>;
 			interrupt-parent = <&combiner>;
 			interrupts = <10 3>;
-- 
2.17.1

