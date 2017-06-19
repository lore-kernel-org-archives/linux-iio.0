Return-Path: <SRS0=fSvt=5Y=ti.com=m-stecklein@kernel.org>
From: Michael Stecklein <m-stecklein@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>
CC: "Andrew F . Davis" <afd@ti.com>, Michael Stecklein <m-stecklein@ti.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] iio: humidity: hdc100x: add match table and device id's
Date: Mon, 19 Jun 2017 11:01:06 -0500
Message-ID: <1497888066-12652-3-git-send-email-m-stecklein@ti.com>
In-Reply-To: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
References: <1497888066-12652-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add of_match_table and point it to a list of compatible device tree
device id's.

Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
---
 drivers/iio/humidity/hdc100x.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 6778bc7..7851bd9 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -429,9 +429,20 @@ static const struct i2c_device_id hdc100x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, hdc100x_id);
 
+static const struct of_device_id hdc100x_dt_ids[] = {
+	{ .compatible = "ti,hdc1000" },
+	{ .compatible = "ti,hdc1008" },
+	{ .compatible = "ti,hdc1010" },
+	{ .compatible = "ti,hdc1050" },
+	{ .compatible = "ti,hdc1080" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
+
 static struct i2c_driver hdc100x_driver = {
 	.driver = {
 		.name	= "hdc100x",
+		.of_match_table = of_match_ptr(hdc100x_dt_ids),
 	},
 	.probe = hdc100x_probe,
 	.remove = hdc100x_remove,
-- 
2.7.4
