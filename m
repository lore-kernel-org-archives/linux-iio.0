Return-Path: <SRS0=etR0=YZ=lechnology.com=david@kernel.org>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] iio: adc: ti-ads7950: Drop "ti-" prefix from module name
Date: Wed, 11 Jan 2017 11:52:50 -0600
Message-Id: <1484157171-15571-3-git-send-email-david@lechnology.com>
In-Reply-To: <1484157171-15571-1-git-send-email-david@lechnology.com>
References: <1484157171-15571-1-git-send-email-david@lechnology.com>
List-ID: <linux-iio@vger.kernel.org>

This drops the "ti-" prefix from the module name. It makes the module name
consistent with other iio ti-ads* drivers and it makes the driver work
with device tree (the spi subsystem drops the "ti," prefix when matching
compatible strings from device tree).

Tested working on LEGO MINDSTORMS EV3 with the following device tree node:

	adc@3 {
		compatible = "ti,ads7957";
		reg = <3>;
		#io-channel-cells = <1>;
		spi-max-frequency = <10000000>;
		vref-supply = <&adc_ref>;
	};

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0330361..b587fa6 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -459,25 +459,25 @@ static int ti_ads7950_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id ti_ads7950_id[] = {
-	{"ti-ads7950", TI_ADS7950},
-	{"ti-ads7951", TI_ADS7951},
-	{"ti-ads7952", TI_ADS7952},
-	{"ti-ads7953", TI_ADS7953},
-	{"ti-ads7954", TI_ADS7954},
-	{"ti-ads7955", TI_ADS7955},
-	{"ti-ads7956", TI_ADS7956},
-	{"ti-ads7957", TI_ADS7957},
-	{"ti-ads7958", TI_ADS7958},
-	{"ti-ads7959", TI_ADS7959},
-	{"ti-ads7960", TI_ADS7960},
-	{"ti-ads7961", TI_ADS7961},
+	{ "ads7950", TI_ADS7950 },
+	{ "ads7951", TI_ADS7951 },
+	{ "ads7952", TI_ADS7952 },
+	{ "ads7953", TI_ADS7953 },
+	{ "ads7954", TI_ADS7954 },
+	{ "ads7955", TI_ADS7955 },
+	{ "ads7956", TI_ADS7956 },
+	{ "ads7957", TI_ADS7957 },
+	{ "ads7958", TI_ADS7958 },
+	{ "ads7959", TI_ADS7959 },
+	{ "ads7960", TI_ADS7960 },
+	{ "ads7961", TI_ADS7961 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ti_ads7950_id);
 
 static struct spi_driver ti_ads7950_driver = {
 	.driver = {
-		.name	= "ti-ads7950",
+		.name	= "ads7950",
 	},
 	.probe		= ti_ads7950_probe,
 	.remove		= ti_ads7950_remove,
-- 
2.7.4
