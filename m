Return-Path: <SRS0=GqNd=54=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44788C2D0EC
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 18:37:27 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F5E20708
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 18:37:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAcwANLe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F5E20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbgDLSh0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 14:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgDLShZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 14:37:25 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A4FC0A3BF0;
        Sun, 12 Apr 2020 11:37:26 -0700 (PDT)
Received: from localhost.localdomain (unknown [157.50.0.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4EC62070A;
        Sun, 12 Apr 2020 18:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586716645;
        bh=yk8SbKnc9fDFKtdOOT2dziga/vvPgDy1h6NydsFTrIc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lAcwANLeFMfmsuGTIfPO4XoKXJK2pzY8I7eOgX+D5thJpfKRMWNOy1yekjXnpHLO6
         JVOiDSEu8oTyXGEzlSZt4XoHYZOiQxdmi4RTlGKxTlZ1mMeD12zmfjjssPZs9xUpVY
         yhMD/4FDLlhKAbwHvlQ+Wxu4Ige+wmJFHwn6WR3U=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH 1/3] dt-bindings: iio: chemical: Add binding for CCS811 VOC sensor
Date:   Mon, 13 Apr 2020 00:06:56 +0530
Message-Id: <20200412183658.6755-2-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200412183658.6755-1-mani@kernel.org>
References: <20200412183658.6755-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

This commit adds devicetree binding for AMS CCS811 VOC sensor.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 .../bindings/iio/chemical/ams,ccs811.yaml     | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
new file mode 100644
index 000000000000..564208af7b2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/ams,ccs811.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/ams,ccs811.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMS CCS811 VOC Sensor
+
+maintainers:
+  - Narcisa Vasile <narcisaanamaria12@gmail.com>
+
+description: |
+  Ultra-Low Power Digital Gas Sensor for Monitoring Indoor Air Quality.
+
+properties:
+  compatible:
+    enum:
+      - ams,ccs811
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO connected to the nRESET line. This is an active low
+                 input to CCS811.
+    maxItems: 1
+
+  wakeup-gpios:
+    description: GPIO connected to the nWAKE line. This is an active low
+                 input to CCS811.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      ccs811@5b {
+        compatible = "ams,ccs811";
+        reg = <0x5b>;
+        reset-gpios = <&gpioa 11 GPIO_ACTIVE_LOW>;
+        wakeup-gpios = <&gpioa 12 GPIO_ACTIVE_LOW>;
+      };
+    };
+
+...
-- 
2.17.1

