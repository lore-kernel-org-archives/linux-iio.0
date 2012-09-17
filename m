Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] iio: adc: add new lp8788 adc driver
Date: Mon, 17 Sep 2012 09:35:10 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF510C@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

 TI LP8788 PMU provides regulators, battery charger, ADC,
 RTC, backlight driver and current sinks.

 This patch enables the LP8788 ADC functions.

 The LP8788 ADC has several ADC input selection and supports 12bit resoluti=
on.
 Internal operation of getting ADC is access to registers of LP8788.
 The LP8788 ADC uses exported functions for accessing these registers.
 (exported by LP8788 MFD device driver)

 This driver supports IIO_CHAN_INFO_RAW and SCALE.
 So the IIO consumer can calculate the value with raw and scale.
 The unit of scale is micro.

 (ADC Input Selection)

 Voltage: battery voltage (MAX 5.0, 5.5 and 6.0V)
          charger input voltage
          four general ADC inputs
          coin cell voltage
 Current: battery charging current
 Temperature: IC temperature

 (The IIO map for the IIO consumer)

 The ADC input is configurable in the platform side.
 Even though this platform data is not defined,
 the default IIO map is created for supporting the power supply driver.
 The battery voltage and temperature are used inside this driver.

 (History)

 Patch v6.
 (a) Fix scale value for each ADC input selection
 Voltage and current type are mili unit and temperature is degree.
 To calculate the IC temperature,
 temp =3D raw * scaleint + (raw * scalepart)/ 1000000, scaleint is always 0=
.
      =3D raw * 0.061050, raw: 0 ~ 4095
 Then range of IC temperature(ADC result) is 0 ~ 250'C

 (b) Reorganization of the IIO channel Spec
 Remove address, scan_type and scan_index and rollback the datasheet name.
 The reason why 'address' field is unnecessary is no relation with each cha=
nnel.
 Moreover, to get the raw ADC value, the address info is not only one regis=
ter
 but also several registers.
 Therefore specific function(lp8788_get_adc_result) is called rather than
 using one 'address' field.

 (c) Fix coding style
 Remove duplicated checking routine while unregistering the IIO map.
 Fix code for space and parenthesis.

 Patch v5.
 Fix default consumer name as 'lp8788-charger'.
 Add mutex for ADC read operation.
 Reorganization on lp8788_adc_read_raw().

 Patch v4.
 Fix adc_raw function: support RAW and SCALE channel info.
 Change LP8788 ADC platform data - iio map.
 Enables the default IIO map.

 Patch v3.
 Fix wrong size of allocating iio private data.
 Fix coding styles.

 Patch v2.
 Support RAW and SCALE interface for IIO consumer.
 Clean up the iio channel spec macro.

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/adc/Kconfig      |    6 +
 drivers/iio/adc/Makefile     |    1 +
 drivers/iio/adc/lp8788_adc.c |  264 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 271 insertions(+)
 create mode 100644 drivers/iio/adc/lp8788_adc.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 8a78b4f..30c06ed 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -22,4 +22,10 @@ config AT91_ADC
 	help
 	  Say yes here to build support for Atmel AT91 ADC.
=20
+config LP8788_ADC
+	bool "LP8788 ADC driver"
+	depends on MFD_LP8788
+	help
+	  Say yes here to build support for TI LP8788 ADC.
+
 endmenu
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 52eec25..72f9a76 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -4,3 +4,4 @@
=20
 obj-$(CONFIG_AD7266) +=3D ad7266.o
 obj-$(CONFIG_AT91_ADC) +=3D at91_adc.o
