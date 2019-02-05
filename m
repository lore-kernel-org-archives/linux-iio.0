Return-Path: <SRS0=iTXR=QM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCFCC282CB
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF7C2207E0
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 17:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X/1RzFo9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfBERnv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Feb 2019 12:43:51 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37525 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbfBERnv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Feb 2019 12:43:51 -0500
Received: by mail-wr1-f66.google.com with SMTP id s12so4614788wrt.4
        for <linux-iio@vger.kernel.org>; Tue, 05 Feb 2019 09:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ERTGWcj2mXhrs1MM5n+vI6FIpImhaTERquVn+K2Zjrc=;
        b=X/1RzFo9umi69PDUybyvJ2T04C1op+H6HZMzjMexVLQNCGfMomxfkr4xM9L0QVnRnJ
         b/0mlHXHOXD/dnZXucCjOv2u3Xa4KExxO3IClyioYogd9G/Rc7vMhJb6D52LPyHAQTwA
         FdlUlg5brXcZX6tunn5F4sba8bZImt4IHpD5yFeEDxvK055I4NN9GLxUNnJWuFh6IOHG
         8SvvFPmiDOJDIvMJT9rZX3QvBrObdmhgK/3FbYhgfr/nH0hhmaeHDkTy5zXB2DPLgHHd
         OSiJSZERNJ4vOaxrquS6JqH2zJP0SDLgxwmtz+6UamsXeWRx5eu9PiB61alelf+Gcd7o
         qPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERTGWcj2mXhrs1MM5n+vI6FIpImhaTERquVn+K2Zjrc=;
        b=msjFuEFOX/SE330SnsiULg2pZElDbNQiu1XE9PO23PUwVcQcga5o9c4Qqwudog0enp
         8+tSvvE8yhaiUvKliV24E+vP1MPjyJ0scG9JsjTf6/gct2CNikWWFCo7ujv6ByiIc0Xt
         QVORHf2gc6T9BQ+tA6wznCZ12/whw92YSJQ8ILpIy3qfNOPSPWlESRk0BH9Bu2kBo3Am
         Im9DiLymNoW2klsbLjg6FlHR3wzticpgbUg2HHaySj5++ZwkO+msdXHmUTeB6L+GFObI
         xE1dbJ5adCJMR81M31qaAvju1cSxygy0dSrRahOIllaiNyhq1r4/FfhXcL4f59qRoLWj
         /alA==
X-Gm-Message-State: AHQUAuazm19DVfse2tK/eSOAS4WoSrl02WTEp6y2/htMfYWx8aQak6OY
        QD2zn4zzAGNX+pdWvipu5Yo+uQ==
X-Google-Smtp-Source: AHgI3IYsLlDP1PrNUAGXtEXqWLtsHcZGdKKF0lp2s0hYJ9jerJk4hT1j7QG3a460mnTTgTLDA8ss3A==
X-Received: by 2002:a5d:4a85:: with SMTP id o5mr4674567wrq.54.1549388629255;
        Tue, 05 Feb 2019 09:43:49 -0800 (PST)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id s132sm12225751wmf.28.2019.02.05.09.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 09:43:48 -0800 (PST)
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
Subject: [PATCH v2 1/5] iio: gyro: add DT bindings to fxas21002
Date:   Tue,  5 Feb 2019 17:43:29 +0000
Message-Id: <20190205174333.17672-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205174333.17672-1-rui.silva@linaro.org>
References: <20190205174333.17672-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the FXAS21002 gyroscope.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 .../bindings/iio/gyroscope/fxas2100x.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
new file mode 100644
index 000000000000..df10a60aa533
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/fxas2100x.txt
@@ -0,0 +1,18 @@
+* NXP FXAS2100X Gyroscope device tree bindings
+
+http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
+
+Required properties:
+  - compatible : should be "nxp,fxas21002"
+  - reg : the I2C address of the sensor
+  - vdd-supply: phandle to the regulator that provides power to the sensor.
+  - vddio-supply: phandle to the regulator that provides power to the bus.
+
+Example:
+
+fxas21002@20 {
+	compatible = "nxp,fxas21002";
+	reg = <0x20>;
+	vdd-supply = <&reg_peri_3p15v>;
+	vddio-supply = <&reg_peri_3p15v>;
+};
-- 
2.20.1

