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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E90EBC4332B
	for <linux-iio@archiver.kernel.org>; Fri, 19 Mar 2021 11:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B520864F7B
	for <linux-iio@archiver.kernel.org>; Fri, 19 Mar 2021 11:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhCSLCV (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 19 Mar 2021 07:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhCSLCE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 Mar 2021 07:02:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194CEC06174A;
        Fri, 19 Mar 2021 04:02:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x26so5622091pfn.0;
        Fri, 19 Mar 2021 04:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/u2CPhZ6rUOBCIUNBfUVUJzsOfzYQHrAipQY//P3glw=;
        b=M6FbohQN6QUpKcRcTQtXxctZgSYOg32ch1cIus2E17bA6hd2xMpvKdX+ycavaIlFrQ
         S+GGz2U7BOzk1dN8RRwOMWr4NW1le+2dEx3EJkSuT762rwIHCmfuZiPiUSSwfwsmlPKE
         F4laZsH/rzuyYlmfMPUIDbKkeXatKqP4COm8b8+OABaJ6SVK2xf5PhXJ80QdsLr1bgU5
         zmXn8NsMzlZXTh5Alnf7Cxx5q3QsZRa9asMPdJI0gGzl8lJLYTirsH6rPEpTf5aiyHTZ
         367j4q8x1MDEYISdNpkXK2Ku7ldTDQx08nNoeuMV2+bhDryD9PGEl5C7dtQIfbmKcQ2Q
         g04Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/u2CPhZ6rUOBCIUNBfUVUJzsOfzYQHrAipQY//P3glw=;
        b=hXdPPd+PZ7+EUxHasmVp+NEQNGFjsYnyxdupqx2NEDL6xWUONOLSF0XIMaaqcZNwYy
         nzrs8202lK14ixPGLMehojnV6OgS2ZwqjGvGb39YRt009GWHTmwY/75V+CHIM2EBdYSP
         0BYw7HQzsmJ24Z5eilS4M6UzSD3x+kF9g8omLK5krqBdRzomm7SQIqcj59NPYekuT5p+
         Pv84kwCq3n85CT/O5q6D24O/0gOciEJedckIEA4iGorWGlBPT5cTvWC1Q5+SnrIY5nFe
         pckCArf8UAs0KmpDmrQqyidZ5O2gl03bx8XuYuY81Dy63MSSQ8wegn4Ar+WQMMY7YSVx
         spvA==
X-Gm-Message-State: AOAM530Sm6mR71jb6UI5o/WTnBeJ+tnefrRep4XXulHVhOBCdQSCVwv0
        m73al6y1n69kkcD6bmLtkkg=
X-Google-Smtp-Source: ABdhPJzoGuapduW8n7o3efs8G9ZXNqL+hMHW/rmBLdctPnuOUR+alBxNVTO0yFqiValIFXrVtJS4aA==
X-Received: by 2002:a63:3705:: with SMTP id e5mr10731684pga.318.1616151723687;
        Fri, 19 Mar 2021 04:02:03 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id i22sm4879042pjz.56.2021.03.19.04.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 04:02:03 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kernel@pengutronix.de, linux-stm32@st-md-mailman.stormreply.com,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v10 12/33] counter: 104-quad-8: Add const qualifier for actions_list array
Date:   Fri, 19 Mar 2021 20:00:31 +0900
Message-Id: <92caedb694b4c66d9a5e9190f8c4545ae28dd418.1616150619.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616150619.git.vilhelm.gray@gmail.com>
References: <cover.1616150619.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The struct counter_synapse actions_list member expects a const enum
counter_synapse_action array. This patch adds the const qualifier to the
quad8_index_actions_list and quad8_synapse_actions_list to match
actions_list.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index ae89ad7a91c6..09d779544969 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -305,12 +305,12 @@ enum quad8_synapse_action {
 	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
 };
 
-static enum counter_synapse_action quad8_index_actions_list[] = {
+static const enum counter_synapse_action quad8_index_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
 };
 
-static enum counter_synapse_action quad8_synapse_actions_list[] = {
+static const enum counter_synapse_action quad8_synapse_actions_list[] = {
 	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-- 
2.30.2

