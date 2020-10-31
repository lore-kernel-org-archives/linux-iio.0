Return-Path: <SRS0=JG+F=EG=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC83C4742C
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E602074F
	for <linux-iio@archiver.kernel.org>; Sat, 31 Oct 2020 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604151856;
	bh=imnr0hPuKLRC23kdsQVHykB3NCohVjYBaGP4M2689ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QXGwu2qAmPIMmxw3O1NUbmmgmgEVzp8AOrlUmDEBusoCkJZBcL4oaCWNiOYInD1U9
	 cuB6KCvn5rq6NGVE3fWwZ0QjNWiWe/sqc/dhpfK2GxwpyDFIx94WxtSbq1Q+0y9JZs
	 9/6R5/zf/1YY3NTg6zkzuM8uxRQAVRZFIoczfsqw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgJaNoQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 31 Oct 2020 09:44:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgJaNoP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 31 Oct 2020 09:44:15 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF04820731;
        Sat, 31 Oct 2020 13:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604151854;
        bh=imnr0hPuKLRC23kdsQVHykB3NCohVjYBaGP4M2689ww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=akvhbeZO2o6/YEN1M67IV4VPNjA9Lf6ZzLQPT58jWO3ndUMU3cac9sXIwGkRwEi09
         i3O1Siyk9j3ZXRvfW6DaVIZ4YygreU2wWs+4nv9ldpnUVce9SalSMHhRvHtRk+H3VK
         WgnDI3DUc9s8EqmiqAvmnshtsILE+KaxCMRixfaw=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH v2 22/29] dt-bindings:iio:dac:nxp,lpc1850-dac yaml conversion.
Date:   Sat, 31 Oct 2020 13:41:03 +0000
Message-Id: <20201031134110.724233-23-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031134110.724233-1-jic23@kernel.org>
References: <20201031134110.724233-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Very similar binding to that for the ADC on the same device.
Conversion from txt to yaml format.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Vladimir Zapolskiy <vz@mleia.com>
---
 .../bindings/iio/dac/lpc1850-dac.txt          | 19 ------
 .../bindings/iio/dac/nxp,lpc1850-dac.yaml     | 58 +++++++++++++++++++
 2 files changed, 58 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt b/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
deleted file mode 100644
index 42db783c4e75..000000000000
--- a/Documentation/devicetree/bindings/iio/dac/lpc1850-dac.txt
+++ /dev/null
@@ -1,19 +0,0 @@
-NXP LPC1850 DAC bindings
-
-Required properties:
-- compatible: Should be "nxp,lpc1850-dac"
-- reg: Offset and length of the register set for the ADC device
-- interrupts: The interrupt number for the ADC device
-- clocks: The root clock of the ADC controller
-- vref-supply: The regulator supply ADC reference voltage
-- resets: phandle to reset controller and line specifier
-
-Example:
-dac: dac@400e1000 {
-	compatible = "nxp,lpc1850-dac";
-	reg = <0x400e1000 0x1000>;
-	interrupts = <0>;
-	clocks = <&ccu1 CLK_APB3_DAC>;
-	vref-supply = <&reg_vdda>;
-	resets = <&rgu 42>;
-};
diff --git a/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml b/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
new file mode 100644
index 000000000000..595f481c548e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/nxp,lpc1850-dac.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/nxp,lpc1850-dac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC1850 DAC bindings
+
+maintainers:
+  - Jonathan Cameron <jic23@kernel.org>
+
+description:
+  Supports the DAC found on the LPC1850 SoC.
+
+properties:
+  compatible:
+    const: nxp,lpc1850-dac
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  vref-supply: true
+
+  resets:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - vref-supply
+  - resets
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+        dac: dac@400e1000 {
+            compatible = "nxp,lpc1850-dac";
+            reg = <0x400e1000 0x1000>;
+            interrupts = <0>;
+            clocks = <&ccu1 CLK_APB3_DAC>;
+            vref-supply = <&reg_vdda>;
+            resets = <&rgu 42>;
+        };
+    };
+...
-- 
2.28.0

