Return-Path: <SRS0=scjX=56=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE70BC2BA19
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 15:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A693D20768
	for <linux-iio@archiver.kernel.org>; Tue, 14 Apr 2020 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586878494;
	bh=Oc9ojVnSei1ncXI3HlXO8s4gqtOD7PSAftmFoOPklOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YMdoiuD3J/5Jezc3jO3aL/fnIsLdNOmo8YSdV4mtcIvD8zW840N4h8uB65Pkh61hW
	 cG2YQDzCbjNfHM4WcMZeVWQ/cQ0ixroj+YpsB27ORoP8B0ypcrK0HAE8l1x0Koj8hS
	 yKRSkwU3Ds+sHLr7eoq2SHUpYY1WOoZpDLE7XU2I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439892AbgDNPeu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:34:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439882AbgDNPep (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 14 Apr 2020 11:34:45 -0400
Received: from localhost.localdomain (unknown [157.50.36.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4DDD20678;
        Tue, 14 Apr 2020 15:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878484;
        bh=Oc9ojVnSei1ncXI3HlXO8s4gqtOD7PSAftmFoOPklOY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=enZpW1mZ6n3HX88iREH1EmVvt8RxSbz6X/eYdqubeNcGeWvc633gbp6FGhVNgj7XO
         LgJoHPshqy6WMTUyZ3S7XsQaMrHbi+9wwCRaoTQN/BsZnfpM699Qn/F5NzEqXNZ5BH
         EuYzQN1PnBRvx+fskzc47UcfSFBlgscEDAwqRttc=
From:   mani@kernel.org
To:     jic23@kernel.org, robh+dt@kernel.org, narcisaanamaria12@gmail.com
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 3/3] iio: chemical: Add OF match table for CCS811 VOC sensor
Date:   Tue, 14 Apr 2020 21:04:15 +0530
Message-Id: <20200414153415.957-4-mani@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200414153415.957-1-mani@kernel.org>
References: <20200414153415.957-1-mani@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Manivannan Sadhasivam <mani@kernel.org>

Add devicetree OF match table support for CCS811 VOC sensor.

Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
---
 drivers/iio/chemical/ccs811.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 951358710f64..310e9dedc9ba 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -538,9 +538,16 @@ static const struct i2c_device_id ccs811_id[] = {
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

