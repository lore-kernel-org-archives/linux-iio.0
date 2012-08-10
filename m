Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: "jic23@cam.ac.uk" <jic23@cam.ac.uk>
CC: "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>
Subject: [PATCH v2] iio: adc: add new lp8788 adc driver
Date: Fri, 10 Aug 2012 07:06:20 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EEF1F7@DQHE02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Patch v2.
(a) Use iio_priv() for private data rather than allocating data
(b) Support raw and scale inferface for iio consumer
(c) Make inline function for lp8788_adc_read_raw()
(d) For better readability, use fixed number for shift and mask
    rather than getting bits from channel scan type
(e) Clean up the iio channel spec macro and use LP8788_CHAN(id, type) macro

Signed-off-by: Milo(Woogyom) Kim <milo.kim@ti.com>
---
 drivers/iio/adc/Kconfig      |    6 +
 drivers/iio/adc/Makefile     |    1 +
 drivers/iio/adc/lp8788_adc.c |  223 ++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 230 insertions(+), 0 deletions(-)
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
index 0000000..7265080
--- /dev/null
+++ b/drivers/iio/adc/lp8788_adc.c
@@ -0,0 +1,223 @@
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
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/mfd/lp8788.h>
+
+/* register address */
+#define LP8788_ADC_CONF			0x60
+#define LP8788_ADC_RAW			0x61
+#define LP8788_ADC_DONE			0x63
+
+#define START_ADC_CHANNEL		LPADC_VBATT_5P5
+#define END_ADC_CHANNEL			LPADC_MAX
+#define ADC_CONV_START			1
+#define ADC_CONV_DELAY_US		100
+
+struct lp8788_adc {
+	struct lp8788 *lp;
+};
+
+static const int adc_const[LPADC_MAX] =3D {
+	[LPADC_VBATT_5P5] =3D 1343,
+	[LPADC_VIN_CHG]   =3D 3052,
+	[LPADC_IBATT]     =3D 610,
+	[LPADC_IC_TEMP]   =3D 610,
+	[LPADC_VBATT_6P0] =3D 1465,
+	[LPADC_VBATT_5P0] =3D 1221,
+	[LPADC_ADC1]      =3D 610,
+	[LPADC_ADC2]      =3D 610,
+	[LPADC_VDD]       =3D 1025,
+	[LPADC_VCOIN]     =3D 757,
+	[LPADC_VDD_LDO]   =3D 610,
+	[LPADC_ADC3]      =3D 610,
+	[LPADC_ADC4]      =3D 610,
+};
+
+static inline int lp8788_adc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan,
+			int *val, int *val2, long mask)
+{
+	struct lp8788_adc *adc =3D iio_priv(indio_dev);
+	int retry =3D 5;
+	unsigned int msb, lsb, result;
+	u8 data, rawdata[2];
+	int size =3D ARRAY_SIZE(rawdata);
+	enum lp8788_adc_id id =3D chan->channel;
+
+	data =3D (id << 1) | ADC_CONV_START;
+	if (lp8788_write_byte(adc->lp, LP8788_ADC_CONF, data))
+		goto err;
+
+	/* retry until adc conversion is done */
+	data =3D 0;
+	while (retry--) {
+		udelay(ADC_CONV_DELAY_US);
+
+		if (lp8788_read_byte(adc->lp, LP8788_ADC_DONE, &data))
+			goto err;
+
+		/* conversion done */
+		if (data)
+			break;
+	}
+
+	if (lp8788_read_multi_bytes(adc->lp, LP8788_ADC_RAW, rawdata, size))
+		goto err;
+
+	msb =3D (rawdata[0] << 4) & 0x00000ff0;
+	lsb =3D (rawdata[1] >> 4) & 0x0000000f;
+	result =3D msb | lsb;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*val =3D result;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val =3D adc_const[id] * ((result * 1000 + 500) / 1000);
+		*val2 =3D 0;
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		break;
+	}
+
+err:
+	return -EINVAL;
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
+		.address =3D LP8788_ADC_RAW,			\
+		.scan_type =3D IIO_ST('u', 8, 12, 4),		\
+		.scan_index =3D 1,				\
+		.datasheet_name =3D #_id,				\
+}
+
+static struct iio_chan_spec lp8788_adc_channels[] =3D {
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
+	[LPADC_VDD_LDO]   =3D LP8788_CHAN(VDD_LDO, IIO_VOLTAGE),
+	[LPADC_ADC3]      =3D LP8788_CHAN(ADC3, IIO_VOLTAGE),
+	[LPADC_ADC4]      =3D LP8788_CHAN(ADC4, IIO_VOLTAGE),
+};
+
+static int __devinit lp8788_adc_probe(struct platform_device *pdev)
+{
+	struct lp8788 *lp =3D dev_get_drvdata(pdev->dev.parent);
+	struct iio_dev *indio_dev;
+	struct iio_map *map;
+	struct lp8788_adc *adc;
+	int i, ret;
+
+	indio_dev =3D iio_device_alloc(sizeof(struct iio_dev));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	adc =3D iio_priv(indio_dev);
+	adc->lp =3D lp;
+	platform_set_drvdata(pdev, indio_dev);
+
+	if (lp->pdata) {
+		for (i =3D START_ADC_CHANNEL; i < END_ADC_CHANNEL ; i++) {
+			map =3D lp->pdata->adc_pdata[i];
+			ret =3D iio_map_array_register(indio_dev, map);
+			if (ret) {
+				dev_err(lp->dev, "iio map err: %d\n", ret);
+				goto err_iio_map_array;
+			}
+		}
+	}
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
+		goto err_iio_register;
+	}
+
+	return 0;
+
+err_iio_map_array:
+	while (--i >=3D START_ADC_CHANNEL) {
+		map =3D lp->pdata->adc_pdata[i];
+		iio_map_array_unregister(indio_dev, map);
+	}
+err_iio_register:
+	iio_device_free(indio_dev);
+	return ret;
+}
+
+static int __devexit lp8788_adc_remove(struct platform_device *pdev)
+{
+	struct iio_dev *indio_dev =3D  platform_get_drvdata(pdev);
+	struct lp8788_adc *adc =3D iio_priv(indio_dev);
+	struct lp8788 *lp =3D adc->lp;
+	struct iio_map *map;
+	int i;
+
+	if (lp->pdata) {
+		for (i =3D START_ADC_CHANNEL; i < END_ADC_CHANNEL ; i++) {
+			map =3D lp->pdata->adc_pdata[i];
+			iio_map_array_unregister(indio_dev, map);
+		}
+	}
+
+	iio_device_unregister(indio_dev);
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
1.7.2.5

Best Regards,
Milo
