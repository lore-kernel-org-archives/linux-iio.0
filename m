Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BB0C64E69
	for <linux-iio@archiver.kernel.org>; Sun, 15 Nov 2020 19:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E23D22384
	for <linux-iio@archiver.kernel.org>; Sun, 15 Nov 2020 19:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHt65GJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgKOTcG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 15 Nov 2020 14:32:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:33976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgKOTcG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Nov 2020 14:32:06 -0500
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A5582417F;
        Sun, 15 Nov 2020 19:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605468725;
        bh=bvLxYjGb0ESyOfmh5/AmeZXqHUg0YeOtUAUB/hHekQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lHt65GJEJZ76VpgxM2WSZkuV8He4tsPcC6NvQytNxJ3xUjDu6LrikywZhQ8fv4z9D
         9+UyE8xOAKX0dd4c8l60bzQjgB8wYgpJp7fp18P9JFdGHNDamwxarzOfy4Qf+MCCxo
         HOQttwboxz3blH2VYC+UiUuiVQq6+8iRdNoeLT1w=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 3/9] ARM: dts: Cygnus: Drop incorrect io-channel-ranges property.
Date:   Sun, 15 Nov 2020 19:29:45 +0000
Message-Id: <20201115192951.1073632-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201115192951.1073632-1-jic23@kernel.org>
References: <20201115192951.1073632-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This property applies to consumers of io-channels.  In this case we
have a provider so the property is not used.

Not dt_schema will now detect this as an error due to a dependency
between this property and the io-channels property.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index dacaef2c14ca..0025c88f660c 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -591,7 +591,6 @@ touchscreen: touchscreen@180a6000 {
 		adc: adc@180a6000 {
 			compatible = "brcm,iproc-static-adc";
 			#io-channel-cells = <1>;
-			io-channel-ranges;
 			adc-syscon = <&ts_adc_syscon>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
 			clock-names = "tsc_clk";
-- 
2.28.0

