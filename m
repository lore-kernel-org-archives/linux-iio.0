Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67716C43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388AF20863
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RxTr9WOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730790AbfCZKRI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:17:08 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46734 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfCZKRI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2019 06:17:08 -0400
Received: by mail-wr1-f65.google.com with SMTP id o1so13577775wrs.13
        for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2019 03:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hsHbm6H4k3Rr7SoTD7ilcig3tjV30GukFS8w5W/eA04=;
        b=RxTr9WOKVgMkQ3FDYS93MYDdmi+tJcmYCYQTh4+WLSxbjvCB4m8A1W8Hd0N+S+E248
         D35ZpcK5Aoo7ti5lXyioRxtzfV8OkEsim+3yDkEqXu+1EdR/Y6J6J1SHXCh8BES6hS4I
         Qh3pojeEhvOyLRiq9GvPtdCQR1F1H2F/cpHSFuJjf99gPN/uBS08uZ16LkDEiKjL5DUl
         UlqJSl3HdhRHjv4rVkq0rAlvLVSexIutuHVqG3w/q/+Ia3OVOAh9PhJ2vVMQQUrKIDN6
         T/WArG4uoQtXyzCF8kEz4zL6J76tNIde9y5iTSaR7wp7+EBtjzZIYlY7IRYU3yjcLIZq
         yP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hsHbm6H4k3Rr7SoTD7ilcig3tjV30GukFS8w5W/eA04=;
        b=EvVvQ1fASAIRsJb7PVbd69BKayf6JKtRJ9PQiB3aKmosYAxinQspMUsGZh3yVN3LWB
         0c1Wx0rcHQvncL1dCfv+GX6ECqZ3WGbWg6TKBaXDSSWo+rXNBi/whA04pKIUkXuXQat2
         Gx+rJaJVcGbANgpc1rqe2Om2TT7M73Icd2UoDSE92r4PYIPUtfOFemN1YxAWruM8eLuG
         CTtT2jCQqqrTWVtbQDUDSYx36eAxwW6+8j6d1QpzrmZwygmEIgdktcgkzG0xncNXjSuN
         TjBvje7locH+wlY9jRb/8tBXJK6BfYilWxAp5+8t/YOkUoSsdCrL8Ip/RKMkqFjBnt62
         eP9g==
X-Gm-Message-State: APjAAAXcJh2br+cVoz13yuVYbgyAccscTIIMi9cBrgqscvy/ODc607+9
        MsRybAVMTqm9ZWrfYvqTOFo0lA==
X-Google-Smtp-Source: APXvYqzA/sTYD9gcxp0MVg0oAbILzwogjaJja0tQNd/u7po5p60P5nSVYWQwa2zijnLLIegYfEVAMw==
X-Received: by 2002:adf:ee91:: with SMTP id b17mr19127096wro.234.1553595426821;
        Tue, 26 Mar 2019 03:17:06 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id j1sm22281024wme.4.2019.03.26.03.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:17:06 -0700 (PDT)
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
Subject: [PATCH v5 1/6] iio: gyro: add DT bindings to fxas21002c
Date:   Tue, 26 Mar 2019 10:16:46 +0000
Message-Id: <20190326101651.25056-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326101651.25056-1-rui.silva@linaro.org>
References: <20190326101651.25056-1-rui.silva@linaro.org>
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

