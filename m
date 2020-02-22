Return-Path: <SRS0=IaIx=4K=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF2EC35673
	for <linux-iio@archiver.kernel.org>; Sat, 22 Feb 2020 22:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BD220702
	for <linux-iio@archiver.kernel.org>; Sat, 22 Feb 2020 22:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="iMq69yFM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBVWqQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Feb 2020 17:46:16 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:46990 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbgBVWqQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Feb 2020 17:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vy6hpE4agJvyBp7yQszSziWr+f3Y16DYRa3kDS7Vz/c=; b=iMq69yFM+ytAbbyRMVS5o10Nku
        ZueuE3FLQsx9HAZGdAo8iuiBaQOSrbx0nBDvRNVKBxQ5HCzn7F0i1y3ArS7VyflxXGqCQWf4snbEI
        gNYCFkK+KvflY+TY192rcNkeISzyTmk9XkB4i0BIN2TVPKrpJsSJzPmLLEWSAtmBKOik=;
Received: from p200300ccff354600e2cec3fffe93fc31.dip0.t-ipconnect.de ([2003:cc:ff35:4600:e2ce:c3ff:fe93:fc31] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1j5dXG-0007uL-Ha; Sat, 22 Feb 2020 23:46:10 +0100
Received: from andi by eeepc with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1j5dXF-0002ys-W1; Sat, 22 Feb 2020 23:46:10 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, phh@phh.me, stefan@agner.ch,
        letux-kernel@openphoenux.org, martin.blumenstingl@googlemail.com,
        jic23@kernel.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v4 1/2] mfd: rn5t618: add ADC subdevice for RC5T619
Date:   Sat, 22 Feb 2020 23:46:01 +0100
Message-Id: <20200222224602.11413-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200222224602.11413-1-andreas@kemnade.info>
References: <20200222224602.11413-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This adds a subdevice for tde ADC in the RC5T619

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
depends on:
https://lore.kernel.org/lkml/20191220122416.31881-1-andreas@kemnade.info/

Changes in v3:
re-added it to the series because of
"Oh, it looks like there was a conflict.  Could you collect any Acks
(including mine) rebase and resend please?"

 drivers/mfd/rn5t618.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 073de8e0e78b..321836f78120 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -24,6 +24,7 @@ static const struct mfd_cell rn5t618_cells[] = {
 };
 
 static const struct mfd_cell rc5t619_cells[] = {
+	{ .name = "rn5t618-adc" },
 	{ .name = "rn5t618-regulator" },
 	{ .name = "rc5t619-rtc" },
 	{ .name = "rn5t618-wdt" },
-- 
2.20.1

