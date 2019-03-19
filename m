Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F731C10F03
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F23992133D
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TH/n/JsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCSK76 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:59:58 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55347 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfCSK75 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Mar 2019 06:59:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id 4so16088021wmf.5
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2019 03:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4UAQGf80mGcL4LT+JY+W46Q4J+EAzJLCXffApvYs8RU=;
        b=TH/n/JsW8zNpWIDNhjpvdEIPCJxj2V9fzZEFBbss3EuMcg/6rDmJ3TXA7YNMU1LS3S
         gbC08qqr59W12YWN6BirxNSehR4LsZPi7M28yfdf0IzQuS7JYtGY+A8a1y0acoaVV++e
         SXTE2ZIR4LeQMHZmvzY7ppno/LIuukmc7t1vzcN9tzIu20Kxykxc63vwY/lNAMigY98X
         jmcKSGortQiTuk4NXg33ZDYRvr6r1AqPx0OfRsuLV/tDGn5xCqz4sT6BXfD9jvC6C7EN
         mYYww5IUhZi4ERMRUMsBr1PE800JtRKcmPQY9qGk3OHEORONqgb0YHAwPdHrz+2FTspw
         WZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4UAQGf80mGcL4LT+JY+W46Q4J+EAzJLCXffApvYs8RU=;
        b=Pqt61/dj8i4YBV6cnPuFzhdIlgZ9//YnWVjHHtlZxhbH/bif+TwWeW0jj9av5svDhy
         ngwLfUK2T4m0rnjn8HgO3XqpTI2CUdXfdNHWDWdibEiY/AgVuQNCea9UCj6QkdFovetB
         XFlLle9Ha+GENXnXoW9gWHiF0jTZcOiX0jmrqNkBAnCIwjhKxYwLoG+HcYB8zd4PVVAA
         P6E3y5YFBwpuwCSt4drUn7vlDCVOtbdwSFkhWbo/wOW3ZF1s1AtEAd23zUe7wuiiGjK1
         SpTGbrUjbe3IGnGZ0Nzt0BdcdS9mlXd0BQOFwefuZdOhz8E/rY2D6bqFbQ9ZjCXb8h2R
         JPRg==
X-Gm-Message-State: APjAAAXVMDu5xGxLX8UQQXRD7T11PpoZiMQMkkZ0IJ3PON3mCIhUGGw2
        Z9zCu/5G3cDIbPkUb8IKugatgw==
X-Google-Smtp-Source: APXvYqz+c7PuRjglLiTYrkn4ukctLAL4DjiwXI6usZ0AfoZfO54zrBE+yXVugWIM2A085HpiFz8GIg==
X-Received: by 2002:a1c:7e51:: with SMTP id z78mr3063746wmc.82.1552993195766;
        Tue, 19 Mar 2019 03:59:55 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm4120052wmf.2.2019.03.19.03.59.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:59:55 -0700 (PDT)
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
Subject: [PATCH v4 5/6] ARM: dts: imx7s-warp: add fxas21002c gyroscope
Date:   Tue, 19 Mar 2019 10:59:24 +0000
Message-Id: <20190319105925.25863-6-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319105925.25863-1-rui.silva@linaro.org>
References: <20190319105925.25863-1-rui.silva@linaro.org>
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

