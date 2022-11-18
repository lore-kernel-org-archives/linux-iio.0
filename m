Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FB4C43219
	for <linux-iio@archiver.kernel.org>; Fri, 18 Nov 2022 23:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236065AbiKRXbm (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Nov 2022 18:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiKRXaX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Nov 2022 18:30:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4175875D97
        for <linux-iio@vger.kernel.org>; Fri, 18 Nov 2022 15:18:11 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8L-0001S8-4i; Fri, 18 Nov 2022 23:46:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8H-0058MX-0X; Fri, 18 Nov 2022 23:46:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1owA8G-00Hb6w-Oi; Fri, 18 Nov 2022 23:46:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 186/606] iio: temperature: mlx90632: Convert to i2c's .probe_new()
Date:   Fri, 18 Nov 2022 23:38:40 +0100
Message-Id: <20221118224540.619276-187-uwe@kleine-koenig.org>
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
 drivers/iio/temperature/mlx90632.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index f1f5ebc145b1..19e30cfca8a7 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -1168,9 +1168,9 @@ static int mlx90632_enable_regulator(struct mlx90632_data *data)
 	return ret;
 }
 
-static int mlx90632_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
+static int mlx90632_probe(struct i2c_client *client)
 {
+	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct mlx90632_data *mlx90632;
 	struct iio_dev *indio_dev;
 	struct regmap *regmap;
@@ -1337,7 +1337,15 @@ static struct i2c_driver mlx90632_driver = {
 		.of_match_table = mlx90632_of_match,
 		.pm	= pm_ptr(&mlx90632_pm_ops),
 	},
+<<<<<<< ours
 	.probe = mlx90632_probe,
+||||||| base
+	.probe = mlx90632_probe,
+	.remove = mlx90632_remove,
+=======
+	.probe_new = mlx90632_probe,
+	.remove = mlx90632_remove,
+>>>>>>> theirs
 	.id_table = mlx90632_id,
 };
 module_i2c_driver(mlx90632_driver);
-- 
2.38.1

