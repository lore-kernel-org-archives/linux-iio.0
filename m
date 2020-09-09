Return-Path: <SRS0=ZcV1=CS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7EFC433E2
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 18:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B7DF21D46
	for <linux-iio@archiver.kernel.org>; Wed,  9 Sep 2020 18:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599674703;
	bh=XpngdjpF08FQex0xcA2ugQ5BaeqEMiH6ImmMdQcJOM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ryK7E2z1yzqhKOk2M6pqhWYQb18ReiH9aRxegPzkgnC2/VJReWusa/pHOcXFxxcdF
	 zmlQN3hxAbvTBSyuE5DzFSS1YHwSKtom+9ua04SsMk36R5cNcPF1dch7WbY3nWo2ya
	 mvTFVNdvtvcoJdAsUiZBNfK1GzDbmSxUEsgdchz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIISFA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:05:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbgIISCh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Sep 2020 14:02:37 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790E9221E7;
        Wed,  9 Sep 2020 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599674556;
        bh=XpngdjpF08FQex0xcA2ugQ5BaeqEMiH6ImmMdQcJOM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bX32jlDnJGbSIFx+F77VwaTpCR0vBhixoRVD/9sud97LmW19PZsXsC/32IRChViFt
         QIlZZpcFZwz5p1D+0Gh/a6wrfJZR5F+dygZgx/Q+M4ATAaGwuKwNNeFOz7A7GIBCBn
         b19GhIDWlEOCcL42of0VqorZZ8ldBAlKlG+6ZrY4=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v2 11/20] dt-bindings:iio:adc:motorola,cpcap-adc yaml conversion
Date:   Wed,  9 Sep 2020 18:59:37 +0100
Message-Id: <20200909175946.395313-12-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200909175946.395313-1-jic23@kernel.org>
References: <20200909175946.395313-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Conversion from txt to yaml.
Slightly expanded example to give a bit more context.
Description lifted from the original driver commit.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 .../devicetree/bindings/iio/adc/cpcap-adc.txt | 17 -------
 .../bindings/iio/adc/motorola,cpcap-adc.yaml  | 51 +++++++++++++++++++
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt b/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
deleted file mode 100644
index ec04008e8f4f..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/cpcap-adc.txt
+++ /dev/null
@@ -1,17 +0,0 @@
-Motorola CPCAP PMIC ADC binding
-
-Required properties:
-- compatible: Should be "motorola,cpcap-adc" or "motorola,mapphone-cpcap-adc"
-- interrupts: The interrupt number for the ADC device
-- interrupt-names: Should be "adcdone"
-- #io-channel-cells: Number of cells in an IIO specifier
-
-Example:
-
-cpcap_adc: adc {
-	compatible = "motorola,mapphone-cpcap-adc";
-	interrupt-parent = <&cpcap>;
-	interrupts = <8 IRQ_TYPE_NONE>;
-	interrupt-names = "adcdone";
-	#io-channel-cells = <1>;
-};
diff --git a/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
new file mode 100644
index 000000000000..7811c0abd5d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/motorola,cpcap-adc.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/motorola,cpcap-adc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Motorola CPCAP PMIC ADC binding
+
+maintainers:
+  - Tony Lindgren <tony@atomide.com>
+
+description:
+  On Motorola phones like droid 4 there is a custom CPCAP PMIC. This PMIC
+  has ADCs that are used for battery charging and USB PHY VBUS and ID pin
+  detection.
+
+properties:
+  compatible:
+    enum:
+      - motorola,cpcap-adc
+      - motorola,mapphone-cpcap-adc
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    const: adcdone
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - interrupts
+  - "#io-channel-cells"
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        adc {
+            compatible = "motorola,mapphone-cpcap-adc";
+            interrupt-parent = <&cpcap>;
+            interrupts = <8 IRQ_TYPE_NONE>;
+            interrupt-names = "adcdone";
+            #io-channel-cells = <1>;
+        };
+    };
+...
-- 
2.28.0

