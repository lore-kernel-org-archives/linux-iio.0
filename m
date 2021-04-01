Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE42C433B4
	for <linux-iio@archiver.kernel.org>; Thu,  1 Apr 2021 06:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC9916108B
	for <linux-iio@archiver.kernel.org>; Thu,  1 Apr 2021 06:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbhDAG0J (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 1 Apr 2021 02:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhDAGZ4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 02:25:56 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EC5C0613E6;
        Wed, 31 Mar 2021 23:25:56 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso2525564pji.3;
        Wed, 31 Mar 2021 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXnLdVNgyUimdPfL+v5GFIuyPBZ6lA/hlpHGp24V/bk=;
        b=KVo7mQYW1fGm/1RDQuou3EKnitEFnv+ZUo7CJdDAMt+YrRIMG08OavCbVAIPcJMf2E
         dLStXZ4J6EJ0Y6GVF+WxbtYcap9xiurjUW/7sdP8ySg+cL0cXd7O+3bUS9cdTZDAmsGR
         dFn1s0SUa4/GE9ndbltNn5U2KQtilEUJpr/tnYsaO30Ngkb/HL+nM7+0Od9khC8HLZv6
         KbwkIEmJwhnyRqDei3GwOCMkSfwVT5++Kcy05+qJ1NsXywkFZZ770p6jZea8Exj4JEpY
         zd0b79fH6eBsk2O0jG8ojHKDye755toxBPRdi5hBvvQzfQe9rKJ948WNKHEuMORD78cE
         80MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXnLdVNgyUimdPfL+v5GFIuyPBZ6lA/hlpHGp24V/bk=;
        b=tYVueuK2ky2pegzPKsAA6Y1/14yDb1GnBz2zo9OkSY3OhygijL5388PL4whi0Pigld
         nG9+V3ngNQfAbtpGQiWl4fK4PlN4PVjY6FodnusAlST8hZTdDG7pWjXtjZXM1loSptJW
         Ae3u6MlvnfoPz34eerdlKHnQsXh7U36NyXMVHYgpC+op4Qstwd4hmGtsrPYb/GMNw0TX
         UlNkwj+Cnb7NIRaj+bguGzSFWHlj2Kn5TjKl8xeBHSY8dFX9AcoBd0l+IClDipF1YywK
         xmMaZD5E1d/+vv43pK4Yn4HkYkRGzlj0xFEPF74n757ZZ70qbT8ZiRetr3Ky4jZD543b
         IIIA==
X-Gm-Message-State: AOAM530ztDOPC7P+myP78yw0pTIfsZZuF5IJ663grae/k9pXAAPGEoao
        iwLzqUCIMltE3TQ9amVw4to=
X-Google-Smtp-Source: ABdhPJxxRRk0Kz8yGHIwAIfry8GyT5A4KQRcQQkGhaZqDW/dNneq0Xw64nnvhaAdzlpb5uYM5sH/9w==
X-Received: by 2002:a17:90a:5b0b:: with SMTP id o11mr7347687pji.18.1617258355805;
        Wed, 31 Mar 2021 23:25:55 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6307:8389:1a0d:8ccb:e643:1f59])
        by smtp.googlemail.com with ESMTPSA id b3sm4231857pjg.41.2021.03.31.23.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:25:55 -0700 (PDT)
From:   Mugilraj Dhavachelvan <dmugil2000@gmail.com>
Cc:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: bcm_iproc_adc: Use %s and __func__
Date:   Thu,  1 Apr 2021 11:55:17 +0530
Message-Id: <20210401062517.28832-1-dmugil2000@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Change function's name to %s and __func__ to fix checkpatch.pl errors.

Signed-off-by: Mugilraj Dhavachelvan <dmugil2000@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 5e396104ac86..6bffda1082a2 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -170,8 +170,7 @@ static irqreturn_t iproc_adc_interrupt_handler(int irq, void *data)
 	adc_priv = iio_priv(indio_dev);
 
 	regmap_read(adc_priv->regmap, IPROC_INTERRUPT_STATUS, &intr_status);
-	dev_dbg(&indio_dev->dev, "iproc_adc_interrupt_handler(),INTRPT_STS:%x\n",
-			intr_status);
+	dev_dbg(&indio_dev->dev, "%s,INTRPT_STS:%x\n", __func__, intr_status);
 
 	intr_channels = (intr_status & IPROC_ADC_INTR_MASK) >> IPROC_ADC_INTR;
 	if (intr_channels) {
-- 
2.25.1

