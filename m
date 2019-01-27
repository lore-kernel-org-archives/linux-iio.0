Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC87C282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D352133F
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="s8h8/jKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbfA0Ukh (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:40:37 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38088 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727158AbfA0Ukh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 15:40:37 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so6815611plb.5
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A5S4IBP0wL4Wp45lAk4Vx9FHPG78i64RpUvUAmANBbM=;
        b=s8h8/jKl6W5Mvm24agk7iAbRl6eAcO75QPFbrhHeYYqSa9Wyxiga6lUDjL1/7vjT5K
         yIOKQ/qTmFfydpubC9EWCJgbeePNwEdmKcmVsekave0ZL5ukoh2Irp30dnE0xw3PWG0s
         u9cNMQTr3RUjLFjbOnQIVDJT9sZhugv6tdwaSGsUoslkceQqXW8iPss7iK9znduWrlP7
         Le3iPJSlI5F6DGuvP4vkwfpfXZ3CVlPxCqAowUHLWxyysL4rjKIR9LF+gwt0Ls9ePej8
         uL8KdcTzSQBDixu3sXjwM42UxgLahyCb+ljjcITbuVm+PwGtB1I5+y/OHcU7+WlNar1w
         rkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A5S4IBP0wL4Wp45lAk4Vx9FHPG78i64RpUvUAmANBbM=;
        b=jceojRYdug+mi5Uv1Yx54OwZ4s1unAdNAF0XGGXf9r/zbzEaBS0OeLAvHd7a059Que
         8T3Kad40gHbVvBGMXYGxjT2XaCASsesrkXXbOf2YJDOHLDHUlLrsXbkeQ29uG+w8ZbVZ
         ovow6ncEDtBOE84Tnc8o47TqJJEZv7z3A8lz1hGQ9HG6fcA788aIXmQThm31R27B5kdE
         Q4iOS9DaFCxT+0717Fow/b4diAQ9gVesc+NvXKOev+CjVuFZxOcGKlsGh5Ql9XR4TGK5
         nptAi4OnVel0HDxgBhDtp5HA6ZoKb9Jq5slIbrTRgOX2QAOgA6oX/0rMCxr4yQO0U0gx
         ocuw==
X-Gm-Message-State: AJcUukcE9xDQsvnFGIIkBNyyCBQpMkINCi6eIMNuAT3Rou7fQUT/LYCw
        h9KECZ3R+gJ9plsgWj65qY4pBL8hWUMvWQ==
X-Google-Smtp-Source: ALg8bN4kiCeI2pkg8OfY++O3ikUidvIMu/2aegWr/IUFSJ4If8vHySsaxQjU3lTTOPPgOChHBCPO+w==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr19279959plj.116.1548621636158;
        Sun, 27 Jan 2019 12:40:36 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id a4sm33049912pgv.70.2019.01.27.12.40.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:40:35 -0800 (PST)
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
Subject: [PATCH v3 4/6] dt-bindings: document open-drain property
Date:   Sun, 27 Jan 2019 12:39:09 -0800
Message-Id: <20190127203911.8696-5-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190127203911.8696-1-martin@martingkelly.com>
References: <20190127203911.8696-1-martin@martingkelly.com>
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
index 1aec19997fb5..7eb4b6016404 100644
--- a/Documentation/devicetree/bindings/iio/imu/bmi160.txt
+++ b/Documentation/devicetree/bindings/iio/imu/bmi160.txt
@@ -12,6 +12,8 @@ Optional properties:
  - interrupts : interrupt mapping for IRQ
  - interrupt-names : set to "INT1" if INT1 pin should be used as interrupt
    input, set to "INT2" if INT2 pin should be used instead
+- bmi160,open-drain : set if the specified interrupt pin should be configured as
+  open drain. If not set, defaults to push-pull.
 
 Examples:
 
-- 
2.11.0

