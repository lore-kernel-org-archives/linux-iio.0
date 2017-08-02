Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:60106 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751188AbdHBXZI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Aug 2017 19:25:08 -0400
Date: Thu, 3 Aug 2017 01:25:04 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] iio: srf08: add device tree table
Message-ID: <20170802232504.GA15256@arbeit>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added MODULE_DEVICE_TABLE for device tree bindings.

It used to work without it by using the i2c_device_id table, but adding the
table makes everything clear and documented.

Signed-off-by: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf08.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 92e1799c430c..a2913a5bf68e 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -455,6 +455,14 @@ static int srf08_probe(struct i2c_client *client,
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct of_device_id of_srf08_match[] = {
+	{ .compatible = "devantech,srf08", (void *)SRF08},
+	{ .compatible = "devantech,srf10", (void *)SRF10},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, of_srf08_match);
+
 static const struct i2c_device_id srf08_id[] = {
 	{ "srf08", SRF08 },
 	{ "srf10", SRF10 },
@@ -465,6 +473,7 @@ MODULE_DEVICE_TABLE(i2c, srf08_id);
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
