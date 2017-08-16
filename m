Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:61344 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbdHPTde (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2017 15:33:34 -0400
Date: Wed, 16 Aug 2017 21:33:47 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] iio: srf08: add device tree table
Message-ID: <20170816193347.GA24416@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added MODULE_DEVICE_TABLE for device tree bindings.

It used to work without it by using the i2c_device_id table, but adding the
table makes everything clear and documented.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf08.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 49316cbf7c60..3f19536f215f 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -378,6 +378,13 @@ static int srf08_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id of_srf08_match[] = {
+	{ .compatible = "devantech,srf08", 0},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_srf08_match);
+
 static const struct i2c_device_id srf08_id[] = {
 	{ "srf08", 0 },
 	{ }
@@ -387,6 +394,7 @@ MODULE_DEVICE_TABLE(i2c, srf08_id);
 static struct i2c_driver srf08_driver = {
 	.driver = {
 		.name	= "srf08",
+		.of_match_table	= of_srf08_match,
 	},
 	.probe = srf08_probe,
 	.id_table = srf08_id,
-- 
2.1.4


-- 
