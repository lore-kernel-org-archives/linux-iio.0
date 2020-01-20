Return-Path: <SRS0=URlP=3J=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BF1C32771
	for <linux-iio@archiver.kernel.org>; Mon, 20 Jan 2020 21:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3CE22527
	for <linux-iio@archiver.kernel.org>; Mon, 20 Jan 2020 21:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="AveaRX7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATVVT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Jan 2020 16:21:19 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:38586 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726897AbgATVVT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Jan 2020 16:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=qI/5dEJnoRpJ6a+p5KqjUs4RogAXl64fcQgcmH2ETkI=; b=AveaRX7I0CcmbuGLGj36B+qJE
        4driXHWA3O9ZJ5l6qX2IXPYmaAIA5q7h9n//yi/jbv9MRht0dSf6a7UCDqXMqaOgNVwU/frm3oxAk
        jraTp2b9tnYpBDK8Z+bQAUSU+T2xMUvoENJYfpoOtJwde4sCGFUdOup6+kYKz+osVs9yU=;
Received: from p200300ccff0880007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff08:8000:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iteTo-0006vn-4A; Mon, 20 Jan 2020 22:21:04 +0100
Received: from andi by eeepc with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iteTn-0007WE-5p; Mon, 20 Jan 2020 22:21:03 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, b.galvani@gmail.com,
        linus.walleij@linaro.org, andreas@kemnade.info,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        phh@phh.me, stefan@agner.ch, letux-kernel@openphoenux.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH RFC v2 2/3] mfd: rn5t618: add IRQ definitions for RN5T618
Date:   Mon, 20 Jan 2020 22:20:55 +0100
Message-Id: <20200120212056.28806-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200120212056.28806-1-andreas@kemnade.info>
References: <20200120212056.28806-1-andreas@kemnade.info>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Previously, only the definitions for the RC5T619 were
available.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Untested, IMHO only acceptable with a Tested-By

 drivers/mfd/rn5t618.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
index 321836f78120..6828fd40b0a1 100644
--- a/drivers/mfd/rn5t618.c
+++ b/drivers/mfd/rn5t618.c
@@ -58,6 +58,24 @@ static const struct regmap_config rn5t618_regmap_config = {
 	.cache_type	= REGCACHE_RBTREE,
 };
 
+static const struct regmap_irq rn5t618_irqs[] = {
+	REGMAP_IRQ_REG(RN5T618_IRQ_SYS, 0, BIT(0)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_DCDC, 0, BIT(1)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_ADC, 0, BIT(3)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_GPIO, 0, BIT(4)),
+	REGMAP_IRQ_REG(RN5T618_IRQ_CHG, 0, BIT(6)),
+};
+
+static const struct regmap_irq_chip rn5t618_irq_chip = {
+	.name = "rn5t618",
+	.irqs = rn5t618_irqs,
+	.num_irqs = ARRAY_SIZE(rn5t618_irqs),
+	.num_regs = 1,
+	.status_base = RN5T618_INTMON,
+	.mask_base = RN5T618_INTEN,
+	.mask_invert = true,
+};
+
 static const struct regmap_irq rc5t619_irqs[] = {
 	REGMAP_IRQ_REG(RN5T618_IRQ_SYS, 0, BIT(0)),
 	REGMAP_IRQ_REG(RN5T618_IRQ_DCDC, 0, BIT(1)),
@@ -92,6 +110,9 @@ static int rn5t618_irq_init(struct rn5t618 *rn5t618)
 	case RC5T619:
 		irq_chip = &rc5t619_irq_chip;
 		break;
+	case RN5T618:
+		irq_chip = &rn5t618_irq_chip;
+		break;
 	default:
 		irq_chip = NULL;
 		break;
-- 
2.11.0

