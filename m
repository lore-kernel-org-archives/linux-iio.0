Return-Path: <SRS0=ui5J=BH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC61C433F2
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jul 2020 23:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A87722074F
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jul 2020 23:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="e8ovD5nr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730399AbgG1XGW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730041AbgG1XFk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jul 2020 19:05:40 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3755C0619D2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:40 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id i138so11814019ild.9
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2020 16:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nao6Sg98gC9dnjx3GEZXAl5nG7UIQ3Jxef2Bqt6ZzNA=;
        b=e8ovD5nrAw0AQrEDf9TwEgeiTLsCgrXKE5Ekm1aC8Awgru6PH0WKivHuShFoekmMu/
         qr7V69nKAd4jLRDoypN2UneXhquWBepj2r1Qbkiy5ZdB6GOWPztLWa5nLvnLErk93K7D
         /FpDoxLelPIAedCwUr6BUZjQ4DMJ8WqwET9Dk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nao6Sg98gC9dnjx3GEZXAl5nG7UIQ3Jxef2Bqt6ZzNA=;
        b=DM6A33bJi2ukxRK/wNiTsAaXgEF6rBjQNuSnzQrcFf00GMcmbOD0VKmcEfXTgA2w9L
         I6CqayMAHacgOFOeCKQwQYlAC59yMUf08/5SP6VB3g5xkIPvY/GEe+t4b4LmLG85QUyf
         eg4ZsxsKddP+v3YExI24E0X9vXLF28qKoVleawRw20ZCyJv9NNSBjf+79R1+1vxIiNhf
         1izAqJZDfePCVwNw8IVqaCQqUVxEM1rVBoKFwOQtImK+++jIiaA2/rE8fa1fWA7uNwo/
         kV6c8mBZGFXoPca9ShH4Rhg/p2pPm9pB6jtNTsMirM9RixBXWdH9x/5LtoQruoVlPskU
         TEjg==
X-Gm-Message-State: AOAM5303sjVJpdJArD/TgLrBSPLccSgGQbbh6/T8vk/sb4h7S2bOTQlN
        NjLZjFZX427ekOwzecTbhz5ksA==
X-Google-Smtp-Source: ABdhPJyhLQiF4TVfnU30f3gpZuJ7l3ktbNkM+nWpgbh48zg3EVccqyu593QJwQZsJaHqAr6usPUyFg==
X-Received: by 2002:a92:89da:: with SMTP id w87mr31763124ilk.236.1595977540032;
        Tue, 28 Jul 2020 16:05:40 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id w10sm148945ilo.10.2020.07.28.16.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:05:39 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 06/14] iio: sx9310: Fixes various memory handling
Date:   Tue, 28 Jul 2020 17:05:12 -0600
Message-Id: <20200728170317.v2.6.I8accffd77d616cb55b29bc3021cb0f5e1da3b68a@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200728230520.2011240-1-campello@chromium.org>
References: <20200728151258.1222876-1-campello@chromium.org>
 <20200728230520.2011240-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Makes use __aligned(8) to ensure that the timestamp is correctly aligned
when we call io_push_to_buffers_with_timestamp().
Also makes use of sizeof() for regmap_bulk_read instead of static value.

Signed-off-by: Daniel Campello <campello@chromium.org>
---

Changes in v2:
 - Fixed commit message from "iio: sx9310: Align memory"

 drivers/iio/proximity/sx9310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9310.c b/drivers/iio/proximity/sx9310.c
index bb007673f758d5..75e85dcd6b3572 100644
--- a/drivers/iio/proximity/sx9310.c
+++ b/drivers/iio/proximity/sx9310.c
@@ -132,8 +132,8 @@ struct sx9310_data {
 	 */
 	bool prox_stat[SX9310_NUM_CHANNELS];
 	bool trigger_enabled;
-	__be16 buffer[SX9310_NUM_CHANNELS +
-		      4]; /* 64-bit data + 64-bit timestamp */
+	/* 64-bit data + 64-bit timestamp buffer */
+	__be16 buffer[SX9310_NUM_CHANNELS + 4] __aligned(8);
 	/* Remember enabled channels and sample rate during suspend. */
 	unsigned int suspend_ctrl0;
 	struct completion completion;
@@ -340,7 +340,7 @@ static int sx9310_read_prox_data(struct sx9310_data *data,
 	if (ret < 0)
 		return ret;
 
-	return regmap_bulk_read(data->regmap, chan->address, val, 2);
+	return regmap_bulk_read(data->regmap, chan->address, val, sizeof(*val));
 }
 
 /*
-- 
2.28.0.163.g6104cc2f0b6-goog

