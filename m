Return-Path: <SRS0=GqNd=54=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A982C2BA2B
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81AC206E5
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 13:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX0U6slW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgDLNuv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 09:50:51 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33297 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgDLNuv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 09:50:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id c138so3409307pfc.0;
        Sun, 12 Apr 2020 06:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=yr4f8795yllh8etiAKj5X4bBRbEHSbY1cKo9NjjeXps=;
        b=QX0U6slWP2AGznRjDMkwzNr4ZA5JV2AJkc63xgo6v8HFUJjW7DdabRBnZfWW9lJBht
         287iYq9GHw/BCg4Od/Uk9s+ggSOAm+C1JQWLc147Tof61eFgFG1Ca4Gjb5SGcfc9vdip
         sRoO2rA81De8UQB/aDfyIp05Fi5tw9Ljpav4Ddjo92Hv8KzmP1/1McLD9fBuwsPJv8/g
         JwQsi2bkFTh2CTowrCPfTEFDP4ntxLfFgOt6EzROHkiVzpn+fBtcPJ6BXk3vV7mEzMuv
         SDW5M0g575OR578TlXMQrd43fHGNagj7fMGgnLTVtFHSdvPdI4XrWwOLS2uBXPN1t1vg
         bMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=yr4f8795yllh8etiAKj5X4bBRbEHSbY1cKo9NjjeXps=;
        b=diIp3xkEXxpKkX14U+j0+FhyCObE3Bbq1T9fg9cvWZUc/Z5T93t4PNXK5BL3JvQKc6
         Mr56yKBnzCPIJtBwH0NSmg2vcd7aNBASKg6KEdCZiQQUS1ltSq3iRw/2M8ce4WQCfdWh
         +m31tbQ82zprw0rmgQ6N3zcsYFkviicYOFFHg8b37arQ8foE2iEOF9ScBSyJLIwzfMVe
         CX1CdQRx73EF+EEKQGWWtA9iO4EOKl3AdpTgdPH7TeSzrXJsO27ep9rRFVQsz1Ayg9Hr
         B29tATSbeb1hMeBfNpSRvkfErqc2f8AJauQLaLZ09VEIeRgfyu8nGeu53DDTQ2RSuizq
         wgrQ==
X-Gm-Message-State: AGi0PuZRWhBuu005Zmtb0Gbmwm0jAoTc56aDEwvAvbtY0G+B56rD+kMi
        GOcwUsLKh3qiKoLpv13myQc=
X-Google-Smtp-Source: APiQypJUYacPH+5THzRbWEwODPJ2v1Goc5TraYqTCPY0PhTsQ3a72PwQJ6IZUOtjuGiAhskIVFNdQQ==
X-Received: by 2002:a62:16d2:: with SMTP id 201mr12833489pfw.295.1586699449608;
        Sun, 12 Apr 2020 06:50:49 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:992:22ab:f465:67ce:fbea:c439])
        by smtp.gmail.com with ESMTPSA id ih15sm6776352pjb.27.2020.04.12.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 06:50:48 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Aishwarya R <aishwaryarj100@gmail.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: fsl-imx25-gcq: Use devm_platform_ioremap_resource
Date:   Sun, 12 Apr 2020 19:20:20 +0530
Message-Id: <20200412135023.3831-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409151306.308-1-aishwaryarj100@gmail.com>
References: <20200409151306.308-1-aishwaryarj100@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

Use the helper function that wraps the calls to
platform_get_resource() and devm_ioremap_resource()
together.It reduces boilerplate and suggested by coccinelle.

Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
---
 drivers/iio/adc/fsl-imx25-gcq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
index fa71489195c6..b0a4dc88ba9b 100644
--- a/drivers/iio/adc/fsl-imx25-gcq.c
+++ b/drivers/iio/adc/fsl-imx25-gcq.c
@@ -294,7 +294,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 	struct mx25_gcq_priv *priv;
 	struct mx25_tsadc *tsadc = dev_get_drvdata(pdev->dev.parent);
 	struct device *dev = &pdev->dev;
-	struct resource *res;
 	void __iomem *mem;
 	int ret;
 	int i;
@@ -305,8 +304,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
 
 	priv = iio_priv(indio_dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	mem = devm_ioremap_resource(dev, res);
+	mem = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(mem))
 		return PTR_ERR(mem);
 
-- 
2.17.1

