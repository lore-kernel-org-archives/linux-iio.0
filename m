Return-Path: <SRS0=q/Pt=RY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BD2C43381
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8568E218D4
	for <linux-iio@archiver.kernel.org>; Thu, 21 Mar 2019 21:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCbU33V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfCUVPu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 21 Mar 2019 17:15:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43799 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfCUVPu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Mar 2019 17:15:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id f18so229515lja.10
        for <linux-iio@vger.kernel.org>; Thu, 21 Mar 2019 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fHDIzg6xpXxHtWluObl5tEXB6psnVCz0yfil0irFqJc=;
        b=kCbU33V7r6OI9WQi/2ixAkgYMgzkio9v9iSSrU9OmKoFY2+pYMNlgDc75d2n5phgeA
         49vUGfPq5B8ML5RwdNzBb0C3IW7aZmwE8utqCPkHpnaUXnNfjUT7WZxHH+h4DIS+WbZz
         3u5ukv2T7VytZAuH/o6Y7wANVw5NsPEhNLaXodavvfVzSHEnFAtuu/nmkM0/odkWJPsd
         Va03fjdJ1Uf8NXpi7kD9y011X0Mten+25zLKB6N58sQ8ftL8tJo29RGGz4hKzWGi2xoz
         pJV/CkJfDHjqjA6Ua2eARlEYVRPLhAqIpJMTq96nHrsTBE5gVbQ0ENGllVa1FshWi+lU
         QC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fHDIzg6xpXxHtWluObl5tEXB6psnVCz0yfil0irFqJc=;
        b=PN64tq2SPj1rdtO68Nkh0cqpdXPVdAf6LoLksM2yRY/SYiE50h9w5jYyct1tqYJLfL
         Xohf2CHBp7uM7ccK4RKFH4Jr8/Vj54LPXu4AAjZyi3jK5+355W4eGJRyJoghtzRGBSxA
         T9KeOoJ8EQenU8ZQsQ8DOKZK3KSep2xvKJJ+BU9ujJavxN+z6AjePQ5I9f965tE2xfL9
         Cf7RJn8YL4KmKEd/n3vtIJaOv7Enzh19qYkkzskYNR3quPE6L5ihppsT+RY0T/T7ObL7
         uWB3SctsvreibgksYUqhvHojaDMTT4X1FJ4efjI45moGqB91JeoWngMCGPetyMKwXtzR
         Hmsg==
X-Gm-Message-State: APjAAAUoWEy0KkPlFlywwYT+ojpKH575rDfXzM7TSK+3mMgJivqzJbBg
        Jv7slZJ8J39DSGEP+gR2Sev1e3rDKVo=
X-Google-Smtp-Source: APXvYqy2AclupOE6WkmpmJrL0EOZVEbmcpXfDP8mgkUCnSPv1q4ZTw7Ok1yIF8K20XXpvN67IGj1qQ==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr3256503lje.22.1553202947827;
        Thu, 21 Mar 2019 14:15:47 -0700 (PDT)
Received: from ubuntu.localdomain ([95.161.223.243])
        by smtp.googlemail.com with ESMTPSA id f18sm1051355lja.91.2019.03.21.14.15.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 21 Mar 2019 14:15:47 -0700 (PDT)
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org,
        Vladimir Petrigo <vladimir.petrigo@gmail.com>
Subject: [PATCH v2 2/2] staging: iio: ad7780: Add parentheses to macros
Date:   Fri, 22 Mar 2019 00:15:28 +0300
Message-Id: <1553202928-34824-3-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553202928-34824-1-git-send-email-vladimir.petrigo@gmail.com>
References: <1553202928-34824-1-git-send-email-vladimir.petrigo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Fix CHECK Macro argument 'wordsize' may be better as '(wordsize)' to avoid precedence issues

Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a8578..010fb47 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -142,7 +142,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 };
 
 #define AD7780_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
+	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, (wordsize) - (bits))
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
-- 
2.7.4

