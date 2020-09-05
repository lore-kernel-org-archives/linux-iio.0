Return-Path: <SRS0=PRbX=CO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B7C2D0E2
	for <linux-iio@archiver.kernel.org>; Sat,  5 Sep 2020 17:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67DB72078E
	for <linux-iio@archiver.kernel.org>; Sat,  5 Sep 2020 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599327183;
	bh=1IL0MVyoisyJ6afqne2x4ewY/YCiP8wNlnqRsz+1SE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bIXcAGUttV+PeGkZmn+I8RZ0CxqW90SvQrbtC1jzWIN8OoFUTceSTN0TRkH/GwtNL
	 YLO53lkZ8MTICuohgZZf3Aks8alqG/lV8oDSo2UtrqwKB4c2r6B1Lx9fyzrziUH14K
	 jht5RmJmQO7szHscLougcasi247uPp92IL97s4hg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgIERct (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 5 Sep 2020 13:32:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728445AbgIERco (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Sep 2020 13:32:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B342E20DD4;
        Sat,  5 Sep 2020 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599327163;
        bh=1IL0MVyoisyJ6afqne2x4ewY/YCiP8wNlnqRsz+1SE0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cQ6IGkmbzY/478Bbsr8I5ZPAio/lizum3yqtkLYl+0UB+d6oeJAjMgFyJVpYlmn3D
         k8gIZYIUpAForI2Ey7hACd9VEK3onVEWVjC+RXec4D+za0frK8H5PlxRoJBB1Bm2IW
         h62EhvZodijWrrVx+OCFkYDXFlEr/MoeM6Z2EEjQ=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 12/20] dt-bindings:iio:adc:dlg,da9150-gpadc yaml conversion
Date:   Sat,  5 Sep 2020 18:29:56 +0100
Message-Id: <20200905173004.216081-13-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200905173004.216081-1-jic23@kernel.org>
References: <20200905173004.216081-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is a small part of an MFD so perhaps ultimately it makes more
sense to document it with that MFD binding rather than separately.

In the meantime it's a straightforward conversion from txt to yaml.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 .../bindings/iio/adc/da9150-gpadc.txt         | 16 ---------
 .../bindings/iio/adc/dlg,da9150-gpadc.yaml    | 33 +++++++++++++++++++
 2 files changed, 33 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt b/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
deleted file mode 100644
index c07228da92ac..000000000000
--- a/Documentation/devicetree/bindings/iio/adc/da9150-gpadc.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Dialog Semiconductor DA9150 IIO GPADC bindings
-
-Required properties:
-- compatible: "dlg,da9150-gpadc" for DA9150 IIO GPADC
-- #io-channel-cells: Should be set to <1>
-  (See Documentation/devicetree/bindings/iio/iio-bindings.txt for further info)
-
-For further information on GPADC channels, see device datasheet.
-
-
-Example:
-
-	gpadc: da9150-gpadc {
-		compatible = "dlg,da9150-gpadc";
-		#io-channel-cells = <1>;
-	};
diff --git a/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
new file mode 100644
index 000000000000..15c51d337108
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/dlg,da9150-gpadc.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/dlg,da9150-gpadc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Dialog Semiconductor DA9150 IIO GPADC
+
+maintainers:
+  - Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
+
+description:
+  This patch adds support for general purpose ADC within the
+  DA9150 Charger & Fuel-Gauge IC.
+
+properties:
+  compatible:
+    const: dlg,da9150-gpadc
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+examples:
+  - |
+    adc {
+        compatible = "dlg,da9150-gpadc";
+        #io-channel-cells = <1>;
+    };
+...
-- 
2.28.0

