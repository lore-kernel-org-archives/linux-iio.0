Return-Path: <SRS0=AGAg=QZ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB0C43381
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86ABE20851
	for <linux-iio@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="lPdVLPON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389726AbfBRODx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:03:53 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:32771 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389759AbfBRODw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Feb 2019 09:03:52 -0500
Received: by mail-ed1-f67.google.com with SMTP id a2so13947289edi.0
        for <linux-iio@vger.kernel.org>; Mon, 18 Feb 2019 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
        b=lPdVLPONMX15tVFEdOGTWdO0qWE/4jq/BAze0ALMLuA0nMhYdTscqDSDouBdQJMKI+
         9P9j1Oo5wGvSlAFqwJ5MbsxrTSd68gxajlZug9ZW4tzsNll+n461GjbggeOeqUQpgDm7
         W1pyYQRMbpuwsNn1TXoxIgHxqzMBLkEm6z/Mm2OFJDHKy3mdBVweK2p66YcDrrpeiyKy
         popuvplA8CMeHuToUOieTP7qkuHWUthsRGN5rVdQwprYyfywzPhUboAT3lTaCfKDFUXD
         GZCmTGPgJsVS9ZBLdp8t6SAGMuf9SNrpjtxDkSgWKiN8DRRDgz3mzZ/37doMnbxznzr/
         OTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kDOvI7KHRas/e++nV1MAoAVesXibxebovw6lFI3t2LQ=;
        b=IDZdy40S+oJq4dhQN/HOxuAz0l5NIfjsHwhJxhJge2LAMD+dVLllavStEOgYXYVOHY
         tZGfAGpW9rPDZxJH8WKHLhxgc/R++NHru03mfVERiJMbCY+E2WOTwM7navT+llJomslS
         jfTjvZqTtRW7JyzHlLwm8zZO5bd6OvgHgDRTLAea5TaOTYQzyypdtR9G+ivKkLqiJtS4
         rZfKmXDDyeX2y647xKqPxopiPtuduq9IidJNTQuUzBhhMiAU7ZbE45gZzCk4If5j8RSD
         MP0BC/CviuB6n+L71BJZpouFxvS8Si4qQG737HxBVMkLGrauRh/X3bz2yiZxJIUIT97s
         53aQ==
X-Gm-Message-State: AHQUAuayCWlfX4VGAvWUQ4Ijkbj23hc4z/MB7vZfxW0q2dhYTa8kA9t9
        cmtv6mlYAowEVG0FGwk5NZUFHg==
X-Google-Smtp-Source: AHgI3IZ8OLgKjAeX/g4O2478yycvuHIzPgfc0uD5abEOkLT1aY3Iky8/UzyD7nuf/AReqmoOjyDzEw==
X-Received: by 2002:a17:906:791:: with SMTP id l17mr13001446ejc.1.1550498630266;
        Mon, 18 Feb 2019 06:03:50 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:49 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 3/8] drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer #defines
Date:   Mon, 18 Feb 2019 15:03:16 +0100
Message-Id: <20190218140321.19166-3-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 drivers/clocksource/timer-fsl-ftm.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/clocksource/timer-fsl-ftm.c b/drivers/clocksource/timer-fsl-ftm.c
index 846d18daf893..e1c34b2f53a5 100644
--- a/drivers/clocksource/timer-fsl-ftm.c
+++ b/drivers/clocksource/timer-fsl-ftm.c
@@ -19,20 +19,9 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 #include <linux/slab.h>
+#include <linux/fsl/ftm.h>
 
-#define FTM_SC		0x00
-#define FTM_SC_CLK_SHIFT	3
-#define FTM_SC_CLK_MASK	(0x3 << FTM_SC_CLK_SHIFT)
-#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_SHIFT)
-#define FTM_SC_PS_MASK	0x7
-#define FTM_SC_TOIE	BIT(6)
-#define FTM_SC_TOF	BIT(7)
-
-#define FTM_CNT		0x04
-#define FTM_MOD		0x08
-#define FTM_CNTIN	0x4C
-
-#define FTM_PS_MAX	7
+#define FTM_SC_CLK(c)	((c) << FTM_SC_CLK_MASK_SHIFT)
 
 struct ftm_clock_device {
 	void __iomem *clksrc_base;
-- 
2.17.1

