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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AA7C433E0
	for <linux-iio@archiver.kernel.org>; Wed, 10 Feb 2021 09:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E9164E45
	for <linux-iio@archiver.kernel.org>; Wed, 10 Feb 2021 09:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBJJAB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 10 Feb 2021 04:00:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhBJI6A (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Feb 2021 03:58:00 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C64C0613D6;
        Wed, 10 Feb 2021 00:57:20 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id h8so947504qkk.6;
        Wed, 10 Feb 2021 00:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OoimW8Anzh7AZNF2nhGinlyqpBaLV8iOgdqMVVRLSk=;
        b=QEvYlMbBQBr56sHwTdsVP0oI40cP0vXkTPNFlHPYPJIlP90lhgxJx25XCz0pjiuWCD
         nAuIh/HKbB3I0w+/9/ltHXod02AXzHcH3ylv9Wh2Ocpvq+gNQ9uKYQ9PW9uJKHuytTop
         dUp8T+rGucuoUemusIdcUQSdK7zdtJ8+KAp5UqOsmHuDDeZpkeK9gF4hxkbdcR4Nx/cQ
         jBdcbSaarktXdGXxcY+Y7/+Pbn5JwFr59kwAF00U5qO4mPfVxIos1oge8nJG7Lhan7DS
         gou5OZFOJBzdbSVkLu+7zYz90ZHw4TSg0UitQaVheRM22tY2yx8DFBbqmTaBIB6pDivB
         jZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OoimW8Anzh7AZNF2nhGinlyqpBaLV8iOgdqMVVRLSk=;
        b=o5mT18Y3ziEkhBszJCqvS6MQBT0chmg+jWJhVa03qA+uwyl3jQfeXfL/xDV0sNg0/c
         OE62zJx9h+zXnahGtnahF2P2JgNEEpk5egLqi/Fmgc6Z7LuTzALaYEal7FVqsdwi2W2B
         SVT1hjUdkhohK5CPk0wcwY9priHP06sIYbosy17xi2UhoyQiBSL7ADlPg1FksunI2GP9
         UDLlHpuRs1OEVxHJmmHfWGnClEDUbbqXNRDO6+wnt0emmtWa3uN7rpTu6SpxVBUYbv6t
         VyXrkere/1X8ZYER7EsAG2fJ5dXty/SJU98VhRi2nPDR0nrJbH4fnBJmVfPD6KhXpYXk
         g8Hg==
X-Gm-Message-State: AOAM5329MK5YHKSj1i5Wxpb8Y7HUomA5g9eGPLiXk8sBUK8d67wABthD
        DpIO1SFXKWSUoGptDCn88ts=
X-Google-Smtp-Source: ABdhPJzt1sZ6RLxyFQLnU6/7b18fb7yVpdqrJmtYd1oU7e02gEQ5+nlauN8VeTiAdWp2LwkNZGhb8g==
X-Received: by 2002:a37:a68a:: with SMTP id p132mr2332645qke.26.1612947439780;
        Wed, 10 Feb 2021 00:57:19 -0800 (PST)
Received: from localhost.localdomain ([156.146.37.177])
        by smtp.gmail.com with ESMTPSA id h12sm1014120qko.29.2021.02.10.00.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 00:57:19 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        alexandru.ardelean@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] drivers: iio: proximity: Fix a spelling postive to positive in the file sx9500.c
Date:   Wed, 10 Feb 2021 14:27:04 +0530
Message-Id: <20210210085704.1228068-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


s/postive/positive/

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 drivers/iio/proximity/sx9500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index acb821cbad46..67353d33af94 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -758,7 +758,7 @@ static const struct sx9500_reg_default sx9500_default_regs[] = {
 		.reg = SX9500_REG_PROX_CTRL5,
 		/*
 		 * Debouncer off, lowest average negative filter,
-		 * highest average postive filter.
+		 * highest average positive filter.
 		 */
 		.def = 0x0f,
 	},
--
2.30.0

