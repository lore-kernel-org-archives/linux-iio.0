Return-Path: <SRS0=AU7e=RJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC23C43381
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 20:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D31920657
	for <linux-iio@archiver.kernel.org>; Wed,  6 Mar 2019 20:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXDMZoP7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbfCFU4g (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Mar 2019 15:56:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44605 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfCFU4g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 6 Mar 2019 15:56:36 -0500
Received: by mail-qk1-f193.google.com with SMTP id r21so7689334qkl.11
        for <linux-iio@vger.kernel.org>; Wed, 06 Mar 2019 12:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gAc+5t/I3Vl2Xt1ej5CqjGLDtBdnNL8t/YFpwa2ZEWM=;
        b=cXDMZoP7UC0hp7DNrnDQtdpk157pjhq8zZyfXCy/QeFp/Tav+QohwoJgIAQGdDfM7n
         rHS2QibFwyDO/8BeJcrRBVn01loWpUS65gOMZ2dK/G1Mpxa7vqQ1jAumMUFHK8IjWan/
         GOhETt4e++Tz/Gw7DqAbzNiQAn9fVyOe0cii/rzwtThQ3DplSyu5ns0RNBBqx0fnpfgM
         3AmTn/LJM0dTRfwls1E4aH6J5ToUbBmanNX2Y7Ogi8zSp1Ic4+Bxs43sX19zzjZiyYBe
         /UVgDhy7re8UYfHfOdEEgbLj9+4aavvJVAuER17RnNH8eXKEa9bK2QOe5eQ4BLfbJMaH
         Baww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gAc+5t/I3Vl2Xt1ej5CqjGLDtBdnNL8t/YFpwa2ZEWM=;
        b=uB/mT/YPx7yIhzoVTpc1I1/7oxFNnYuy1gxm1hpjsTFsDT79ZkyAp1E5gDqy5NRYJU
         t9i7zvtHpb2ns45sWheDT02orKUaI0mjyz8UWLdnN5tdT/b0yNjz26NSy1sKFKsVSQXN
         /C250tBOeSXIb34TtyH+96QlDExjKaBVpA8I8TiZW28R8kVm3SxyYntL/xmsos5lwQdM
         LDn8jq+sX0rhxxlM9/QYkbFvP9fKrvovjscQEwPRj8MvJ6YvGtoLVRopID/PLw1PwhdT
         MF63D5mpiv6dQbVhQ3vKj+MBzpfxpGvhcwdBqI9s3laGkE6U6lVVl+EeM8fiqSkV/zJR
         +jwA==
X-Gm-Message-State: APjAAAWQMVgh+UwQrXByxzplSuhmBAz2WUgByryVaUORxRw8I4bXx3LS
        wjepraL4S0pR/+IG3QGj+72zL5L6
X-Google-Smtp-Source: APXvYqzchnGtuwFf9isYBrboqVMop4saRqxKo7yd3wpjY7vduVuvBNgP/YztmxRvfHeoNrbBk2jVAg==
X-Received: by 2002:a05:620a:1362:: with SMTP id d2mr7210217qkl.210.1551905795212;
        Wed, 06 Mar 2019 12:56:35 -0800 (PST)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id s49sm1669601qtk.7.2019.03.06.12.56.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 12:56:34 -0800 (PST)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH] iio: dac: mcp4725: add missing powerdown bits in store eeprom
Date:   Wed,  6 Mar 2019 15:56:06 -0500
Message-Id: <20190306205606.30419-1-jeff.dagenais@gmail.com>
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
index 6ab1f23e5a79..97bb350d1e77 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -98,6 +98,7 @@ static ssize_t mcp4725_store_eeprom(struct device *dev,
 
 	inoutbuf[0] = 0x60; /* write EEPROM */
 	inoutbuf[0] |= data->ref_mode << 3;
+	inoutbuf[0] |= data->powerdown ? ((data->powerdown_mode+1) << 1) : 0;
 	inoutbuf[1] = data->dac_value >> 4;
 	inoutbuf[2] = (data->dac_value & 0xf) << 4;
 
-- 
2.11.0

