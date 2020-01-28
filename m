Return-Path: <SRS0=H1qA=3R=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54B5C2D0DB
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jan 2020 13:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD9D24686
	for <linux-iio@archiver.kernel.org>; Tue, 28 Jan 2020 13:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgA1Nds (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:33:48 -0500
Received: from ip-78-45-52-129.net.upcbroadband.cz ([78.45.52.129]:39092 "EHLO
        ixit.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgA1Nds (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 28 Jan 2020 08:33:48 -0500
Received: from localhost.localdomain (227.146.230.94.awnet.cz [94.230.146.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 9A25B251F0;
        Tue, 28 Jan 2020 14:33:46 +0100 (CET)
From:   David Heidelberg <david@ixit.cz>
To:     linux-iio@vger.kernel.org
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 6/7] iio: light: al3320a implement suspend support
Date:   Tue, 28 Jan 2020 14:30:51 +0100
Message-Id: <20200128133052.201587-7-david@ixit.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128133052.201587-1-david@ixit.cz>
References: <20200128133052.201587-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

AL3320a is fairly simple chip, so for suspend is enough to disable and
later enable it again.

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/iio/light/al3320a.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/al3320a.c b/drivers/iio/light/al3320a.c
index 613830b7df6e..d99f9d139b5f 100644
--- a/drivers/iio/light/al3320a.c
+++ b/drivers/iio/light/al3320a.c
@@ -7,6 +7,9 @@
  * IIO driver for AL3320A (7-bit I2C slave address 0x1C).
  *
  * TODO: interrupt support, thresholds
+ * When the driver will get support for interrupt handling, then interrupt
+ * will need to be disabled before turning sensor OFF in order to avoid
+ * potential races with the interrupt handling.
  */
 
 #include <linux/module.h>
@@ -84,13 +87,19 @@ static const struct attribute_group al3320a_attribute_group = {
 	.attrs = al3320a_attributes,
 };
 
+static int al3320a_set_pwr(struct i2c_client *client, bool pwr)
+{
+	u8 val = pwr ? AL3320A_CONFIG_ENABLE : AL3320A_CONFIG_DISABLE;
+	return i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG, val);
+}
+
+
 static int al3320a_init(struct al3320a_data *data)
 {
 	int ret;
 
-	/* power on */
-	ret = i2c_smbus_write_byte_data(data->client, AL3320A_REG_CONFIG,
-					AL3320A_CONFIG_ENABLE);
+	ret = al3320a_set_pwr(data->client, true);
+
 	if (ret < 0)
 		return ret;
 
@@ -208,10 +217,21 @@ static int al3320a_probe(struct i2c_client *client,
 
 static int al3320a_remove(struct i2c_client *client)
 {
-	return i2c_smbus_write_byte_data(client, AL3320A_REG_CONFIG,
-					 AL3320A_CONFIG_DISABLE);
+	return al3320a_set_pwr(client, false);
+}
+
+static int __maybe_unused al3320a_suspend(struct device *dev)
+{
+	return al3320a_set_pwr(to_i2c_client(dev), false);
+}
+
+static int __maybe_unused al3320a_resume(struct device *dev)
+{
+	return al3320a_set_pwr(to_i2c_client(dev), true);
 }
 
+SIMPLE_DEV_PM_OPS(al3320a_pm_ops, al3320a_suspend, al3320a_resume);
+
 static const struct i2c_device_id al3320a_id[] = {
 	{"al3320a", 0},
 	{}
@@ -221,6 +241,7 @@ MODULE_DEVICE_TABLE(i2c, al3320a_id);
 static struct i2c_driver al3320a_driver = {
 	.driver = {
 		.name = AL3320A_DRV_NAME,
+		.pm = &al3320a_pm_ops,
 	},
 	.probe		= al3320a_probe,
 	.remove		= al3320a_remove,
-- 
2.25.0

