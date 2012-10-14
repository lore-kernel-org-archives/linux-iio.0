Return-Path: <denis.ciocca@gmail.com>
MIME-Version: 1.0
In-Reply-To: <665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
References: <5072F3B9.4050309@st.com>
	<5073260C.3010506@metafoo.de>
	<20121008195007.GA32042@elf.ucw.cz>
	<507338B5.60307@metafoo.de>
	<665718a4-de6b-4d09-ba80-35705fcf2595@email.android.com>
Date: Sun, 14 Oct 2012 17:05:27 +0200
Message-ID: <CAEE_umojW5OyB3yGgE54wH7_k__dBu9=Yew_0tCCf5--=C2g5g@mail.gmail.com>
Subject: Re: STMicroelectronics accelerometers driver.
From: Denis Ciocca <denis.ciocca@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@denx.de>, Denis CIOCCA <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"burman.yan@gmail.com" <burman.yan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi guys,

according to your requests I have modified my driver. Only one things
about this function:

static int acc_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)

You tell to me:

>In buffered mode the samples should not be postprocessed. Userspace expects the
>samples in the format as described by the scan_type. The buffer demuxing should
>be handled by the IIO core. If you set up available_scan_masks correctly it
>will automatically do the right thing.

I agree with you for the postprocessed samples part, but I don't understand very
well the second one.
I saw the other drivers, if I check only the available_scan_masks variable
I don't know which channels are actives and which not.
I will read every time all data channels, but I choose which channel
put in the buffer.

Thanks,
Denis





>From 0917bcc1e22462db0469709d1020b5378d91959c Mon Sep 17 00:00:00 2001
From: userid <userid@MacBookAir.(none)>
Date: Sun, 14 Oct 2012 00:05:54 +0200
Subject: [PATCH] Add STMicroelectronics accelerometers driver to support I2C
 and SPI devices.

---
 drivers/iio/accel/Kconfig                    |   32 +
 drivers/iio/accel/Makefile                   |    6 +
 drivers/iio/accel/ST_accel_buffer.c          |  122 +++
 drivers/iio/accel/ST_accel_core.c            | 1335 ++++++++++++++++++++++++++
 drivers/iio/accel/ST_accel_i2c.c             |  165 ++++
 drivers/iio/accel/ST_accel_spi.c             |  236 +++++
 drivers/iio/accel/ST_accel_trigger.c         |   87 ++
 include/linux/iio/accel/ST_accel.h           |  120 +++
 include/linux/platform_data/ST_accel_pdata.h |   34 +
 9 files changed, 2137 insertions(+)
 create mode 100644 drivers/iio/accel/ST_accel_buffer.c
 create mode 100644 drivers/iio/accel/ST_accel_core.c
 create mode 100644 drivers/iio/accel/ST_accel_i2c.c
 create mode 100644 drivers/iio/accel/ST_accel_spi.c
 create mode 100644 drivers/iio/accel/ST_accel_trigger.c
 create mode 100644 include/linux/iio/accel/ST_accel.h
 create mode 100644 include/linux/platform_data/ST_accel_pdata.h

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b2510c4..13cc44f 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -13,4 +13,36 @@ config HID_SENSOR_ACCEL_3D
 	  Say yes here to build support for the HID SENSOR
 	  accelerometers 3D.

+config ST_ACCEL_3AXIS
+	tristate "STMicroelectronics accelerometers 3-Axis Driver"
+	depends on (I2C || SPI)
+	help
+	  Say yes here to build support for STMicroelectronics accelerometers.
+
+choice
+	prompt "Bus type"
+	depends on ST_ACCEL_3AXIS
+
+config ST_ACCEL_3AXIS_I2C
+	bool "support I2C bus connection"
+	depends on I2C && ST_ACCEL_3AXIS
+	help
+	  Say yes here to build I2C support for STMicroelectronics accelerometers.
+
+config ST_ACCEL_3AXIS_SPI
+	bool "support SPI bus connection"
+	depends on SPI && ST_ACCEL_3AXIS
+	help
+	Say yes here to build SPI support for STMicroelectronics accelerometers.
+
+endchoice
+
+config ST_ACCEL_3AXIS_TRIGGERED_BUFFER
+	tristate "support triggered buffer"
+	depends on ST_ACCEL_3AXIS
+	select IIO_TRIGGERED_BUFFER
+	select IIO_BUFFER
+	help
+	  Default trigger and buffer for STMicroelectronics accelerometers driver.
+
 endmenu
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 5bc6855..b797db4 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -3,3 +3,9 @@
 #

 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
