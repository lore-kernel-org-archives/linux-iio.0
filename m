Return-Path: <SRS0=Oeur=RQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0431C10F03
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64012075C
	for <linux-iio@archiver.kernel.org>; Wed, 13 Mar 2019 18:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZFKU34S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbfCMSki (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:40:38 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43764 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbfCMSkO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 Mar 2019 14:40:14 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so3130998wre.10
        for <linux-iio@vger.kernel.org>; Wed, 13 Mar 2019 11:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7OCibVDj3ON11Iv/B5fQbr5wmXHceO6Y9v3ZEb/PvXw=;
        b=GZFKU34S2Lbx6DqysakGu7w/AXr0EKkf9jtsvsWBUqgpXPcOPQq7742J26yfxhbR//
         Nx/zswMUYxhTce7T9oOxQDeDcg/5M9lBp9f76DS0hAzhCGv2ONEUQL+BIxA4p2TyWxCA
         0KthCXFbxL/BweQb3SDsBHJKaGTbohGVD5x5vkp8AkKIquvjxDl1E2Gtsb5l/DxCmMru
         xYyrOXcsVU6/F4vwpVp26+TtVzUrb3oB25sNYdfYfdBHYxeEJ6NPHJwZ40NbQNPz4Apo
         lXqSb8x9aWtTtDNe7dyEMJV6x9izYW3ezMOx71YmTAbWe1cwzXpWyOCaixAYZU141O8T
         RlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7OCibVDj3ON11Iv/B5fQbr5wmXHceO6Y9v3ZEb/PvXw=;
        b=Vluu4d+4gBHCc1/ACBnMI0lj/wXVxghx9rVJ463uuLHUOJ97l91n0IZVtylLquTsSl
         9ktSdRKiVyRQojvIt7dGA/zYWDiTYZGz2xT0xAsujit945ATzQfsHlqjT1/KMXoyIjBg
         uOKqwdGyH6Eq5poIR8Cjnm6A5jwG/dtCNMYtXj+uW8tvsPqD7EA9tq1C8isfms4MWXT6
         VXW8HkbIj2XnHa6lRSxALn/NduqkXtan7xgaS7UuF4+r9sl3UusxvbTAH92ks0+7FYIr
         pJgi5JPd0QFU24Jp8FZx1HPII+iO7Dbgn+s2QLbySCIPylVFKQOahZI5i369UT/ONDy+
         3LKA==
X-Gm-Message-State: APjAAAWS+eZYN8Z34xlaK+zcInwTh0NSAA8uHbDkYZtkRkkSwuOYruUx
        8feeOE1P1VvbO+hPTNmieXQ6kw==
X-Google-Smtp-Source: APXvYqzdo223GOa/IciQ3d8IwH7SZoCRkf8iQHNGy81Au4rgL4MBqyVQ/sb6K3s+NSsEvz++cBj6bQ==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr27770411wrx.243.1552502412067;
        Wed, 13 Mar 2019 11:40:12 -0700 (PDT)
Received: from arch-late.localdomain ([87.196.73.151])
        by smtp.gmail.com with ESMTPSA id p17sm3829660wmi.35.2019.03.13.11.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:40:11 -0700 (PDT)
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
Subject: [PATCH v3 1/6] iio: gyro: add DT bindings to fxas21002c
Date:   Wed, 13 Mar 2019 18:39:57 +0000
Message-Id: <20190313184002.2501-2-rui.silva@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190313184002.2501-1-rui.silva@linaro.org>
References: <20190313184002.2501-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add device tree bindings for the FXAS21002C gyroscope.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 .../bindings/iio/gyroscope/nxp,fxas21002c.txt | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
new file mode 100644
index 000000000000..68b4cd283d1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/gyroscope/nxp,fxas21002c.txt
@@ -0,0 +1,26 @@
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
+  - interrupts : device support 2 interrupts, INT1 and INT2.
+                 See interrupt-controller/interrupts.txt
+  - interrupt-names: should contain "INT1" or "INT2", the gyroscope interrupt
+                     line in use.
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
2.20.1

