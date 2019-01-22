Return-Path: <SRS0=dXrR=P6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6797EC37122
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3702D21841
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="dwuZqCQs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfAVCEs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:04:48 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36304 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbfAVCEs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 21:04:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so10285906pgm.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 18:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AoooTCmjZ5+hUnrheSFS4kgpOtp0NBQrzyp55jolc5Q=;
        b=dwuZqCQsZawaLUa3kw+sSM1yddHKcNSfgi6uyOZEYjU8ISOt/pg5v+yeJ6AQqFbgyO
         WAcwpuxoQWdSThbiHMYNP+KiiEM8sUjM1Wzt4qap32odHxp2u9QgysaQu/LrTow7ZkOA
         RrM3qJ2Mt/G9ZidrYNft152bBXz071Otfq6B1HrsOO4eEVgftq35vLEWtX6dJhpuiRAo
         LDwWG8qGb2DYfQHh8Q5UCCx+3hxqFJGC/NH5IdGzQVMJ2eq9ecZHI/4ya9l7i5AxTHmQ
         siti7sZmxliRWoFmxBT/tJkXRV41gj03YbiJ9sFENMTI+Rw69r51+w7+dzGkUZn8LCXn
         i+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AoooTCmjZ5+hUnrheSFS4kgpOtp0NBQrzyp55jolc5Q=;
        b=pnjscpT3YL9SC/b5yfucfCbxBOi4OqWkX91ti7TYF7YtZlxfTZ253ey836NukYV2f1
         KGp12aEX5qJZLUFL/jfTg0bqSQeqsQ8GFdPKuzhx9P59fcPMJDEF9zjQ7MOy/4H/UTJj
         6MJMHT6WaebBqXiFG+yMi8pRAlh46CfrT393jAIJzhNFvPKN1ZwVx1YH1jhq6hDd7gP5
         1YDlSkYWjtZ7w2T15EF1VIOQgRN7pPCz5ou43RSHg2jgse3yblrarKZZ9jHhLlaVPfEQ
         u0+4TPpH5YQlJiLgufAaGz0v4lArV74GLl3A7ot2g33CQVU6qZMwu+9O4HRcsJSfDrD5
         YIow==
X-Gm-Message-State: AJcUukdFoRaZYZ1wLcPVf00CBoiNP8iTBXsocfPzvSyedfCgXX3OHf+Z
        z8ox8d13xiwWu374l1O7d6TojYW/noQ=
X-Google-Smtp-Source: ALg8bN7Hp9awGnxLt8iunNVeXUVnGOll4TrqrhDRNOfRqA+lsEb/TvC5MzKsemn3wdAq7I0jcFqLjQ==
X-Received: by 2002:a63:a112:: with SMTP id b18mr30401698pgf.440.1548122687498;
        Mon, 21 Jan 2019 18:04:47 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id n21sm19759404pfg.84.2019.01.21.18.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:04:46 -0800 (PST)
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
Subject: [PATCH v2 3/6] dt-bindings: fix incorrect bmi160 IRQ note
Date:   Mon, 21 Jan 2019 18:04:28 -0800
Message-Id: <20190122020431.5338-3-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190122020431.5338-1-martin@martingkelly.com>
References: <20190122020431.5338-1-martin@martingkelly.com>
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

