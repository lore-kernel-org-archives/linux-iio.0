Return-Path: <SRS0=AU7e=RJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC2FC4360F
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 11:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B799020661
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 11:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="guHZcbpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbfCFLNB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Mar 2019 06:13:01 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36733 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbfCFLMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Mar 2019 06:12:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id g9so9989785eds.3
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2019 03:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cDSuoyKdNV1HV5DOgGi6pj2N/BJT3JWfpiGnrduNvUU=;
        b=guHZcbpBM7nvUcaZ6yVNVW194npw7ZDkaCs6IDJ/YAGhiSft9/UWwaATplFk/Y4Hd3
         HzYmIYIFBtjWG5uQVqJnl5fA+FH1ft3rBfGfonIraRKRjLPS0b59lUftY0G234rmRPsS
         8EfdQtHuSGKEi9SGFEHCekmLSrEaoOVtN9aai5C6VLjLolPid1GfIdXZgfpk7flXPQ7m
         W2KyD9Mdfji0CuW3VD9R4KTc+8BfIUcpSz6412Ez2P00vw4CUce94ZzCt02NtwpRLOTf
         AtBsPfLsCzOEod6NYuFJi4rGd2sHbSdqUHiAsSsrb7BXb+ZDTvSSXZeao3IdfCyncFDb
         KkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cDSuoyKdNV1HV5DOgGi6pj2N/BJT3JWfpiGnrduNvUU=;
        b=jvwoKWXO949bE9FzQ3zwFha0oFv/R2o8KsMsWComLOZ0ZuxuXmaYeEieVnhmfiec0P
         qyPsSNaeq6eQblGjkbEm8qJsuoVd8VuErmgFsu0jvU42ETfEdQtM8pZ7HdFWa2KuDvAJ
         zmWItofqF4EARhhB2QMVGDr1KaS8Sn9DTLOmZK6br/T08NHlsVbmlSbnEehUxgvMFJOy
         AemN5fV7uxhay77UdtYa+DNawaSogF7kcM9gz8Cwfk8X6rGDUtKHxXGY6g/pcmq7byGK
         WnDHwKFEqGnVas0JFTkkH+Snm+Yp4X0zNHilYzE+6VjJxVJUWWQdy2tVKnbbgwySoIxp
         hMuA==
X-Gm-Message-State: APjAAAW/cITWBox/fr1/XEPATHhhVeLXQEf4rsI/3lGIqCH72lWLQs2m
        bC515yN7ZJlQPW04XdwYy3Gbiw==
X-Google-Smtp-Source: APXvYqxy3t4cZ+G/kwi2CriFtp5sfmhj9QiM++r4mVpAGkRt16u6ZgmHIwrc9WwxsbWYeGbi/hInpg==
X-Received: by 2002:a05:6402:1490:: with SMTP id e16mr22862133edv.201.1551870751292;
        Wed, 06 Mar 2019 03:12:31 -0800 (PST)
Received: from ph-ThinkPad-E560.local.ess-mail.com (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id t25sm277879ejr.30.2019.03.06.03.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 03:12:30 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH v2 3/7] drivers/clocksource: timer-fsl-ftm: use common header for FlexTimer #defines
Date:   Wed,  6 Mar 2019 12:12:04 +0100
Message-Id: <20190306111208.7454-4-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306111208.7454-1-patrick.havelange@essensium.com>
References: <20190306111208.7454-1-patrick.havelange@essensium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Common #defines have been moved to "linux/fsl/ftm.h". Thus making use of
this file.
Also FTM_SC_CLK_SHIFT has been renamed to FTM_SC_CLK_MASK_SHIFT.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
Changes v2
     - None
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
2.19.1

