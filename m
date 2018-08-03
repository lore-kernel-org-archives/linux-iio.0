Return-Path: <SRS0=Zj+I=KS=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	robh+dt@kernel.org,
	mark.rutland@arm.com,
	andy.gross@linaro.org,
	david.brown@linaro.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org
Cc: jonathan@marek.ca,
	jmaneyrol@invensense.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	mkelly@xevo.com,
	fischerdouglasc@gmail.com,
	bshah@kde.org,
	ctatlor97@gmail.com
Subject: [PATCH v3 3/9] iio: tsl2772: add support for reading proximity led settings from device tree
Date: Thu,  2 Aug 2018 20:18:54 -0400
Message-Id: <20180803001900.25371-4-masneyb@onstation.org>
In-Reply-To: <20180803001900.25371-1-masneyb@onstation.org>
References: <20180803001900.25371-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

This patch adds support for optionally reading the proximity led diode
and current settings from device tree. This was tested using a LG
Nexus 5 (hammerhead) which requires a different diode than the driver
default for the IR LED.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/iio/light/tsl2772.c | 81 +++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/iio/light/tsl2772.c b/drivers/iio/light/tsl2772.c
index df5b2a0da96c..ae00edf0d87e 100644
--- a/drivers/iio/light/tsl2772.c
+++ b/drivers/iio/light/tsl2772.c
@@ -107,6 +107,8 @@
 #define TSL2772_ALS_GAIN_TRIM_MIN	250
 #define TSL2772_ALS_GAIN_TRIM_MAX	4000
 
+#define TSL2772_MAX_PROX_LEDS		2
+
 /* Device family members */
 enum {
 	tsl2571,
@@ -141,6 +143,14 @@ struct tsl2772_chip_info {
 	const struct iio_info *info;
 };
 
+static const int tsl2772_led_currents[][2] = {
+	{ 100000, TSL2772_100_mA },
+	{  50000, TSL2772_50_mA },
+	{  25000, TSL2772_25_mA },
+	{  13000, TSL2772_13_mA },
+	{      0, 0 }
+};
+
 struct tsl2772_chip {
 	kernel_ulong_t id;
 	struct mutex prox_mutex;
@@ -515,6 +525,75 @@ static int tsl2772_get_prox(struct iio_dev *indio_dev)
 	return ret;
 }
 
+static int tsl2772_read_prox_led_current(struct tsl2772_chip *chip)
+{
+	struct device_node *of_node = chip->client->dev.of_node;
+	int ret, tmp, i;
+
+	ret = of_property_read_u32(of_node, "led-max-microamp", &tmp);
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; tsl2772_led_currents[i][0] != 0; i++) {
+		if (tmp == tsl2772_led_currents[i][0]) {
+			chip->settings.prox_power = tsl2772_led_currents[i][1];
+			return 0;
+		}
+	}
+
+	dev_err(&chip->client->dev, "Invalid value %d for led-max-microamp\n",
+		tmp);
+
+	return -EINVAL;
+
+}
+
+static int tsl2772_read_prox_diodes(struct tsl2772_chip *chip)
+{
+	struct device_node *of_node = chip->client->dev.of_node;
+	int i, ret, num_leds, prox_diode_mask;
+	u32 leds[TSL2772_MAX_PROX_LEDS];
+
+	ret = of_property_count_u32_elems(of_node, "amstaos,proximity-diodes");
+	if (ret < 0)
+		return ret;
+
+	num_leds = ret;
+	if (num_leds > TSL2772_MAX_PROX_LEDS)
+		num_leds = TSL2772_MAX_PROX_LEDS;
+
+	ret = of_property_read_u32_array(of_node, "amstaos,proximity-diodes",
+					 leds, num_leds);
+	if (ret < 0) {
+		dev_err(&chip->client->dev,
+			"Invalid value for amstaos,proximity-diodes: %d.\n",
+			ret);
+		return ret;
+	}
+
+	prox_diode_mask = 0;
+	for (i = 0; i < num_leds; i++) {
+		if (leds[i] == 0)
+			prox_diode_mask |= TSL2772_DIODE0;
+		else if (leds[i] == 1)
+			prox_diode_mask |= TSL2772_DIODE1;
+		else {
+			dev_err(&chip->client->dev,
+				"Invalid value %d in amstaos,proximity-diodes.\n",
+				leds[i]);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static void tsl2772_parse_dt(struct tsl2772_chip *chip)
+{
+	tsl2772_read_prox_led_current(chip);
+	tsl2772_read_prox_diodes(chip);
+}
+
 /**
  * tsl2772_defaults() - Populates the device nominal operating parameters
  *                      with those provided by a 'platform' data struct or
@@ -541,6 +620,8 @@ static void tsl2772_defaults(struct tsl2772_chip *chip)
 		memcpy(chip->tsl2772_device_lux,
 		       tsl2772_default_lux_table_group[chip->id],
 		       TSL2772_DEFAULT_TABLE_BYTES);
+
+	tsl2772_parse_dt(chip);
 }
 
 /**
-- 
2.17.1
