Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89531C10F11
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 544BB2075A
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 19:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwTjanrD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfDVTDg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:03:36 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46855 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfDVTDg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 22 Apr 2019 15:03:36 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so9715672lfj.13
        for <linux-iio@vger.kernel.org>; Mon, 22 Apr 2019 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Vfbcnb91USokgDkoHrXI3k17fvdBiXAecx3wORrWgGs=;
        b=MwTjanrDzdxESAEiW+tAExppCcMGxMBPF/SEC0Kj3Tl1mRULqKCt6vI2EV5I8FlraB
         XNFi10OVGnbzG9++zUHMOxViE7yT18hm9fuySSo2UeAGVYStCAtDD1S+dfVDPNyI86w+
         sVaFt3zULHG/o4dHfajgv142DpZ5wY5qp4f5L78tyW36GotziUQhS6OHeau16SiDpKnV
         LLBgHNT9NpsP6iXOM7FHdgwjVgq68LRIoZBtPIX3dsvbhCpMbne+H1gMgCFMSlYB41pb
         KHBZgdSf0vC9q4RYufNdPyFCv1bemQaiePYn4iUn3f6SMGjo8NUBqHidtf+GWzOTub3F
         HZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vfbcnb91USokgDkoHrXI3k17fvdBiXAecx3wORrWgGs=;
        b=YFIMUE5Sj13na6ff2oeS/JtWcrmi1aH38B3S0R43vTWjrXM+ntHGdJMyNbp+gLSqwk
         DU5x9pEN8/nBf+pFCSGlON25CSfN/dI6hsiaLoaoMJ1eD5avXS/4cZF6hFQ4fAkGKsZu
         kT3F0xhezgFIZK90AldIO+6GJl5PUlDrWLCuSvSLwgMx+yhDItOTeQuk023yd4DOzeqR
         R9c7rQOoOE7XkItA6031GYWR21421n2Gx3nKoQ+e0yUcRrWj5k/p5LNICNSbMPyhrTFV
         PfT3yfpmuf+Lcx3Jc0LKKnxLd6HC6XX2dBXfD6kDxuPN+jOOqqwXDFDQVUN6C+R2ATl+
         cZSg==
X-Gm-Message-State: APjAAAX8IZWebTeC05pNgRchEf3bEzy5RxOLMJYYJoAq2OpL7/uX36+H
        YvA+Ms726PjWcSwzZxMjLVk=
X-Google-Smtp-Source: APXvYqx6OKLKkXY+Aqg6auXn+BKrYNcaYUZtIZcx2S+FsSbbsdxcwk8Ko4gdAV3AkRwCRQzUT2eYtw==
X-Received: by 2002:ac2:55b2:: with SMTP id y18mr11795861lfg.133.1555959814723;
        Mon, 22 Apr 2019 12:03:34 -0700 (PDT)
Received: from localhost.localdomain (80-167-223-88-cable.dk.customer.tdc.net. [80.167.223.88])
        by smtp.gmail.com with ESMTPSA id n9sm3134061lfl.35.2019.04.22.12.03.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Apr 2019 12:03:33 -0700 (PDT)
From:   Daniel Gomez <dagmcr@gmail.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, dagmcr@gmail.com, javier@dowhile0.org
Subject: [PATCH] spi: Maxim Thermocouple temperature sensor: declare missing of table
Date:   Mon, 22 Apr 2019 21:03:12 +0200
Message-Id: <1555959792-8037-1-git-send-email-dagmcr@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing <of_device_id> table for SPI driver relying on SPI
device match since compatible is in a DT binding or in a DTS.

Before this patch:
modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
alias:          spi:max31855
alias:          spi:max6675

After this patch:
modinfo drivers/iio/temperature/maxim_thermocouple.ko | grep alias
alias:          spi:max31855
alias:          spi:max6675
alias:          of:N*T*Cmaxim,max31855C*
alias:          of:N*T*Cmaxim,max31855
alias:          of:N*T*Cmaxim,max6675C*
alias:          of:N*T*Cmaxim,max6675

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
---
 drivers/iio/temperature/maxim_thermocouple.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index c31b963..bbc5c86 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -10,6 +10,8 @@
 #include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/err.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/spi/spi.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger.h>
@@ -262,9 +264,17 @@ static const struct spi_device_id maxim_thermocouple_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, maxim_thermocouple_id);
 
+static const struct of_device_id maxim_thermocouple_spi_of_match[] = {
+        { .compatible = "maxim,max6675" },
+        { .compatible = "maxim,max31855" },
+        { },
+};
+MODULE_DEVICE_TABLE(of, maxim_thermocouple_spi_of_match);
+
 static struct spi_driver maxim_thermocouple_driver = {
 	.driver = {
 		.name	= MAXIM_THERMOCOUPLE_DRV_NAME,
+		.of_match_table = of_match_ptr(maxim_thermocouple_spi_of_match),
 	},
 	.probe		= maxim_thermocouple_probe,
 	.remove		= maxim_thermocouple_remove,
-- 
2.7.4

