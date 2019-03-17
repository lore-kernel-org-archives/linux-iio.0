Return-Path: <SRS0=squ6=RU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB74C43381
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3752120857
	for <linux-iio@archiver.kernel.org>; Sun, 17 Mar 2019 20:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paTjtOn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfCQUx0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 Mar 2019 16:53:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32841 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbfCQUx0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2019 16:53:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id z7so12232352lji.0
        for <linux-iio@vger.kernel.org>; Sun, 17 Mar 2019 13:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=84H3pTWgezBqcL/wIfsJQc/ezB2F1lkLs6yD0mYdpT8=;
        b=paTjtOn3P+F8N1tRNQnShp/Pr8jf+Inz6px0B6DSfmeAEretr+KdkPt1Atvv7z37hs
         8LMHKSordnodVOsBsNq5+SjaZ0dbTPHQb+aNL0vYltRkwS2u2Rx0bn77yAhmUTQWmEOR
         TGGe7uyiBbZ1zKACQV6NgiZHeGJCoFoJguEKJi2K2Ww5fJCGDyXZnRzhcaM9W7m2+FEg
         skmh9GPybKZJgkuaWfMTkyhq0GysskQkJqFLC4AQBqBOBkcLMVvTFxVWv9ysrQyzcI0Y
         COTJeCqHXysxEubXrk/AuNysHBZ4EzcnulWFRldcS6ITVjcBNFvjstpNIHirtaAoBzu1
         NljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=84H3pTWgezBqcL/wIfsJQc/ezB2F1lkLs6yD0mYdpT8=;
        b=uKfatmgWIehSOztF5ELIWmkiwYF5wfa2jE07cxys1vCEFZmY92Zgl34yb3chf5axsa
         Po5/wOsmtb1WoGxe6HnxZTRRxFtRvgRGpKoPxuO+eKXuQLOd/qUGMfr3/bilDp0ly5L8
         /7Wj/9WpHr0Ig9fsgapyJ5+cfROwje6VMO8yhxXSwdoUGpPgTfuRsO/hTpyPk6O7cr/r
         SZmJN5Gag7TCfWEQ/UqAJ+hx0tftToJffyyFF2codtmPWeDGOSIbjp6AQsQOmfGqwKcx
         /TIF+rdrsXvZ8QxiMbITINWsALMhkbELgF5iNWNflB2NQRFPUX6iMGSHTyR7ge7KkUTR
         Ucgg==
X-Gm-Message-State: APjAAAXkMKN6hxrcOOHjXs0SAIHsZAI+vrRoh7MLolHain+dU66w7fE2
        H7SnZTGgUFWOiQ7RsKMroa+VqEWpDlc=
X-Google-Smtp-Source: APXvYqyJqu86aq0w34OAJtLI2sck0PkGVmb9fQl6eSy2tLBeZxZx7ppllocA34zvuO8SlbREqXC3VQ==
X-Received: by 2002:a2e:899a:: with SMTP id c26mr6924401lji.192.1552856004523;
        Sun, 17 Mar 2019 13:53:24 -0700 (PDT)
Received: from ubuntu.localdomain ([95.161.223.243])
        by smtp.googlemail.com with ESMTPSA id v4sm1725578ljj.80.2019.03.17.13.53.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 17 Mar 2019 13:53:24 -0700 (PDT)
From:   Vladimir Petrigo <vladimir.petrigo@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        devel@driverdev.osuosl.org,
        Vladimir Petrigo <vladimir.petrigo@gmail.com>
Subject: [PATCH 3/3] staging: iio: ad7780: Add parentheses to macros
Date:   Sun, 17 Mar 2019 23:53:12 +0300
Message-Id: <1552855992-27653-4-git-send-email-vladimir.petrigo@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
References: <1552855992-27653-1-git-send-email-vladimir.petrigo@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- Fix CHECK Macro argument 'wordsize' may be better as '(wordsize)' to avoid precedence issues
- Fix CHECK Macro argument reuse 'bits' - possible side-effects?

Signed-off-by: Vladimir Petrigo <vladimir.petrigo@gmail.com>
---
 drivers/staging/iio/adc/ad7780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
index c4a8578..2dfd6f8 100644
--- a/drivers/staging/iio/adc/ad7780.c
+++ b/drivers/staging/iio/adc/ad7780.c
@@ -142,7 +142,7 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
 };
 
 #define AD7780_CHANNEL(bits, wordsize) \
-	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, wordsize - bits)
+	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, (bits), 32, ((wordsize) - (bits)))
 
 static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
 	[ID_AD7170] = {
-- 
2.7.4

