Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C033C4743D
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 01:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270AB61027
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 01:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhFIBfL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 8 Jun 2021 21:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235691AbhFIBfG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F27C061789;
        Tue,  8 Jun 2021 18:32:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2723713pjx.1;
        Tue, 08 Jun 2021 18:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrquYkvxwwxaQpkei8svMskXgimhFQ45B33xBG8Z/x4=;
        b=IqBtJ7TBH5T+FDg/B2YXmXc8Fl+/QP9kZ4QjcS+30KTAuNuvpZneMez8fxV/jWTCWE
         mGYXtaQZsZb/Gk5rwrji15SrSNxCwBMCYF7BBYs3Q0HuURNiNc3ExBYk3+EkFKegaNP6
         RFTKR9dNSu7kXFyGPDFEjEqujqzIA3kSL8prTA1gbCbKDLQQzxI1fTrGqdVTbGFuCzH0
         skqeyZcMG4IqGANLsmnODTSHf0YM0nr0Af9XXJwvOrDr2/aQxX6jwjCMZMriVZVxOfMA
         XC0uk0Y+CFQ+NwhTGxbFtYWYy6CIYCsPvcB9SpiRz9UUoolce6ciK5uPH22fUNIv3Nwb
         tS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrquYkvxwwxaQpkei8svMskXgimhFQ45B33xBG8Z/x4=;
        b=nJEZoQ4vGWsv1E0fmDrkMRljOigJJVEHDDyePIt8SAoB9zzUCOdCg2dVOxqBBkH81A
         7tWq1WnuYsa/JibQTcbY9yjpJ0q+FFBCCOBurKNinSm72tBgFPVmOY2zDrMtSS4Gim4l
         WY3WpLu2X7ibLlkRCUgE3ojRHbY2yAZ3jxgmrozYZ0YpxFsRLzCSSiicMs/MULd2NQP9
         b7BQalpJQild2+PKptkchtUzFsEoT7rSEEU9n4/MUtQ42yZIgIIIW1A5mGM41TdrLBFR
         3nR20OQep3myKKSeqHvQwwpzpeC5qjXu6F40I4dYwNVsWiodv/raQm8RkM9MxzDb4faL
         guLA==
X-Gm-Message-State: AOAM5329wnvyp4zl2uvQgNcBGbZBQdNH/6LkE78I6s8xKwfYG+fiCr5G
        IYm/C3vpXqZC2W/11+fax9Q=
X-Google-Smtp-Source: ABdhPJxT4r0FYvKTngF67u27Oof0BX5/ssfdITgfV0FJKdbRWz8BLhe1PBwfeNXI5kWQx9cRCrKlhg==
X-Received: by 2002:a17:902:7c92:b029:111:2ca8:3d8e with SMTP id y18-20020a1709027c92b02901112ca83d8emr2569557pll.77.1623202375667;
        Tue, 08 Jun 2021 18:32:55 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:55 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v11 13/33] counter: ftm-quaddec: Add const qualifier for actions_list array
Date:   Wed,  9 Jun 2021 10:31:16 +0900
Message-Id: <db1df2021efb1b98e6d1a50787be5a52a1896574.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
ftm_quaddec_synapse_actions to match actions_list.

Cc: Patrick Havelange <patrick.havelange@essensium.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/ftm-quaddec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index c2b3fdfd8b77..9371532406ca 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -162,7 +162,7 @@ enum ftm_quaddec_synapse_action {
 	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
 };
 
-static enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
+static const enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
 	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
-- 
2.32.0

