Return-Path: <SRS0=kDFh=RT=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48398C43381
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 22:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EAD8218AC
	for <linux-iio@archiver.kernel.org>; Sat, 16 Mar 2019 22:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="qF6XXrT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbfCPWIr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 16 Mar 2019 18:08:47 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:42676 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbfCPWIr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 16 Mar 2019 18:08:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 69857B81
        for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2019 22:08:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sXRqhIX_ThON for <linux-iio@vger.kernel.org>;
        Sat, 16 Mar 2019 17:08:45 -0500 (CDT)
Received: from mail-it1-f197.google.com (mail-it1-f197.google.com [209.85.166.197])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3AD32B5D
        for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2019 17:08:45 -0500 (CDT)
Received: by mail-it1-f197.google.com with SMTP id y6so8723413itj.5
        for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2019 15:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cSFq9gi/n+o1aAJXKdC2m4mpRxXnRFu9Q4meSx6wM4M=;
        b=qF6XXrT8MXGLism1ur8qpXLILExLf7bGeWE2YTeG7FeRdzWHyclXIrs3ToaPZMbqI1
         RdzMVjcD83k3ivMeODxyMmjldvl5W0Kjqw29O6Od23Gd9Wg1Ip8r294lk3JJUx2mMHAo
         TRaxd+TCRiL3pvU4ZTzPHHYgv1uI+ecYlWrd1PAeJ18/xCO/nFtVYrtsq7vvWfk5ejhU
         NcTQx71mq0WQdlTnO2A4rChC5hmvgtMxQsB1/vZgvrsn3pdnhZuTGqzG+Nzoqo1BgyHy
         n3CsshZiSyLM2IYhcXCrB3WJFV5yddLzhYM7WytZcf9XbOYS7WXp/aHP3tX2DboR6G/q
         B+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cSFq9gi/n+o1aAJXKdC2m4mpRxXnRFu9Q4meSx6wM4M=;
        b=ltz5yjUJSRf/k+9vmnxOsBXyrZXMWxNroOl2oAm6O+dpj+EtB8q/zAGhy1I3Co+bCO
         PVJU93Ouw66UmncyacUr797VhlIFmSvlU2KtQYzpQsM1o9wb5bjGrg1RyPDZAI7/SYpP
         GVpv1Mlq22211/c1JuUNPGlIyVVC6SiqiUNExyWJ1+I3QhPYJTqyd4fTzFcB2dsOa3dX
         gNJW+J28cHqOPWrLU/kc5dx8hzXmxSE+kzWkc2WwYB+/yxiUulGRrbb+uAr5TaCGuIXr
         iZH5XNJautgp8JO6jt8d+4B8L1/fkjY4O1KEEQ55JtdGLsUN3Z8knIwGzCe5iC3utnaD
         14qA==
X-Gm-Message-State: APjAAAWbL8qboZqcbY+iiiGmVZeshHqtAGNQHTquz+n8G6FAhQr4LRp+
        JT6/qs3tEjmAAho36CoFBZgt9Vpi9PcO+X4qVEBpntHX/+lNFNmr1tXMO9J04HH5cWbsOqJHhis
        kuquWGrrfu5ZaEr+CvdPg/ryc
X-Received: by 2002:a05:660c:185:: with SMTP id v5mr6543042itj.34.1552774124098;
        Sat, 16 Mar 2019 15:08:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRsOT/r0to0mKwwjc3BTUyUPNDoWDmjKJ94EJ0/l1TxEJC5kf5fvYREwaqde98Oxy6Z2Hm9w==
X-Received: by 2002:a05:660c:185:: with SMTP id v5mr6543028itj.34.1552774123897;
        Sat, 16 Mar 2019 15:08:43 -0700 (PDT)
Received: from bee.dtc.umn.edu (cs-bee-u.cs.umn.edu. [128.101.106.63])
        by smtp.gmail.com with ESMTPSA id s142sm3070512itb.37.2019.03.16.15.08.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 15:08:42 -0700 (PDT)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: hmc5843: fix potential NULL pointer dereferences
Date:   Sat, 16 Mar 2019 17:08:33 -0500
Message-Id: <20190316220836.25092-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190316151912.4a7ea87d@archlinux>
References: <20190316151912.4a7ea87d@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

devm_regmap_init_i2c may fail and return NULL. The fix returns
the error when it fails.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
V2: fix the two together
---
 drivers/iio/magnetometer/hmc5843_i2c.c | 7 ++++++-
 drivers/iio/magnetometer/hmc5843_spi.c | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
index 3de7f4426ac4..86abba5827a2 100644
--- a/drivers/iio/magnetometer/hmc5843_i2c.c
+++ b/drivers/iio/magnetometer/hmc5843_i2c.c
@@ -58,8 +58,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
 static int hmc5843_i2c_probe(struct i2c_client *cli,
 			     const struct i2c_device_id *id)
 {
+	struct regmap *regmap = devm_regmap_init_i2c(cli,
+			&hmc5843_i2c_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
 	return hmc5843_common_probe(&cli->dev,
-			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
+			regmap,
 			id->driver_data, id->name);
 }
 
diff --git a/drivers/iio/magnetometer/hmc5843_spi.c b/drivers/iio/magnetometer/hmc5843_spi.c
index 535f03a70d63..8355713651d4 100644
--- a/drivers/iio/magnetometer/hmc5843_spi.c
+++ b/drivers/iio/magnetometer/hmc5843_spi.c
@@ -58,6 +58,7 @@ static const struct regmap_config hmc5843_spi_regmap_config = {
 static int hmc5843_spi_probe(struct spi_device *spi)
 {
 	int ret;
+	struct regmap *regmap;
 	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	spi->mode = SPI_MODE_3;
@@ -67,8 +68,12 @@ static int hmc5843_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	regmap = devm_regmap_init(spi, &hmc5843_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(devm_regmap);
+
 	return hmc5843_common_probe(&spi->dev,
-			devm_regmap_init_spi(spi, &hmc5843_spi_regmap_config),
+			regmap,
 			id->driver_data, id->name);
 }
 
-- 
2.17.1

