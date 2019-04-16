Return-Path: <SRS0=o58m=SS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FF8C10F13
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 23:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A595920880
	for <linux-iio@archiver.kernel.org>; Tue, 16 Apr 2019 23:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PODkFOlE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730997AbfDPXtc (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 16 Apr 2019 19:49:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36014 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730888AbfDPXtc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 16 Apr 2019 19:49:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id z5so11174996pfn.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Apr 2019 16:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3M4/HoeJn7RNDbgaruRvsbC8Cdn0pROv2vGhlyKRaIE=;
        b=PODkFOlEUt3dQC718Q9k72NahTdCZ02gCKlLWaF6gFHblJG0tee819YGf7shJxIKR5
         xeKAWOYVLlxqpo8qhC0Jn6W+lwqpY6Ow7ehhxxpLI2A0cIB79t4BrxNCypqZR4c1+hK8
         zfHsIKIjRxOYNSm64WzLDzXuIGA9zDUNgNuPKoefk1hsFqnOhxoD5njPZr5y4RJIpXa2
         54XQ1JtSF0EZEIGre4ExiwESA9ddUEJMvlTdIdpl8qkM7nzFqSlbmPFx4C8PlY0eEaPm
         NV4l1zALrL6rS9UxV281A8WCOev+fjPUIpMPwVqrYWq44YhkZBhElIxRPpTs84mTGYix
         terQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3M4/HoeJn7RNDbgaruRvsbC8Cdn0pROv2vGhlyKRaIE=;
        b=jtfvJ06NCezTQlBSEg4nPls+VLfPfaXYRTHO8c2rvmJKk9iEkmdqwtT7qu/RRQ6TDL
         hbmORRXjt3PAovWmGTJ/3NzoZHi/oUdm2pkxfy4xm+kRZ5H+3/zEEYPPUnFgy2c8YNLQ
         RTPy8z1cX5BOh0Avbk45xsrBeM1xeM/RIO/BkW2eB07lC7qZRvS5+KjmwaHiz049SnyB
         PzHkeLwGgMG+muV++cxKy81yu9UDB4MNQbcNSeKp+3A9y2ZPDs5W6NLM/R/iqY8uN2ba
         NoRJPhk8C2WBwrQm1a+GyvgQhgaVNc7WBq5XgI8II1FaxbCxVqLyTndOUBPVZacdYWsv
         RhXw==
X-Gm-Message-State: APjAAAXG7sWITmG6VVqku072pCQWl5+A93qJaxqwazu/VPCVlLlqjDOp
        nul84OVWWOA6mBTS0jNTCTzTnw==
X-Google-Smtp-Source: APXvYqyEdQpyvckB+opTG4clt2LM9TFIFAEKE52alZSqqWZjInDhwpQo2dl7VyuDp1bu3Rh3PJ4rxw==
X-Received: by 2002:a62:6842:: with SMTP id d63mr87739354pfc.9.1555458570856;
        Tue, 16 Apr 2019 16:49:30 -0700 (PDT)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id g10sm39427998pgq.54.2019.04.16.16.49.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 16:49:30 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] iio: adc: qcom-spmi-adc5: Fix of-based module autoloading
Date:   Tue, 16 Apr 2019 16:49:27 -0700
Message-Id: <20190416234927.8888-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The of_device_id table needs to be registered as module alias in order
for automatic module loading to pick the kernel module based on the
DeviceTree compatible. So add MODULE_DEVICE_TABLE() to make this happen.

Fixes: e13d757279bb ("iio: adc: Add QCOM SPMI PMIC5 ADC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 6a866cc187f7..21fdcde77883 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -664,6 +664,7 @@ static const struct of_device_id adc5_match_table[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, adc5_match_table);
 
 static int adc5_get_dt_data(struct adc5_chip *adc, struct device_node *node)
 {
-- 
2.18.0

