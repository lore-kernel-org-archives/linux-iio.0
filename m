Return-Path: <SRS0=7pg1=3U=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens@rwth-aachen.de>
To: <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>, =?UTF-8?q?Stefan=20Br=C3=BCns?=
	<stefan.bruens@rwth-aachen.de>
Subject: [PATCH 2/2] iio: adc: Allow setting Shunt Voltage PGA gain and Bus Voltage range
Date: Wed, 12 Apr 2017 05:01:40 +0200
In-Reply-To: <20170412030140.9328-1-stefan.bruens@rwth-aachen.de>
References: <20170412030140.9328-1-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Message-ID: <81f81a0af7dd420db51f97d9be4dcbad@rwthex-w2-b.rwth-ad.de>
List-ID: <linux-iio@vger.kernel.org>

Reducing shunt and bus voltage range improves the accuracy, so allow
altering the default settings.

Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
---
 drivers/iio/adc/ina2xx-adc.c | 165 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 164 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index d1678f886297..856409ecceb3 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -47,8 +47,10 @@
 #define INA2XX_MAX_REGISTERS            8
 
 /* settings - depend on use case */
-#define INA219_CONFIG_DEFAULT           0x399F	/* PGA=8 */
+#define INA219_CONFIG_DEFAULT           0x399F	/* PGA=1/8, BRNG=32V */
 #define INA219_DEFAULT_IT		532
+#define INA219_DEFAULT_BRNG             32
+#define INA219_DEFAULT_PGA              125 /* 1000/8 */
 #define INA226_CONFIG_DEFAULT           0x4327
 #define INA226_DEFAULT_AVG              4
 #define INA226_DEFAULT_IT		1110
@@ -61,6 +63,14 @@
  */
 #define INA2XX_MODE_MASK	GENMASK(3, 0)
 
+/* Gain for VShunt: 1/8 (default), 1/4, 1/2, 1 */
+#define INA219_PGA_MASK		GENMASK(12, 11)
+#define INA219_SHIFT_PGA(val)	((val) << 11)
+
+/* VBus range: 32V (default), 16V */
+#define INA219_BRNG_MASK	BIT(13)
+#define INA219_SHIFT_BRNG(val)	((val) << 13)
+
 /* Averaging for VBus/VShunt/Power */
 #define INA226_AVG_MASK		GENMASK(11, 9)
 #define INA226_SHIFT_AVG(val)	((val) << 9)
@@ -125,6 +135,8 @@ struct ina2xx_chip_info {
 	int avg;
 	int int_time_vbus; /* Bus voltage integration time uS */
 	int int_time_vshunt; /* Shunt voltage integration time uS */
+	int range_vbus; /* Bus voltage maximum in V */
+	int pga_gain_vshunt; /* Shunt voltage PGA gain */
 	bool allow_async_readout;
 };
 
@@ -351,6 +363,44 @@ static int ina219_set_int_time_vshunt(struct ina2xx_chip_info *chip,
 	return 0;
 }
 
+static int ina219_set_vbus_range(struct ina2xx_chip_info *chip,
+				 unsigned int range,
+				 unsigned int *config)
+{
+	if (range != 16 && range != 32)
+		return -EINVAL;
+
+	chip->range_vbus = range;
+
+	*config &= ~INA219_BRNG_MASK;
+	*config |= INA219_SHIFT_BRNG(range == 32 ? 1 : 0) & INA219_BRNG_MASK;
+
+	return 0;
+}
+
+static const int ina219_vshunt_gain_tab[] = { 125, 250, 500, 1000 };
+
+static int ina219_set_vshunt_pga_gain(struct ina2xx_chip_info *chip,
+				      unsigned int gain,
+				      unsigned int *config)
+{
+	int bits;
+
+	if (gain < 125 || gain > 1000)
+		return -EINVAL;
+
+	bits = find_closest(gain, ina219_vshunt_gain_tab,
+			    ARRAY_SIZE(ina219_vshunt_gain_tab));
+
+	chip->pga_gain_vshunt = ina219_vshunt_gain_tab[bits];
+	bits = 3 - bits;
+
+	*config &= ~INA219_PGA_MASK;
+	*config |= INA219_SHIFT_PGA(bits) & INA219_PGA_MASK;
+
+	return 0;
+}
+
 static int ina2xx_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long mask)
@@ -485,6 +535,92 @@ static ssize_t ina2xx_shunt_resistor_store(struct device *dev,
 	return len;
 }
 
