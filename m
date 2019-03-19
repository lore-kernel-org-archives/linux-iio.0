Return-Path: <SRS0=6njX=RW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C6C43381
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 11:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AD8F2133D
	for <linux-iio@archiver.kernel.org>; Tue, 19 Mar 2019 11:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rc4zmp6N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfCSLAA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 19 Mar 2019 07:00:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40540 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727531AbfCSLAA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Mar 2019 07:00:00 -0400
Received: by mail-wm1-f68.google.com with SMTP id u10so13479598wmj.5
        for <linux-iio@vger.kernel.org>; Tue, 19 Mar 2019 03:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=noA5hGizQDXl6ah278hgp2vxbvOexc3UizaRJQT0CyA=;
        b=rc4zmp6NMzSIwBTu2wZcbZwvnYlvKick7B7OrJTGIqB0wvYTfbXQFBXnrrPKNUfEep
         cWxvl+oJYCBOOlxf9E9SrON4VdMx4QCMobRc4fS2fcHsV/ODiCaIe1RdylIcdcGkAuJt
         FD2sXBh1pEDb3KGIG5pCAom5mcJxkkMyVsMNlefTTQLI3akNMNBLaBszuWfEyDDTggKe
         Dsn28WzjuXn7PLDGBINPjES+AHOO6vHvEqDCO8XcMRz6EclxrJJaZUZCSr5I7XlQp38k
         sQEQ22G92u0OyCxPNs44k2RyzJJoF//hsFyuSLX2yXJbrgZquRcH4RIcws8hOvCgwnZ7
         X8WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=noA5hGizQDXl6ah278hgp2vxbvOexc3UizaRJQT0CyA=;
        b=rdB6TX0iRef4YZg2ilAVGw5Pjdb/FS5dJG43pZB7KXoVHNB8UANk+f9oi6xS1jdfy8
         m1L4sVeS/f4zq0zL7lrmeAFWj2x9G/UZqMMV285BUwp2HPVjybgjAIpINEIW6F6e70YN
         m+ewbABe6uJcaQnm2mHZ3LNM24ZDLYoZe8tv2+WaidUh8PRiysTB+OXi+ougz6JlSlLB
         EArUxE00K+TpDh36Mgukvbzip4TQAqIeoHCyZuUEqcolaRy/sUOdbfAUZE2cNSNspCaK
         7Vx9NcjZ1Eav/mjuMUdURiyjTXMLTJA1YeYGejKPc5Wl8Kn/u0JiMAAafAAZLvQgqj9y
         bFrQ==
X-Gm-Message-State: APjAAAX+SMLz+2cxti6Aab2djNSjGccW3D+2ZiFWvRtJDM+80lCOZfOn
        47TLP2lg7Lglr/mkQxeq0TsPYQ==
X-Google-Smtp-Source: APXvYqzKVL9P/19vGxW/dGX9X3MsFjndaw1O6tu39MkOESvuPaCjX4WkF0VYrbdcPgd17oExcjvM2A==
X-Received: by 2002:a1c:e185:: with SMTP id y127mr1701423wmg.76.1552993198128;
        Tue, 19 Mar 2019 03:59:58 -0700 (PDT)
Received: from arch-late.local (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id h10sm4120052wmf.2.2019.03.19.03.59.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:59:57 -0700 (PDT)
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
Subject: [PATCH v4 6/6] MAINTAINERS: add entry for fxas21002c gyro driver
Date:   Tue, 19 Mar 2019 10:59:25 +0000
Message-Id: <20190319105925.25863-7-rui.silva@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190319105925.25863-1-rui.silva@linaro.org>
References: <20190319105925.25863-1-rui.silva@linaro.org>
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
index dce5c099f43c..13e229d4a425 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10905,6 +10905,16 @@ F:	Documentation/ABI/stable/sysfs-bus-nvmem
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

