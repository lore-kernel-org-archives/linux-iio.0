Return-Path: <SRS0=PdeJ=A3=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00A34C433ED
	for <linux-iio@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1DF3206C1
	for <linux-iio@archiver.kernel.org>; Thu, 16 Jul 2020 14:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LBq+wAly"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgGPN7n (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729114AbgGPN7m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Jul 2020 09:59:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7DFC061755
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:42 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l2so11745921wmf.0
        for <linux-iio@vger.kernel.org>; Thu, 16 Jul 2020 06:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/50EGrtFWRegK5lMk9s0po818SOAgTGmFH82qJKUi/I=;
        b=LBq+wAlywu8+D/xsZk/Cs41V54ogsSAD0symhkOQYpLjrmqFC+uJYxhqW0UP/c5E1A
         HlqZ5qywOollM5+myR2LqfRsc5+Alvhl5bHRZ0Z4QnismbaeFRT/esVAVg9hGK6aliq4
         /X/srN2wM3FTqHYr90UMBYB14yyyPrBPCny4IBkBKhPszAsPg5emDstBgUGnpf0uqJ52
         RSyIenLpfqHEKS/hHGWhy1BGzEm9FhL4Lfc65738Gvuw+UMhsJnaWv4lx/DM9ttGUcO2
         GmvThV397PbiqHdicaNyoJUo0DEm0RLW5k2O5DeYF3AL06StH8q2G/1fwNokG9guyMCF
         DNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/50EGrtFWRegK5lMk9s0po818SOAgTGmFH82qJKUi/I=;
        b=A+c0ma1280AKgcLSFU/srqvEbYlbpRqvOxzsjVT2Hhl2U7fA6vHNPU/+1zqIRxs6qP
         LsE3oJ8V3SYDMFsfYHGzQrMBXMBuHgi16x1l0MN3mcKnsG07AIO6NG3XbdqssKdc/SHM
         NZBPhuRXpP2y2QdkABpgPQf6t/Hkdo6ptRBNMm+7yKblWuQv1fVSOWOLHA1AQSlSP9T/
         glkBZMFTrwVfHNcaDyW+eMJZkpfSZ0o+Dp36u0bh6sHpElTSi5U1QavWZgSEZcUdrivh
         U5AXOXOzisOTBswhzeC8NrGYI+1B/LHVXtucCVrfbgwcUuatb5PnNMlFFFjaU8WmFhRg
         tfJQ==
X-Gm-Message-State: AOAM531OiSD8gZhtS4Bbh6ckl2tLQzR3M49GwPIYt4IgkZGXZveZJIhq
        lfpmIuUlyBeo6iLVSU/Mrvcfiw==
X-Google-Smtp-Source: ABdhPJwTXEWVIoqKpOfpR0giULN1Ul3cws+HaMeoV0tNTI2jQekaFtv3xPzB4pUvgA61vDc3bIkKEg==
X-Received: by 2002:a05:600c:2253:: with SMTP id a19mr4302911wmm.136.1594907980735;
        Thu, 16 Jul 2020 06:59:40 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.61])
        by smtp.gmail.com with ESMTPSA id x18sm9351001wrq.13.2020.07.16.06.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 06:59:40 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: [PATCH 07/30] iio: dac: ad5360: Fix kerneldoc attribute formatting for 'lock'
Date:   Thu, 16 Jul 2020 14:59:05 +0100
Message-Id: <20200716135928.1456727-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716135928.1456727-1-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format.

Fixes the following W=1 kernel build warning(s):

 drivers/iio/dac/ad5360.c:89: warning: Function parameter or member 'lock' not described in 'ad5360_state'

Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/iio/dac/ad5360.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
index 3e0c9e84e8dab..e2a2473bfed77 100644
--- a/drivers/iio/dac/ad5360.c
+++ b/drivers/iio/dac/ad5360.c
@@ -67,7 +67,7 @@ struct ad5360_chip_info {
  * @chip_info:		chip model specific constants, available modes etc
  * @vref_reg:		vref supply regulators
  * @ctrl:		control register cache
- * @lock		lock to protect the data buffer during SPI ops
+ * @lock:		lock to protect the data buffer during SPI ops
  * @data:		spi transfer buffers
  */
 
-- 
2.25.1

