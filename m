Return-Path: <SRS0=iTXR=QM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFF8C282CB
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 316E4217D6
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bHzekH/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfBERn7 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:43:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53104 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728741AbfBERn7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Feb 2019 12:43:59 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so4589187wml.2
        for <linux-iio@vger.kernel.org>; Tue, 05 Feb 2019 09:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1beXyQ7Gf29kAeZEAs9WtF0BKb4rwWHgLwQvrdn6V/Y=;
        b=bHzekH/bWSHQl3zTXv2YVD9MjXSFYUPbsiuMgER2iccqk0ib4nip+rpB3WWWvODWDi
         9evwdQqULxH+ix0hKCpAS98nNNqiAsIYhVJOU52peR5lVT7N/QFMfoQZ8oZJrQylalu/
         J6FxXl/oe6LCvr9r3JWUNj9NPbxV4xRljdGrMEM+r5VKEirxq5f8paXw+npuPUrDEHZj
         vvoDX3NFF1tgK0dQFvasDZKdD96/FzVLYMDb1LtW7t+bBasNkTyvaaMEzLydWmhfiBg6
         twc8kU21S7bPqP8EeLiOy43PbXAtonr9nScoS6Efk5ur4CUzZ7LxF4JVwGFJk2A0QS5c
         nSTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1beXyQ7Gf29kAeZEAs9WtF0BKb4rwWHgLwQvrdn6V/Y=;
        b=Pni1GtLTxmni2bwfX3g4pftU+3/NtKgrJeZTL4y/rh4fcFaHHz/oVSDaybippngxAP
         ZU2kSl3uQFAsikQjPhJiKsCw7AT6fc1l/ANMBK0Znj6d7XwWiQXXjruKcZoE/Y1NblAT
         MEmDw6Tr63QW7a1Cp8/KAXku5qqYCyifcZSXMxI6mUZBZhodYVRDrvmYoRpmD1Pgkruy
         khm4YnfJMNTLpom2d/55l74Rx9aTGrjrgvESsqDmc6WstrNl3xnbAoodhyjBjTfSveV8
         2QbplgG5h7KNI/FI0+Dw81Tkrp/PzoGoDr9tY7lvaeJCcJf8T1tpPQEVBl6xoRwSKWyO
         E31Q==
X-Gm-Message-State: AHQUAuZGxYAvPEWtemoHxdgtemz/+3/VIAUpDyLwktfyjqnsaoaBA27w
        RVwjjFR608uYfqJv/XK4jR6CVA==
X-Google-Smtp-Source: AHgI3IauMFIqR5UhM/Qe2u6Imjg9f9NtV+2/ihKpOM8JXoIQFFwfgedsE/l+P/CWeuEVmG37p7L/Kw==
X-Received: by 2002:a1c:bc82:: with SMTP id m124mr4554500wmf.77.1549388637813;
        Tue, 05 Feb 2019 09:43:57 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id s132sm12225751wmf.28.2019.02.05.09.43.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 09:43:57 -0800 (PST)
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
Subject: [PATCH v2 5/5] ARM: dts: imx7s-warp: add fxas21002 gyroscope
Date:   Tue,  5 Feb 2019 17:43:33 +0000
Message-Id: <20190205174333.17672-6-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205174333.17672-1-rui.silva@linaro.org>
References: <20190205174333.17672-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add entry to enable the fxas21002 in the warp7 board

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/boot/dts/imx7s-warp.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 58d1a89ee3e3..233ff2b68488 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -238,6 +238,13 @@
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
 	};
+
+	fxas21002@20 {
+		compatible = "nxp,fxas21002";
+		reg = <0x20>;
+		vdd-supply = <&reg_peri_3p15v>;
+		vddio-supply = <&reg_peri_3p15v>;
+	};
 };
 
 &sai1 {
-- 
2.20.1

