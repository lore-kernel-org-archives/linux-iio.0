Return-Path: <SRS0=WqhK=5F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40AD2C4332D
	for <linux-iio@archiver.kernel.org>; Fri, 20 Mar 2020 16:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16DA320753
	for <linux-iio@archiver.kernel.org>; Fri, 20 Mar 2020 16:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuvKruss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCTQFj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:05:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38535 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCTQFi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2020 12:05:38 -0400
Received: by mail-wm1-f65.google.com with SMTP id l20so6960961wmi.3;
        Fri, 20 Mar 2020 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JLEsYKEREffsW91fxuckpfdebz0coXr2sPxg/jgVCHM=;
        b=MuvKrussVl9pwXnOM+bNZBHkwf1MLFgdly3pUAxpm8lOMO4C4syYKHEOBxgggXn4PF
         +IVQnuOJeUOeVSGPykQ1cQRFOwFWQy6egd3ZitrUZQ2x5qZ61K8WuxacT5YmUs2GzvFW
         M+p9RIg/izPXI3z1eLeRpDUuq/VEUzt5V2a6REHHXD9wNwY6XleAV0m+BYoKWoS61Wto
         +/KY2J+n96EtAwrymn88daU24CQLSIV76JQz7yzT6l5JT6s5ateNwae6ukazrVlIXbyP
         v3Wi78gA+wuN5uD7U4wFcxJQkqi3Y8SzqSlmlMDhHtJc7gIx9fNH1oHet4ExuCs+Evj3
         Ni4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JLEsYKEREffsW91fxuckpfdebz0coXr2sPxg/jgVCHM=;
        b=gsn6y7qx3oK2uXOB1rWaBHmuI+A+iiEE4G6bHk2RfHuruAH+TYf5ZMRmXSUFSoL1F1
         jmXa2uPjMeQ75GOXlr60eGGpbdtykoFjKCH5Qh8XYRub3JBdrQiverQp3Wwpc+lVc7oI
         6/LCZhNuMhVAWwmq/X0c944ecPcXaV3fsIuQh8Q6mB1khpr/2rRLE5yNugI5vj5210yu
         wXrCD17MlGHUpzT7jUQVN+4JJLgCOpRklEyrUeDY+11eE4LP+V5vmQlN1D7XzonxwKov
         ai7tyrym/l8j06bwPz73RTUPFJelh/mpWkmea9JBVrc0SGtURFcnVm79r9l0xRPi/jBY
         Vs8g==
X-Gm-Message-State: ANhLgQ2nsm5tRw3rHaRVSzrt1FQdasf0jNKAogguUVcjoqjnQ4HHjYf0
        JalqvQxkWD1cOLag9APSTu0M8C8c
X-Google-Smtp-Source: ADFU+vv2g9mEmlmLuUNwkh5Gn37HsYa8JGyksjC3efeN/he8FlIZu8d+CEQb1wAfPGixwgEmp7Vw0w==
X-Received: by 2002:a1c:5452:: with SMTP id p18mr11431681wmi.102.1584720334196;
        Fri, 20 Mar 2020 09:05:34 -0700 (PDT)
Received: from localhost.localdomain ([95.77.248.51])
        by smtp.gmail.com with ESMTPSA id k3sm8348895wro.59.2020.03.20.09.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 09:05:33 -0700 (PDT)
From:   Alexandru Tachici <tachicialex@gmail.com>
X-Google-Original-From: Alexandru Tachici <alexandru.tachici@analog.com>
To:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     jic23@kernel.org
Subject: [PATCH 1/2] iio: dac: ad5770r: read channel nr from reg
Date:   Fri, 20 Mar 2020 18:05:30 +0200
Message-Id: <20200320160531.23732-2-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200320160531.23732-1-alexandru.tachici@analog.com>
References: <20200320160531.23732-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Read channel number from the reg property of each child
node.

Fixes: cbbb819837f6 ("iio: dac: ad5770r: Add AD5770R support")
Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/iio/dac/ad5770r.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5770r.c b/drivers/iio/dac/ad5770r.c
index a98ea76732e7..6302f11551d4 100644
--- a/drivers/iio/dac/ad5770r.c
+++ b/drivers/iio/dac/ad5770r.c
@@ -522,7 +522,7 @@ static int ad5770r_channel_config(struct ad5770r_state *st)
 		return -EINVAL;
 
 	device_for_each_child_node(&st->spi->dev, child) {
-		ret = fwnode_property_read_u32(child, "num", &num);
+		ret = fwnode_property_read_u32(child, "reg", &num);
 		if (ret)
 			return ret;
 		if (num > AD5770R_MAX_CHANNELS)
-- 
2.20.1

