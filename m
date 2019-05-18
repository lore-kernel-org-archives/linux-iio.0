Return-Path: <SRS0=VRlQ=TS=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F406C04AAF
	for <linux-iio@archiver.kernel.org>; Sat, 18 May 2019 21:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E1320675
	for <linux-iio@archiver.kernel.org>; Sat, 18 May 2019 21:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="A9hJJsNg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfERVfX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 18 May 2019 17:35:23 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:43682 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfERVfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 May 2019 17:35:23 -0400
Received: by mail-qt1-f196.google.com with SMTP id i26so12045969qtr.10
        for <linux-iio@vger.kernel.org>; Sat, 18 May 2019 14:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jKyoBKDfoJbBN8ZdJzWAMlrp7KnkxmJ6vA1sEgIrsvE=;
        b=A9hJJsNgzHTIBXWrT4kKKaOgpXcypIv15DqAp0mgO8ZoSdfDRLE6EH7YYr3QTb7Z9a
         hhgD6YF2Yyj29lRZpPLnqJHRfK35jaxoxx/QUbWJcRkfGJhm/04UaflPxiQV20mzNJ+g
         gcz/3h3A0uv0FyFzlUYEODvtD/X2sv2729y9ullVSBtu0qyl7WAlGY0wy2O8nCGvf9Z/
         jgc3HIXSvVA5/v1ETq1l2dHgDUjuQzK1oQ5dCX7C6H4ZKiTUnM06Yp3wUqkYS/sJOV3O
         Jr7dg9zKAHs0k9QuRUoHAmj81XmMnigB2cFqugtd+pmKG6H+1zBcE3xETy9g9M12XnWh
         WWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jKyoBKDfoJbBN8ZdJzWAMlrp7KnkxmJ6vA1sEgIrsvE=;
        b=iNWdqAMjA2Wc6BhsI3iN7G1Lw33HWhqo15lIMgx2wg17hSGfrPk2my5QPr/l6A1kgc
         +y0f6uSOfTLI0/HFYrgNle/lYsSKyHnZ+Aep2Fy3jmDWdDSCOXkgRGQXf5sqLBG1877x
         tGqvwsiMsTObFU2s57sLcUicXfTJjvJhx0Vro/cIfh21wbipabvQxhAnP/JVOcKRkTzF
         5KHzpZyUeryQ00AqrUDqHrR3bo0l9Z3raa1Oa8WLPQjMw2WgANo4BKxkQ8ywnKevUT42
         ngSazO482+woILyNtsfpjUVP2LNVC4UqzNW4uXCppLOs0WKwYw4sEIM/uJyCkoHO6VjK
         m/PA==
X-Gm-Message-State: APjAAAWClJDaZgQOpDmcx0LAh7Rzenbbm3y27laWesQuFl/tLJbipjl6
        qzyqr6Cj7fPQ5VHEg/+nRXH0W0jCJIY=
X-Google-Smtp-Source: APXvYqzAx/e+UzvQ6iJthYYHtEkloEggrVUZpJuTuLBoEsTWcBkm73DN/KGEHmkf1Utyp7P1VBQJ+Q==
X-Received: by 2002:ac8:2bb3:: with SMTP id m48mr3217146qtm.218.1558215321814;
        Sat, 18 May 2019 14:35:21 -0700 (PDT)
Received: from greta.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id e133sm3168333qkb.76.2019.05.18.14.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 May 2019 14:35:21 -0700 (PDT)
From:   =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?q?B=C3=A1rbara=20Fernandes?= <barbara.fernandes@usp.br>,
        Wilson Sales <spoonm@spoonm.org>
Subject: [PATCH 2/2] staging: iio: cdc: ad7150: create macro for capacitance channels
Date:   Sat, 18 May 2019 18:35:11 -0300
Message-Id: <20190518213511.23253-3-barbara.fernandes@usp.br>
X-Mailer: git-send-email 2.22.0.rc0.1.g337bb99195.dirty
In-Reply-To: <20190518213511.23253-1-barbara.fernandes@usp.br>
References: <20190518213511.23253-1-barbara.fernandes@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Create macro for capacitance channels in order to remove the repeated
code and improve its readability.

Signed-off-by: Bárbara Fernandes <barbara.fernandes@usp.br>
Signed-off-by: Wilson Sales <spoonm@spoonm.org>
Co-developed-by: Wilson Sales <spoonm@spoonm.org>
---
 drivers/staging/iio/cdc/ad7150.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index 072094227e1b..d8c43cabce25 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -468,24 +468,19 @@ static const struct iio_event_spec ad7150_events[] = {
 	},
 };
 
+#define AD7150_CAPACITANCE_CHAN(_chan)	{			\
+		.type = IIO_CAPACITANCE,			\
+		.indexed = 1,					\
+		.channel = _chan,				\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+		BIT(IIO_CHAN_INFO_AVERAGE_RAW),			\
+		.event_spec = ad7150_events,			\
+		.num_event_specs = ARRAY_SIZE(ad7150_events),	\
+	}
+
 static const struct iio_chan_spec ad7150_channels[] = {
-	{
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 0,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
-		.event_spec = ad7150_events,
-		.num_event_specs = ARRAY_SIZE(ad7150_events),
-	}, {
-		.type = IIO_CAPACITANCE,
-		.indexed = 1,
-		.channel = 1,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-		BIT(IIO_CHAN_INFO_AVERAGE_RAW),
-		.event_spec = ad7150_events,
-		.num_event_specs = ARRAY_SIZE(ad7150_events),
-	},
+	AD7150_CAPACITANCE_CHAN(0),
+	AD7150_CAPACITANCE_CHAN(1)
 };
 
 /*
-- 
2.22.0.rc0.1.g337bb99195.dirty

