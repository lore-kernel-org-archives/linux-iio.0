Return-Path: <SRS0=K6jb=SO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025B6C10F14
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C359721872
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LwRoZCka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfDLQtX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:49:23 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40176 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbfDLQtX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Apr 2019 12:49:23 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so12791781wre.7
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2019 09:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kQemHlhy5IBnI5eVM64sXDhOaup6+sWkXsp3l2KLBrk=;
        b=LwRoZCka7v63qKMrmROTLZHPquKk7Y4aSs41gsPnjACf2EbKpAcmSYwSBew87dui8P
         +ys+ZrLoH9nJVUXsQ6eC9YCXU2Dn6E8aHFxhJcOHLRdo/kJyMCNkxmLgaCPOkBxdh9aI
         wFIRqfCUAveB5vrr7szvXyqbU3tEdOPc5gVoAG8XGT1cpfYq1bp3tlY3/CmjhjFlIrJX
         QQMnxkReXA6yiwNpNWiumYm456AHBcXI7PjnLwERY3XMgPZqnAuA8Vmzp2NL5YfzCAWI
         xwaAR18RyHHyTKk4wdG7IyHKADNEatx+K+wp6NSWVMprUtj5raBNefhXRb9mcm/u9hyN
         YSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kQemHlhy5IBnI5eVM64sXDhOaup6+sWkXsp3l2KLBrk=;
        b=N5lZlf2a1jDlb5rKNP83YrBAhiu6NPBmlGoRMbN/NDfJYNdaWXLQKCIuU18CGTD810
         8rP0Gf4WE348dsqnimkMxrAOD2YJ2bBoo67m/jlKCzwhW93NjQN30R14wpsEfxSkaUrt
         PNnf36FXreK03SSIsIHY/gqhRsNGH2JZZxMEvGpib9ExoukL9abh5or7jNnd/Uoaz48c
         foVTGjmokHs7FrZwjykRwZQmr/UyPldgU3jRQTn8lpVHfaeLep1WPK9DcvF9+4jJ1kZN
         4dnc88xS7Xo/fZKqaHoeqEmppTfaQAyPPyeC0ZSkty2YXkeRFtbDP8oynkkFR1Nzj0S8
         RhfQ==
X-Gm-Message-State: APjAAAXdTXSXYSYrArBXRQScfb/0YuJkRh9a5qHBkdBAUo36Ets0mRC6
        rcfohuNlcHuDM6qlLColhpMvIw==
X-Google-Smtp-Source: APXvYqzebZV/Fo9QUswfOIUQoQYNqZVwnyk4MeCcLv6lBKixd4i43bvYRwSnLX1iNDEAfZcoOT0WKQ==
X-Received: by 2002:adf:dd0f:: with SMTP id a15mr477919wrm.221.1555087761563;
        Fri, 12 Apr 2019 09:49:21 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm73863141wrs.27.2019.04.12.09.49.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:49:21 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v6 5/6] ARM: dts: imx7s-warp: add fxas21002c gyroscope
Date:   Fri, 12 Apr 2019 17:49:00 +0100
Message-Id: <20190412164901.2321-6-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412164901.2321-1-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add entry to enable the fxas21002c gyroscope in the warp7 board.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/boot/dts/imx7s-warp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 613f0a9b319f..568f3289b34c 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -242,6 +242,13 @@
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
 	};
+
+	gyroscope@20 {
+		compatible = "nxp,fxas21002c";
+		reg = <0x20>;
+		vdd-supply = <&reg_peri_3p15v>;
+		vddio-supply = <&reg_peri_3p15v>;
+	};
 };
 
 &mipi_csi {
-- 
2.21.0

