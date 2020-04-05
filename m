Return-Path: <SRS0=q/te=5V=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F071C2BA15
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 18:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34B6E206C3
	for <linux-iio@archiver.kernel.org>; Sun,  5 Apr 2020 18:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586109945;
	bh=t9P+pyoUFij+kWGMhTYvvxg/WLmtzDg9rE3VUgRhm2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O3E1J2r5MTMPD9jmEucCTJbfHOHw8JsEDUNv4zYfCtQ7PoKIcDoDDct+nzv7VO/Ke
	 jesKeGmsT5d24Rg4bA+8a/6DmrAQORZWg+L5+fwZqQ2FNPtm9G+CdnJ9OD2eXFZFRq
	 NeEezlBuQkR9NxASbJWkHt9vgXevOEiqf6Uhqzp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgDESFo (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 5 Apr 2020 14:05:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbgDESFo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Apr 2020 14:05:44 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E9DB20678;
        Sun,  5 Apr 2020 18:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586109944;
        bh=t9P+pyoUFij+kWGMhTYvvxg/WLmtzDg9rE3VUgRhm2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M79BDxoVMqNtxlnhxZ9ABH4zs4XihKZMAcJSmBdVz5yRd4GoYB0A31ymutjPQpmwD
         KRaBJsNMIw6gDTqyzGShFk7fCzyRUi2mO7FyA8vD4hNJXLspTjRKrrGwWSufOB8+f3
         LlH2mfDUv5qX9yWX7JJ+s8GCuiW9CYrkEph7RrD0=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 1/6] iio:accel:mxc4005: Drop unnecessary explicit casts in regmap_bulk_read calls
Date:   Sun,  5 Apr 2020 19:03:16 +0100
Message-Id: <20200405180321.1737310-2-jic23@kernel.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200405180321.1737310-1-jic23@kernel.org>
References: <20200405180321.1737310-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

regmap_bulk_read takes a void * for its val parameter. It certainly
makes no sense to cast to a (u8 *) + no need to explicitly cast
at all when converting another pointer type to void *.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mxc4005.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index 3d5bea651923..9d07642c0de1 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -135,7 +135,7 @@ static int mxc4005_read_xyz(struct mxc4005_data *data)
 	int ret;
 
 	ret = regmap_bulk_read(data->regmap, MXC4005_REG_XOUT_UPPER,
-			       (u8 *) data->buffer, sizeof(data->buffer));
+			       data->buffer, sizeof(data->buffer));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read axes\n");
 		return ret;
@@ -150,7 +150,7 @@ static int mxc4005_read_axis(struct mxc4005_data *data,
 	__be16 reg;
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, addr, (u8 *) &reg, sizeof(reg));
+	ret = regmap_bulk_read(data->regmap, addr, &reg, sizeof(reg));
 	if (ret < 0) {
 		dev_err(data->dev, "failed to read reg %02x\n", addr);
 		return ret;
-- 
2.26.0

