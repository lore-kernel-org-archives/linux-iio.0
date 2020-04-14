Return-Path: <SRS0=scjX=56=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1002AC2BB85
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9ADB2074D
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586890212;
	bh=Qr/sUzlLBeiS7flY0fWa67V38Y7Io0QddHUGCTBCdz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JAjHCLpprynV1DOX1Erm4+y1vaqcnuAd4iodhEZrKVYma19Qi6AUVlJ8mLYkUApDy
	 Iz8LansRs5BwfVzW4ECtUlU6eybB+kHk2RM93QfiPyZoOcxvG8nqdou/XGMep3vfti
	 OWHzljV/aACk5x8NsSn5hsOc0jpMFHggR8eeEZW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504425AbgDNSuE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 14 Apr 2020 14:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504413AbgDNSt5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 14:49:57 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E812074D;
        Tue, 14 Apr 2020 18:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586890197;
        bh=Qr/sUzlLBeiS7flY0fWa67V38Y7Io0QddHUGCTBCdz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGQet9UXzHdqBwr1sEGjsHPwT9oVtzZeN9iYDmFX4nXarxzOvU+b6gTLCH3Dvzv54
         mD6YhT5U5fqveMXtJPaWwUFBVafte2HxsOjRlEuXU1+pwDdI7/DOYQFiff0D5dXJaj
         qnR9pu7AOBd6Nhw1aQ9a0DGy4fNrD8pEwH31uwmg=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [RESEND PATCH v3 3/3] iio: chemical: Add OF match table for CCS811 VOC sensor
Date:   Wed, 15 Apr 2020 00:19:30 +0530
Message-Id: <20200414184930.5576-4-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414184930.5576-1-mani@kernel.org>
References: <20200414184930.5576-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Add devicetree OF match table support for CCS811 VOC sensor.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/iio/chemical/ccs811.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 1500e4b0dfbd..3ecd633f9ed3 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -549,9 +549,16 @@ static const struct i2c_device_id ccs811_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ccs811_id);
 
+static const struct of_device_id ccs811_dt_ids[] = {
+	{ .compatible = "ams,ccs811" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ccs811_dt_ids);
+
 static struct i2c_driver ccs811_driver = {
 	.driver = {
 		.name = "ccs811",
+		.of_match_table = ccs811_dt_ids,
 	},
 	.probe = ccs811_probe,
 	.remove = ccs811_remove,
-- 
2.17.1

