Return-Path: <SRS0=TPgR=R5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EA3C43381
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6941320863
	for <linux-iio@archiver.kernel.org>; Tue, 26 Mar 2019 10:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P9ZAveC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfCZKRX (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 26 Mar 2019 06:17:23 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50570 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCZKRW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2019 06:17:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id z11so12050812wmi.0
        for <linux-iio@vger.kernel.org>; Tue, 26 Mar 2019 03:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fylf7pTOJC8ppYoSWOQNUlj74ePm38xqTj3FfXozA2w=;
        b=P9ZAveC3HcU+GRwveIhtJfwnaNrvMsjAEX0iSbNmrsepR3IlZa1a26ofUEAAmIuuY5
         NfP3b5w4GNbxXULggMHem9GBJTuqtE4tHuo+7whWBHIBZDRHteyKiYDXDTfUvtF7SdpX
         NCIwKUiLwK1BVsxFQEM8Io9ZvJRolVJ+nRHZ3wchvVODM1hqCQZUTDj+9ZEslKEhogxb
         vcL8Ub+HYuvqobIalyYRAxWhbMO+H+OQTVjZVanZ94sdBmoNNvPd9RzA2ATRYF2T2Nzr
         toSmlQUD25d7FOLLNnLmT4/ftOZAkBcd+ydkVf9rTQkN8pFUGB+pVEBBNWltt9vC2tsh
         5RJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fylf7pTOJC8ppYoSWOQNUlj74ePm38xqTj3FfXozA2w=;
        b=AiJi8NOc0JsFZcxRHHMWg3jxn8sJBhy3GI71Ef7pZ266veSYrjA9E3/2ea+ioc+n2F
         0OF8ZZDdD3IPKX/RwNZPEzxCR9Sdf2IGmR7HB/93CiwJnR6ulj4DjvrGVqkxvYRMy9C1
         sVEzDDzTe2h0z+h6boWXY3Ukwg6u3Or7WVm+NNdcWpx2pJBJDlmF+5SUxEmMEuJHJZn0
         0j5RXN++vY3d20QqCbuj75eThT77DhjlDv9mTGZWyWoNL05c2aApKgqnIiAsStmm1BBI
         GJzMEYCffJwCaYNj3uG2F71jgijS3xctDyJC5CIWS44lfcLUSvXKUM6+/jcpQizBNGNY
         RzLA==
X-Gm-Message-State: APjAAAV87ppfx8/Lzaq7VyVzQK/iKajzprXFR1vtT5ZLTZMk0+CSHZy2
        dA2f8fVo1D8DLcfBweYXVE/npA==
X-Google-Smtp-Source: APXvYqwlQPYyKaGSKwQOVKbDDwxvE1TqpXZeIVwMmELCLcHNhSVgBMlKkdwRquijHqnpHoOGeiIVnA==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr7227725wmt.33.1553595440833;
        Tue, 26 Mar 2019 03:17:20 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id j1sm22281024wme.4.2019.03.26.03.17.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 03:17:20 -0700 (PDT)
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rui Miguel Silva <rui.silva@linaro.org>
Subject: [PATCH v5 6/6] MAINTAINERS: add entry for fxas21002c gyro driver
Date:   Tue, 26 Mar 2019 10:16:51 +0000
Message-Id: <20190326101651.25056-7-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326101651.25056-1-rui.silva@linaro.org>
References: <20190326101651.25056-1-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add me as maintainer of the nxp fxas21002c gyroscope driver.

Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e17ebf70b548..2748e406889c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11107,6 +11107,16 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
 F:	include/linux/nvmem-consumer.h
 F:	include/linux/nvmem-provider.h
 
+NXP FXAS21002C DRIVER
+M:	Rui Miguel Silva <rmfrfs@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/gyroscope/fxas21002c.txt
+F:	drivers/iio/gyro/fxas21002c_core.c
+F:	drivers/iio/gyro/fxas21002c.h
+F:	drivers/iio/gyro/fxas21002c_i2c.c
+F:	drivers/iio/gyro/fxas21002c_spi.c
+
 NXP SGTL5000 DRIVER
 M:	Fabio Estevam <festevam@gmail.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
-- 
2.21.0

