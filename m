Return-Path: <SRS0=K6jb=SO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27619C10F14
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED73D2171F
	for <linux-iio@archiver.kernel.org>; Fri, 12 Apr 2019 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t34mCP/1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbfDLQtO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:49:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41611 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfDLQtO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Apr 2019 12:49:14 -0400
Received: by mail-wr1-f68.google.com with SMTP id r4so12761258wrq.8
        for <linux-iio@vger.kernel.org>; Fri, 12 Apr 2019 09:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xndsdNKupCrtLI+E4Zuybchip1AkkdCy59d6FVBn3vA=;
        b=t34mCP/1SgyP5uDN5yldWxX6OO0yrISdzpuRYplaBJ10+rFfo4jhGKu9H4Vu66ZtxZ
         uYFTfQOV2xibxSCQciuvz0E2/J9ANiqZzJCzI31AjzIe1ugmclZeNNRyG+3f0nYb+t+V
         AgXjAGCbWKQJrJCKYx5wY7zK/MmcNWhXUNp6X3nxj7L0w6galNi2iLsR8A5ZakUmIyOA
         qou0xowynoRJ+E748prjx4+yJPjtPAK+SMdLmJBy/3m7Uxw+Eg8dmY+yEFk3/Pw+0mCN
         GI06dw/SiCZzZZgS0fDnUvSzMy1lgJ/zueV+QYhuz8RiNpGioAEILy5+zSvo1V2EiDov
         ZgZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xndsdNKupCrtLI+E4Zuybchip1AkkdCy59d6FVBn3vA=;
        b=brgkosawykWYrLlpHVtEG7bNDxWhGwJYzdEDNyQzTt0caRHhWM+/Eipf+2Ee3PsJZt
         ki3neS41cMxjrovuI3cVh7bRuHPif6SttDmAS/yw/fI3u7P2RLTX/nFmFYU3iOAz6g36
         2l23MPPYG41X+ykKSX+TFQdRZ46zkq+4+csVs1vUYGW5smLRLuYUYrF8n6b+5IjmU2x5
         6RierEoXNHkGsEHLs8Sf3897o692V+sbkWxrQaSJhsSYRhAUVgqrnzTHYHto5qjzVUUi
         hYt8EFG1Kct5zBfacO0uOOpkeil2Rg7QulYab8BBDA18mJyJ97zkw8m/IQZCZE7+cJrB
         LS/Q==
X-Gm-Message-State: APjAAAXQvzBPKk5/2g9By6oyT8MlYTwz5BGx+UXTd1DSuTkAtuowqfHW
        YjiFD/ZHoZmRU8VJ9V1kgGwA+/9SukE=
X-Google-Smtp-Source: APXvYqxvnuK13wquzI3hUIYfEHtQDx/FaNzy/LP5tNLFQ957v94j/IFCZ56RmPQUzVqOuakYwG8e4w==
X-Received: by 2002:a5d:68cf:: with SMTP id p15mr15787348wrw.301.1555087752448;
        Fri, 12 Apr 2019 09:49:12 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm73863141wrs.27.2019.04.12.09.49.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 09:49:12 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v6 1/6] iio: gyro: add DT bindings to fxas21002c
Date:   Fri, 12 Apr 2019 17:48:56 +0100
Message-Id: <20190412164901.2321-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190412164901.2321-1-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the FXAS21002C gyroscope.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
new file mode 100644
index 000000000000..465e104bbf14
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
@@ -0,0 +1,31 @@
+* NXP FXAS21002C Gyroscope device tree bindings
+
+http://www.nxp.com/products/sensors/gyroscopes/3-axis-digital-gyroscope:FXAS21002C
+
+Required properties:
+  - compatible : should be "nxp,fxas21002c"
+  - reg : the I2C address of the sensor or SPI chip select number for the
+          device.
+  - vdd-supply: phandle to the regulator that provides power to the sensor.
+  - vddio-supply: phandle to the regulator that provides power to the bus.
+
+Optional properties:
+  - reset-gpios : gpio used to reset the device, see gpio/gpio.txt
+  - interrupts : device support 2 interrupts, INT1 and INT2,
+                 the interrupts can be triggered on rising or falling edges.
+                 See interrupt-controller/interrupts.txt
+  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
+                     line in use.
+  - drive-open-drain: the interrupt/data ready line will be configured
+                      as open drain, which is useful if several sensors share
+                      the same interrupt line. This is a boolean property.
+                      (This binding is taken from pinctrl/pinctrl-bindings.txt)
+
+Example:
+
+gyroscope@20 {
+	compatible = "nxp,fxas21002c";
+	reg = <0x20>;
+	vdd-supply = <&reg_peri_3p15v>;
+	vddio-supply = <&reg_peri_3p15v>;
+};
-- 
2.21.0

