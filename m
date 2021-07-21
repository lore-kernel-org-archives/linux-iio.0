Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1246C636CE
	for <linux-iio@archiver.kernel.org>; Wed, 21 Jul 2021 10:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E420B61283
	for <linux-iio@archiver.kernel.org>; Wed, 21 Jul 2021 10:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbhGUJmu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238317AbhGUJMU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jul 2021 05:12:20 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CFDC061762;
        Wed, 21 Jul 2021 02:52:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g4-20020a17090ace84b029017554809f35so3666288pju.5;
        Wed, 21 Jul 2021 02:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E9H+LL07oPc0V9kmYs1nYHJkaHFr4pSCnkaHn51r1wo=;
        b=XeggZt3LI6Rc3UlP1xo/yba/R0uYYWe4GxQ0UZUGqkcrlFgnI0UWFpulN9W1jSfkV5
         kLdsMidSKl3pGNEzrP3Up1jFFfX8U0ifn2HwmMK/9GWWcqPaOC/5FOQMfgRuKYz63Nu0
         RJzNRofh9Ci0RK0nOh/OLVo1m5aoZPLags0TChmYlCJyvBDE2Gr8JJ+ciOwokj2kFMIo
         hWTx+8k4nuKFLISLj7qx/U4eRrDIuO347lUq28tSG73NJ6UlddwYZw+F+j5vIjXqKQbi
         U7A0rCdrYiWnBWGXb/FNgoacXsI9pAE/5zrd7nfKvs5DVgI+ZbtlreJJKkO01BqT5v65
         1PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E9H+LL07oPc0V9kmYs1nYHJkaHFr4pSCnkaHn51r1wo=;
        b=cBQ9KKTbXssVehYAIOm2H8k8H/zRY3J4E+kUS3MvnfCoELKEhtuUp88k8UzXiAFBbx
         BhSvqxsHFQwQ1q+RTekieC8p1XkahJODfQi+Zyw5I2BdqYCjw2hMBiWb/J04AK9Z6CaF
         QAX09LD12nzpIUMleN0IYOTu7ODcVZKiwnhao290QpehJXbXYhjby9laPoRRSN8pCuH5
         ysHQg99/S/QjZ8vVYXK1Q/7+BuAzBXoEbueQgRETdJIOxdJucZjCVqNn/MNRCyDS5FrZ
         pS84kqTzHP88qyouToW0YDMHyAOWPClrH9ZsoI48nZXlbAqpFb/F9ln73RddZxtvVF9d
         Ox4Q==
X-Gm-Message-State: AOAM533wmKIlYWVtYgPES91gx6HOwjEfjB8oBeSoOjHx1VCOpdubdSn5
        K7QXZtvh3yylAU/9b/sB5JE=
X-Google-Smtp-Source: ABdhPJzpj4cxPtzz8Cg0RO9Pssmzu0ds4zpe1r/CXKMeGT+1DORoWeBQCXkMdsZBZZA1gEOr9IwBnA==
X-Received: by 2002:a17:90b:10a:: with SMTP id p10mr33845299pjz.189.1626861174098;
        Wed, 21 Jul 2021 02:52:54 -0700 (PDT)
Received: from localhost.localdomain ([2409:4055:289:a04e:668d:a877:6739:60c0])
        by smtp.googlemail.com with ESMTPSA id g18sm25752439pfi.199.2021.07.21.02.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 02:52:53 -0700 (PDT)
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Michael.Hennerich@analog.com, alexandru.ardelean@analog.com,
        jic23@kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        lars@metafoo.de, Dragos.Bogdan@analog.com, Darius.Berghe@analog.com
Cc:     Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: accel: Add ADXL355 in trivial-devices
Date:   Wed, 21 Jul 2021 15:22:34 +0530
Message-Id: <20210721095235.218519-2-puranjay12@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210721095235.218519-1-puranjay12@gmail.com>
References: <20210721095235.218519-1-puranjay12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add ADXL355, a 3-Axis MEMS Accelerometer into trivial-devices.yaml.

Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 8341e9d23..0097d6e81 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -41,6 +41,8 @@ properties:
           - adi,adp5589
             # +/-1C TDM Extended Temp Range I.C
           - adi,adt7461
+            # ADXL355:- 3-Axis Low noise MEMS Accelerometer.
+          - adi,adxl355
             # +/-1C TDM Extended Temp Range I.C
           - adt7461
             # AMS iAQ-Core VOC Sensor
-- 
2.30.1

