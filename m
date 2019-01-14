Return-Path: <SRS0=BsLG=PW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E45C43612
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3B2D20870
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="0TesgYfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfAND4p (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:56:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37906 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfAND4p (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jan 2019 22:56:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id g189so8882482pgc.5
        for <linux-iio@vger.kernel.org>; Sun, 13 Jan 2019 19:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AoooTCmjZ5+hUnrheSFS4kgpOtp0NBQrzyp55jolc5Q=;
        b=0TesgYfdb+J/wkWGX744GE7lmPS8/X/WRxph6pHxTpuOaT6UAzGTQ3HmgFDtVjKWYa
         qIxOO/yh5yBEEey+ulMMFzqcjWfnrU2n1wXUzSGHxb9yHZDW8rG8+goGTqU7aoiv94xa
         OkTV9KUTt/W2HVadNrV47ltU/IDRSFxek+o2iXPLHKUHQQpjjoBB07y5DYWl/kZdODeZ
         n9tgZgR7kpyaK0aLDI+JCCyh2ix38rSZu2Wupu/BM1d4N7Z0XXIR9xufwGrVll6x8ef+
         Wl5MzY2E2TkC7/LXUZ8ffRtBVPRwaRb8saTOaeqHhOmIAGPPiRNacTv99IcIoaE5cCbd
         FWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AoooTCmjZ5+hUnrheSFS4kgpOtp0NBQrzyp55jolc5Q=;
        b=s3EnLMaGLfwLmhCQn5lEq9q9MeNXat2tqfPclHdxXAdtfQrDwrWsRbKfrhld1mgAz+
         UktGU7Rgc3b+NfxnehqWBES8G6B2PTPlo+tRunO8m2Uyyl1kXA50A5zc2VZguZOjbaOp
         eUpFUaXwepEbQo5VUiUYEUgEu5uW06IKjM8B92DLTEKpPF+j/bKg0J8iqAtxww1DPNZq
         L/vndTij6YHGwU4EhPyG6jRlCm5aZkHX1aCyUsBe+5GCY/TmedSjVkEWOK0ZdeRrA1RO
         pj4Ot88jru4PRGq28amPSZYoHULoeVAQzWOnQVHpVPpsVYs9SajWaq8bE172fosBg3jm
         LYQQ==
X-Gm-Message-State: AJcUukdYz0OOPCnnEwqQnmv1aMGRI04JZyD4eXMlYRO4BmNMh4Nb0ktI
        Y57BBzGdrd68ixfZ7/eaCPakLtzwetU=
X-Google-Smtp-Source: ALg8bN4wMBMc5Jbofa5emp9WSuTFjxR+qsbrzQbUGbhRWLPkVPyg8s/VbEFBL4N4Lv2AdkJj20LxdA==
X-Received: by 2002:a62:870e:: with SMTP id i14mr24312425pfe.41.1547438204242;
        Sun, 13 Jan 2019 19:56:44 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id l70sm93582741pgd.20.2019.01.13.19.56.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 19:56:43 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH 3/5] dt-bindings: fix incorrect bmi160 IRQ note
Date:   Sun, 13 Jan 2019 19:56:19 -0800
Message-Id: <20190114035621.5252-4-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190114035621.5252-1-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

The bmi160 bindings say that the BMI160 requires level-triggered,
active-low interrupts, but it actually supports all interrupt types, so fix
the note to reflect that.

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