+obj-$(CONFIG_LP8788_ADC) +=3D lp8788_adc.o
diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
new file mode 100644
index 0000000..a93aaf0
--- /dev/null
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -0,0 +1,264 @@
+/*
+ * TI LP8788 MFD - ADC driver
+ *
+ * Copyright 2012 Texas Instruments
+ *
+ * Author: Milo(Woogyom) Kim <milo.kim@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/machine.h>
+#include <linux/mfd/lp8788.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/* register address */
+#define LP8788_ADC_CONF			0x60
+#define LP8788_ADC_RAW			0x61
+#define LP8788_ADC_DONE			0x63
+
+#define ADC_CONV_START			1
+
+struct lp8788_adc {
+	struct lp8788 *lp;
+	struct iio_map *map;
+	struct mutex lock;
+};
+
+static const int lp8788_scale[LPADC_MAX] =3D {
+	[LPADC_VBATT_5P5] =3D 1343101,
+	[LPADC_VIN_CHG]   =3D 3052503,
+	[LPADC_IBATT]     =3D 610500,
+	[LPADC_IC_TEMP]   =3D 61050,
+	[LPADC_VBATT_6P0] =3D 1465201,
+	[LPADC_VBATT_5P0] =3D 1221001,
+	[LPADC_ADC1]      =3D 610500,
+	[LPADC_ADC2]      =3D 610500,
+	[LPADC_VDD]       =3D 1025641,
+	[LPADC_VCOIN]     =3D 757020,
+	[LPADC_ADC3]      =3D 610500,
+	[LPADC_ADC4]      =3D 610500,
+};
+
+static int lp8788_get_adc_result(struct lp8788_adc *adc, enum lp8788_adc_i=
d id,
+				int *val)
+{
+	unsigned int msb;
+	unsigned int lsb;
+	unsigned int result;
+	u8 data;
+	u8 rawdata[2];
+	int size =3D ARRAY_SIZE(rawdata);
+	int retry =3D 5;
+	int ret;
+
+	data =3D (id << 1) | ADC_CONV_START;
+	ret =3D lp8788_write_byte(adc->lp, LP8788_ADC_CONF, data);
+	if (ret)
+		goto err_io;
+
+	/* retry until adc conversion is done */
+	data =3D 0;
+	while (retry--) {
+		usleep_range(100, 200);
+
+		ret =3D lp8788_read_byte(adc->lp, LP8788_ADC_DONE, &data);
+		if (ret)
+			goto err_io;
+
+		/* conversion done */
+		if (data)
+			break;
+	}
+
+	ret =3D lp8788_read_multi_bytes(adc->lp, LP8788_ADC_RAW, rawdata, size);
+	if (ret)
+		goto err_io;
+
+	msb =3D (rawdata[0] << 4) & 0x00000ff0;
+	lsb =3D (rawdata[1] >> 4) & 0x0000000f;
+	result =3D msb | lsb;
+	*val =3D result;
+
+	return 0;
+
+err_io:
+	return ret;
+}
+
+static int lp8788_adc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct lp8788_adc *adc =3D iio_priv(indio_dev);
+	enum lp8788_adc_id id =3D chan->channel;
+	int ret;
+
+	mutex_lock(&adc->lock);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret =3D lp8788_get_adc_result(adc, id, val) ? -EIO : IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D lp8788_scale[id] / 1000000;
+		*val2 =3D lp8788_scale[id] % 1000000;
+		ret =3D IIO_VAL_INT_PLUS_MICRO;
+		break;
+	default:
+		ret =3D -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&adc->lock);
+
+	return ret;
+}
+
+static const struct iio_info lp8788_adc_info =3D {
+	.read_raw =3D &lp8788_adc_read_raw,
+	.driver_module =3D THIS_MODULE,
+};
+
+#define LP8788_CHAN(_id, _type) {				\
+		.type =3D _type,					\
+		.indexed =3D 1,					\
+		.channel =3D LPADC_##_id,				\
+		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
+			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
+		.datasheet_name =3D #_id,				\
+}
+
+static const struct iio_chan_spec lp8788_adc_channels[] =3D {
+	[LPADC_VBATT_5P5] =3D LP8788_CHAN(VBATT_5P5, IIO_VOLTAGE),
+	[LPADC_VIN_CHG]   =3D LP8788_CHAN(VIN_CHG, IIO_VOLTAGE),
+	[LPADC_IBATT]     =3D LP8788_CHAN(IBATT, IIO_CURRENT),
+	[LPADC_IC_TEMP]   =3D LP8788_CHAN(IC_TEMP, IIO_TEMP),
+	[LPADC_VBATT_6P0] =3D LP8788_CHAN(VBATT_6P0, IIO_VOLTAGE),
+	[LPADC_VBATT_5P0] =3D LP8788_CHAN(VBATT_5P0, IIO_VOLTAGE),
+	[LPADC_ADC1]      =3D LP8788_CHAN(ADC1, IIO_VOLTAGE),
+	[LPADC_ADC2]      =3D LP8788_CHAN(ADC2, IIO_VOLTAGE),
+	[LPADC_VDD]       =3D LP8788_CHAN(VDD, IIO_VOLTAGE),
+	[LPADC_VCOIN]     =3D LP8788_CHAN(VCOIN, IIO_VOLTAGE),
+	[LPADC_ADC3]      =3D LP8788_CHAN(ADC3, IIO_VOLTAGE),
+	[LPADC_ADC4]      =3D LP8788_CHAN(ADC4, IIO_VOLTAGE),
+};
+
+/* default maps used by iio consumer (lp8788-charger driver) */
+static struct iio_map lp8788_default_iio_maps[] =3D {
+	{
+		.consumer_dev_name =3D "lp8788-charger",
+		.consumer_channel =3D "lp8788_vbatt_5p0",
+		.adc_channel_label =3D "VBATT_5P0",
+	},
+	{
+		.consumer_dev_name =3D "lp8788-charger",
+		.consumer_channel =3D "lp8788_adc1",
+		.adc_channel_label =3D "ADC1",
+	},
+	{ }
+};
+
+static int lp8788_iio_map_register(struct iio_dev *indio_dev,
+				struct lp8788_platform_data *pdata,
+				struct lp8788_adc *adc)
+{
+	struct iio_map *map;
+	int ret;
+
+	map =3D (!pdata || !pdata->adc_pdata) ?
+		lp8788_default_iio_maps : pdata->adc_pdata;
+
+	ret =3D iio_map_array_register(indio_dev, map);
+	if (ret) {
+		dev_err(adc->lp->dev, "iio map err: %d\n", ret);
+		return ret;
+	}
+
+	adc->map =3D map;
+	return 0;
+}
+
+static inline void lp8788_iio_map_unregister(struct iio_dev *indio_dev,
+				struct lp8788_adc *adc)
+{
+	iio_map_array_unregister(indio_dev, adc->map);
+}
+
+static int __devinit lp8788_adc_probe(struct platform_device *pdev)
+{
+	struct lp8788 *lp =3D dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev;
+	struct lp8788_adc *adc;
+	int ret;
+
+	indio_dev =3D iio_device_alloc(sizeof(*adc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc =3D iio_priv(indio_dev);
+	adc->lp =3D lp;
+	platform_set_drvdata(pdev, indio_dev);
+
+	ret =3D lp8788_iio_map_register(indio_dev, lp->pdata, adc);
+	if (ret)
+		goto err_iio_map;
+
+	mutex_init(&adc->lock);
+
+	indio_dev->dev.parent =3D lp->dev;
+	indio_dev->name =3D pdev->name;
+	indio_dev->modes =3D INDIO_DIRECT_MODE;
+	indio_dev->info =3D &lp8788_adc_info;
+	indio_dev->channels =3D lp8788_adc_channels;
+	indio_dev->num_channels =3D ARRAY_SIZE(lp8788_adc_channels);
+
+	ret =3D iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(lp->dev, "iio dev register err: %d\n", ret);
+		goto err_iio_device;
+	}
+
+	return 0;
+
+err_iio_device:
+	lp8788_iio_map_unregister(indio_dev, adc);
+err_iio_map:
+	iio_device_free(indio_dev);
+	return ret;
+}
+
+static int __devexit lp8788_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
+	struct lp8788_adc *adc =3D iio_priv(indio_dev);
+
+	iio_device_unregister(indio_dev);
+	lp8788_iio_map_unregister(indio_dev, adc);
+	iio_device_free(indio_dev);
+
+	return 0;
+}
+
+static struct platform_driver lp8788_adc_driver =3D {
+	.probe =3D lp8788_adc_probe,
+	.remove =3D __devexit_p(lp8788_adc_remove),
+	.driver =3D {
+		.name =3D LP8788_DEV_ADC,
+		.owner =3D THIS_MODULE,
+	},
+};
+module_platform_driver(lp8788_adc_driver);
+
+MODULE_DESCRIPTION("Texas Instruments LP8788 ADC Driver");
+MODULE_AUTHOR("Milo Kim");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:lp8788-adc");
--=20
1.7.9.5


Best Regards,
Milo
