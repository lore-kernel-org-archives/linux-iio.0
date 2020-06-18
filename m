Return-Path: <SRS0=n5n8=77=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B95C433DF
	for <linux-iio@archiver.kernel.org>; Thu, 18 Jun 2020 02:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFB9C20720
	for <linux-iio@archiver.kernel.org>; Thu, 18 Jun 2020 02:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447842;
	bh=EIJbw7mKgkDtoV/1GnE7maH6brijqvufX+8YAgg0Br4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PF0CI7TBemNdmupW0vWGqSjdBrK1RDpW0UeXLRclmtsUfb9KQ5Xj7S/nESVPMcYgN
	 4G7QyK6TQhdVZ0exB2OsymRdEZ2B3LlfGuTUFViR+UHh95ZnG8cs0wvNZ8jL/QyBAI
	 gXmKTvWep0JU8wjUD2GYadygmyNc1IJgS0zBXtLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387658AbgFRChM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:37:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbgFRBNo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 17 Jun 2020 21:13:44 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59C1B221EB;
        Thu, 18 Jun 2020 01:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442824;
        bh=EIJbw7mKgkDtoV/1GnE7maH6brijqvufX+8YAgg0Br4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6jneSvyEPsmasmNOgTiidalOKkMZp6rfkaokmUejmzlUDVJ5tAzRFS3CswAfPgZB
         HMLAYB6EAi798jA9T0MjVEQPEwjV8KXn+XN30LeHEcxOZ4DLuP28g2KKL/C6yFr7l8
         i2xJPPOHdWG+6Zi2WDCr68yvrqu1toCevEYOVTE0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jonathan Bakker <xc-racer2@live.ca>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 260/388] iio: light: gp2ap002: Take runtime PM reference on light read
Date:   Wed, 17 Jun 2020 21:05:57 -0400
Message-Id: <20200618010805.600873-260-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

[ Upstream commit f6dbf83c17cb223ceabd7c42d441414f3e0e8a86 ]

The light sensor needs the regulators to be enabled which means
the runtime PM needs to be on.  This only happened when the
proximity part of the chip was enabled.

As fallout from this change, only report changes to the prox
state in the interrupt handler when it is explicitly enabled.

Fixes: 97d642e23037 ("iio: light: Add a driver for Sharp GP2AP002x00F")
Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/gp2ap002.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index b7ef16b28280..7a2679bdc987 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -158,6 +158,9 @@ static irqreturn_t gp2ap002_prox_irq(int irq, void *d)
 	int val;
 	int ret;
 
+	if (!gp2ap002->enabled)
+		goto err_retrig;
+
 	ret = regmap_read(gp2ap002->map, GP2AP002_PROX, &val);
 	if (ret) {
 		dev_err(gp2ap002->dev, "error reading proximity\n");
@@ -247,6 +250,8 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
 	int ret;
 
+	pm_runtime_get_sync(gp2ap002->dev);
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		switch (chan->type) {
@@ -255,13 +260,21 @@ static int gp2ap002_read_raw(struct iio_dev *indio_dev,
 			if (ret < 0)
 				return ret;
 			*val = ret;
-			return IIO_VAL_INT;
+			ret = IIO_VAL_INT;
+			goto out;
 		default:
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+out:
+	pm_runtime_mark_last_busy(gp2ap002->dev);
+	pm_runtime_put_autosuspend(gp2ap002->dev);
+
+	return ret;
 }
 
 static int gp2ap002_init(struct gp2ap002 *gp2ap002)
-- 
2.25.1

