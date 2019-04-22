Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EA4C10F11
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5EE721738
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Fm0vu2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbfDVTEx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:04:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39550 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDVTEx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Apr 2019 15:04:53 -0400
Received: by mail-lf1-f66.google.com with SMTP id d12so9748587lfk.6
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2019 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EiM5o/sn9LF5pkRPe4CAluV0I7D54w9AJ0lNiDcboZg=;
        b=A9Fm0vu2cK7bqoTqjPbCxNiyXdzchsU/KZlRzrmvSiOtNx4IPmvEKKXHMX5CjpwPPZ
         hapOFONjsAqLK0aebLMpQpL1llt2c856n29LPDc2Krc5FIlOljjBAPZEaYA4pTxOibF/
         9jaC5L2OaqmsOjYrn/bZKQPF5+KFPXUzAzlbjM9Hfr/UJvCY4hmn9+Fig7b/b8Zjq/T9
         q+eQlWJSD92HtdVnZSHCB+S0C/ajEdrdRVrrJce2dy5FozIsJ7dN/4aJfrRp9Bkdtp1H
         sVI8wukXc9n9TGJ7IjCCwbtpukYE2i3mYQAQEm7UT/5c0LfPV7i41gW2YPpMtWqVEKsQ
         FkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EiM5o/sn9LF5pkRPe4CAluV0I7D54w9AJ0lNiDcboZg=;
        b=qo8lWEajB9hjvXjgWSDmObCK/pDp1gcUYnSpCUifNV6F1qwrj/JUiXCjah/MHYL/5d
         XVx8OfmDCCydPJdKWhoQMiW9AZFPtpZjtrS3a7PAMw/bvyXZrMFOTsIUapTAFYTlL4bn
         BC9iZ9ZZNzpsMPPnpfIcRLimKqosWpwMgCIXPVZ6pBhRJVlDHtVTypyXEzRTaLYrlcrH
         UQTzAnOljl9La/2ZF5dFhSFl6sP4MYETXGczafIzdouigsCsq6ff6ioYPIMioRzhyx8V
         2rI+dUo4FDDtLigyXM7Pt7l70ESZIUJBH9m+oBgLwPUdlVuwQlFHdkGIRODHeDaSnnkB
         JHIg==
X-Gm-Message-State: APjAAAWHnw3c0D23DT+HMnqkArOj2M7Vt+vnHxginl3WnICJy/Uukp6s
        UlB26q7kpkEvwcQ52ECo6vaSpFYxw9k=
X-Google-Smtp-Source: APXvYqzBP5DTf0hk9jcLoP8K9Nxw5lrTurtmr6cE0IM6GT0ff9juIOdYFYSsFl4HsDosqaGuzoH26Q==
X-Received: by 2002:a19:f24c:: with SMTP id d12mr11231054lfk.163.1555959891657;
        Mon, 22 Apr 2019 12:04:51 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id w2sm55199ljh.72.2019.04.22.12.04.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 12:04:51 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, dagmcr@gmail.com, javier@dowhile0.org
Subject: [PATCH] spi: Kionix accelerometer: declare missing of table
Date:   Mon, 22 Apr 2019 21:04:40 +0200
Message-Id: <1555959880-8152-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/accel/kxsd9-spi.ko  | grep alias
alias:          spi:kxsd9

After this patch:
modinfo drivers/iio/accel/kxsd9-spi.ko  | grep alias
alias:          spi:kxsd9
alias:          of:N*T*Ckionix,kxsd9C*
alias:          of:N*T*Ckionix,kxsd9

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/accel/kxsd9-spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index b7d0078..f538843 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -1,5 +1,7 @@
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -40,10 +42,17 @@ static const struct spi_device_id kxsd9_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, kxsd9_spi_id);
 
+static const struct of_device_id kxsd9_spi_of_match[] = {
+        { .compatible = "kionix,kxsd9" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, kxsd9_spi_of_match);
+
 static struct spi_driver kxsd9_spi_driver = {
 	.driver = {
 		.name = "kxsd9",
 		.pm = &kxsd9_dev_pm_ops,
+		.of_match_table = of_match_ptr(kxsd9_spi_of_match),
 	},
 	.probe = kxsd9_spi_probe,
 	.remove = kxsd9_spi_remove,
-- 
2.7.4

