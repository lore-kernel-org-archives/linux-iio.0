Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80647C4360F
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511B220879
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WRfXS+a7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731003AbfCZKRT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:17:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34852 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbfCZKRT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2019 06:17:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so12238415wmd.0
        for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2019 03:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UAQGf80mGcL4LT+JY+W46Q4J+EAzJLCXffApvYs8RU=;
        b=WRfXS+a779Fb1SdYP5VW2TOEFzNcu0b422wa9GrLXVSLfuljoSujF3ZqBL8qXuqIrp
         TiHqYBuIF9dg2TDhHFOmXoPNRQjVibnGvh41I1Rx9XUTO7cgod+ewdJmsqW6kUSW8TDc
         5+ixAM0YRXzezqsIy0xXwlRJ9g9gIm1x8bsrwTU59WovAEY+XP21/hTWisV9zWWSvBL/
         Y2yDH/RXhZVr8ZzrjXGSprdKqVhLjmcb7BnE15Y8Ht3d/KrV9fOUUsYfU6jFg7IA7xjD
         fS/oe5P3ovtRkkcu0VfrQpOQTBoMs/BeHoBw6CCql70DLD3+7pbE/nNU2r9KKCKhYSnn
         /A5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UAQGf80mGcL4LT+JY+W46Q4J+EAzJLCXffApvYs8RU=;
        b=koykiNRKxw8as/Z+PeMM0xCaw8FwsrQ5RqC5VsZRI3lDibU5F1dVinYxg8N7pCEEZV
         ev6ZmSh4yIrl9OR0+WN0IJ/dvn1wRzQBMzdpUdEfjPITtoePRgosY06KztExHbkP/bh2
         cDd+C8rZZzWF6VcniSnYrNy2UNhhWqgBG5llzNbHEpCkuMuB8AkBqLEHrcJUHsx3kLI9
         S9jlDCvSMEbfe6dyRWLVU48Tp9VFgwSN8/WN0X3TK5Br1QnnaknvAIMFJFCX4QLPyw2L
         PC09DKUysGuh1Y+zPAUtIJM5ylubJUhGkzApECHu/PsT2neLywVfkhC3JrA6nHT2WhV4
         xHBA==
X-Gm-Message-State: APjAAAUtXIW5TRnOt37EwnYhq6ND9fbC/15rIpp1mdVn06NqeJdgAe3f
        T8EJqTHrd3h4+XiyKhaLbeENiA==
X-Google-Smtp-Source: APXvYqzr8DcAiK6d3qzItpIdX5B/vOxycbvMNsxT87nchwPtz5U/GAe6m938wxG/UfkoFuEfC7zalg==
X-Received: by 2002:a1c:bac2:: with SMTP id k185mr8136761wmf.5.1553595437651;
        Tue, 26 Mar 2019 03:17:17 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id j1sm22281024wme.4.2019.03.26.03.17.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:17:17 -0700 (PDT)
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
Subject: [PATCH v5 5/6] ARM: dts: imx7s-warp: add fxas21002c gyroscope
Date:   Tue, 26 Mar 2019 10:16:50 +0000
Message-Id: <20190326101651.25056-6-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326101651.25056-1-rui.silva@linaro.org>
References: <20190326101651.25056-1-rui.silva@linaro.org>
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
index 23431faecaf4..c7dd66828a90 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -209,6 +209,13 @@
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
 
 &sai1 {
-- 
2.21.0

