Return-Path: <SRS0=pZra=RO=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6653AC43381
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 11:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A6020657
	for <linux-iio@archiver.kernel.org>; Mon, 11 Mar 2019 11:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tBOQrm/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbfCKLm5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 11 Mar 2019 07:42:57 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35608 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbfCKLm5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Mar 2019 07:42:57 -0400
Received: by mail-qk1-f194.google.com with SMTP id z13so2448051qki.2
        for <linux-iio@vger.kernel.org>; Mon, 11 Mar 2019 04:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=otEej5RcPdzOe4juxbvRk7K/wZhb2jCnReTgeDE8Dks=;
        b=tBOQrm/PWrdNiXQm7wT0UgXHna/fNvkDI/yR1/KOE3rXGgOonpgdxaG/pOyUGuTDw+
         LDKHKo2j5SwH4BFKsJCKo+uNi3CvVV9TdOmPSoGRay39YGFDI55sroRbNke6JdXNLQBw
         UORvi7D5jQfjNiPCBcKJjUXymaBWuK0Pj809gJiE+h2+2m6DY8KtbyWdKQ2cYBiLx7H1
         2ZOvBOXWxqL9s3MZyP0tptxOsP+RcyN9MfhdIvh5I+Kz2tbAidVKtaQP3nyaMr4dsU09
         uFvwILhpzkq9zzUFgtABOZP22nPRQ1qW+aaPKjbKd8r0JhyQWvHuV6pnQCKX+SU3GJ9L
         zS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=otEej5RcPdzOe4juxbvRk7K/wZhb2jCnReTgeDE8Dks=;
        b=kfGKJFXMbW1B7anDUB5Di4K1CNPxeQf0ATrbJhZB2TizjnQwaQSqnaIGvNSz+Unu1B
         iOI6rY9PIESTlgW/frgYzl8BcHRgh3X+RaRo9qiaeqwxQMTXLCozVfGoM1344kVxuXVa
         oLC430tXLrSd20XQCIKVTwTCFGzYyvUa/0xMKYNdfgfEJof36/lb/64TaS6ts0jfrWWH
         9NL8KKkuZCdD2/fcBjy+LPDmBoHCJ5M4nxwKYmgCsnqnyiacrYkkw0BSpZOKJ6F8PBsm
         M5Ocpv6TP5U2YEM3KdIhMtqR7a9pQu8sdJQ/haZiBVKDwrUp1F/Xami7UgUJBHL5cp98
         ZV0A==
X-Gm-Message-State: APjAAAWzLVOWyBsE6xq0STfBPvmNJgo2r0w9abhOojbDwueOWfhJvaKz
        F8ZFp/UCK1bAF69LU0iObZDHEcoa
X-Google-Smtp-Source: APXvYqyBhVbLv+pnS2fjjU8A5wriVGXrOQwzexPT14BDi9cmko9mNhoqL+MQRCH/GrkgaMEYyP2RZQ==
X-Received: by 2002:a37:a412:: with SMTP id n18mr6624815qke.321.1552304576403;
        Mon, 11 Mar 2019 04:42:56 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id g5sm488708qke.71.2019.03.11.04.42.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 04:42:55 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH v2] iio: dac: mcp4725: add missing powerdown bits in store eeprom
Date:   Mon, 11 Mar 2019 07:42:39 -0400
Message-Id: <20190311114239.30512-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

When issuing the write DAC register and write eeprom command, the two
powerdown bits (PD0 and PD1) are assumed by the chip to be present in
the bytes sent. Leaving them at 0 implies "powerdown disabled" which is
a different state that the current one. By adding the current state of
the powerdown in the i2c write, the chip will correctly power-on exactly
like as it is at the moment of store_eeprom call.

This is documented in MCP4725's datasheet, FIGURE 6-2: "Write Commands
for DAC Input Register and EEPROM" and MCP4726's datasheet, FIGURE 6-3:
"Write All Memory Command".

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/iio/dac/mcp4725.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 6ab1f23e5a79..fe3e42defb33 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -98,6 +98,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
 
 	inoutbuf[0] = 0x60; /* write EEPROM */
 	inoutbuf[0] |= data->ref_mode << 3;
+	inoutbuf[0] |= data->powerdown ? ((data->powerdown_mode + 1) << 1) : 0;
 	inoutbuf[1] = data->dac_value >> 4;
 	inoutbuf[2] = (data->dac_value & 0xf) << 4;
 
-- 
2.11.0

