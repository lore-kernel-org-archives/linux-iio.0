Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589DFC4321E
	for <linux-iio@archiver.kernel.org>; Fri, 18 Nov 2022 22:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiKRWwz (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Nov 2022 17:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiKRWwW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 17:52:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE78A2886
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 14:47:31 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8C-0000us-QO; Fri, 18 Nov 2022 23:46:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA88-0058Jf-7e; Fri, 18 Nov 2022 23:46:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA88-00Hb4s-II; Fri, 18 Nov 2022 23:46:40 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Machata <petrm@nvidia.com>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 155/606] iio: magnetometer: bmc150_magn_i2c: Convert to i2c's .probe_new()
Date:   Fri, 18 Nov 2022 23:38:09 +0100
Message-Id: <20221118224540.619276-156-uwe@kleine-koenig.org>
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
 drivers/iio/magnetometer/bmc150_magn_i2c.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index 570deaa87836..44b8960eea17 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -16,9 +16,9 @@
 
 #include "bmc150_magn.h"
 
-static int bmc150_magn_i2c_probe(struct i2c_client *client,
-				 const struct i2c_device_id *id)
+static int bmc150_magn_i2c_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct regmap *regmap;
 	const char *name = NULL;
 
@@ -71,7 +71,7 @@ static struct i2c_driver bmc150_magn_driver = {
 		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
 		.pm	= &bmc150_magn_pm_ops,
 	},
-	.probe		= bmc150_magn_i2c_probe,
+	.probe_new	= bmc150_magn_i2c_probe,
 	.remove		= bmc150_magn_i2c_remove,
 	.id_table	= bmc150_magn_i2c_id,
 };
-- 
2.38.1

