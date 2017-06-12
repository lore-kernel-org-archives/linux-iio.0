Return-Path: <SRS0=HePV=5R=ti.com=m-stecklein@kernel.org>
From: Michael Stecklein <m-stecklein@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>,
        Michael Stecklein
	<m-stecklein@ti.com>
Subject: [PATCH 3/3] iio: humidity: hdc100x: add match table and device id's
Date: Mon, 12 Jun 2017 09:49:10 -0500
Message-ID: <1497278950-12973-3-git-send-email-m-stecklein@ti.com>
In-Reply-To: <1497278950-12973-1-git-send-email-m-stecklein@ti.com>
References: <1497278950-12973-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add of_match_table and point it to a list of compatible device tree
device id's.

Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
---
 drivers/iio/humidity/hdc100x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index 0e5962f..659d7da 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -427,9 +427,19 @@ static const struct i2c_device_id hdc100x_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, hdc100x_id);
 
+static const struct of_device_id hdc100x_dt_ids[] = {
+	{ .compatible = "ti,hdc100x" },
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
