Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3BBC07E96
	for <linux-iio@archiver.kernel.org>; Tue,  6 Jul 2021 16:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D5F61C1D
	for <linux-iio@archiver.kernel.org>; Tue,  6 Jul 2021 16:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbhGFQMl (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhGFQMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 6 Jul 2021 12:12:33 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CC8C061764;
        Tue,  6 Jul 2021 09:09:53 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j13so20645061qka.8;
        Tue, 06 Jul 2021 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9cfCi3940j+E1XFUEFlGplq5sdXS0Te+rNKenVvXq0k=;
        b=DyI9mxi46V88tQr/5lyRvGEJ8aiN7vSzI2ROIKBXswK/ZY6aP4nT2vEtR9664zMD7U
         OJD+qKo3neRbSgvkP0XpC5dp8BS/lyP1C6q96oTfqUW8CW0oQVto4xvDjQgeL67C8aPK
         EvqwdixV2eu1+MruhMQzpBehLypLJWhHQM7V0glQQlEMpwe+FUjZLj1WzyO5NfYjnZ8U
         hg31rrkVHD2WipWAwt8hsEl+s3eN9pdo1rq9c0mTgWxVDoY2xeM6fvBLuLlM5EgKBNcd
         qQZ+Zjo55/mEXXF3BJDDvm2vM1ptChqgyTmSwEoreggZp/rftVEMNYjbaqxn3efPM8LW
         eygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9cfCi3940j+E1XFUEFlGplq5sdXS0Te+rNKenVvXq0k=;
        b=pSdWbMG+EsJCaqrOxFKNqkMVQ995GwIRoQ7+18NgX3Uq3KU7cr3usUSf85QFoq2nyI
         cJtTZLn6wV4JdPDsYKMx0UXgAE7weYV00PEMd5RXsfnOXWDPvuT4SMTrCV+d3vxLFwrP
         NwpJAVTKGkckIS7oKJNvbKKWWYcpzcpK5FEWYSHQ23OHFpsCE3sQjedecfNfJ5OfzMXh
         LWYSHZU83cnOkWJpuAtu8y87tkqR/XXGV1CtAVUvcWalNKVQV6giB+Wf11Y6pNlBg9L1
         iSYlIdjOUV0W/+hV3pz4qG+yMGaf4BuSPdYoJrOlmPaYF9nroyrbJ93uENgHgA/5S5t2
         EH0g==
X-Gm-Message-State: AOAM5338T9zokr/FLRlyTGtAtnJeuIZyrPRcFecuTlZzOSmZxQkDuiie
        vmZvARVN9c8X0HyGTkV08g0=
X-Google-Smtp-Source: ABdhPJwSNm2Uphnihsj7vmsjwY9Ss0ji9df/7RLuQBcMDCTFVnmXzGbwkB0WSkTLLNpWhPqE1AE9bg==
X-Received: by 2002:a37:9bd4:: with SMTP id d203mr20569785qke.474.1625587792848;
        Tue, 06 Jul 2021 09:09:52 -0700 (PDT)
Received: from shaak.xiphos.ca (198-48-202-89.cpe.pppoe.ca. [198.48.202.89])
        by smtp.gmail.com with ESMTPSA id n64sm6995371qkd.79.2021.07.06.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 09:09:52 -0700 (PDT)
From:   Liam Beguin <liambeguin@gmail.com>
To:     liambeguin@gmail.com, peda@axentia.se, jic23@kernel.org,
        lars@metafoo.de, pmeerw@pmeerw.net
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: [PATCH v4 04/10] iio: afe: rescale: reduce risk of integer overflow
Date:   Tue,  6 Jul 2021 12:09:36 -0400
Message-Id: <20210706160942.3181474-5-liambeguin@gmail.com>
X-Mailer: git-send-email 2.30.1.489.g328c10930387
In-Reply-To: <20210706160942.3181474-1-liambeguin@gmail.com>
References: <20210706160942.3181474-1-liambeguin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Liam Beguin <lvb@xiphos.com>

Reduce the risk of integer overflow by doing the scale calculation with
64bit integers and looking for a Greatest Common Divider for both parts
of the fractional value.

Signed-off-by: Liam Beguin <lvb@xiphos.com>
---
 drivers/iio/afe/iio-rescale.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/afe/iio-rescale.c b/drivers/iio/afe/iio-rescale.c
index 774eb3044edd..ba3bdcc69b16 100644
--- a/drivers/iio/afe/iio-rescale.c
+++ b/drivers/iio/afe/iio-rescale.c
@@ -39,7 +39,8 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct rescale *rescale = iio_priv(indio_dev);
-	unsigned long long tmp;
+	s64 tmp, tmp2;
+	u32 factor;
 	int ret;
 
 	switch (mask) {
@@ -67,8 +68,13 @@ static int rescale_read_raw(struct iio_dev *indio_dev,
 		}
 		switch (ret) {
 		case IIO_VAL_FRACTIONAL:
-			*val *= rescale->numerator;
-			*val2 *= rescale->denominator;
+			tmp = (s64)*val * rescale->numerator;
+			tmp2 = (s64)*val2 * rescale->denominator;
+			factor = gcd(tmp, tmp2);
+			do_div(tmp, factor);
+			*val = tmp;
+			do_div(tmp2, factor);
+			*val2 = tmp2;
 			return ret;
 		case IIO_VAL_INT:
 			*val *= rescale->numerator;
-- 
2.30.1.489.g328c10930387

