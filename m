Return-Path: <SRS0=UK/C=DV=gmail.com=milan.o.stevanovic@kernel.org>
Subject: Re: [PATCH] iio: adc: add driver for ti adc081s/adc101s/adc121s
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Jonathan Cameron <jic23@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-iio@vger.kernel.org
References: <1513984753-3040-1-git-send-email-milan.o.stevanovic@gmail.com>
 <CAOFm3uFn+z+ouTNM5HOw3FEgBhW3T4WiPRwtPuwapq_m4wHWKQ@mail.gmail.com>
 <6ac417c6-b9d6-8aa6-c998-5a729a512434@gmail.com>
 <CAOFm3uH+QCKMmkrRNYv0-8ibwPZ5Wobg9EK8dWW5ot0sU5j-7w@mail.gmail.com>
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Message-ID: <019cfe3e-8d13-8200-393e-621df6c71375@gmail.com>
Date: Mon, 25 Dec 2017 21:42:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAOFm3uH+QCKMmkrRNYv0-8ibwPZ5Wobg9EK8dWW5ot0sU5j-7w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/25/2017 03:21 PM, Philippe Ombredanne wrote:
> On Sun, Dec 24, 2017 at 8:02 PM, Milan Stevanovic
> <milan.o.stevanovic@gmail.com> wrote:
>> On 12/23/2017 03:13 PM, Philippe Ombredanne wrote:
>>> Milan,
>>>
>>> On Sat, Dec 23, 2017 at 12:19 AM, Milan Stevanovic
>>> <milan.o.stevanovic@gmail.com> wrote:
>>>> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
>>> <snip>
>>>
>>> May be it is just me, but you may be missing a commit message?
>>>
>>> <snip>
>> Yes... Sorry I missed this
>>>> --- /dev/null
>>>> +++ b/drivers/iio/adc/ti-adc081s.c
>>>> @@ -0,0 +1,239 @@
>>>> +/*
>>>> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit ADC driver
>>>> + *
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2 as
>>>> + * published by the Free Software Foundation.
>>> Could you consider using an SPDX tag here as documented by Thomas in
>>> this patch set [1] ?
>>> This is the new thing for this end of of year and a must have for 2018!
>>>
>>> [1] https://lkml.org/lkml/2017/12/4/934
>> Thanks for this... I added it...
>>
>> Best regards
>> Milan
>>
>>  From 039f53aa702bd524e53c61b0365d048e2624ef02 Mon Sep 17 00:00:00 2001
>> From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
>> Date: Sat, 23 Dec 2017 00:06:32 +0100
>> Subject: [PATCH v2] iio: adc: add driver for ti adc081s/adc101s/adc121s
>>
>> Linux device driver for single-channel CMOS
>> 8/10/12-bit analog-to-digital converter with a
>> high-speed serial interface.
>>
>> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
>>
>> Changes in v2:
>>   - Add SPDX tag
>>   - Add correct git commit message
> <snip>
>
>> --- /dev/null
>> +++ b/drivers/iio/adc/ti-adc081s.c
>> @@ -0,0 +1,242 @@
>> +/*
>> + * Released under the GPLv2 only.
>> + * SPDX-License-Identifier: GPL-2.0
>> + *
> The SPDX tag should be on the first line using a C++ style comment
> when in a .c file as explained in Thomas doc
> And when using an SPDx id, do no repeat a license notice: this would
> defeat the whole purpose of getting rid of boilerplate.
>
>> +// SPDX-License-Identifier: GPL-2.0
Thanks

Best regards
Milan

 From 108841eb108275081958610f03d8c8b0da280666 Mon Sep 17 00:00:00 2001
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Date: Sat, 23 Dec 2017 00:06:32 +0100
Subject: [PATCH v3] iio: adc: add driver for ti adc081s/adc101s/adc121s

Linux device driver for single-channel CMOS
8/10/12-bit analog-to-digital converter with a
high-speed serial interface.

Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>

Changes in v2:
  - Add SPDX tag
  - Add correct git commit message

Changes in v3:
  - C++ style comment for SPDX
  - update Kconfig file with name of devices
  - Add device tree txt file
---
  .../devicetree/bindings/iio/adc/ti-adc081s.txt     |  18 ++
  drivers/iio/adc/Kconfig                            |  10 +
  drivers/iio/adc/Makefile                           |   1 +
  drivers/iio/adc/ti-adc081s.c                       | 238 +++++++++++++++++++++
  4 files changed, 267 insertions(+)
  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti-adc081s.txt
  create mode 100644 drivers/iio/adc/ti-adc081s.c

diff --git a/Documentation/devicetree/bindings/iio/adc/ti-adc081s.txt b/Documentation/devicetree/bindings/iio/adc/ti-adc081s.txt
new file mode 100644
index 0000000..7d2a10d
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti-adc081s.txt
@@ -0,0 +1,18 @@
+* Texas Instruments' ADC081S/ADC101S/ADC121S
+
+Required properties:
+ - compatible: Should be one of
+	* "ti,adc081s"
+	* "ti,adc101s"
+	* "ti,adc121s"
+ - reg: spi chip select number for the device
+ - vref-supply: The regulator supply for ADC reference voltage
+ - spi-max-frequency: Max SPI frequency to use (< 400000)
+
+Example:
+adc@0 {
+	compatible = "ti,adc081s";
+	reg = <0>;
+	vref-supply = <&vdd_supply>;
+	spi-max-frequency = <200000>;
+};
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ef86296..10366d6 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -701,6 +701,16 @@ config TI_ADC081C
  	  This driver can also be built as a module. If so, the module will be
  	  called ti-adc081c.
  
+config TI_ADC081S
+	tristate "Texas Instruments ADC081S/ADC101S/ADC121S family"
+	depends on SPI
+	help
+	  If you say yes here you get support for Texas Instruments
+	  ADC081S/ADC101S/ADC121S family ADC chips.
+
+	  This driver can also be built as a module. If so, the module will be
+	  called ti-adc081s.
+
  config TI_ADC0832
  	tristate "Texas Instruments ADC0831/ADC0832/ADC0834/ADC0838"
  	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9572c10..020fecf 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_SUN4I_GPADC) += sun4i-gpadc-iio.o
  obj-$(CONFIG_STM32_ADC_CORE) += stm32-adc-core.o
  obj-$(CONFIG_STM32_ADC) += stm32-adc.o
  obj-$(CONFIG_TI_ADC081C) += ti-adc081c.o
+obj-$(CONFIG_TI_ADC081S) += ti-adc081s.o
  obj-$(CONFIG_TI_ADC0832) += ti-adc0832.o
  obj-$(CONFIG_TI_ADC084S021) += ti-adc084s021.o
  obj-$(CONFIG_TI_ADC12138) += ti-adc12138.o
diff --git a/drivers/iio/adc/ti-adc081s.c b/drivers/iio/adc/ti-adc081s.c
new file mode 100644
index 0000000..e0db4fd
--- /dev/null
+++ b/drivers/iio/adc/ti-adc081s.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI ADC081S/ADC101S/ADC121S 8/10/12-bit ADC driver
+ *
+ * Linux device driver for single-channel CMOS
+ * 8/10/12-bit analog-to-digital converter with a
+ * high-speed serial interface.
+ *
+ * Datasheets:
+ *	http://www.ti.com/lit/ds/symlink/adc081s021.pdf
+ *	http://www.ti.com/lit/ds/symlink/adc101s021.pdf
+ *	http://www.ti.com/lit/ds/symlink/adc121s021.pdf
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/acpi.h>
+
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/regulator/consumer.h>
+
+struct adc081s {
+	struct spi_device *spi;
+	struct regulator *reg;
+	struct mutex lock;
+
+	/* 8, 10 or 12 */
+	int bits;
+};
+
+static int adc081s_read_raw(struct iio_dev *iio,
+			    struct iio_chan_spec const *channel, int *value,
+			    int *shift, long mask)
+{
+	struct adc081s *adc = iio_priv(iio);
+	int ret;
+	__be16 buf;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&adc->lock);
+		ret = spi_read(adc->spi, (void *) &buf, 2);
+		mutex_unlock(&adc->lock);
+		if (ret)
+			return ret;
+		*value = (be16_to_cpu(buf) & 0x0FFF) >> (12 - adc->bits);
+		*value = sign_extend32(*value, channel->scan_type.realbits - 1);
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*value = regulator_get_voltage(adc->reg);
+		if (*value < 0)
+			return *value;
+
+		/* convert regulator output voltage to mV */
+		*value /= 1000;
+		*shift = adc->bits;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+#define ADCxx1S_CHAN(_bits) {					\
+	.type = IIO_VOLTAGE,					\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (_bits),				\
+		.storagebits = 16,				\
+		.shift = 12 - (_bits),				\
+		.endianness = IIO_CPU,				\
+	},							\
+}
+
+#define DEFINE_ADCxx1S_CHANNELS(_name, _bits)				\
+	static const struct iio_chan_spec _name ## _channels[] = {	\
+		ADCxx1S_CHAN((_bits)),					\
+		IIO_CHAN_SOFT_TIMESTAMP(1),				\
+	}								\
+
+#define ADC081S_NUM_CHANNELS 2
+
+struct adcxx1s_model {
+	const struct iio_chan_spec *channels;
+	int bits;
+};
+
+#define ADCxx1S_MODEL(_name, _bits)					\
+	{								\
+		.channels = _name ## _channels,				\
+		.bits = (_bits),					\
+	}
+
+DEFINE_ADCxx1S_CHANNELS(adc081s,  8);
+DEFINE_ADCxx1S_CHANNELS(adc101s, 10);
+DEFINE_ADCxx1S_CHANNELS(adc121s, 12);
+
+/* Model ids are indexes in _models array */
+enum adcxx1s_model_id {
+	ADC081S = 0,
+	ADC101S = 1,
+	ADC121S = 2,
+};
+
+static struct adcxx1s_model adcxx1s_models[] = {
+	ADCxx1S_MODEL(adc081s,  8),
+	ADCxx1S_MODEL(adc101s, 10),
+	ADCxx1S_MODEL(adc121s, 12),
+};
+
+static const struct iio_info adc081s_info = {
+	.read_raw = adc081s_read_raw,
+};
+
+static int adc081s_probe(struct spi_device *spi)
+{
+	struct iio_dev *iio;
+	struct adc081s *adc;
+	struct adcxx1s_model *model;
+	int err;
+
+	if (ACPI_COMPANION(&spi->dev)) {
+		const struct acpi_device_id *ad_id;
+
+		ad_id = acpi_match_device(spi->dev.driver->acpi_match_table,
+					  &spi->dev);
+		if (!ad_id)
+			return -ENODEV;
+		model = &adcxx1s_models[ad_id->driver_data];
+	} else {
+		model = &adcxx1s_models[spi_get_device_id(spi)->driver_data];
+	}
+
+	iio = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
+	if (!iio)
+		return -ENOMEM;
+
+	adc = iio_priv(iio);
+	adc->spi = spi;
+	adc->bits = model->bits;
+	mutex_init(&adc->lock);
+
+	adc->reg = devm_regulator_get(&spi->dev, "vref");
+	if (IS_ERR(adc->reg))
+		return PTR_ERR(adc->reg);
+
+	err = regulator_enable(adc->reg);
+	if (err < 0)
+		return err;
+
+	iio->dev.parent = &spi->dev;
+	iio->dev.of_node = spi->dev.of_node;
+	iio->name = dev_name(&spi->dev);
+	iio->modes = INDIO_DIRECT_MODE;
+	iio->info = &adc081s_info;
+
+	iio->channels = model->channels;
+	iio->num_channels = ADC081S_NUM_CHANNELS;
+
+	err = iio_device_register(iio);
+	if (err < 0)
+		goto err_regulator_disable;
+
+	spi_set_drvdata(spi, iio);
+
+	return 0;
+
+err_regulator_disable:
+	regulator_disable(adc->reg);
+
+	return err;
+}
+
+static int adc081s_remove(struct spi_device *spi)
+{
+	struct iio_dev *iio = spi_get_drvdata(spi);
+	struct adc081s *adc = iio_priv(iio);
+
+	iio_device_unregister(iio);
+	regulator_disable(adc->reg);
+
+	return 0;
+}
+
+static const struct spi_device_id adc081s_id[] = {
+	{ "adc081s", ADC081S },
+	{ "adc101s", ADC101S },
+	{ "adc121s", ADC121S },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, adc081s_id);
+
+#ifdef CONFIG_OF
+static const struct of_device_id adc081s_of_match[] = {
+	{ .compatible = "ti,adc081s" },
+	{ .compatible = "ti,adc101s" },
+	{ .compatible = "ti,adc121s" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adc081s_of_match);
+#endif
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id adc081s_acpi_match[] = {
+	{ "ADC081S", ADC081S },
+	{ "ADC101S", ADC101S },
+	{ "ADC121S", ADC121S },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adc081s_acpi_match);
+#endif
+
+static struct spi_driver adc081s_driver = {
+	.driver = {
+		.name = "adc081s",
+		.of_match_table = of_match_ptr(adc081s_of_match),
+		.acpi_match_table = ACPI_PTR(adc081s_acpi_match),
+	},
+	.probe = adc081s_probe,
+	.remove = adc081s_remove,
+	.id_table = adc081s_id,
+};
+module_spi_driver(adc081s_driver);
+
+MODULE_AUTHOR("Milan Stevanovic <milan.o.stevanovic@gmail.com>");
+MODULE_DESCRIPTION("Texas Instruments ADC081S/ADC101S/ADC121S driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