+static ssize_t ina219_bus_voltage_range_show(struct device *dev,
+					     struct device_attribute *attr,
+					     char *buf)
+{
+	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%d\n", chip->range_vbus);
+}
+
+static ssize_t ina219_bus_voltage_range_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t len)
+{
+	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
+	unsigned long val;
+	unsigned int config, tmp;
+	int ret;
+
+	ret = kstrtoul((const char *) buf, 10, &val);
+	if (ret)
+		return ret;
+
+	mutex_lock(&chip->state_lock);
+
+	ret = regmap_read(chip->regmap, INA2XX_CONFIG, &config);
+	if (ret)
+		goto err;
+
+	tmp = config;
+
+	ret = ina219_set_vbus_range(chip, val, &config);
+
+	if (!ret && (tmp != config))
+		ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
+
+	if (!ret)
+		ret = len;
+err:
+	mutex_unlock(&chip->state_lock);
+
+	return ret;
+}
+
+static ssize_t ina219_shunt_voltage_gain_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
+	int vals[2] = { chip->pga_gain_vshunt, 1000 };
+
+	return iio_format_value(buf, IIO_VAL_FRACTIONAL, 1, vals);
+}
+
+static ssize_t ina219_shunt_voltage_gain_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t len)
+{
+	struct ina2xx_chip_info *chip = iio_priv(dev_to_iio_dev(dev));
+	unsigned int config, tmp;
+	int val, val_fract, ret;
+
+	ret = iio_str_to_fixpoint(buf, 100, &val, &val_fract);
+	if (ret)
+		return ret;
+
+	mutex_lock(&chip->state_lock);
+
+	ret = regmap_read(chip->regmap, INA2XX_CONFIG, &config);
+	if (ret)
+		goto err;
+
+	tmp = config;
+
+	ret = ina219_set_vshunt_pga_gain(chip, val * 1000 + val_fract, &config);
+
+	if (!ret && (tmp != config))
+		ret = regmap_write(chip->regmap, INA2XX_CONFIG, config);
+
+	if (!ret)
+		ret = len;
+err:
+	mutex_unlock(&chip->state_lock);
+
+	return ret;
+}
+
 #define INA2XX_CHAN(_type, _index, _address) { \
 	.type = (_type), \
 	.address = (_address), \
@@ -698,6 +834,15 @@ static IIO_CONST_ATTR_NAMED(ina226_integration_time_available,
 			    integration_time_available,
 			    "0.000140 0.000204 0.000332 0.000588 0.001100 0.002116 0.004156 0.008244");
 
+/* INA219/220 Bus voltage range */
+static IIO_CONST_ATTR_NAMED(ina219_bus_voltage_range_available,
+			    in_bus_voltage_range_available,
+			    "16 32");
+
+/* INA219/220 Shunt voltage PGA gain */
+static IIO_CONST_ATTR_NAMED(ina219_shunt_voltage_gain_available,
+			    in_shunt_voltage_gain_available,
+			    "0.125 0.25 0.5 1");
 
 static IIO_DEVICE_ATTR(in_allow_async_readout, S_IRUGO | S_IWUSR,
 		       ina2xx_allow_async_readout_show,
@@ -707,9 +852,25 @@ static IIO_DEVICE_ATTR(in_shunt_resistor, S_IRUGO | S_IWUSR,
 		       ina2xx_shunt_resistor_show,
 		       ina2xx_shunt_resistor_store, 0);
 
+static IIO_DEVICE_ATTR_NAMED(ina219_bus_voltage_range,
+			     in_bus_voltage_range,
+			     S_IRUGO | S_IWUSR,
+			     ina219_bus_voltage_range_show,
+			     ina219_bus_voltage_range_store, 0);
+
+static IIO_DEVICE_ATTR_NAMED(ina219_shunt_voltage_gain,
+			     in_shunt_voltage_gain,
+			     S_IRUGO | S_IWUSR,
+			     ina219_shunt_voltage_gain_show,
+			     ina219_shunt_voltage_gain_store, 0);
+
 static struct attribute *ina219_attributes[] = {
 	&iio_dev_attr_in_allow_async_readout.dev_attr.attr,
 	&iio_const_attr_ina219_integration_time_available.dev_attr.attr,
+	&iio_dev_attr_ina219_bus_voltage_range.dev_attr.attr,
+	&iio_const_attr_ina219_bus_voltage_range_available.dev_attr.attr,
+	&iio_dev_attr_ina219_shunt_voltage_gain.dev_attr.attr,
+	&iio_const_attr_ina219_shunt_voltage_gain_available.dev_attr.attr,
 	&iio_dev_attr_in_shunt_resistor.dev_attr.attr,
 	NULL,
 };
@@ -809,6 +970,8 @@ static int ina2xx_probe(struct i2c_client *client,
 		chip->avg = 1;
 		ina219_set_int_time_vbus(chip, INA219_DEFAULT_IT, &val);
 		ina219_set_int_time_vshunt(chip, INA219_DEFAULT_IT, &val);
+		ina219_set_vbus_range(chip, INA219_DEFAULT_BRNG, &val);
+		ina219_set_vshunt_pga_gain(chip, INA219_DEFAULT_PGA, &val);
 	}
 
 	ret = ina2xx_init(chip, val);
-- 
2.12.0
