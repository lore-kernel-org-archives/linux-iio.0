Return-Path: <SRS0=dQzZ=QL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7304C282C4
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F5522087C
	for <linux-iio@archiver.kernel.org>; Mon,  4 Feb 2019 17:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBGz09Ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729315AbfBDRAg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 4 Feb 2019 12:00:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33928 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbfBDRAf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 4 Feb 2019 12:00:35 -0500
Received: by mail-wr1-f67.google.com with SMTP id f7so651120wrp.1
        for <linux-iio@vger.kernel.org>; Mon, 04 Feb 2019 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=du8lrySGcO2WJA5/+uAnRzTcnQRKVBAHdlz4DPUA1Dc=;
        b=dBGz09EpaU24J4UaI/0Ml+Zcm6sz/+Azur8bZf5QpYaxdrXvBdjYiLOgBbFYLcI66u
         hXvD+X4DgCH6azFILLZx66/Y8uvM6DN9Lxl2Va9+jPm2NYHJpvb5Jq7JVaUBvjFO7Xy4
         IYyh+O3yBF1p6YuDBB+0M07+cxdFpOwyqP7GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=du8lrySGcO2WJA5/+uAnRzTcnQRKVBAHdlz4DPUA1Dc=;
        b=kMU6AuwoiR/y0nZypLg6Myx/084lQPiLr3HL+xbd8cAcwRRG0gIH4PqOg60slNdPbX
         MIHINP5wM/D2UvI4al3IHlT1PklGdQrz4agqa5RaNOUjVywS9/Gebx8veT1MB6pmbmrc
         bHs/c0ony9oMSmOASRVh5PJT3noKQ7SxJVmAtXZ+wAfa9XFNAcWCi4/uLWerYj6bojfB
         u5lYL78XGxa8q+B8OoSRdlYL20j3lBT5zhE1mCIYOpTgb0CNkbwSzOMq7m++euQAz2Gr
         U2LI6QFWZbWHqu7JXhH9QZ2iBzf1Xk55GVwOnPYdx1PsEglxr1p91sNMEkzxSh8DT41V
         drsA==
X-Gm-Message-State: AHQUAuZDSXA22EKIYZLgYJBJwDflP/vVizWOgo8nX7XzPGteIXm7JPVs
        VR5YFQGsXO3CcehbPlIC5gjmLA==
X-Google-Smtp-Source: AHgI3IbFEYdNLlVLKA9YCwYEIBPzYTERtImH8BZlMlR6rF9Z6oeJkYX9hkB7ieX4N+K2zYk70/AQrA==
X-Received: by 2002:a5d:6b8b:: with SMTP id n11mr274269wrx.216.1549299634451;
        Mon, 04 Feb 2019 09:00:34 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id i186sm19352297wmd.19.2019.02.04.09.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 09:00:33 -0800 (PST)
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
Subject: [PATCH 5/5] ARM: dts: imx7s-warp: add fxas2100x gyroscope
Date:   Mon,  4 Feb 2019 17:00:12 +0000
Message-Id: <20190204170012.13617-6-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204170012.13617-1-rui.silva@linaro.org>
References: <20190204170012.13617-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add entry to enable the fxas2100x in the warp7 board

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 arch/arm/boot/dts/imx7s-warp.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 58d1a89ee3e3..47ff43cd229e 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -238,6 +238,11 @@
 		compatible = "fsl,mpl3115";
 		reg = <0x60>;
 	};
+
+	fxas2100x@20 {
+		compatible = "nxp,fxas2100x";
+		reg = <0x20>;
+	};
 };
 
 &sai1 {
-- 
2.20.1

