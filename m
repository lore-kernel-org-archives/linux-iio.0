Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DD7C43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4416E2147C
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pH5Qp7zL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbfCSK7p (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:59:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38420 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbfCSK7p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Mar 2019 06:59:45 -0400
Received: by mail-wr1-f66.google.com with SMTP id g12so20499421wrm.5
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2019 03:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsHbm6H4k3Rr7SoTD7ilcig3tjV30GukFS8w5W/eA04=;
        b=pH5Qp7zL/iXdaa5T2jrHsR1bzlX0r9p8UliiyUdXNylEQESCOTMzD8LgxtgkrDUdpR
         63FidAy8VGyBzQ9MiT9Dc3crSnGQOR4YV4PZOHhzcaU3rkrQ6dGcw6E6SBYFmS1jEabI
         7o3d+6d+C533nprCk2gotpPEtKpWCzp8khsUjTHPQBKoJxj4R2SSOdz789s3wtt96SHi
         WtOdxVfLZawku3wVNoFa2kFiYcbnTWkFfYIF41AtlqRw4BUuoTIaZpg6H/ISbTdA6xiG
         3H32f1h4O1k4QYMmcsnork0/RdytO4vvGakhcFZv0Wq/zMA0E/6OOgICz79UZow7CBuw
         tI9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsHbm6H4k3Rr7SoTD7ilcig3tjV30GukFS8w5W/eA04=;
        b=IvNGDiSVp9fpu+c3CwieKqg98xCK03+NMUusNcBjSlJ+/gor66nSx1S4Sizg0E/VWN
         D+mcT/uftR0kf8kYyTpn6Vpaip/eUxqKwD5r7/K/emIZ9et2uYWxnhgacGEoIYXHDKFb
         Rj+Qt+onh7hNNm9M8UUPiR1GkUvKKrnvEu0tzqPxwn+rkJGF/g5HkgweI9h1cg9z8bvg
         tOaYyzEeOz06Y1fimK4sD0o5HF1yyUMgpAT8svNa2tPuRIHOZyVzGf6yL61E09C25X7k
         BgY5l2EKM6Y9tZxVfWfSctleVkUqRSnOr8UkpHyUPduOtIL7ABg2si1K+06WSE9eYYpn
         tb/g==
X-Gm-Message-State: APjAAAUVRTG5f0t28+KIUAOV4+yk9ltqnhek06bLfc3YyFIVfP7CxwcY
        H6eRe6oGkJ/BsI80CsrIN8W4mg==
X-Google-Smtp-Source: APXvYqxYZ4bWA7P3jAjlEJe9BJBpTW49CkSug7e+T86Nr2XggXROV6110BqVodoqLa/mgrXwLbbRkg==
X-Received: by 2002:adf:8367:: with SMTP id 94mr17274311wrd.46.1552993184059;
        Tue, 19 Mar 2019 03:59:44 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm4120052wmf.2.2019.03.19.03.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:59:43 -0700 (PDT)
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
Subject: [PATCH v4 1/6] iio: gyro: add DT bindings to fxas21002c
Date:   Tue, 19 Mar 2019 10:59:20 +0000
Message-Id: <20190319105925.25863-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319105925.25863-1-rui.silva@linaro.org>
References: <20190319105925.25863-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the FXAS21002C gyroscope.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
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

