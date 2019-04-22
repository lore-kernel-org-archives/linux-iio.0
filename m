Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255A1C10F11
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93D0206A3
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4J7F0Ga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfDVTET (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:04:19 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40410 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDVTET (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Apr 2019 15:04:19 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so11193973ljq.7
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2019 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vm0GRS1t9IT0WxbJ6lnCZYUIpVGp08MplxyMFP1FVQI=;
        b=k4J7F0Gads9GyZM6wHY/PzuWLiSrm8kNkTHuabqgOrun1T1oU/2HqKt3SOKzFZrUoP
         IfzZa5pnjt5LTBD9zPOysA7KkZ/p/liT34eA/58X/Kye8jUgoP8CNXcqw2wm6da2TGS9
         UU36xEIiMG2mq8/DThiL+9h4wCln5fQUVClvOp7BQXTmbg5E0XBH3FBLxMVR1pMxn5kx
         5TyXQBGVdJQrCoeWUKq7XnsF73zpkSJ/Zw9AWdrR2U3J0ltmdyiAiEs4hR32zxm2dNyu
         ldVEEN7jDfriXfO+PZeQqtV9W/M0lavNGUhkTI3IWXVhya3R/6AHfWKH3NsRgSqhA6gZ
         hvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vm0GRS1t9IT0WxbJ6lnCZYUIpVGp08MplxyMFP1FVQI=;
        b=uMqCQ/82DFV8y+25/g+MW0rmnCXL+leqsYOyWi8aD2NgDhNHnUkjPP+V6lHZfcxnVK
         DDwAkup29OAu2f7T9x83exZpahbI8i884IwwA44UfGUn0BTfD4CszXlChjOnHOX9mAsf
         WmtlMsK0MChyUyKMAZwwmVMM26qPL6KtvsfFyf7hYeiPjmvrhuRhzWJOjnZFxkNpiLI0
         ZyGGS3KZ534Fun72K5vy/ugMFqsqbQPvQymHMO98xqWhYZZPmcq/Er6pWD8SsQTnY7Tn
         pnFKLH2n6y77idHXr3cNgwzLQoHFX5qCmE86RHC9IQRXDHt70T6z6lL6IxG023Gcng7B
         YcHg==
X-Gm-Message-State: APjAAAW5XCCWXjpkDl5LN6lpfMlqEAEeJ8NDIRtajK2kp+qR4CODWtNn
        KUhE7CDd0pgcnu8+O1qJP94=
X-Google-Smtp-Source: APXvYqyJPpnSSKvkXgNfZH9bnJ02OsWnDpti4Y9SvPMLeFDxIJFfAcDPlVhMbg24XhcyxVs55WIPxw==
X-Received: by 2002:a2e:7114:: with SMTP id m20mr11337692ljc.120.1555959857443;
        Mon, 22 Apr 2019 12:04:17 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id y3sm3149849lfh.12.2019.04.22.12.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 12:04:16 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        stefan.popa@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, dagmcr@gmail.com, javier@dowhile0.org
Subject: [PATCH] spi: AD DAC: declare missing of table
Date:   Mon, 22 Apr 2019 21:04:07 +0200
Message-Id: <1555959847-8102-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/dac/ad5758.ko | grep alias
alias:          spi:ad5758

After this patch:
modinfo drivers/iio/dac/ad5758.ko | grep alias
alias:          spi:ad5758
alias:          of:N*T*Cadi,ad5758C*
alias:          of:N*T*Cadi,ad5758

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/dac/ad5758.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 2bdf1b0..e9e038b 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -11,6 +11,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/gpio/consumer.h>
 
@@ -904,9 +906,16 @@ static const struct spi_device_id ad5758_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad5758_id);
 
+static const struct of_device_id ad5758_spi_of_match[] = {
+        { .compatible = "adi,ad5758" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, ad5758_spi_of_match);
+
 static struct spi_driver ad5758_driver = {
 	.driver = {
 		.name = KBUILD_MODNAME,
+		.of_match_table = of_match_ptr(ad5758_spi_of_match),
 	},
 	.probe = ad5758_probe,
 	.id_table = ad5758_id,
-- 
2.7.4

