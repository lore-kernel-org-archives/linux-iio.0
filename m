Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C88C43460
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 04:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 782E861059
	for <linux-iio@archiver.kernel.org>; Sun, 16 May 2021 04:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbhEPEo5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 16 May 2021 00:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbhEPEo4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 00:44:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC3AC061573;
        Sat, 15 May 2021 21:43:41 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t20so2623774qtx.8;
        Sat, 15 May 2021 21:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIToHobG6pTTBKNe51uGI5W8iEeCvWA+i/a4f6RY748=;
        b=mr3LFluMgZNnLD5bnLlzlWCjMX4RCEqzuItR1DHResiWc7YA4eCtJ6d2pSxl4cvSWg
         C73xPm+ZhuuXAACgmpoEb6HKDBqQZWul9AkmlKAEhih4mzMBkW0pfpunRK3id7yObjfo
         dXgyaQfqZMbgzF6yb20N3L311D682ngUnEcvqUtIi23QRZMMyOjBh3svzHSsQMlaj/uS
         iCzLY2VcnJSoNZehRUjo3oRwnklcUklmXneOVSxl4OyjH/1xj8EOuz86svCvx9Hp9f72
         agrXhu4qxGXJzSAnEmpobzae2SzcAIPQ3sfiU1fM2qm514cCCgLbJ6oWsLoeDLPjh7oB
         LR1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIToHobG6pTTBKNe51uGI5W8iEeCvWA+i/a4f6RY748=;
        b=NFzOH5Sxusa7ebZ9wwLQO6tfPFDVNxamc8g6K1I/xfvmIWJh6yNS8DdyPa3OOQXrlx
         uDuMk9GD+HsG2qQjdiWZpIPKBix4euY0++EfnHYKNHQpB2T9BqWzjWfvtuVmtyl7+2O4
         VBdA5Bdo0mrPFVvTc54zy+Mafj6VLYwIcrbyEVE9XOijnFgbnygTJM/Ql4Zjaja9q4mA
         8UYwTYNgTc6QgDpUWArSnn2D1mupAct5Tl4yh3vWzs+uC0PUwZXQplgVerFPv7Ycw18h
         6cZ8ImSGK+yny69UeObOzWwzJOdh5XWTJEsxAHI7pXHr65GUjdFdKw4Xbgam8klg9hcs
         aq5w==
X-Gm-Message-State: AOAM533BOGPAENH0OZB5JC/RiTIc+f9FxMYi7mXVj+63BxQMyqkqG+yM
        iQnOD5KhCxe9Xd3yeU+wmfLdmp2XuzlbCQ==
X-Google-Smtp-Source: ABdhPJxHn3MiTWvmPeDqVEHKvKSjZVUGScm2yNsuyeg5Gdk4GCo48UZP71KL5DjEnUH9XIscXtTCBg==
X-Received: by 2002:ac8:5b81:: with SMTP id a1mr29942291qta.172.1621140221184;
        Sat, 15 May 2021 21:43:41 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id j28sm7750980qkl.35.2021.05.15.21.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 21:43:40 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, jdelvare@suse.com, linux@roeck-us.net,
        jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org
Subject: [RFC PATCH v1 2/2] dt-bindings: hwmon: add iio-hwmon bindings
Date:   Sun, 16 May 2021 00:43:15 -0400
Message-Id: <20210516044315.116290-3-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210516044315.116290-1-liambeguin@gmail.com>
References: <20210516044315.116290-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Document devicetree bindings for the iio-hwmon driver.
Also add documentation for the channel-types option.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 .../devicetree/bindings/hwmon/iio-hwmon.yaml  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
new file mode 100644
index 000000000000..fb8b437112a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/iio-hwmon.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/iio-hwmon.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: bindings for the IIO hwmon bridge
+
+maintainers:
+  - Jean Delvare <jdelvare@suse.com>
+  - Guenter Roeck <linux@roeck-us.net>
+
+properties:
+  compatible:
+    enum:
+      - iio-hwmon
+
+  io-channels:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+  io-channel-names:
+    $ref: /schemas/types.yaml#/definitions/string-array
+
+  channel-types:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description: |
+      an array of channel types used to override the IIO type of each channel.
+
+additionalProperties: false
+
+examples:
+  - |
+    #define IIO_VOLTAGE 0
+    #define IIO_CURRENT 1
+    iio_hwmon_adc0 {
+        compatible = "iio-hwmon";
+        io-channels = <&adc 0>, <&adc 1>;
+        io-channel-names = "input_current", "input_voltage" ;
+        channel-types = <IIO_CURRENT>, <IIO_VOLTAGE>;
+    };
-- 
2.30.1.489.g328c10930387

