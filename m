Return-Path: <SRS0=e2m4=ME=gmail.com=decatf@kernel.org>
From: ryang <decatf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ryang <decatf@gmail.com>
Subject: [PATCH v3 2/2] iio: light: bh1750: Add device tree support
Date: Sat, 22 Sep 2018 16:57:54 -0400
Message-Id: <20180922205754.6100-2-decatf@gmail.com>
In-Reply-To: <20180922205754.6100-1-decatf@gmail.com>
References: <20180922205754.6100-1-decatf@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree support for ROHM BH1750 series ambient light sensors.

Signed-off-by: ryang <decatf@gmail.com>
---
Changes in v2:
     - Export module device table
Changes in v3:
     - Remove of_match_ptr so that bh1750_of_match is available
       without CONFIG_OF.

 drivers/iio/light/bh1750.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index c3a481452b67..28347df78cff 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -307,9 +307,20 @@ static const struct i2c_device_id bh1750_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bh1750_id);
 
+static const struct of_device_id bh1750_of_match[] = {
+	{ .compatible = "rohm,bh1710", },
+	{ .compatible = "rohm,bh1715", },
+	{ .compatible = "rohm,bh1721", },
+	{ .compatible = "rohm,bh1750", },
+	{ .compatible = "rohm,bh1751", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bh1750_of_match);
+
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
+		.of_match_table = bh1750_of_match,
 		.pm = &bh1750_pm_ops,
 	},
 	.probe = bh1750_probe,
-- 
2.17.1
