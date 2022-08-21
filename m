Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DAEC32772
	for <linux-iio@archiver.kernel.org>; Sun, 21 Aug 2022 16:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiHUQpg (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 21 Aug 2022 12:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiHUQpb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Aug 2022 12:45:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852851AD90
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 09:45:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F0E960F1E
        for <linux-iio@vger.kernel.org>; Sun, 21 Aug 2022 16:45:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF235C433D7;
        Sun, 21 Aug 2022 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661100329;
        bh=SdcjqKCI6Jn5UtVvfyoEo1n2bWlJ5r2/d5SFNaoVVXg=;
        h=From:To:Cc:Subject:Date:From;
        b=qxuqmnIZwxYOMmhQXF+vfp3vxJ33nRoLwlY2AIqlBGpgjrgune3+8wduBgfwuBvKO
         mlSC8uRXqArUcbyR/fIJ+oEnaWm+gVqoNPGEpu6WFtqnFlzooh8m2kJbL/Sr7lPlmk
         K/EQtzxYIciDKcP23mgA9zeu+A4jUSGlph7X7ZNyTlaX7tp4EXWuu9cVOvMicPyNE5
         xJZTcJOMgMbV7s0gmtsxjlXt++zLdMfouhfvFf2SkLvf7MIpVEkWv1oMpO7GLEl5yA
         V9Yug2isIY55iYAwe3Ad1V5YfBDxZURrhEIXUdaIRchG+l5uEweuIyEM5VSeacMw8V
         rkOI635URuKHQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH] iio: adc: max1363: Drop provision to provide an IIO channel map via platform data
Date:   Sun, 21 Aug 2022 17:10:58 +0100
Message-Id: <20220821161058.2207185-1-jic23@kernel.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Back in the days of board files, platform data was used to provide
information on the mapping from ADC channel to an analog signal
from another device. We've long since moved to doing this via
device tree. Hence drop the support from the max1363 driver which is
the only driver still providing this.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/max1363.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index eef55ed4814a..a28cf86cdce8 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -29,7 +29,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>
 #include <linux/iio/buffer.h>
-#include <linux/iio/driver.h>
 #include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
@@ -1595,11 +1594,6 @@ static int max1363_probe(struct i2c_client *client,
 	if (!indio_dev)
 		return -ENOMEM;
 
-	ret = devm_iio_map_array_register(&client->dev, indio_dev,
-					  client->dev.platform_data);
-	if (ret < 0)
-		return ret;
-
 	st = iio_priv(indio_dev);
 
 	mutex_init(&st->lock);
-- 
2.37.2

