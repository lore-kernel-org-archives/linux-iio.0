Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D790BC282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9EFC20856
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="JQOp6EZ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbfBBV40 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:56:26 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46637 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbfBBV4Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 16:56:25 -0500
Received: by mail-pg1-f196.google.com with SMTP id w7so4585209pgp.13
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 13:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F8in0vy/Hvy6LyQX0+LUelBgBHeVg6+YK/wgYarwERQ=;
        b=JQOp6EZ4X0iqxdBXqrL8DgqlNnHeBUHKjSJCDLXG0IhyzqLRESEDjF3lsEEPnvQwqq
         un1McS8j2YXKYkjHrwQBtKhPIW+CMBJ7qIbhzkyANq2cXFRZ9dz8hzK+QFdSKNZjbsG1
         xKLNVnlw1n+NDBCSGc8fWTyF9sw1eIgy+ZArisMXSKg8BcPr7+YPwu3w2o2vL5mA4J2y
         /sgeipeooskVQ2bajHELPY6QOFREcRL6K8D8yk1q2dkXPSjCHcTcuUr4gSefrzheqph1
         L7vqkSOKX1Fmmf0ddsgRDWtCs685VAu9KDDXP/ZDZv1+5GJHycO7MkoV6nGCfwHewMTZ
         EqSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F8in0vy/Hvy6LyQX0+LUelBgBHeVg6+YK/wgYarwERQ=;
        b=cCa0Sw+XzaEYKlPiKjqCGqeg62qqk++W3m2V48WRGsnaTmdTgc6BYV7MdqrjS7Haco
         O4WnIp56asCHz2JeRa0uREwR9EWYIYMG65C9A2V5bIO9wx7J1H0mQbVYjuT1nAMURv4H
         EqcnZlpmfyivObWSX2NT66XaDIX+qFrbMEAydifSc2a5k4WybeUJjfvXQbFx9XmVGEX4
         5tWTnrMpnoWTdpOc8Y9al6VeYYPZgFLGQf7wviIxWeB3F7kmqBEQ+QfxWDXlBXcyPrXn
         6wThkdDdjjdpDX0tUc9O3Klib3MbSZi6Cu49s/HnCnwXv0JBPKC8XXS2WjvL4TpREF8m
         6EhA==
X-Gm-Message-State: AHQUAubdLb4V2Sk+QVBRCqozMyBTNVTYR70a8zDjv3uFIAPRBsjOJ8C9
        b67SBGE1pp4b1chwFSNXlWV4cEbIvAI=
X-Google-Smtp-Source: AHgI3IbxssVlQQednHWm0F3HHqziV+NAMKLSSjropUtV+6x8wXDogk+ahRhLgNIL9Y8n4CWkCMbbVQ==
X-Received: by 2002:a63:170c:: with SMTP id x12mr7306442pgl.364.1549144584730;
        Sat, 02 Feb 2019 13:56:24 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id z127sm20082025pfb.80.2019.02.02.13.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 13:56:24 -0800 (PST)
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
Subject: [PATCH v4 4/6] dt-bindings: document open-drain property
Date:   Sat,  2 Feb 2019 13:55:59 -0800
Message-Id: <20190202215601.20275-5-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190202215601.20275-1-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

We have added an optional boolean property for configuring a BMI160
interrupt pin as open-drain, as opposed to the default push-pull, so
document this.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 Documentation/devicetree/bindings/iio/imu/bmi160.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/bmi160.txt b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
index 1aec19997fb5..900c169de00f 100644
--- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
@@ -12,6 +12,8 @@ Optional properties:
  - interrupts : interrupt mapping for IRQ
  - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
    input, set to "INT2" if INT2 pin should be used instead
+ - drive-open-drain : set if the specified interrupt pin should be configured as
+   open drain. If not set, defaults to push-pull.
 
 Examples:
 
-- 
2.11.0

