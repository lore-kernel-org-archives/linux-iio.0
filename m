Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EFDC10F11
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 003F22075A
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuYOaE5+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfDVTFe (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:05:34 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35313 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVTFe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Apr 2019 15:05:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id t4so11202669ljc.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2019 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Rji9U5yiKQMIh3jrJfxFqrp7UKvtI7bqQfxFaHKXRfk=;
        b=JuYOaE5+3EEifQp3uT4wB9vSMXoTo5LB6HOov3irab6XBPHwxB3+tqu93eTJzQBV/c
         4kr2tyf1tmMV9tjFLu1z51uwrOoq2tzRKkSmjYfgdOm4wz8DHJV1By4TwOazJJC45GIy
         Hb9vyH0XPYA7z9kQfUEj+5DsOQuj2Tm1qwKeAe8AJehCU3yHXKNJ7B6OgUO1X0qVRfEL
         WoqxngvVuw7Fvu0PcnJCNtQIp5KH89YJif9UQlsYoHaaSDEpn05av7HnI0lMDOJjMJAi
         M/boMZR+kxXv391sv9n4dYFtwbe4f+P5rIPYXFyjjxEUnZMJeEHp0KP9dnnzWrOMF0Nj
         4Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rji9U5yiKQMIh3jrJfxFqrp7UKvtI7bqQfxFaHKXRfk=;
        b=mbUUV+IO0D/19fvPIVqLKdowv+81HvTW7VGiBenKqNqf++qn945/7fj56kWm35s/Oj
         lUREkz2CAuBlS+Hl/hUgM5oTqzomFR3qp8Kr9pU+eI+X5jGhFHjEcr9dsB0IBB9GHJPY
         qRAMufS0ci7a9hdyibX7UFUOtweYBnxzZLikR3zfiqdW1EtEB5T/1l1ICoqCBWy6lNGj
         hidZlUkGUUGE5xnK8U2oVsExbo/wBFoTksu4sgFy0Jc5SvIWnYHVld/ukhi6qjJ3HbWI
         Ge2G/O1ohpepM7bHUFkwCy88JznE8k/23uEFbF4IM6bN6XIOB8CaPOJEOHnw4vptgYiX
         dczw==
X-Gm-Message-State: APjAAAVqvARgCfOTqESboMo6l2BUfz9ip/Kmr5rUFPx6n8iOKDVL8dvH
        gbP+3LkV1Rh09snvfTHgLsc=
X-Google-Smtp-Source: APXvYqxybPQEUhbDsnva/2o3qnqgw9w7xFp0ZUfXCD/PfGIpoYA4zxAZM5L9Auex4ZNiw9P7uoMMOg==
X-Received: by 2002:a2e:9d99:: with SMTP id c25mr11185979ljj.159.1555959932728;
        Mon, 22 Apr 2019 12:05:32 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id q29sm2854313ljc.8.2019.04.22.12.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 12:05:32 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     jic23@kernel.org
Cc:     stefan.popa@analog.com, lars@metafoo.de,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, dagmcr@gmail.com, javier@dowhile0.org
Subject: [PATCH] spi: AD accelerometer: declare missing of table
Date:   Mon, 22 Apr 2019 21:05:16 +0200
Message-Id: <1555959916-8207-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/accel/adxl372_spi.ko | grep alias

After this patch:
modinfo drivers/iio/accel/adxl372_spi.ko | grep alias
alias:          spi:adxl372
alias:          of:N*T*Cadi,adxl372C*
alias:          of:N*T*Cadi,adxl372

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/accel/adxl372_spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/accel/adxl372_spi.c b/drivers/iio/accel/adxl372_spi.c
index e14e655..af0624b 100644
--- a/drivers/iio/accel/adxl372_spi.c
+++ b/drivers/iio/accel/adxl372_spi.c
@@ -7,6 +7,8 @@
 
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 
 #include "adxl372.h"
@@ -37,9 +39,16 @@ static const struct spi_device_id adxl372_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adxl372_spi_id);
 
+static const struct of_device_id adxl372_spi_of_match[] = {
+        { .compatible = "adi,adxl372" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, adxl372_spi_of_match);
+
 static struct spi_driver adxl372_spi_driver = {
 	.driver = {
 		.name = "adxl372_spi",
+		.of_match_table = of_match_ptr(adxl372_spi_of_match),
 	},
 	.probe = adxl372_spi_probe,
 	.id_table = adxl372_spi_id,
-- 
2.7.4

