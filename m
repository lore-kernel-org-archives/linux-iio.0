Return-Path: <SRS0=Ovgp=YQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7786BCA9EB6
	for <linux-iio@archiver.kernel.org>; Wed, 23 Oct 2019 08:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7BF21906
	for <linux-iio@archiver.kernel.org>; Wed, 23 Oct 2019 08:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OzzgfmEc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390314AbfJWItI (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 23 Oct 2019 04:49:08 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36538 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387829AbfJWItI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2019 04:49:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so20190035ljj.3
        for <linux-iio@vger.kernel.org>; Wed, 23 Oct 2019 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYTwS9JVIc/vjYRIXBD99W88cNw3SraU5JN1upXaT5k=;
        b=OzzgfmEcDGAskwfQFhULOwobx8kGWuEnlFI9y6y2j5jrB9x3ukijfMjKnncRKpfGkK
         TZK32Ar7m3ExHeWyIvYqpW6Ghjmz7KF9KNZ2M0WnRmksptZPNtWymjXzAEg78re+nYLg
         DTpUMLruUME/AMpkm9hQ0z+sJnTMn2U4maKM82JTrYPbY+Jo08Cj726Mobw1Q3JkIIEx
         dV4tnxeiGySjT8O99dNrQA//CGhcl7AZh/zu1lzQ6wgi1fEnjVRp6Q1M8qdTTCKTxPOr
         CaQg5u8Aji4PeKFDRmbf5lH4MvIzoCKWDycHgyWC1aaXoFutGMfWQ6EGhrYg24KVWdiv
         MIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IYTwS9JVIc/vjYRIXBD99W88cNw3SraU5JN1upXaT5k=;
        b=bDR0RrPyGbz9mbm89XRaqWk7yGAEpIOruSKCa84drlTYvlcbLMb69/ZAaxOttWmrFs
         qoYErK8ca3JFOayDdsgDL7KlwrxEJXOC3OgEOImBMTZTV/PPRkBkjo0xMioJUvHpkrwM
         i1B8kzhH6aA9up7MzKnM4kEz959isUSel5X4hSZs7KBVxMUpvSrd8emK/XbZok4ND7nV
         BSlpSiZbuFGk7TzuLyQAbP1UhE4VzDtqv3YXo41YhNI53mQuen8LVKJ7PUhw45JBk/HY
         CEdeN0unSDLGzULyQHa2rZsku3YMypfno3Zz1fV93BS48toQLcWnlbDkNG8zoeqnK3BU
         G/UA==
X-Gm-Message-State: APjAAAUKuOKjSXu/aw+6GEQZkM6U2KdSldx12m5ut4H20st6BrbI0VW5
        gOD8hk++SLXUQzUBpwvjTgu+GA==
X-Google-Smtp-Source: APXvYqyg6Gn7eqZecTroojuLP060OG96tZlC+o+bWqF3lmtqhNdENM9cVPGX3H8STPlgqXFLTqmlwg==
X-Received: by 2002:a2e:b537:: with SMTP id z23mr1641311ljm.129.1571820546640;
        Wed, 23 Oct 2019 01:49:06 -0700 (PDT)
Received: from localhost.localdomain (c-79c8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.200.121])
        by smtp.gmail.com with ESMTPSA id x17sm8396065lji.62.2019.10.23.01.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 01:49:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: st: Drop GPIO include
Date:   Wed, 23 Oct 2019 10:47:02 +0200
Message-Id: <20191023084702.22969-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

None of the ST sensor drivers use any symbols from
<linux/gpio.h>, just drop the include from all of them.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_core.c       | 1 -
 drivers/iio/gyro/st_gyro_core.c         | 1 -
 drivers/iio/magnetometer/st_magn_core.c | 1 -
 drivers/iio/pressure/st_pressure_core.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 2e37f8a6d8cf..7b837641f166 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -15,7 +15,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index c0acbb5d2ffb..57be68b291fa 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -14,7 +14,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index a3a268ee2896..e68184a93a6d 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -14,7 +14,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index ca6863b32a5f..bd972cec4830 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -14,7 +14,6 @@
 #include <linux/types.h>
 #include <linux/interrupt.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
 #include <linux/irq.h>
 #include <linux/delay.h>
 #include <linux/iio/iio.h>
-- 
2.21.0

