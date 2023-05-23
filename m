Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BFEDC7EE26
	for <linux-iio@archiver.kernel.org>; Tue, 23 May 2023 15:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237151AbjEWPNS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 23 May 2023 11:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237477AbjEWPNJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 May 2023 11:13:09 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE239E43;
        Tue, 23 May 2023 08:12:55 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 40781C0018;
        Tue, 23 May 2023 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684854774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wyrbVwxZ0KTdJmelqko+tUdutg5HmqXXq7T/rn7OWng=;
        b=EBpNWx/8LcFOktzb/W/4ZB5ZW9iPWLEYoo9hpOU2o5gxHr7fzxt9ecSz33yHx/0Or82Un7
        G7WTwex35OTs3Ydmuwv/GHXCM2fZ7NVPyxKLIaiXEX0WSU5pdrxe15H8feq5tkB5mA6okY
        Bob3oDS6NogidlnIGqFHA5U2bhdthUhj+xwEjEAHCbPBWC0I+vTscCosqMjTF2ZJLKYONm
        TbF+yjcNp86S30P7Csq1jV6kGBuvAANsR2HPuoKyNKAdVqJvz62yyZ2efUYPRvX+8MfBgk
        JSVdO4I0WM+x1rPMw75o0xNTbWMDdWs9wYhU0mkgWBjfX1MCFhj7YbEWpIrqhg==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Herve Codina <herve.codina@bootlin.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v2 8/9] ASoC: simple-card: Add missing of_node_put() in case of error
Date:   Tue, 23 May 2023 17:12:22 +0200
Message-Id: <20230523151223.109551-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In the error path, a of_node_put() for platform is missing.
Just add it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 6f044cc8357e..5a5e4ecd0f61 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -416,6 +416,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
-- 
2.40.1

