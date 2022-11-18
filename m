Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BCA9C433FE
	for <linux-iio@archiver.kernel.org>; Fri, 18 Nov 2022 22:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiKRWwE (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Nov 2022 17:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiKRWv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 17:51:27 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F743BB44B
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 14:47:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA84-0000Jk-1p; Fri, 18 Nov 2022 23:46:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA7y-0058G6-TA; Fri, 18 Nov 2022 23:46:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA7y-00Hb1t-Q1; Fri, 18 Nov 2022 23:46:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 108/606] iio: imu: fxos8700_i2c: Convert to i2c's .probe_new()
Date:   Fri, 18 Nov 2022 23:37:22 +0100
Message-Id: <20221118224540.619276-109-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118224540.619276-1-uwe@kleine-koenig.org>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

.probe_new() doesn't get the i2c_device_id * parameter, so determine
that explicitly in the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/imu/fxos8700_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/fxos8700_i2c.c b/drivers/iio/imu/fxos8700_i2c.c
index 40a570325b0a..a74a15fda8cb 100644
--- a/drivers/iio/imu/fxos8700_i2c.c
+++ b/drivers/iio/imu/fxos8700_i2c.c
@@ -18,9 +18,9 @@
 
 #include "fxos8700.h"
 
-static int fxos8700_i2c_probe(struct i2c_client *client,
-			      const struct i2c_device_id *id)
+static int fxos8700_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct regmap *regmap;
 	const char *name = NULL;
 
@@ -60,7 +60,7 @@ static struct i2c_driver fxos8700_i2c_driver = {
 		.acpi_match_table       = ACPI_PTR(fxos8700_acpi_match),
 		.of_match_table         = fxos8700_of_match,
 	},
-	.probe          = fxos8700_i2c_probe,
+	.probe_new      = fxos8700_i2c_probe,
 	.id_table       = fxos8700_i2c_id,
 };
 module_i2c_driver(fxos8700_i2c_driver);
-- 
2.38.1

