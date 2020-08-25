Return-Path: <SRS0=+pSt=CD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5376C433E1
	for <linux-iio@archiver.kernel.org>; Tue, 25 Aug 2020 12:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C617020767
	for <linux-iio@archiver.kernel.org>; Tue, 25 Aug 2020 12:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nn45BJno"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgHYMsI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgHYMsB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 25 Aug 2020 08:48:01 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DA2C061574;
        Tue, 25 Aug 2020 05:48:01 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id p37so6764744pgl.3;
        Tue, 25 Aug 2020 05:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC7jYoJcfKkpwWPsNEp8M63/l3I3y2LHOlI73a/F3EQ=;
        b=nn45BJnoeyd4Dp5yJ2nKCIHoWqhJXJ7cIS9lDzB/+Cpj3S8GIeQG50JOhfelB/HbqF
         IpgHFtJmpkcQmCcr5+ik5IL6DOdo9sATJ2Jccej1D7sxj1mwmuD3aclxti/7ospV65wo
         BJVrhIBPSvqD4FtGukv99Y6N6HcprwDvQZnztEJolI3+4jAEt5su7ZRdtZDIWNKe3eJ4
         a02v2tKosuaffRzdPLztLx1jjQoMS3abZNKiby+HnsW3A2q3teT9qA9V68hATZHfahyU
         /o8LawCcMtsZ60k3ID16slbEK4nNHyIY8ICvv6Osa9zXvG3eAcY6MqULS6HQ+icqgp0c
         SsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC7jYoJcfKkpwWPsNEp8M63/l3I3y2LHOlI73a/F3EQ=;
        b=Slg0iGz6uhI3L9aisUk8KkAAqzNPPUdibkj3GRK+VB6dH4IIpHkt36V/ApSrTEBXmZ
         vDkv5dh1dSWf5EdJGtdEpott3dY7Z2RkZ1dWk802QPVc9eUYN5ss12+HH16T5lkC4A+U
         g0/bDXO5Hf6LWhwL1xBKwsVLutf3n6qomGdfct6iNmLEJrGAK8w5ZqZFosFAgTn0H/Fk
         2M8Mj2dYnzm8mFjpAqNPWTQ0K+0b5BFVUL7PObmjsyonTSOu2fTq3993AFcEw0yji7AW
         XjgT4LAeu7f0sw1BX3ydPAXrdo6ZYzWE4NAP37n8SMCcjZ40SX9dc5R1ZXOafwouLHAk
         9hkw==
X-Gm-Message-State: AOAM530qQCQltA3QRc/WUjLR5xdgu/2LHcKrhN4cpL8P/9RxQMJmGvHW
        6RQ/WCihN51ap/VhlWykKZQaoXvG544=
X-Google-Smtp-Source: ABdhPJxstWr6a+HLYGFPRMPIearJ/ycuuG9i41ndPYjopUkz3e1Mle12k7ktjcrp36+r+QARBULc+g==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr7833807plr.58.1598359680845;
        Tue, 25 Aug 2020 05:48:00 -0700 (PDT)
Received: from nish-HP-Pavilion ([2409:4072:619:dc6c:a526:a3b6:4686:f6fb])
        by smtp.gmail.com with ESMTPSA id b18sm13198746pgj.12.2020.08.25.05.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 05:48:00 -0700 (PDT)
From:   Nishant Malpani <nish.malpani25@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org
Cc:     dragos.bogdan@analog.com, darius.berghe@analog.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nishant Malpani <nish.malpani25@gmail.com>
Subject: [PATCH 2/3] dt-bindings: iio: gyro: adxrs290: Add required interrupts property
Date:   Tue, 25 Aug 2020 18:17:10 +0530
Message-Id: <20200825124711.11455-3-nish.malpani25@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825124711.11455-1-nish.malpani25@gmail.com>
References: <20200825124711.11455-1-nish.malpani25@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Append 'interrupts' as a required property and provide a suitable example
for using a GPIO interrupt line.

Signed-off-by: Nishant Malpani <nish.malpani25@gmail.com>
---
 .../devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
index 61adb2c2454b..cae593dd1ba7 100644
--- a/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
+++ b/Documentation/devicetree/bindings/iio/gyroscope/adi,adxrs290.yaml
@@ -28,17 +28,23 @@ properties:
 
   spi-cpha: true
 
+  interrupts:
+    maxItems: 1
+
 required:
   - compatible
   - reg
   - spi-max-frequency
   - spi-cpol
   - spi-cpha
+  - interrupts
 
 additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -48,6 +54,8 @@ examples:
                    spi-max-frequency = <5000000>;
                    spi-cpol;
                    spi-cpha;
+                   interrupt-parent = <&gpio>;
+                   interrupts = <25 IRQ_TYPE_EDGE_RISING>;
         };
     };
 ...
-- 
2.20.1

