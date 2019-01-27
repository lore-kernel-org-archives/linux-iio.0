Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C4EC282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90C5E21473
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="MtAvwxqD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfA0Ukg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:40:36 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39013 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727031AbfA0Ukf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 15:40:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so7051696pfc.6
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 12:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AoooTCmjZ5+hUnrheSFS4kgpOtp0NBQrzyp55jolc5Q=;
        b=MtAvwxqDbMzJe6Dj4pzPXllkyqtiwXJ9l6TUCGzYocH5Ra+LeuEpX9Cclv57CIp5XL
         9sFKnmb144oDZMyclQf5bDsfMnPTychxCB7XFyUTiyLWV5/bChW7Y3OmsvRa90ch68G7
         9DkC5rKpfbMRSG1r3E5gmGNb0SxuxjYiD/Wb5qtnm5cZ3Pf5Upn864CnSNpkAHj9hG3G
         zHOv9ngCMW7fqZRd3PGSpJFeOau4cFiVoRcdw0MBoraG+vY7qxK04HrfnMO0D/C15ieZ
         3Z5RKQsHleuczMiTcE1pDSspnigJnA2ZEFYLXnP+ZKj8UErSkZV6AuLLcnmwxMYnfLhg
         ZhLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AoooTCmjZ5+hUnrheSFS4kgpOtp0NBQrzyp55jolc5Q=;
        b=IzSOkrrHasYUDlJkCDmq8zHWtDvaHGcmbWinYCmpWlJ44hvQNL24rcQL9+eSY2xL5U
         oz/uOeG24qm5bTzrFh2DxyDn9O49HytRHng7ixhSWg905XKUINUHMKHCNFi6zxKKERy8
         y7drQNnK8SrjRPJXPwWYAmIE8umESl7Pbz5UoX0iZhliAsg6PEDnqSCSu5131opFbq/w
         1+HqMaoteA/19ZEFboxNcTzl+PfY94L9XGRwup738smDPxXW4XOWS3qkrSb0HltaAWkP
         do3WQAgw5mgrYwJXcMSU8gDzbQcwXnrQTIQjf+pbZArdoJh7rZ6PR2OWrtySxU64RSFz
         zCKQ==
X-Gm-Message-State: AJcUukf+E47Fh0zh1ZGAofHYZcr9ltKXsNsveBLExuCDUBAz8zw8kCph
        JHQZnPCqDdGcrcAGLRQd2r8KOMO7S4wDHw==
X-Google-Smtp-Source: ALg8bN77peA/I73D5k9K6hsf30y2Cpe6oiOEl6L/KOve6XpEOmAlA+D86OVd6B5vEeytahpxXGa9RQ==
X-Received: by 2002:a63:4a0a:: with SMTP id x10mr17438771pga.237.1548621634676;
        Sun, 27 Jan 2019 12:40:34 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id a4sm33049912pgv.70.2019.01.27.12.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:40:33 -0800 (PST)
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
Subject: [PATCH v3 3/6] dt-bindings: fix incorrect bmi160 IRQ note
Date:   Sun, 27 Jan 2019 12:39:08 -0800
Message-Id: <20190127203911.8696-4-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190127203911.8696-1-martin@martingkelly.com>
References: <20190127203911.8696-1-martin@martingkelly.com>
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

