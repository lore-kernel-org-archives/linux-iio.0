Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C55C25B08
	for <linux-iio@archiver.kernel.org>; Fri,  5 Aug 2022 14:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240675AbiHEOFG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 5 Aug 2022 10:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiHEOFE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 5 Aug 2022 10:05:04 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305B65A148
        for <linux-iio@vger.kernel.org>; Fri,  5 Aug 2022 07:05:01 -0700 (PDT)
Received: from localhost.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id AEA3E1FBB2;
        Fri,  5 Aug 2022 15:57:41 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 4/5] arm64: dts: qcom: sm6125-seine: Include PM6125 and configure PON
Date:   Fri,  5 Aug 2022 15:57:28 +0200
Message-Id: <20220805135729.1037079-5-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805135729.1037079-1-marijn.suijten@somainline.org>
References: <20220805135729.1037079-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Sony Xperia Seine board uses the PM6125; include it and configure
the PON buttons that provide the power and volume-up key.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 .../boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 038970c0b68e..c5967140d028 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -6,8 +6,8 @@
 /dts-v1/;
 
 #include "sm6125.dtsi"
+#include "pm6125.dtsi"
 #include <dt-bindings/gpio/gpio.h>
-#include <dt-bindings/input/input.h>
 #include <dt-bindings/input/gpio-keys.h>
 
 / {
@@ -88,6 +88,15 @@ &hsusb_phy1 {
 	status = "okay";
 };
 
+&pon_pwrkey {
+	status = "okay";
+};
+
+&pon_resin {
+	status = "okay";
+	linux,code = <KEY_VOLUMEUP>;
+};
+
 &sdc2_off_state {
 	sd-cd {
 		pins = "gpio98";
-- 
2.37.1

