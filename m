Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C953C4332D
	for <linux-iio@archiver.kernel.org>; Tue,  9 Mar 2021 01:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10FED6529C
	for <linux-iio@archiver.kernel.org>; Tue,  9 Mar 2021 01:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCIBSx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Mar 2021 20:18:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhCIBSj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 20:18:39 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79993C061760
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 17:18:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id j12so8244037pfj.12
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 17:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iZXlduTFaV90bjujtmV6RwTAkiVATc4QS14E/YZSmX8=;
        b=QzqPc+UjNuHszoXOLnW0ydOf15qoCFasjIp3z6id32sMpnJfyt/COk03l4nNT3K3C3
         s1UwvjL23CrvYRWyHBuKC7p6ifc4SEzUfAiNR5d06nPEgXuc+RCIiFKFeeEqo8GpHrl2
         PK14PosVBpocsyX8bYu937Uh8AJwIy1gNDh64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iZXlduTFaV90bjujtmV6RwTAkiVATc4QS14E/YZSmX8=;
        b=SSS7ueUt0rDixnZ6ddAq1GOte1+0dK/cfIZrTY9Tm7tf/7+a3g00zUNulG8mM+rf3D
         XmK2VUuu3sfQm3lFxx1hrBpt9XIfmzfwBcPfbk9mwNcUwn753RQkkofAfiazDJfH1ksp
         YHaB8okSHc3GFnXLDKHGjsIWI8NqI5eO3EKfL8GFlThu24nlmepkPVwEPaKkMd+r492t
         +lDdfjcDHyTSg6yVTTSKnRkoP21EVdMx7XpA0xk8XWAXrNGHDTSp32HnN07O/BzQ47TO
         LVEvkVZq9NG3/72LFEMVOqTA5yg/PmPa3vron8on+7b0ZhGNAX5u+mDbVqbr6aHmpiL1
         xzLA==
X-Gm-Message-State: AOAM533qpNk9ND0z6njFfIOTTFqcDdURBV5ijxM+pvf6FLceIsJa1kdb
        AB5FBABlynC1peNC+vxa/cEgXQ==
X-Google-Smtp-Source: ABdhPJxWLjXVHIM8CoqfpV/y2R68ctFS3I1PTGqqUEhtqI3srFLPQZP/nyIeusiTV6xoYJV0m9APRg==
X-Received: by 2002:a65:57cf:: with SMTP id q15mr22985795pgr.380.1615252719057;
        Mon, 08 Mar 2021 17:18:39 -0800 (PST)
Received: from localhost ([2620:15c:202:201:3cb0:414a:7f1c:ca43])
        by smtp.gmail.com with UTF8SMTPSA id gz12sm529055pjb.33.2021.03.08.17.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 17:18:38 -0800 (PST)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     jic23@kernel.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        ardeleanalex@gmail.com
Cc:     linux-iio@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v3 8/8] iio: xilinx-xadc: Remove code to set trigger parent
Date:   Mon,  8 Mar 2021 17:18:16 -0800
Message-Id: <20210309011816.2024099-9-gwendal@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
In-Reply-To: <20210309011816.2024099-1-gwendal@chromium.org>
References: <20210309011816.2024099-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Already done in boiler plate code

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v2.

 drivers/iio/adc/xilinx-xadc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 34800dccbf698..6914c1900ed0b 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -747,7 +747,6 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
 	if (trig == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	trig->dev.parent = indio_dev->dev.parent;
 	trig->ops = &xadc_trigger_ops;
 	iio_trigger_set_drvdata(trig, iio_priv(indio_dev));
 
-- 
2.30.1.766.gb4fecdf3b7-goog

