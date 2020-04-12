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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D0DC2BA2B
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 14:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9B63206E5
	for <linux-iio@archiver.kernel.org>; Sun, 12 Apr 2020 14:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZ7fYEt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgDLOct (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 12 Apr 2020 10:32:49 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38979 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgDLOct (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Apr 2020 10:32:49 -0400
Received: by mail-pj1-f68.google.com with SMTP id o1so1999023pjs.4;
        Sun, 12 Apr 2020 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/Lj7/UVhiRjtSh2yT7HeljEOXZWQTtN5YOXyQ/wCWCY=;
        b=XZ7fYEt706nnXOsWwkkXV2znCaV1uZBc/qih5IwvviHtoehAHgl7D2w5sm2q4JkDla
         bhW1LSzxRFE5g/tbJs7NLpW3VjRMN77n5H+lblLrdJNtzPurzYwrsyzAp9JsGzDndDkf
         kXm319skeqK3tUz9BETmdCtclFGfvGD6GPfSwpjpkgPZChiJ4iUZ0BP109p11OFQTesx
         OyVrRBu63ZjOyD/pLRBdpjrgjB6OghdeyMaMMalQh4rl1kqT7CbzLCzTLXsP+xDYlCUa
         41wSEX2VxDRSuZEKzIFoU8EGxrinmfawOEiHz/FIIHtFF/Yyv3GeBSVSfFP7I56FiEeC
         YV4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/Lj7/UVhiRjtSh2yT7HeljEOXZWQTtN5YOXyQ/wCWCY=;
        b=UFk9eAJUa6LpT8Y9DIUgxi2+fgdXgxu/cvRhESbG4vek0sqIHIpF3eX8maqFpIKmD4
         pcJW9FYzP80G/oAsVx+OIYoEWRGlLDsCEhwJ+cCVV+f3dHrktFWxCqW1zg9EqH3fgE8V
         g99lrgjLSjt/2BGwc4gT6+wz2H0fqEq1VBq8IoOhl+JSJH0y4QxbNLRSOfS3knKuS5lt
         nqD1DWdtLS/f901BXwq9XKXcDa3oPcHZkZSJsF4lPTyLcDl2VMkaEbV9aFfAMj++dax/
         qakIvp+X1K/ePwhTjboDGIU25NQSBWl6y+mry8xMmtPFL4EZjAzJiMZP+9GDIxTPgAMc
         QBtg==
X-Gm-Message-State: AGi0PuZwCm+YLvD7Yns+PJyP5dKQk7ZwxRpi19Ng2hpth511Y95IVie2
        DHlhYPCxxAV9dPX2mv/kthc=
X-Google-Smtp-Source: APiQypI8Aw8VypliK7WobMXeNhlVyHnh78NM3mTSMY1+2n993F5rJj/bworYiZmPZNFkPwrvout9+g==
X-Received: by 2002:a17:90a:a111:: with SMTP id s17mr17362116pjp.129.1586701966819;
        Sun, 12 Apr 2020 07:32:46 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:992:22ab:f465:67ce:fbea:c439])
        by smtp.gmail.com with ESMTPSA id o11sm5804266pgh.78.2020.04.12.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 07:32:46 -0700 (PDT)
From:   Aishwarya R <aishwaryarj100@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Aishwarya R <aishwaryarj100@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: sun4i-gpadc-iio: Use devm_platform_ioremap_resource
Date:   Sun, 12 Apr 2020 20:02:18 +0530
Message-Id: <20200412143220.4476-1-aishwaryarj100@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409141331.30882-1-aishwaryarj100@gmail.com>
References: <20200409141331.30882-1-aishwaryarj100@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>

Use the helper function that wraps the calls to platform_get_resource()
and devm_ioremap_resource() together.Reduces boilerplate and suggested
by coccinelle.

Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
---
 drivers/iio/adc/sun4i-gpadc-iio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
index 176e1cb4abb1..0f2c1738a90d 100644
--- a/drivers/iio/adc/sun4i-gpadc-iio.c
+++ b/drivers/iio/adc/sun4i-gpadc-iio.c
@@ -496,7 +496,6 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 				struct iio_dev *indio_dev)
 {
 	struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
-	struct resource *mem;
 	void __iomem *base;
 	int ret;
 
@@ -508,8 +507,7 @@ static int sun4i_gpadc_probe_dt(struct platform_device *pdev,
 	indio_dev->num_channels = ARRAY_SIZE(sun8i_a33_gpadc_channels);
 	indio_dev->channels = sun8i_a33_gpadc_channels;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	base = devm_ioremap_resource(&pdev->dev, mem);
+	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-- 
2.17.1

