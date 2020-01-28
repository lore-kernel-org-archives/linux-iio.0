Return-Path: <SRS0=H1qA=3R=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FC4C2D0DB
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7230924688
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jan 2020 13:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA1NeG (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:34:06 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:39108 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgA1NeF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 08:34:05 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id C2628251F3;
        Tue, 28 Jan 2020 14:34:03 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 7/7] iio: light: al3320a allow module autoload and polish
Date:   Tue, 28 Jan 2020 14:30:52 +0100
Message-Id: <20200128133052.201587-8-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128133052.201587-1-david@ixit.cz>
References: <20200128133052.201587-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

- allow autoloading when build as module and defined inside DT
- drop init.h and alphabetically sort includes

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index d99f9d139b5f..d66c85b27907 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -12,9 +12,9 @@
  * potential races with the interrupt handling.
  */
 
-#include <linux/module.h>
-#include <linux/init.h>
 #include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -238,9 +238,16 @@ static const struct i2c_device_id al3320a_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, al3320a_id);
 
+static const struct of_device_id al3320a_of_match[] = {
+	{ .compatible = "dynaimage,al3320a", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, al3320a_of_match);
+
 static struct i2c_driver al3320a_driver = {
 	.driver = {
 		.name = AL3320A_DRV_NAME,
+		.of_match_table = al3320a_of_match,
 		.pm = &al3320a_pm_ops,
 	},
 	.probe		= al3320a_probe,
-- 
2.25.0

