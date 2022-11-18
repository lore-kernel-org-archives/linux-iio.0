Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706FC4332F
	for <linux-iio@archiver.kernel.org>; Sat, 19 Nov 2022 00:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiKSALK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Nov 2022 19:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiKSAKB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 19:10:01 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9748A1106
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 15:33:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8B-0000on-6d; Fri, 18 Nov 2022 23:46:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA86-0058In-H4; Fri, 18 Nov 2022 23:46:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA85-00Hb3z-On; Fri, 18 Nov 2022 23:46:37 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 141/606] iio: light: tcs3414: Convert to i2c's .probe_new()
Date:   Fri, 18 Nov 2022 23:37:55 +0100
Message-Id: <20221118224540.619276-142-uwe@kleine-koenig.org>
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

The probe function doesn't make use of the i2c_device_id * parameter so it
can be trivially converted.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/iio/light/tcs3414.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/tcs3414.c b/drivers/iio/light/tcs3414.c
index 3951536022b3..5100732fbaf0 100644
--- a/drivers/iio/light/tcs3414.c
+++ b/drivers/iio/light/tcs3414.c
@@ -279,8 +279,7 @@ static void tcs3414_powerdown_cleanup(void *data)
 	tcs3414_powerdown(data);
 }
 
-static int tcs3414_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static int tcs3414_probe(struct i2c_client *client)
 {
 	struct tcs3414_data *data;
 	struct iio_dev *indio_dev;
@@ -374,7 +373,7 @@ static struct i2c_driver tcs3414_driver = {
 		.name	= TCS3414_DRV_NAME,
 		.pm	= pm_sleep_ptr(&tcs3414_pm_ops),
 	},
-	.probe		= tcs3414_probe,
+	.probe_new	= tcs3414_probe,
 	.id_table	= tcs3414_id,
 };
 module_i2c_driver(tcs3414_driver);
-- 
2.38.1

