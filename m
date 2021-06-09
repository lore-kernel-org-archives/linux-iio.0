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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BCC48BCF
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 01:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3861661027
	for <linux-iio@archiver.kernel.org>; Wed,  9 Jun 2021 01:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235723AbhFIBfQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 8 Jun 2021 21:35:16 -0400
Received: from mail-pj1-f42.google.com ([209.85.216.42]:40640 "EHLO
        mail-pj1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhFIBfO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Jun 2021 21:35:14 -0400
Received: by mail-pj1-f42.google.com with SMTP id mp5-20020a17090b1905b029016dd057935fso421667pjb.5;
        Tue, 08 Jun 2021 18:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTRFeIgR82VeMe8p5ZV3YrTNSoJ/Vz3X3Xth8hi5pHc=;
        b=d88eVXQHjZEx5iTzxcmgkdsv5Un4KkQr0n6ujS4RIBMRD5XkCaIXCL3LJRk7odZqBg
         /zrNJNxhsvfAjllevEXrdb1qmfTPgLaUFjr2qr8U3ohs1aWbk+OtfXih+kMbXkoTEvvx
         vnUxJg4xhyQAIDKobIctpCAMwBsSHNJPNtRKvVJZMfp9HgJGYnQvTkFWlOKTrrbnUnoa
         z1SYyKhbgMvRk8jJgg0U8JHN3ekBNc9NiT6RMbZjzRYSbvc2w4K49T0MoOQEVkI1PsIW
         Cg3i6Du2w5pbi79pLVelGkUnXC6NCn4qaT0uBYfmQchZv0sEy11f8JGrxbdkNaa1NZFl
         EkpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTRFeIgR82VeMe8p5ZV3YrTNSoJ/Vz3X3Xth8hi5pHc=;
        b=Wxr7Opfo7vc/TAbs72BBHZhSYwsEU9IIXgBkMvtSDEehIhp061Nenzi0nUneJVJ0UM
         roPqPcMhZk433tU8xsLU2VdRyhRTQdg59onA9N/r8GWPzDcEQGMxb8lvmQkrdML6Lgtz
         OZRhfvpnDZ0CGimM9iHPfbtvxJt1bGTLS0WwPGnFC0BMu7uKc9FLRRZ/S/Jw9mdPduiN
         hRaVCayPbtlK4DbH8yO6fEYga9setQruvzPMr+y78wB7pnKsK/QSLJh13IsxmYngeSst
         76NZSugjPrzOHcKhA3GE0L7qePsiPst7fqIcRYVfZpqJISgyPTUjCvwhdz0VAjvFRtfs
         pBEw==
X-Gm-Message-State: AOAM533fOF/Pcti8jFDrebykt1t/DGDZ0ItHsycS5JsIXxCyGMk9Cflx
        XoPc2ONCkYfKF0wCdra5+hg=
X-Google-Smtp-Source: ABdhPJzPu5Gr1EwWZENCd+j8st+EGD4Hf76QJujQeDnYFUm9cK8D0kOhZrmGzApp0MmU3GDly7pDZw==
X-Received: by 2002:a17:90b:8d6:: with SMTP id ds22mr29632911pjb.54.1623202329876;
        Tue, 08 Jun 2021 18:32:09 -0700 (PDT)
Received: from localhost.localdomain ([156.146.35.76])
        by smtp.gmail.com with ESMTPSA id v14sm12659815pgl.86.2021.06.08.18.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 18:32:09 -0700 (PDT)
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
Subject: [PATCH v11 04/33] counter: 104-quad-8: Return error when invalid mode during ceiling_write
Date:   Wed,  9 Jun 2021 10:31:07 +0900
Message-Id: <538122752d61df30dd450276b87df606a17ac4c7.1623201081.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623201081.git.vilhelm.gray@gmail.com>
References: <cover.1623201081.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The 104-QUAD-8 only has two count modes where a ceiling value makes
sense: Range Limit and Modulo-N. Outside of these two modes, setting a
ceiling value is an invalid operation -- so let's report it as such by
returning -EINVAL.

Fixes: fc069262261c ("counter: 104-quad-8: Add lock guards - generic interface")
Acked-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 drivers/counter/104-quad-8.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 4bb9abffae48..233a3acc1377 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -714,13 +714,14 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	switch (priv->count_mode[count->id]) {
 	case 1:
 	case 3:
+		mutex_unlock(&priv->lock);
 		quad8_preset_register_set(priv, count->id, ceiling);
-		break;
+		return len;
 	}
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return -EINVAL;
 }
 
 static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
-- 
2.32.0

