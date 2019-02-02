Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EECC282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057012084A
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="1pCyROAj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbfBBV4Y (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:56:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42276 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbfBBV4Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 16:56:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so4997858pfr.9
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 13:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cCMSBL+YM9QF6GcPueiLjjJAGqiDvbW99utOUVhBYe0=;
        b=1pCyROAjjHTuV5er7Rw3xGrA8M4vYVgfLCGtQVkPVyN4WU9hedJmNnkZcJl6BZFPjs
         XEM2/RY6SSZLntxTDjh/JC2thV1Lu9HFk8KbWQDPUYZQS9jbYJJS8QKH48p7NcVKln6T
         hDh+Y+VcuAQ8ISf6XMRUGWKZJLyhdoYLSSpl3HYQ7L1wQn//12ecIh6DK8kOg5Jj3M3A
         nWr2QKnqWbslRjY+myT1uEU6WnNU4bJh9c2rJVTXkNG9a8waVF+Hshb2W1EAaYiCZBX6
         rClFRSfEK1i6ZrdBELiAAXCuarLQnHcC4w1SlSXn9qrmdWA8qg+lKLfBI3UIDAw9Z1sB
         Futg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cCMSBL+YM9QF6GcPueiLjjJAGqiDvbW99utOUVhBYe0=;
        b=TCZB/B/HRULm13jD++Rf3GGu3uzo+unaAAeeHNBFK8KH8uv0A6BcIIMqsxuTNmF9lI
         X3YW/Gk4w//kNLpLDMD6ZHK1jAbN1QXZ1Lm9pgUlZk6RP+jw4Wd+Q3t30n3K7pblPBMp
         RBETLP8tXTBXEcenwnEO4BN+/4ra9zrNQbvjhLRnfD5SFSvGIUXzFpgUTLKEsx7y9NQy
         uTUDNpdx7z21zuaUiBwm9ekpXtmkdKtUVDRwEUYDNt5SYz+vRbIvLDNZ9jDs9XjtiGOg
         pxc47Zdone3kqDLZHizoDV6hmF8AATEjWcmhfNqSjn3AcACay80nNarBgu3v0j7vnY1K
         RIhQ==
X-Gm-Message-State: AJcUukcodtqqMShOXQRhFf+yHUA+gEv+VFIIcezps+ldtj8IrA7Zk3Ya
        TiwWrjYQi8A8R/T0eLjHGjPEygWPUZs=
X-Google-Smtp-Source: AHgI3IaVUK8TmvVExqVgsBPreVJPgZZ0LAnRIk75Ed9xQRHcexmLvQ2eMcTulsl8f9DvCRQMud2fuA==
X-Received: by 2002:a62:9305:: with SMTP id b5mr24046433pfe.10.1549144582754;
        Sat, 02 Feb 2019 13:56:22 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id z127sm20082025pfb.80.2019.02.02.13.56.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 13:56:21 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v4 3/6] dt-bindings: fix incorrect bmi160 IRQ note
Date:   Sat,  2 Feb 2019 13:55:58 -0800
Message-Id: <20190202215601.20275-4-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190202215601.20275-1-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

The bmi160 bindings say that the BMI160 requires level-triggered,
active-low interrupts, but it actually supports all interrupt types, so fix
the note to reflect that.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 Documentation/devicetree/bindings/iio/imu/bmi160.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
index 0c1c105fb503..1aec19997fb5 100644
--- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
@@ -9,7 +9,7 @@ Required properties:
  - spi-max-frequency : set maximum clock frequency (only for SPI)

 Optional properties:
- - interrupts : interrupt mapping for IRQ, must be IRQ_TYPE_LEVEL_LOW
+ - interrupts : interrupt mapping for IRQ
  - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
    input, set to "INT2" if INT2 pin should be used instead

@@ -20,7 +20,7 @@ bmi160@68 {
 	reg = <0x68>;

 	interrupt-parent = <&gpio4>;
-	interrupts = <12 IRQ_TYPE_LEVEL_LOW>;
+	interrupts = <12 IRQ_TYPE_EDGE_RISING>;
 	interrupt-names = "INT1";
 };

--
2.11.0