+
+ST_accel-y := ST_accel_core.o
+obj-$(CONFIG_ST_ACCEL_3AXIS_I2C) += ST_accel_i2c.o
+obj-$(CONFIG_ST_ACCEL_3AXIS_SPI) += ST_accel_spi.o
+obj-$(CONFIG_ST_ACCEL_3AXIS_TRIGGERED_BUFFER) += ST_accel_trigger.o
ST_accel_buffer.o
+obj-$(CONFIG_ST_ACCEL_3AXIS) += ST_accel.o
\ No newline at end of file
diff --git a/drivers/iio/accel/ST_accel_buffer.c
b/drivers/iio/accel/ST_accel_buffer.c
new file mode 100644
index 0000000..61ee836
--- /dev/null
+++ b/drivers/iio/accel/ST_accel_buffer.c
@@ -0,0 +1,122 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/byteorder/generic.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
+#include <linux/iio/accel/ST_accel.h>
+
+
+#define ST_ACCEL_NUMBER_DATA_CHANNELS		3
+
+static int acc_read_all(struct iio_dev *indio_dev, u8 *rx_array)
+{
+	int len;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	len = adata->read_multiple_byte(adata,
+		indio_dev->channels[ST_ACC_SCAN_X].address,
+		ST_ACC_BYTE_FOR_CHANNEL*ST_ACCEL_NUMBER_DATA_CHANNELS,
+		rx_array);
+	if (len < 0)
+		goto read_error;
+
+	return len;
+
+read_error:
+	return -EIO;
+}
+
+static int acc_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
+{
+	int ret, i, n = 0;
+	u8 *rx_array;
+	u8 mask = 0x01;
+	s16 *data = (s16 *)buf;
+	int scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				       indio_dev->masklength);
+
+	rx_array = kzalloc(ST_ACC_BYTE_FOR_CHANNEL*
+				ST_ACCEL_NUMBER_DATA_CHANNELS, GFP_KERNEL);
+	if (rx_array == NULL)
+		return -ENOMEM;
+	ret = acc_read_all(indio_dev, rx_array);
+	if (ret < 0)
+		return ret;
+	for (i = 0; i < ST_ACCEL_NUMBER_DATA_CHANNELS; i++) {
+		if ((*indio_dev->active_scan_mask & mask) > 0) {
+			if (indio_dev->channels[i].scan_type.endianness ==
+								IIO_LE) {
+				data[n] = (s16)(cpu_to_le16(le16_to_cpu((
+				(__le16 *)rx_array)[i])));
+				n++;
+			} else {
+				data[n] = (s16)(cpu_to_be16(be16_to_cpu((
+				(__be16 *)rx_array)[i])));
+				n++;
+			}
+		}
+		mask = mask << 1;
+	}
+	kfree(rx_array);
+	return i*sizeof(data[0]);
+}
+
+static irqreturn_t acc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	int len = 0;
+	char *data;
+
+	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
+	if (data == NULL)
+		goto done;
+	if (!bitmap_empty(indio_dev->active_scan_mask, indio_dev->masklength))
+		len = acc_get_buffer_element(indio_dev, data);
+	else
+		goto done;
+	if (indio_dev->scan_timestamp)
+		*(s64 *)((u8 *)data + ALIGN(len, sizeof(s64))) = pf->timestamp;
+	iio_push_to_buffer(indio_dev->buffer, data);
+	kfree(data);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+static const struct iio_buffer_setup_ops acc_buf_setup_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+};
+
+int acc_allocate_ring(struct iio_dev *indio_dev)
+{
+	return iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
+			&acc_trigger_handler, &acc_buf_setup_ops);
+}
+EXPORT_SYMBOL(acc_allocate_ring);
+
+void acc_deallocate_ring(struct iio_dev *indio_dev)
+{
+	iio_triggered_buffer_cleanup(indio_dev);
+}
+EXPORT_SYMBOL(acc_deallocate_ring);
diff --git a/drivers/iio/accel/ST_accel_core.c
b/drivers/iio/accel/ST_accel_core.c
new file mode 100644
index 0000000..5b30155
--- /dev/null
+++ b/drivers/iio/accel/ST_accel_core.c
@@ -0,0 +1,1335 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+#include <linux/irq.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/buffer.h>
+
+#include <linux/iio/accel/ST_accel.h>
+
+
+#define ST_ACCEL_FULLSCALE_AVL_MAX	5
+#define ST_ACCEL_ODR_LIST_MAX		10
+#define UG_TO_MS2(x)			(x*9800)
+#define ST_ACCEL_ON			1
+#define ST_ACCEL_OFF			0
+
+/* DEFAULT VALUE FOR SENSORS */
+#define ST_DEFAULT_OUT_X_L_ADDR		0x28
+#define ST_DEFAULT_OUT_X_H_ADDR		0x29
+#define ST_DEFAULT_OUT_Y_L_ADDR		0x2a
+#define ST_DEFAULT_OUT_Y_H_ADDR		0x2b
+#define ST_DEFAULT_OUT_Z_L_ADDR		0x2c
+#define ST_DEFAULT_OUT_Z_H_ADDR		0x2d
+#define ST_DEFAULT_WAI_ADDRESS		0x0f
+#define ST_DEFAULT_POWER_ON_VALUE	0x01
+#define ST_DEFAULT_POWER_OFF_VALUE	0x00
+
+/* ODR */
+#define ST_ACCEL_ODR_AVL_1HZ		1
+#define ST_ACCEL_ODR_AVL_3HZ		3
+#define ST_ACCEL_ODR_AVL_6HZ		6
+#define ST_ACCEL_ODR_AVL_10HZ		10
+#define ST_ACCEL_ODR_AVL_12HZ		12
+#define ST_ACCEL_ODR_AVL_25HZ		25
+#define ST_ACCEL_ODR_AVL_50HZ		50
+#define ST_ACCEL_ODR_AVL_100HZ		100
+#define ST_ACCEL_ODR_AVL_200HZ		200
+#define ST_ACCEL_ODR_AVL_400HZ		400
+#define ST_ACCEL_ODR_AVL_800HZ		800
+#define ST_ACCEL_ODR_AVL_1000HZ		1000
+#define ST_ACCEL_ODR_AVL_1600HZ		1600
+
+/* FULLSCALE */
+#define ST_ACCEL_FS_AVL_2G		2
+#define ST_ACCEL_FS_AVL_4G		4
+#define ST_ACCEL_FS_AVL_6G		6
+#define ST_ACCEL_FS_AVL_8G		8
+#define ST_ACCEL_FS_AVL_16G		16
+
+/* CUSTOM VALUES FOR SENSOR 1 */
+#define S1_WAI_EXP			0x33
+#define S1_ODR_ADDR			0x20
+#define S1_ODR_MASK			0xf0
+#define S1_ODR_N_BIT			4
+#define S1_ODR_AVL_1HZ_VALUE		0x01
+#define S1_ODR_AVL_10HZ_VALUE		0x02
+#define S1_ODR_AVL_25HZ_VALUE		0x03
+#define S1_ODR_AVL_50HZ_VALUE		0x04
+#define S1_ODR_AVL_100HZ_VALUE		0x05
+#define S1_ODR_AVL_200HZ_VALUE		0x06
+#define S1_ODR_AVL_400HZ_VALUE		0x07
+#define S1_ODR_AVL_1600HZ_VALUE		0x08
+#define S1_FS_N_BIT			2
+#define S1_FS_ADDR			0x23
+#define S1_FS_MASK			0x30
+#define S1_FS_AVL_2_VALUE		0x00
+#define S1_FS_AVL_4_VALUE		0x01
+#define S1_FS_AVL_8_VALUE		0x02
+#define S1_FS_AVL_16_VALUE		0x03
+#define S1_FS_AVL_2_GAIN		1000
+#define S1_FS_AVL_4_GAIN		2000
+#define S1_FS_AVL_8_GAIN		4000
+#define S1_FS_AVL_16_GAIN		12000
+#define S1_REALBITS			12
+#define S1_BDU_ADDR			0x23
+#define S1_BDU_MASK			0x80
+#define S1_DRDY_IRQ_ADDR		0x22
+#define S1_DRDY_IRQ_MASK		0x10
+#define S1_MULTIREAD_BIT		true
+
+/* CUSTOM VALUES FOR SENSOR 2 */
+#define S2_WAI_EXP			0x49
+#define S2_ODR_ADDR			0x20
+#define S2_ODR_MASK			0xf0
+#define S2_ODR_N_BIT			4
+#define S2_ODR_AVL_3HZ_VALUE		0x01
+#define S2_ODR_AVL_6HZ_VALUE		0x02
+#define S2_ODR_AVL_12HZ_VALUE		0x03
+#define S2_ODR_AVL_25HZ_VALUE		0x04
+#define S2_ODR_AVL_50HZ_VALUE		0x05
+#define S2_ODR_AVL_100HZ_VALUE		0x06
+#define S2_ODR_AVL_200HZ_VALUE		0x07
+#define S2_ODR_AVL_400HZ_VALUE		0x08
+#define S2_ODR_AVL_800HZ_VALUE		0x09
+#define S2_ODR_AVL_1600HZ_VALUE		0x0a
+#define S2_FS_N_BIT			3
+#define S2_FS_ADDR			0x21
+#define S2_FS_MASK			0x38
+#define S2_FS_AVL_2_VALUE		0X00
+#define S2_FS_AVL_4_VALUE		0X01
+#define S2_FS_AVL_6_VALUE		0x02
+#define S2_FS_AVL_8_VALUE		0x03
+#define S2_FS_AVL_16_VALUE		0x04
+#define S2_FS_AVL_2_GAIN		61
+#define S2_FS_AVL_4_GAIN		122
+#define S2_FS_AVL_6_GAIN		183
+#define S2_FS_AVL_8_GAIN		244
+#define S2_FS_AVL_16_GAIN		732
+#define S2_REALBITS			16
+#define S2_BDU_ADDR			0x20
+#define S2_BDU_MASK			0x08
+#define S2_DRDY_IRQ_ADDR		0x22
+#define S2_DRDY_IRQ_MASK		0x04
+#define S2_MULTIREAD_BIT		true
+
+/* CUSTOM VALUES FOR SENSOR 3 */
+#define S3_WAI_EXP			0x3c
+#define S3_ODR_ADDR			0x20
+#define S3_ODR_MASK			0x18
+#define S3_ODR_N_BIT			2
+#define S3_ODR_AVL_50HZ_VALUE		0x00
+#define S3_ODR_AVL_100HZ_VALUE		0x01
+#define S3_ODR_AVL_400HZ_VALUE		0x02
+#define S3_ODR_AVL_1000HZ_VALUE		0x03
+#define S3_PW_ADDR			0x20
+#define S3_PW_MASK			0xe0
+#define S3_PW_N_BIT			3
+#define S3_PW_VALUE_ON			0x01
+#define S3_PW_VALUE_OFF			0x00
+#define S3_FS_N_BIT			2
+#define S3_FS_ADDR			0x23
+#define S3_FS_MASK			0x30
+#define S3_FS_AVL_2_VALUE		0X00
+#define S3_FS_AVL_4_VALUE		0X01
+#define S3_FS_AVL_8_VALUE		0x03
+#define S3_FS_AVL_2_GAIN		1000
+#define S3_FS_AVL_4_GAIN		2000
+#define S3_FS_AVL_8_GAIN		3900
+#define S3_REALBITS			12
+#define S3_BDU_ADDR			0x23
+#define S3_BDU_MASK			0x80
+#define S3_DRDY_IRQ_ADDR		0x22
+#define S3_DRDY_IRQ_MASK		0x02
+#define S3_MULTIREAD_BIT		true
+
+/* CUSTOM VALUES FOR SENSOR 4 */
+#define S4_WAI_EXP			0xd4
+#define S4_ODR_ADDR			0x20
+#define S4_ODR_MASK			0xf0
+#define S4_ODR_N_BIT			4
+#define S4_ODR_AVL_3HZ_VALUE		0x01
+#define S4_ODR_AVL_6HZ_VALUE		0x02
+#define S4_ODR_AVL_12HZ_VALUE		0x03
+#define S4_ODR_AVL_25HZ_VALUE		0x04
+#define S4_ODR_AVL_50HZ_VALUE		0x05
+#define S4_ODR_AVL_100HZ_VALUE		0x06
+#define S4_ODR_AVL_200HZ_VALUE		0x07
+#define S4_ODR_AVL_400HZ_VALUE		0x08
+#define S4_ODR_AVL_800HZ_VALUE		0x09
+#define S4_ODR_AVL_1600HZ_VALUE		0x0a
+#define S4_FS_N_BIT			3
+#define S4_FS_ADDR			0x24
+#define S4_FS_MASK			0x38
+#define S4_FS_AVL_2_VALUE		0X00
+#define S4_FS_AVL_4_VALUE		0X01
+#define S4_FS_AVL_6_VALUE		0x02
+#define S4_FS_AVL_8_VALUE		0x03
+#define S4_FS_AVL_16_VALUE		0x04
+#define S2_FS_AVL_2_GAIN		61
+#define S2_FS_AVL_4_GAIN		122
+#define S2_FS_AVL_6_GAIN		183
+#define S2_FS_AVL_8_GAIN		244
+#define S2_FS_AVL_16_GAIN		732
+#define S4_REALBITS			12
+#define S4_BDU_ADDR			0x20
+#define S4_BDU_MASK			0x08
+#define S4_DRDY_IRQ_ADDR		0x23
+#define S4_DRDY_IRQ_MASK		0x80
+#define S4_MULTIREAD_BIT		false
+
+struct odr_available {
+	int hz;
+	u8 value;
+};
+
+struct odr {
+	u8 addr;
+	u8 mask;
+	short num_bit;
+	struct odr_available odr_avl[ST_ACCEL_ODR_LIST_MAX];
+};
+
+struct power {
+	u8 addr;
+	u8 mask;
+	short num_bit;
+	u8 value_off;
+	u8 value_on;
+};
+
+struct fullscale_available {
+	int num;
+	u8 value;
+	int gain;
+};
+
+struct fullscale {
+	u8 addr;
+	u8 mask;
+	short num_bit;
+	struct fullscale_available fs_avl[ST_ACCEL_FULLSCALE_AVL_MAX];
+};
+
+struct bdu {
+	u8 addr;
+	u8 mask;
+};
+
+struct interrupt_generator {
+	u8 en_addr;
+	u8 latch_mask_addr;
+	u8 en_mask;
+	u8 latching_mask;
+};
+
+struct data_ready_irq {
+	u8 addr;
+	u8 mask;
+	struct interrupt_generator ig1;
+};
+
+#define LSM_CHANNELS(index, mod, endian, bits, addr) \
+{ \
+	.type = IIO_ACCEL, \
+	.modified = 1, \
+	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
+					IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.scan_index = index, \
+	.channel2 = mod, \
+	.address = addr, \
+	.scan_type = { \
+		.sign = 's', \
+		.realbits = bits, \
+		.shift = 16 - bits, \
+		.storagebits = 16, \
+		.endianness = endian, \
+	}, \
+}
+
+static const struct iio_chan_spec default_channels[] = {
+	LSM_CHANNELS(ST_ACC_SCAN_X, IIO_MOD_X, IIO_LE,
+					S1_REALBITS, ST_DEFAULT_OUT_X_L_ADDR),
+	LSM_CHANNELS(ST_ACC_SCAN_Y, IIO_MOD_Y, IIO_LE,
+					S1_REALBITS, ST_DEFAULT_OUT_Y_L_ADDR),
+	LSM_CHANNELS(ST_ACC_SCAN_Z, IIO_MOD_Z, IIO_LE,
+					S1_REALBITS, ST_DEFAULT_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+static const struct iio_chan_spec s2_channels[] = {
+	LSM_CHANNELS(ST_ACC_SCAN_X, IIO_MOD_X, IIO_LE,
+					S2_REALBITS, ST_DEFAULT_OUT_X_L_ADDR),
+	LSM_CHANNELS(ST_ACC_SCAN_Y, IIO_MOD_Y, IIO_LE,
+					S2_REALBITS, ST_DEFAULT_OUT_Y_L_ADDR),
+	LSM_CHANNELS(ST_ACC_SCAN_Z, IIO_MOD_Z, IIO_LE,
+					S2_REALBITS, ST_DEFAULT_OUT_Z_L_ADDR),
+	IIO_CHAN_SOFT_TIMESTAMP(3)
+};
+
+/**
+ * struct st_accel_sensors - ST accel sensors list
+ * @wai: Contents of WhoAmI register.
+ * @ch: IIO channels for the sensor.
+ * @odr: Output data rate register and odr list available.
+ * @pw: Power register of the sensor.
+ * @fs: Full scale register and fs list available.
+ * @bdu: Block data update register.
+ * @drdy_irq: Data ready register of the sensor.
+ * @ multi_read_bit: Use or not particular bit for [I2C/SPI] multiread.
+ */
+
+static const struct st_accel_sensors {
+	u8 wai;
+	struct iio_chan_spec *ch;
+	struct odr odr;
+	struct power pw;
+	struct fullscale fs;
+	struct bdu bdu;
+	struct data_ready_irq drdy_irq;
+	bool multi_read_bit;
+} st_accel_sensors[] = {
+	{
+	.wai = S1_WAI_EXP,
+	.ch = (struct iio_chan_spec *)default_channels,
+	.odr = {
+		.addr = S1_ODR_ADDR,
+		.mask = S1_ODR_MASK,
+		.num_bit = S1_ODR_N_BIT,
+		.odr_avl = {
+			[0] = {
+				.hz = ST_ACCEL_ODR_AVL_1HZ,
+				.value = S1_ODR_AVL_1HZ_VALUE,
+			},
+			[1] = {
+				.hz = ST_ACCEL_ODR_AVL_10HZ,
+				.value = S1_ODR_AVL_10HZ_VALUE,
+			},
+			[2] = {
+				.hz = ST_ACCEL_ODR_AVL_25HZ,
+				.value = S1_ODR_AVL_25HZ_VALUE,
+			},
+			[3] = {
+				.hz = ST_ACCEL_ODR_AVL_50HZ,
+				.value = S1_ODR_AVL_50HZ_VALUE,
+			},
+			[4] = {
+				.hz = ST_ACCEL_ODR_AVL_100HZ,
+				.value = S1_ODR_AVL_100HZ_VALUE,
+			},
+			[5] = {
+				.hz = ST_ACCEL_ODR_AVL_200HZ,
+				.value = S1_ODR_AVL_200HZ_VALUE,
+			},
+			[6] = {
+				.hz = ST_ACCEL_ODR_AVL_400HZ,
+				.value = S1_ODR_AVL_400HZ_VALUE,
+			},
+			[7] = {
+				.hz = ST_ACCEL_ODR_AVL_1600HZ,
+				.value = S1_ODR_AVL_1600HZ_VALUE,
+			},
+		},
+	},
+	.pw = {
+		.addr = S1_ODR_ADDR,
+		.mask = S1_ODR_MASK,
+		.num_bit = S1_ODR_N_BIT,
+		.value_off = ST_DEFAULT_POWER_OFF_VALUE,
+	},
+	.fs = {
+		.addr = S1_FS_ADDR,
+		.mask = S1_FS_MASK,
+		.num_bit = S1_FS_N_BIT,
+		.fs_avl = {
+			[0] = {
+				.num = ST_ACCEL_FS_AVL_2G,
+				.value = S1_FS_AVL_2_VALUE,
+				.gain = S1_FS_AVL_2_GAIN,
+			},
+			[1] = {
+				.num = ST_ACCEL_FS_AVL_4G,
+				.value = S1_FS_AVL_4_VALUE,
+				.gain = S1_FS_AVL_4_GAIN,
+			},
+			[2] = {
+				.num = ST_ACCEL_FS_AVL_8G,
+				.value = S1_FS_AVL_8_VALUE,
+				.gain = S1_FS_AVL_8_GAIN,
+			},
+			[3] = {
+				.num = ST_ACCEL_FS_AVL_16G,
+				.value = S1_FS_AVL_16_VALUE,
+				.gain = S1_FS_AVL_16_GAIN,
+			},
+		},
+	},
+	.bdu = {
+		.addr = S1_BDU_ADDR,
+		.mask = S1_BDU_MASK,
+	},
+	.drdy_irq = {
+		.addr = S1_DRDY_IRQ_ADDR,
+		.mask = S1_DRDY_IRQ_MASK,
+	},
+	.multi_read_bit = S1_MULTIREAD_BIT,
+	},
+	{
+	.wai = S2_WAI_EXP,
+	.ch = (struct iio_chan_spec *)s2_channels,
+	.odr = {
+		.addr = S2_ODR_ADDR,
+		.mask = S2_ODR_MASK,
+		.num_bit = S2_ODR_N_BIT,
+		.odr_avl = {
+			[0] = {
+				.hz = ST_ACCEL_ODR_AVL_3HZ,
+				.value = S2_ODR_AVL_3HZ_VALUE,
+			},
+			[1] = {
+				.hz = ST_ACCEL_ODR_AVL_6HZ,
+				.value = S2_ODR_AVL_6HZ_VALUE,
+			},
+			[2] = {
+				.hz = ST_ACCEL_ODR_AVL_12HZ,
+				.value = S2_ODR_AVL_12HZ_VALUE,
+			},
+			[3] = {
+				.hz = ST_ACCEL_ODR_AVL_25HZ,
+				.value = S2_ODR_AVL_25HZ_VALUE,
+			},
+			[4] = {
+				.hz = ST_ACCEL_ODR_AVL_50HZ,
+				.value = S2_ODR_AVL_50HZ_VALUE,
+			},
+			[5] = {
+				.hz = ST_ACCEL_ODR_AVL_100HZ,
+				.value = S2_ODR_AVL_100HZ_VALUE,
+			},
+			[6] = {
+				.hz = ST_ACCEL_ODR_AVL_200HZ,
+				.value = S2_ODR_AVL_200HZ_VALUE,
+			},
+			[7] = {
+				.hz = ST_ACCEL_ODR_AVL_400HZ,
+				.value = S2_ODR_AVL_400HZ_VALUE,
+			},
+			[8] = {
+				.hz = ST_ACCEL_ODR_AVL_800HZ,
+				.value = S2_ODR_AVL_800HZ_VALUE,
+			},
+			[9] = {
+				.hz = ST_ACCEL_ODR_AVL_1600HZ,
+				.value = S2_ODR_AVL_1600HZ_VALUE,
+			},
+		},
+	},
+	.pw = {
+		.addr = S2_ODR_ADDR,
+		.mask = S2_ODR_MASK,
+		.num_bit = S2_ODR_N_BIT,
+		.value_off = ST_DEFAULT_POWER_OFF_VALUE,
+	},
+	.fs = {
+		.addr = S2_FS_ADDR,
+		.mask = S2_FS_MASK,
+		.num_bit = S2_FS_N_BIT,
+		.fs_avl = {
+			[0] = {
+				.num = ST_ACCEL_FS_AVL_2G,
+				.value = S2_FS_AVL_2_VALUE,
+				.gain = S2_FS_AVL_2_GAIN,
+			},
+			[1] = {
+				.num = ST_ACCEL_FS_AVL_4G,
+				.value = S2_FS_AVL_4_VALUE,
+				.gain = S2_FS_AVL_4_GAIN,
+			},
+			[2] = {
+				.num = ST_ACCEL_FS_AVL_6G,
+				.value = S2_FS_AVL_6_VALUE,
+				.gain = S2_FS_AVL_6_GAIN,
+			},
+			[3] = {
+				.num = ST_ACCEL_FS_AVL_8G,
+				.value = S2_FS_AVL_8_VALUE,
+				.gain = S2_FS_AVL_8_GAIN,
+			},
+			[4] = {
+				.num = ST_ACCEL_FS_AVL_16G,
+				.value = S2_FS_AVL_16_VALUE,
+				.gain = S2_FS_AVL_16_GAIN,
+			},
+		},
+	},
+	.drdy_irq = {
+		.addr = S2_DRDY_IRQ_ADDR,
+		.mask = S2_DRDY_IRQ_MASK,
+	},
+	.bdu = {
+		.addr = S2_BDU_ADDR,
+		.mask = S2_BDU_MASK,
+	},
+	.multi_read_bit = S2_MULTIREAD_BIT,
+	},
+	{
+	.wai = S3_WAI_EXP,
+	.ch = (struct iio_chan_spec *)default_channels,
+	.odr = {
+		.addr = S3_ODR_ADDR,
+		.mask = S3_ODR_MASK,
+		.num_bit = S3_ODR_N_BIT,
+		.odr_avl = {
+			[0] = {
+				.hz = ST_ACCEL_ODR_AVL_50HZ,
+				.value = S3_ODR_AVL_50HZ_VALUE,
+			},
+			[1] = {
+				.hz = ST_ACCEL_ODR_AVL_100HZ,
+				.value = S3_ODR_AVL_100HZ_VALUE,
+			},
+			[2] = {
+				.hz = ST_ACCEL_ODR_AVL_400HZ,
+				.value = S3_ODR_AVL_400HZ_VALUE,
+			},
+			[3] = {
+				.hz = ST_ACCEL_ODR_AVL_1000HZ,
+				.value = S3_ODR_AVL_1000HZ_VALUE,
+			},
+		},
+	},
+	.pw = {
+		.addr = S3_PW_ADDR,
+		.mask = S3_PW_MASK,
+		.num_bit = S3_PW_N_BIT,
+		.value_on = S3_PW_VALUE_ON,
+		.value_off = S3_PW_VALUE_OFF,
+	},
+	.fs = {
+		.addr = S3_FS_ADDR,
+		.mask = S3_FS_MASK,
+		.num_bit = S3_FS_N_BIT,
+		.fs_avl = {
+			[0] = {
+				.num = ST_ACCEL_FS_AVL_2G,
+				.value = S3_FS_AVL_2_VALUE,
+				.gain = S3_FS_AVL_2_GAIN,
+			},
+			[1] = {
+				.num = ST_ACCEL_FS_AVL_4G,
+				.value = S3_FS_AVL_4_VALUE,
+				.gain = S3_FS_AVL_4_GAIN,
+			},
+			[2] = {
+				.num = ST_ACCEL_FS_AVL_8G,
+				.value = S3_FS_AVL_8_VALUE,
+				.gain = S3_FS_AVL_8_GAIN,
+			},
+		},
+	},
+	.bdu = {
+		.addr = S3_BDU_ADDR,
+		.mask = S3_BDU_MASK,
+	},
+	.drdy_irq = {
+		.addr = S3_DRDY_IRQ_ADDR,
+		.mask = S3_DRDY_IRQ_MASK,
+	},
+	.multi_read_bit = S3_MULTIREAD_BIT,
+	},
+	{
+	.wai = S4_WAI_EXP,
+	.ch = (struct iio_chan_spec *)s2_channels,
+	.odr = {
+		.addr = S4_ODR_ADDR,
+		.mask = S4_ODR_MASK,
+		.num_bit = S4_ODR_N_BIT,
+		.odr_avl = {
+			[0] = {
+				.hz = ST_ACCEL_ODR_AVL_3HZ,
+				.value = S4_ODR_AVL_3HZ_VALUE,
+			},
+			[1] = {
+				.hz = ST_ACCEL_ODR_AVL_6HZ,
+				.value = S4_ODR_AVL_6HZ_VALUE,
+			},
+			[2] = {
+				.hz = ST_ACCEL_ODR_AVL_12HZ,
+				.value = S4_ODR_AVL_12HZ_VALUE,
+			},
+			[3] = {
+				.hz = ST_ACCEL_ODR_AVL_25HZ,
+				.value = S4_ODR_AVL_25HZ_VALUE,
+			},
+			[4] = {
+				.hz = ST_ACCEL_ODR_AVL_50HZ,
+				.value = S4_ODR_AVL_50HZ_VALUE,
+			},
+			[5] = {
+				.hz = ST_ACCEL_ODR_AVL_100HZ,
+				.value = S4_ODR_AVL_100HZ_VALUE,
+			},
+			[6] = {
+				.hz = ST_ACCEL_ODR_AVL_200HZ,
+				.value = S4_ODR_AVL_200HZ_VALUE,
+			},
+			[7] = {
+				.hz = ST_ACCEL_ODR_AVL_400HZ,
+				.value = S4_ODR_AVL_400HZ_VALUE,
+			},
+			[8] = {
+				.hz = ST_ACCEL_ODR_AVL_800HZ,
+				.value = S4_ODR_AVL_800HZ_VALUE,
+			},
+			[9] = {
+				.hz = ST_ACCEL_ODR_AVL_1600HZ,
+				.value = S4_ODR_AVL_1600HZ_VALUE,
+			},
+		},
+	},
+	.pw = {
+		.addr = S4_ODR_ADDR,
+		.mask = S3_ODR_MASK,
+		.num_bit = S3_ODR_N_BIT,
+		.value_off = ST_DEFAULT_POWER_OFF_VALUE,
+	},
+	.fs = {
+		.addr = S4_FS_ADDR,
+		.mask = S4_FS_MASK,
+		.num_bit = S4_FS_N_BIT,
+		.fs_avl = {
+			[0] = {
+				.num = ST_ACCEL_FS_AVL_2G,
+				.value = S4_FS_AVL_2_VALUE,
+				.gain = S4_FS_AVL_2_GAIN,
+			},
+			[1] = {
+				.num = ST_ACCEL_FS_AVL_4G,
+				.value = S4_FS_AVL_4_VALUE,
+				.gain = S4_FS_AVL_4_GAIN,
+			},
+			[2] = {
+				.num = ST_ACCEL_FS_AVL_6G,
+				.value = S4_FS_AVL_6_VALUE,
+				.gain = S4_FS_AVL_6_GAIN,
+			},
+			[3] = {
+				.num = ST_ACCEL_FS_AVL_8G,
+				.value = S4_FS_AVL_8_VALUE,
+				.gain = S4_FS_AVL_8_GAIN,
+			},
+			[4] = {
+				.num = ST_ACCEL_FS_AVL_16G,
+				.value = S4_FS_AVL_16_VALUE,
+				.gain = S4_FS_AVL_16_GAIN,
+			},
+		},
+	},
+	.bdu = {
+		.addr = S4_BDU_ADDR,
+		.mask = S4_BDU_MASK,
+	},
+	.drdy_irq = {
+		.addr = S4_DRDY_IRQ_ADDR,
+		.mask = S4_DRDY_IRQ_MASK,
+	},
+	.multi_read_bit = S4_MULTIREAD_BIT,
+	},
+};
+
+static int acc_write_data_with_mask(struct iio_dev *indio_dev, u8 reg_addr,
+						u8 mask, short num_bit, u8 data)
+{
+	int err, j, pos;
+	u8 prev_data;
+	u8 new_data;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	pos = 7;
+	for (j = 128; j >= 0; j = j/2) {
+		if (mask/j > 0)
+			break;
+		else
+			pos--;
+	}
+
+	err = adata->read_byte(adata, reg_addr, &prev_data);
+	if (err < 0)
+		goto i2c_write_data_with_mask_error;
+
+	new_data = ((prev_data & (~mask)) | ((data << (pos-num_bit+1)) & mask));
+	err = adata->write_byte(adata, reg_addr, new_data);
+
+i2c_write_data_with_mask_error:
+	return err;
+}
+
+static int match_odr(const struct st_accel_sensors *sensor, int odr,
+						struct odr_available *odr_out)
+{
+	int n, i, ret = -1;
+
+	n = ARRAY_SIZE(sensor->odr.odr_avl);
+	for (i = 0; i < n; i++)
+		if (sensor->odr.odr_avl[i].hz == odr) {
+			odr_out->hz = sensor->odr.odr_avl[i].hz;
+			odr_out->value = sensor->odr.odr_avl[i].value;
+			ret = 0;
+			break;
+		}
+
+	return ret;
+}
+
+static int match_fs(const struct st_accel_sensors *sensor, int fs,
+					struct fullscale_available *fs_out)
+{
+	int n, i, ret = -1;
+
+	n = ARRAY_SIZE(sensor->fs.fs_avl);
+	for (i = 0; i < n; i++)
+		if (sensor->fs.fs_avl[i].num == fs) {
+			fs_out->num = sensor->fs.fs_avl[i].num;
+			fs_out->gain = sensor->fs.fs_avl[i].gain;
+			fs_out->value = sensor->fs.fs_avl[i].value;
+			ret = 0;
+			break;
+		}
+
+	return ret;
+}
+
+int acc_set_dataready_irq(struct iio_dev *indio_dev, bool enable)
+{
+	int err;
+	struct st_acc_data *adata;
+
+	adata = iio_priv(indio_dev);
+	if (st_accel_sensors[adata->index].drdy_irq.ig1.en_addr > 0) {
+		err = acc_write_data_with_mask(indio_dev,
+			st_accel_sensors[adata->index].drdy_irq.ig1.en_addr,
+			st_accel_sensors[adata->index].drdy_irq.ig1.en_mask, 1,
+			(int)enable);
+		if (err < 0)
+			goto acc_set_dataready_irq_error;
+	}
+
+	if (st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr > 0) {
+		err = acc_write_data_with_mask(indio_dev,
+		st_accel_sensors[adata->index].drdy_irq.ig1.latch_mask_addr,
+		st_accel_sensors[adata->index].drdy_irq.ig1.latching_mask, 1,
+			(int)enable);
+		if (err < 0)
+			goto acc_set_dataready_irq_error;
+	}
+
+	err = acc_write_data_with_mask(indio_dev,
+		st_accel_sensors[adata->index].drdy_irq.addr,
+		st_accel_sensors[adata->index].drdy_irq.mask, 1, (int)enable);
+	if (err < 0)
+		goto acc_set_dataready_irq_error;
+
+	return 0;
+
+acc_set_dataready_irq_error:
+	return -EIO;
+}
+EXPORT_SYMBOL(acc_set_dataready_irq);
+
+static int set_bdu(struct iio_dev *indio_dev, const struct bdu *bdu, u8 value)
+{
+	int err;
+
+	err = acc_write_data_with_mask(indio_dev,
+					bdu->addr,
+					bdu->mask,
+					1,
+					value);
+
+	return err;
+}
+
+static int set_odr(struct iio_dev *indio_dev,
+					struct odr_available *odr_available)
+{
+	int err;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	if ((st_accel_sensors[adata->index].odr.addr ==
+		st_accel_sensors[adata->index].pw.addr) &&
+			(st_accel_sensors[adata->index].odr.mask ==
+				st_accel_sensors[adata->index].pw.mask)) {
+		if (atomic_read(&adata->enabled) == ST_ACCEL_ON) {
+			err = acc_write_data_with_mask(indio_dev,
+				st_accel_sensors[adata->index].odr.addr,
+				st_accel_sensors[adata->index].odr.mask,
+				st_accel_sensors[adata->index].odr.num_bit,
+				odr_available->value);
+			if (err < 0)
+				goto set_odr_error;
+		} else {
+			adata->odr = odr_available->hz;
+			err = 0;
+		}
+	} else {
+		err = acc_write_data_with_mask(indio_dev,
+				st_accel_sensors[adata->index].odr.addr,
+				st_accel_sensors[adata->index].odr.mask,
+				st_accel_sensors[adata->index].odr.num_bit,
+				odr_available->value);
+		if (err < 0)
+			goto set_odr_error;
+	}
+
+set_odr_error:
+	return err;
+}
+
+static int set_enable(struct iio_dev *indio_dev, int enable)
+{
+	int found, err;
+	u8 tmp_value;
+	struct odr_available *odr_out;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	odr_out = kzalloc(sizeof(*odr_out), GFP_KERNEL);
+	if (odr_out == NULL) {
+		err = -ENOMEM;
+		goto odr_out_allocate_memory_error;
+	}
+
+	switch (enable) {
+	case ST_ACCEL_ON:
+		found = 0;
+		tmp_value = st_accel_sensors[adata->index].pw.value_on;
+		if ((st_accel_sensors[adata->index].odr.addr ==
+				st_accel_sensors[adata->index].pw.addr) &&
+			(st_accel_sensors[adata->index].odr.mask ==
+				st_accel_sensors[adata->index].pw.mask)) {
+			err = match_odr(&st_accel_sensors[adata->index],
+							adata->odr, odr_out);
+			if (err < 0)
+				goto set_enable_error;
+			tmp_value = odr_out->value;
+			found = 1;
+		}
+		err = acc_write_data_with_mask(indio_dev,
+				st_accel_sensors[adata->index].pw.addr,
+				st_accel_sensors[adata->index].pw.mask,
+				st_accel_sensors[adata->index].pw.num_bit,
+				tmp_value);
+		if (err < 0)
+			goto set_enable_error;
+		atomic_set(&adata->enabled, ST_ACCEL_ON);
+		if (found == 1)
+			adata->odr = odr_out->hz;
+		break;
+	case ST_ACCEL_OFF:
+		err = acc_write_data_with_mask(indio_dev,
+				st_accel_sensors[adata->index].pw.addr,
+				st_accel_sensors[adata->index].pw.mask,
+				st_accel_sensors[adata->index].pw.num_bit,
+				st_accel_sensors[adata->index].pw.value_off);
+		if (err < 0)
+			goto set_enable_error;
+		atomic_set(&adata->enabled, ST_ACCEL_OFF);
+		break;
+	default:
+		err = -1;
+		goto set_enable_error;
+	}
+
+set_enable_error:
+	kfree(odr_out);
+odr_out_allocate_memory_error:
+	return err;
+}
+
+static int set_fullscale(struct iio_dev *indio_dev,
+					struct fullscale_available *fs_avl)
+{
+	int err;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	err = acc_write_data_with_mask(indio_dev,
+				st_accel_sensors[adata->index].fs.addr,
+				st_accel_sensors[adata->index].fs.mask,
+				st_accel_sensors[adata->index].fs.num_bit,
+				fs_avl->value);
+	if (err < 0)
+		goto set_fullscale_error;
+	adata->fullscale = fs_avl->num;
+	adata->gain = fs_avl->gain;
+	return err;
+
+set_fullscale_error:
+	pr_err("%s: failed to set new fullscale.\n", adata->name);
+	return err;
+}
+
+static int acc_read_raw(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *ch, int *val,
+							int *val2, long mask)
+{
+	int err;
+	int data_tmp;
+	u8 outdata[ST_ACC_BYTE_FOR_CHANNEL];
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+			err = -EBUSY;
+			goto read_error;
+		} else {
+			err = atomic_read(&adata->enabled);
+			if (!err) {
+				err = -EHOSTDOWN;
+				goto read_error;
+			} else {
+				err = adata->read_multiple_byte(adata,
+					ch->address, ST_ACC_BYTE_FOR_CHANNEL,
+					outdata);
+				if (err < 0)
+					goto read_error;
+
+				if (ch->scan_type.endianness == IIO_LE)
+					*val = (s32)(s16)(cpu_to_le16(
+					le16_to_cpu(((__le16 *)outdata)[0])))
+					>> ch->scan_type.shift;
+				else
+					*val = (s32)(s16)(cpu_to_le16(
+					be16_to_cpu(((__be16 *)outdata)[0])))
+					>> ch->scan_type.shift;
+			}
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		data_tmp = UG_TO_MS2(adata->gain);
+		*val = 0;
+		*val2 = data_tmp;
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+
+read_error:
+	return err;
+}
+
+static int acc_check_irq(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	if (*adata->irq_data_ready <= 0)
+		err = -EINVAL;
+	else
+		err = 0;
+
+	return err;
+}
+
+static void register_channels(struct iio_dev *indio_dev)
+{
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	indio_dev->channels = st_accel_sensors[adata->index].ch;
+	indio_dev->num_channels = ST_ACC_NUMBER_ALL_CHANNELS;
+}
+
+static void set_sensor_parameters(struct iio_dev *indio_dev)
+{
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	adata->multiread_bit = st_accel_sensors[adata->index].multi_read_bit;
+}
+
+static int check_device_list(struct iio_dev *indio_dev, u8 wai)
+{
+	int i, sensor_length, found;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	found = 0;
+	sensor_length = ARRAY_SIZE(st_accel_sensors);
+	for (i = 0; i < sensor_length; i++) {
+		if (st_accel_sensors[i].wai == wai) {
+			found = 1;
+			break;
+		}
+	}
+	if (found != 1)
+		goto check_device_error;
+	adata->index = i;
+	return i;
+
+check_device_error:
+	pr_err("%s: device not supported -> wai (0x%x).\n", adata->name, wai);
+	return -ENODEV;
+}
+
+static int get_wai_device(struct iio_dev *indio_dev, u8 reg_addr, u8 *value)
+{
+	int ret;
+	u8 buf;
+	struct st_acc_data *adata;
+
+	adata = iio_priv(indio_dev);
+	buf = reg_addr;
+	ret = adata->read_byte(adata, reg_addr, value);
+	if (ret < 0)
+		goto read_byte_wai_error;
+
+	return 0;
+
+read_byte_wai_error:
+	pr_err("%s: failed to read wai register (0x%x).\n",
+							adata->name, reg_addr);
+	return -EIO;
+}
+
+static ssize_t sysfs_set_sampling_frequency(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	int err;
+	unsigned long freq;
+	struct odr_available *odr_out;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	err = kstrtoul(buf, 10, &freq);
+	if (err) {
+		pr_err("%s: input is not a number! (errn %d).\n",
+							adata->name, err);
+		goto sysfs_set_sampling_frequency_error;
+	}
+
+	mutex_lock(&indio_dev->mlock);
+	odr_out = kzalloc(sizeof(*odr_out), GFP_KERNEL);
+	if (odr_out == NULL)
+		goto odr_out_allocate_memory_error;
+
+	err = match_odr(&st_accel_sensors[adata->index], (int)freq, odr_out);
+	if (err < 0)
+		goto sysfs_set_sampling_frequency_error;
+	err = set_odr(indio_dev, odr_out);
+	if (err < 0) {
+		pr_err("%s: failed to set sampling frequency to %d.\n",
+							adata->name, (int)freq);
+		goto sysfs_set_sampling_frequency_error;
+	}
+	adata->odr = odr_out->hz;
+	kfree(odr_out);
+
+odr_out_allocate_memory_error:
+	mutex_unlock(&indio_dev->mlock);
+sysfs_set_sampling_frequency_error:
+	return size;
+}
+
+static ssize_t sysfs_get_sampling_frequency(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	ssize_t ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	ret = sprintf(buf, "%d\n", adata->odr);
+
+	return ret;
+}
+
+static ssize_t sysfs_set_enable(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	int err;
+	unsigned long en;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	err = kstrtoul(buf, 10, &en);
+	if (err) {
+		pr_err("%s: input is not a number! (errn %d).\n",
+							adata->name, err);
+		goto set_enable_error;
+	}
+
+	mutex_lock(&indio_dev->mlock);
+	err = set_enable(indio_dev, (int)en);
+	if (err < 0)
+		pr_err("%s: failed to set enable to %d.\n",
+							adata->name, (int)en);
+	mutex_unlock(&indio_dev->mlock);
+
+set_enable_error:
+	return size;
+}
+
+static ssize_t sysfs_get_enable(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	ssize_t ret;
+	int status;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	status = atomic_read(&adata->enabled);
+	ret = sprintf(buf, "%d\n", status);
+
+	return ret;
+}
+
+static ssize_t sysfs_get_fullscale(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	ssize_t ret;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	ret = sprintf(buf, "%d\n", adata->fullscale);
+
+	return ret;
+}
+
+static ssize_t sysfs_set_fullscale(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t size)
+{
+	int err;
+	unsigned long fs;
+	struct fullscale_available *fs_out;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	err = kstrtoul(buf, 10, &fs);
+	if (err) {
+		pr_err("%s: input is not a number! (errn %d).\n",
+							adata->name, err);
+		goto set_fullscale_error;
+	}
+
+	mutex_lock(&indio_dev->mlock);
+	fs_out = kzalloc(sizeof(*fs_out), GFP_KERNEL);
+	if (fs_out == NULL)
+		goto fs_out_allocate_memory_error;
+
+	err = match_fs(&st_accel_sensors[adata->index], fs, fs_out);
+	if (err < 0) {
+		pr_err("%s: input is not a valid fullscale! (errn %d).\n",
+							adata->name, err);
+		goto match_fullscale_error;
+	}
+	err = set_fullscale(indio_dev, fs_out);
+	if (err < 0) {
+		pr_err("%s: failed to set new fullscale. (errn %d).\n",
+							adata->name, err);
+	}
+
+match_fullscale_error:
+	kfree(fs_out);
+fs_out_allocate_memory_error:
+	mutex_unlock(&indio_dev->mlock);
+set_fullscale_error:
+	return size;
+}
+
+static ssize_t sysfs_fullscale_available(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int i, n, len;
+	char tmp[4];
+	char fullscale[30] = "";
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	mutex_lock(&indio_dev->mlock);
+	n = ARRAY_SIZE(st_accel_sensors[adata->index].fs.fs_avl);
+	for (i = 0; i < n; i++) {
+		if (st_accel_sensors[adata->index].fs.fs_avl[i].num != 0) {
+			len = strlen(&fullscale[0]);
+			sprintf(tmp, "%d ",
+			st_accel_sensors[adata->index].fs.fs_avl[i].num);
+			strcpy(&fullscale[len], tmp);
+		} else
+			break;
+	}
+	mutex_unlock(&indio_dev->mlock);
+
+	return sprintf(buf, "%s\n", fullscale);
+}
+
+static ssize_t sysfs_sampling_frequency_available(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	int i, n, len;
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	mutex_lock(&indio_dev->mlock);
+	n = ARRAY_SIZE(st_accel_sensors[adata->index].odr.odr_avl);
+	for (i = 0; i < n; i++) {
+		if (st_accel_sensors[adata->index].odr.odr_avl[i].hz != 0) {
+			len = strlen(buf);
+			sprintf(buf+len, "%d ",
+			st_accel_sensors[adata->index].odr.odr_avl[i].hz);
+		} else
+			break;
+	}
+	mutex_unlock(&indio_dev->mlock);
+
+	len = strlen(buf);
+	return sprintf(buf+len, "\n");
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO,
+				sysfs_sampling_frequency_available, NULL , 0);
+static IIO_DEVICE_ATTR(fullscale_available, S_IRUGO,
+				sysfs_fullscale_available, NULL , 0);
+static IIO_DEVICE_ATTR(fullscale, S_IWUSR | S_IRUGO, sysfs_get_fullscale,
+				sysfs_set_fullscale , 0);
+static IIO_DEVICE_ATTR(enable, S_IWUSR | S_IRUGO, sysfs_get_enable,
+						sysfs_set_enable , 0);
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO, sysfs_get_sampling_frequency,
+				sysfs_set_sampling_frequency);
+
+static struct attribute *acc_attributes[] = {
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	&iio_dev_attr_fullscale_available.dev_attr.attr,
+	&iio_dev_attr_fullscale.dev_attr.attr,
+	&iio_dev_attr_enable.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group acc_attribute_group = {
+	.attrs = acc_attributes,
+};
+
+static const struct iio_info acc_info = {
+	.driver_module = THIS_MODULE,
+	.attrs = &acc_attribute_group,
+	.read_raw = &acc_read_raw,
+};
+
+static int init_sensor(struct iio_dev *indio_dev)
+{
+	int err;
+	struct odr_available *odr_out;
+	struct fullscale_available *fs_out;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	odr_out = kzalloc(sizeof(*odr_out), GFP_KERNEL);
+	if (odr_out == NULL)
+		goto odr_out_allocate_memory_error;
+	fs_out = kzalloc(sizeof(*fs_out), GFP_KERNEL);
+	if (fs_out == NULL)
+		goto fs_out_allocate_memory_error;
+	set_enable(indio_dev, ST_ACCEL_OFF);
+	match_fs(&st_accel_sensors[adata->index], adata->fullscale, fs_out);
+	err = set_fullscale(indio_dev, fs_out);
+	if (err < 0)
+		goto init_error;
+	match_odr(&st_accel_sensors[adata->index], adata->odr, odr_out);
+	err = set_odr(indio_dev, odr_out);
+	if (err < 0)
+		goto init_error;
+	err = set_bdu(indio_dev,
+			&st_accel_sensors[adata->index].bdu, (u8)ST_ACCEL_ON);
+	if (err < 0)
+		goto init_error;
+	kfree(odr_out);
+	kfree(fs_out);
+
+	return 0;
+
+init_error:
+	kfree(fs_out);
+fs_out_allocate_memory_error:
+	kfree(odr_out);
+odr_out_allocate_memory_error:
+	return -EIO;
+}
+
+int acc_iio_probe(struct iio_dev *indio_dev)
+{
+	int err;
+	u8 wai;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	mutex_init(&adata->slock);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &acc_info;
+
+	err = get_wai_device(indio_dev, ST_DEFAULT_WAI_ADDRESS, &wai);
+	if (err < 0)
+		goto get_wai_error;
+	err = check_device_list(indio_dev, wai);
+	if (err < 0)
+		goto check_device_list_error;
+	set_sensor_parameters(indio_dev);
+	register_channels(indio_dev);
+	err = init_sensor(indio_dev);
+	if (err < 0)
+		goto init_sensor_error;
+
+	err = acc_check_irq(indio_dev);
+	if (err < 0)
+		goto gpio_check_error;
+	err = acc_allocate_ring(indio_dev);
+	if (err < 0)
+		goto acc_allocate_ring_error;
+
+	err = acc_probe_trigger(indio_dev);
+	if (err < 0)
+		goto acc_probe_trigger_error;
+
+	err = iio_device_register(indio_dev);
+	if (err)
+		goto iio_device_register_error;
+
+	pr_info("%s: probe end correctly.\n", adata->name);
+
+	return err;
+
+iio_device_register_error:
+	acc_remove_trigger(indio_dev);
+acc_probe_trigger_error:
+	acc_deallocate_ring(indio_dev);
+acc_allocate_ring_error:
+gpio_check_error:
+init_sensor_error:
+check_device_list_error:
+get_wai_error:
+	return err;
+}
+EXPORT_SYMBOL(acc_iio_probe);
+
+void acc_iio_remove(struct iio_dev *indio_dev)
+{
+	acc_remove_trigger(indio_dev);
+	acc_deallocate_ring(indio_dev);
+	iio_device_unregister(indio_dev);
+	iio_device_free(indio_dev);
+}
+EXPORT_SYMBOL(acc_iio_remove);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/ST_accel_i2c.c b/drivers/iio/accel/ST_accel_i2c.c
new file mode 100644
index 0000000..55bca3a
--- /dev/null
+++ b/drivers/iio/accel/ST_accel_i2c.c
@@ -0,0 +1,165 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/ST_accel.h>
+#include <linux/platform_data/ST_accel_pdata.h>
+
+
+#define ST_ACCEL_I2C_MULTIREAD			0x80
+
+static inline s32 acc_i2c_read_byte(struct st_acc_data *adata, u8 reg_addr,
+								u8 *res_byte)
+{
+	s32 err;
+
+	err = i2c_smbus_read_byte_data(to_i2c_client(adata->dev), reg_addr);
+	if (err < 0)
+		goto acc_i2c_read_byte_error;
+	*res_byte = err & 0xff;
+	return err;
+
+acc_i2c_read_byte_error:
+	return -EIO;
+}
+
+static inline s32 acc_i2c_read_multiple_byte(struct st_acc_data *adata,
+						u8 reg_addr, int len, u8 *data)
+{
+	s32 err;
+
+	if (adata->multiread_bit == true)
+		reg_addr |= ST_ACCEL_I2C_MULTIREAD;
+
+	err = i2c_smbus_read_i2c_block_data(to_i2c_client(adata->dev),
+							reg_addr, len, data);
+	if (err < 0)
+		goto acc_i2c_read_multiple_byte_error;
+
+	return err;
+
+acc_i2c_read_multiple_byte_error:
+	return -EIO;
+}
+
+static inline s32 acc_i2c_write_byte(struct st_acc_data *adata,
+							u8 reg_addr, u8 data)
+{
+	return i2c_smbus_write_byte_data(to_i2c_client(adata->dev),
+								reg_addr, data);
+}
+
+void set_platform_data(struct i2c_client *client, struct st_acc_data *adata)
+{
+	if (client->dev.platform_data == NULL) {
+		adata->fullscale = st_acc_default_pdata.fullscale;
+		adata->odr = st_acc_default_pdata.sampling_frequency;
+	} else {
+		adata->fullscale = ((struct st_acc_platform_data *)
+			(client->dev.platform_data))->fullscale;
+		adata->odr = ((struct st_acc_platform_data *)
+			(client->dev.platform_data))->sampling_frequency;
+	}
+}
+
+void set_trigger_parent(struct iio_dev *indio_dev)
+{
+	struct i2c_client *client;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	client = to_i2c_client(adata->dev);
+	adata->trig->dev.parent = &client->dev;
+}
+
+static int __devinit acc_i2c_probe(struct i2c_client *client,
+				const struct i2c_device_id *id)
+{
+	struct iio_dev *indio_dev;
+	struct st_acc_data *adata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*adata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	adata = iio_priv(indio_dev);
+	adata->dev = &client->dev;
+	i2c_set_clientdata(client, indio_dev);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = client->name;
+
+	adata->read_byte = acc_i2c_read_byte;
+	adata->write_byte = acc_i2c_write_byte;
+	adata->read_multiple_byte = acc_i2c_read_multiple_byte;
+	adata->set_trigger_parent = set_trigger_parent;
+	adata->name = client->name;
+	adata->irq_data_ready = &client->irq;
+
+	set_platform_data(client, adata);
+	err = acc_iio_probe(indio_dev);
+	if (err < 0)
+		goto acc_iio_default_error;
+
+	return 0;
+
+acc_iio_default_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int __devexit acc_i2c_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	acc_iio_remove(indio_dev);
+	return 0;
+}
+
+static const struct i2c_device_id acc_id_table[] = {
+	{ LSM303DLH_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303DLHC_ACC_IIO_DEV_NAME, 0 },
+	{ LIS3DH_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330D_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330DL_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330DLC_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303D_ACC_IIO_DEV_NAME, 0 },
+	{ LSM9DS0_ACC_IIO_DEV_NAME, 0 },
+	{ LIS331DLH_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303DL_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303DLM_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330_ACC_IIO_DEV_NAME, 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(i2c, acc_id_table);
+
+static struct i2c_driver acc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "ST-accel-i2c",
+	},
+	.probe = acc_i2c_probe,
+	.remove = __devexit_p(acc_i2c_remove),
+	.id_table = acc_id_table,
+};
+module_i2c_driver(acc_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers i2c driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/ST_accel_spi.c b/drivers/iio/accel/ST_accel_spi.c
new file mode 100644
index 0000000..c918715
--- /dev/null
+++ b/drivers/iio/accel/ST_accel_spi.c
@@ -0,0 +1,236 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/ST_accel.h>
+#include <linux/platform_data/ST_accel_pdata.h>
+
+
+#define ACC_SPI_READ		0x80;
+#define ACC_SPI_MULTIREAD	0xc0
+
+static inline s32 acc_spi_read_byte(struct st_acc_data *adata, u8 reg_addr,
+								u8 *res_byte)
+{
+	struct spi_message msg;
+	int err;
+	u8 tx;
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &tx,
+			.bits_per_word = 8,
+			.len = 1,
+			.cs_change = 0,
+			.delay_usecs = 10,
+		},
+		{
+			.rx_buf = res_byte,
+			.bits_per_word = 8,
+			.len = 1,
+			.cs_change = 0,
+			.delay_usecs = 10,
+		}
+	};
+
+	mutex_lock(&adata->slock);
+	tx = reg_addr | ACC_SPI_READ;
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	err = spi_sync(to_spi_device(adata->dev), &msg);
+	mutex_unlock(&adata->slock);
+	if (err)
+		goto acc_spi_read_byte_error;
+
+
+	return err;
+
+acc_spi_read_byte_error:
+	return -EIO;
+}
+
+static inline s32 acc_spi_read_multiple_byte(struct st_acc_data *adata,
+						u8 reg_addr, int len, u8 *data)
+{
+	struct spi_message msg;
+	int err;
+	u8 tx;
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &tx,
+			.bits_per_word = 8,
+			.len = 1,
+			.cs_change = 0,
+			.delay_usecs = 10,
+		},
+		{
+			.rx_buf = data,
+			.bits_per_word = 8,
+			.len = len,
+			.cs_change = 0,
+			.delay_usecs = 10,
+		}
+	};
+
+	mutex_lock(&adata->slock);
+	if (adata->multiread_bit == true)
+		tx = reg_addr | ACC_SPI_MULTIREAD;
+	else
+		tx = reg_addr | ACC_SPI_READ;
+
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	spi_message_add_tail(&xfers[1], &msg);
+	err = spi_sync(to_spi_device(adata->dev), &msg);
+	mutex_unlock(&adata->slock);
+	if (err)
+		goto acc_spi_read_multiple_byte_error;
+	return len;
+
+acc_spi_read_multiple_byte_error:
+	return -EIO;
+}
+
+static inline s32 acc_spi_write_byte(struct st_acc_data *adata,
+							u8 reg_addr, u8 data)
+{
+	struct spi_message msg;
+	int err;
+	u8 tx[2];
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = tx,
+			.bits_per_word = 8,
+			.len = 2,
+			.cs_change = 0,
+			.delay_usecs = 10,
+		}
+	};
+
+	mutex_lock(&adata->slock);
+	tx[0] = reg_addr;
+	tx[1] = data;
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfers[0], &msg);
+	err = spi_sync(to_spi_device(adata->dev), &msg);
+	mutex_unlock(&adata->slock);
+
+	return err;
+}
+
+void set_platform_data(struct spi_device *client, struct st_acc_data *adata)
+{
+	if (client->dev.platform_data == NULL) {
+		adata->fullscale = st_acc_default_pdata.fullscale;
+		adata->odr = st_acc_default_pdata.sampling_frequency;
+	} else {
+		adata->fullscale = ((struct st_acc_platform_data *)
+			(client->dev.platform_data))->fullscale;
+		adata->odr = ((struct st_acc_platform_data *)
+			(client->dev.platform_data))->sampling_frequency;
+	}
+}
+
+void set_trigger_parent(struct iio_dev *indio_dev)
+{
+	struct spi_device *client;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	client = to_spi_device(adata->dev);
+	adata->trig->dev.parent = &client->dev;
+}
+
+static int __devinit acc_spi_probe(struct spi_device *client)
+{
+	struct iio_dev *indio_dev;
+	struct st_acc_data *adata;
+	int err;
+
+	indio_dev = iio_device_alloc(sizeof(*adata));
+	if (indio_dev == NULL) {
+		err = -ENOMEM;
+		goto iio_device_alloc_error;
+	}
+
+	adata = iio_priv(indio_dev);
+	adata->dev = &client->dev;
+	spi_set_drvdata(client, indio_dev);
+
+	indio_dev->dev.parent = &client->dev;
+	indio_dev->name = client->modalias;
+
+	adata->read_byte = acc_spi_read_byte;
+	adata->write_byte = acc_spi_write_byte;
+	adata->read_multiple_byte = acc_spi_read_multiple_byte;
+	adata->set_trigger_parent = set_trigger_parent;
+	adata->name = client->modalias;
+	adata->irq_data_ready = &client->irq;
+
+	set_platform_data(client, adata);
+	err = acc_iio_probe(indio_dev);
+	if (err < 0)
+		goto acc_iio_default_error;
+
+	return 0;
+
+acc_iio_default_error:
+	iio_device_free(indio_dev);
+iio_device_alloc_error:
+	return err;
+}
+
+static int __devexit acc_spi_remove(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev = spi_get_drvdata(spi);
+
+	acc_iio_remove(indio_dev);
+	return 0;
+}
+
+static const struct spi_device_id acc_id_table[] = {
+	{ LSM303DLH_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303DLHC_ACC_IIO_DEV_NAME, 0 },
+	{ LIS3DH_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330D_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330DL_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330DLC_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303D_ACC_IIO_DEV_NAME, 0 },
+	{ LSM9DS0_ACC_IIO_DEV_NAME, 0 },
+	{ LIS331DLH_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303DL_ACC_IIO_DEV_NAME, 0 },
+	{ LSM303DLM_ACC_IIO_DEV_NAME, 0 },
+	{ LSM330_ACC_IIO_DEV_NAME, 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(spi, acc_id_table);
+
+static struct spi_driver acc_driver = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "ST-accel-spi",
+	},
+	.probe = acc_spi_probe,
+	.remove = __devexit_p(acc_spi_remove),
+	.id_table = acc_id_table,
+};
+module_spi_driver(acc_driver);
+
+MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
+MODULE_DESCRIPTION("STMicroelectronics accelerometers spi driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/accel/ST_accel_trigger.c
b/drivers/iio/accel/ST_accel_trigger.c
new file mode 100644
index 0000000..4375c31
--- /dev/null
+++ b/drivers/iio/accel/ST_accel_trigger.c
@@ -0,0 +1,87 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/interrupt.h>
+#include <linux/i2c.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+
+#include <linux/iio/accel/ST_accel.h>
+
+
+static int iio_trig_acc_set_state(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *indio_dev = trig->private_data;
+	return acc_set_dataready_irq(indio_dev, state);
+}
+
+static const struct iio_trigger_ops iio_acc_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &iio_trig_acc_set_state,
+};
+
+int acc_probe_trigger(struct iio_dev *indio_dev)
+{
+	int err;
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	adata->trig = iio_trigger_alloc("%s-trigger", indio_dev->name);
+	if (adata->trig == NULL) {
+		err = -ENOMEM;
+		pr_err("%s: failed to allocate iio trigger.\n", adata->name);
+		goto iio_trigger_alloc_error;
+	}
+
+	err = request_threaded_irq(*adata->irq_data_ready,
+			iio_trigger_generic_data_rdy_poll,
+			NULL,
+			IRQF_TRIGGER_RISING,
+			adata->trig->name,
+			adata->trig);
+	if (err) {
+		pr_err("%s: failed to request threaded irq [%d].\n",
+					adata->name, *adata->irq_data_ready);
+		goto request_irq_error;
+	}
+	adata->trig->private_data = indio_dev;
+	adata->trig->ops = &iio_acc_trigger_ops;
+
+	adata->set_trigger_parent(indio_dev);
+
+	err = iio_trigger_register(adata->trig);
+	if (err < 0) {
+		pr_err("%s: failed to register iio trigger.\n", adata->name);
+		goto iio_trigger_register_error;
+	}
+	indio_dev->trig = adata->trig;
+	pr_info("%s: using [%s] trigger.\n", adata->name, adata->trig->name);
+	return 0;
+
+iio_trigger_register_error:
+	free_irq(*adata->irq_data_ready, adata->trig);
+request_irq_error:
+	iio_trigger_free(adata->trig);
+iio_trigger_alloc_error:
+	return err;
+}
+EXPORT_SYMBOL(acc_probe_trigger);
+
+void acc_remove_trigger(struct iio_dev *indio_dev)
+{
+	struct st_acc_data *adata = iio_priv(indio_dev);
+
+	iio_trigger_unregister(adata->trig);
+	free_irq(*adata->irq_data_ready, adata->trig);
+	iio_trigger_free(adata->trig);
+}
+EXPORT_SYMBOL(acc_remove_trigger);
diff --git a/include/linux/iio/accel/ST_accel.h
b/include/linux/iio/accel/ST_accel.h
new file mode 100644
index 0000000..20d1973
--- /dev/null
+++ b/include/linux/iio/accel/ST_accel.h
@@ -0,0 +1,120 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ * v. 1.0.0
+ * Licensed under the GPL-2.
+ */
+
+/*
+ * Supported sensors:
+ * LSM303DLH
+ * LSM303DLHC
+ * LIS3DH
+ * LSM330D
+ * LSM330DL
+ * LSM330DLC
+ * LSM303D
+ * LSM9DS0
+ * LIS331DLH
+ * LSM303DL
+ * LSM303DLM
+ * LSM330
+ */
+
+
+#ifndef ST_ACCELEROMETERS_IIO_ACC_H
+#define ST_ACCELEROMETERS_IIO_ACC_H
+
+#define LSM303DLH_ACC_IIO_DEV_NAME	"lsm303dlh_acc_iio"
+#define LSM303DLHC_ACC_IIO_DEV_NAME	"lsm303dlhc_acc_iio"
+#define LIS3DH_ACC_IIO_DEV_NAME		"lis3dh_acc_iio"
+#define LSM330D_ACC_IIO_DEV_NAME	"lsm330d_acc_iio"
+#define LSM330DL_ACC_IIO_DEV_NAME	"lsm330dl_acc_iio"
+#define LSM330DLC_ACC_IIO_DEV_NAME	"lsm330dlc_acc_iio"
+#define LSM303D_ACC_IIO_DEV_NAME	"lsm303d_iio"
+#define LSM9DS0_ACC_IIO_DEV_NAME	"lsm9ds0_iio"
+#define LIS331DLH_ACC_IIO_DEV_NAME	"lis331dlh_acc_iio"
+#define LSM303DL_ACC_IIO_DEV_NAME	"lsm303dl_acc_iio"
+#define LSM303DLM_ACC_IIO_DEV_NAME	"lsm303dlm_acc_iio"
+#define LSM330_ACC_IIO_DEV_NAME		"lsm330_acc_iio"
+
+#define ST_ACC_NUMBER_ALL_CHANNELS	4
+#define ST_ACC_BYTE_FOR_CHANNEL		2
+#define ST_ACC_SCAN_X			0
+#define ST_ACC_SCAN_Y			1
+#define ST_ACC_SCAN_Z			2
+
+/**
+ * struct st_acc_data - ST accel device status
+ * @dev: Pointer to instance of struct device (I2C or SPI).
+ * @name: Name of the sensor in use.
+ * @enabled: Status of the sensor (0->off, 1->on).
+ * @index: Number used to point the sensor being used in the
+ *	st_accel_sensors struct.
+ * @fullscale: Maximum range of measure by the sensor.
+ * @gain: Sensitivity of the sensor [ug/LSB].
+ * @odr: Output data rate of the sensor.
+ * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
+ * @read_byte: Function used to read one byte.
+ * @write_byte: Function used to write one byte.
+ * @read_multiple_byte: Function used to read multiple byte.
+ * @set_trigger_parent: Function used to set the trigger parent.
+ * @trig: The trigger in use by the core driver.
+ * @irq_data_ready: IRQ number for data ready on INT1 pin.
+ * @slock: mutex for read and write operation.
+ */
+
+struct st_acc_data {
+	struct device *dev;
+	char *name;
+	atomic_t enabled;
+	short index;
+
+	int fullscale;
+	int gain;
+	int odr;
+
+	bool multiread_bit;
+	int (*read_byte) (struct st_acc_data *adata, u8 reg_addr, u8 *res_byte);
+	int (*write_byte) (struct st_acc_data *adata, u8 reg_addr, u8 data);
+	int (*read_multiple_byte) (struct st_acc_data *adata, u8 reg_addr,
+							int len, u8 *data);
+	void (*set_trigger_parent) (struct iio_dev *indio_dev);
+
+	struct iio_trigger *trig;
+	int *irq_data_ready;
+	struct mutex slock;
+};
+
+int acc_iio_probe(struct iio_dev *indio_dev);
+void acc_iio_remove(struct iio_dev *indio_dev);
+int acc_set_dataready_irq(struct iio_dev *indio_dev, bool enable);
+
+#ifdef CONFIG_IIO_BUFFER
+int acc_probe_trigger(struct iio_dev *indio_dev);
+void acc_remove_trigger(struct iio_dev *indio_dev);
+int acc_allocate_ring(struct iio_dev *indio_dev);
+void acc_deallocate_ring(struct iio_dev *indio_dev);
+#else /* CONFIG_IIO_BUFFER */
+static inline int acc_probe_trigger(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void acc_remove_trigger(struct iio_dev *indio_dev)
+{
+	return;
+}
+static inline int acc_allocate_ring(struct iio_dev *indio_dev)
+{
+	return 0;
+}
+static inline void acc_deallocate_ring(struct iio_dev *indio_dev)
+{
+	return;
+}
+#endif /* CONFIG_IIO_BUFFER */
+
+#endif /* ST_ACCELEROMETERS_IIO_ACC_H */
diff --git a/include/linux/platform_data/ST_accel_pdata.h
b/include/linux/platform_data/ST_accel_pdata.h
new file mode 100644
index 0000000..51f7b2c
--- /dev/null
+++ b/include/linux/platform_data/ST_accel_pdata.h
@@ -0,0 +1,34 @@
+/*
+ * STMicroelectronics accelerometers driver
+ *
+ * Copyright 2012 STMicroelectronics Inc.
+ *
+ * Denis Ciocca <denis.ciocca@st.com>
+ *
+ * Licensed under the GPL-2.
+ */
+
+
+#ifndef ST_ACCELEROMETERS_PDATA_ACC_H
+#define ST_ACCELEROMETERS_PDATA_ACC_H
+
+#define DEFAULT_ACCEL_ODR_AVL_100HZ		100
+#define DEFAULT_ACCEL_FS_AVL_2G			2
+
+/**
+ * struct st_acc_platform_data - ST accel device platform data
+ * @fullscale: Value of fullscale used for the sensor.
+ * @sampling_frequency: Value of sampling frequency used for the sensor.
+ */
+
+struct st_acc_platform_data {
+	int fullscale;
+	int sampling_frequency;
+};
+
+static const struct st_acc_platform_data st_acc_default_pdata = {
+	.fullscale = DEFAULT_ACCEL_FS_AVL_2G,
+	.sampling_frequency = DEFAULT_ACCEL_ODR_AVL_100HZ,
+};
+
+#endif /* ST_ACCELEROMETERS_PDATA_ACC_H */
-- 
1.7.9.5
