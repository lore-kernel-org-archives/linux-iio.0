Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D46DC77B75
	for <linux-iio@archiver.kernel.org>; Tue, 23 May 2023 15:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237488AbjEWPNO (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 23 May 2023 11:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEWPNE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 23 May 2023 11:13:04 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1981B1;
        Tue, 23 May 2023 08:12:51 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 3D8ECC0008;
        Tue, 23 May 2023 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684854770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DrMZ95BLnGjcDr2P+qmpgq0WbufG1vHwF/RueaYJS28=;
        b=OJWTwCnlWn+Xthk0Xfek+s2r5juF2h7SNMSfs+CDSVW51lOc8n36dXjfmK4BGPJBYbTAPt
        86JjRd4Mcrd49qLXHvDbArKC/E8hki2QuxdslB+MaEZqxwzDROqTu3G8Z0Oz5C6eQX+enW
        1FEIgs2cKR0VhE8GLUYxb3DvhzjllrjjdzEjgxzsfnZWENwkRrwuSFZJ1V6owA63QJX4at
        E+lI4csyxxNOldCH4gEdjII1NaSjAe/tFPmI74ueGDSpFa0nTIg+UIMmKFywgHxEA6Z5du
        0P+mF8ZkTdK3AP4vyWzvlgggQVXF+c6HB2D3ptw9OPIUQUqHT2gaJZ7N9lx2tQ==
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
Subject: [PATCH v2 6/9] ASoC: soc-dapm.h: Add a helper to build a DAPM widget dynamically
Date:   Tue, 23 May 2023 17:12:20 +0200
Message-Id: <20230523151223.109551-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523151223.109551-1-herve.codina@bootlin.com>
References: <20230523151223.109551-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The SND_SOC_DAPM_* helpers family are used to build widgets array in a
static way.

Introduce SND_SOC_DAPM_WIDGET() in order to use the SND_SOC_DAPM_*
helpers family in a dynamic way. The different SND_SOC_DAPM_* parameters
can be computed by the code and the widget can be built based on this
parameter computation.
For instance:
  static int create_widget(char *input_name)
  {
	struct snd_soc_dapm_widget widget;
	char name*;
	...
	name = input_name;
	if (!name)
		name = "default";

	widget = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_INPUT(name));
	...
  }

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/sound/soc-dapm.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
index 87f8e1793af1..6b62fe5c779c 100644
--- a/include/sound/soc-dapm.h
+++ b/include/sound/soc-dapm.h
@@ -276,7 +276,17 @@ struct soc_enum;
 	.reg = SND_SOC_NOPM, .event = dapm_pinctrl_event, \
 	.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD }
 
-
+/*
+ * Helper to create a widget 'dynamically'
+ * This can be used with any of the SND_SOC_DAPM_* widget helper.
+ * For instance:
+ *  struct snd_soc_dapm_widget widget;
+ *  ...
+ *  widget = SND_SOC_DAPM_WIDGET(SND_SOC_DAPM_INPUT(input_name));
+ */
+#define SND_SOC_DAPM_WIDGET(_widget)({ \
+		struct snd_soc_dapm_widget _w[1] = { _widget }; \
+	_w[0]; })
 
 /* dapm kcontrol types */
 #define SOC_DAPM_DOUBLE(xname, reg, lshift, rshift, max, invert) \
-- 
2.40.1

