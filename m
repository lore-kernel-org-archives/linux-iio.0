Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:54550 "EHLO mail.aswsp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932657AbcHXOz5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 Aug 2016 10:55:57 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Alexander Kurz <akurz@blala.de>, Tejun Heo <tj@kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        "Ludovic Tancerel" <ludovic.tancerel@maplehightech.com>,
        Vlad Dogaru <vlad.dogaru@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Marek Vasut" <marex@denx.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 3/3] iio:pressure: initial zpa2326 barometer support
Date: Wed, 24 Aug 2016 16:58:48 +0200
Message-ID: <a16becf5ac0ac811a993a26de32a0d41f3eb4ffa.1472050374.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1472050374.git.gregor.boirie@parrot.com>
References: <cover.1472050374.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Introduce driver for Murata ZPA2326 pressure and temperature sensor:
http://www.murata.com/en-us/products/productdetail?partno=ZPA2326-0311A-R

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 .../devicetree/bindings/iio/pressure/zpa2326.txt   |   23 +
 drivers/iio/pressure/Kconfig                       |   33 +
 drivers/iio/pressure/Makefile                      |    3 +
 drivers/iio/pressure/zpa2326.c                     | 1766 ++++++++++++++++++++
 drivers/iio/pressure/zpa2326.h                     |   76 +
 drivers/iio/pressure/zpa2326_i2c.c                 |  188 +++
 drivers/iio/pressure/zpa2326_spi.c                 |  184 ++
 7 files changed, 2273 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
 create mode 100644 drivers/iio/pressure/zpa2326.c
 create mode 100644 drivers/iio/pressure/zpa2326.h
 create mode 100644 drivers/iio/pressure/zpa2326_i2c.c
 create mode 100644 drivers/iio/pressure/zpa2326_spi.c

diff --git a/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt b/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
new file mode 100644
index 0000000..4b92906
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/zpa2326.txt
@@ -0,0 +1,23 @@
+Murata ZPA2326 pressure sensor
+
+Pressure sensor from Murata with SPI and I2C bus interfaces.
+
+Required properties:
+- compatible: "murata,zpa2326"
+- reg: the I2C address or SPI chip select the device will respond to
+
+Optional properties:
+- interrupt-parent: should be the phandle for the interrupt controller
+- interrupts: interrupt mapping for IRQ
+- vdd-supply: an optional regulator that needs to be on to provide VDD
+  power to the sensor
+
+Example:
+
+zpa2326@5c {
+	compatible = "murata,zpa2326";
+	reg = <0x5c>;
+	interrupt-parent = <&gpio>;
+	interrupts = <12>;
+	vdd-supply = <&ldo_1v8_gnss>;
+};
diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index d130cdc..a3db56f 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -187,4 +187,37 @@ config HP206C
 	  This driver can also be built as a module. If so, the module will
 	  be called hp206c.
 
+config ZPA2326
+	tristate "Murata ZPA2326 pressure sensor driver"
+	depends on I2C || SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say Y here to build support for the Murata ZPA2326 pressure and
+	  temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called zpa2326.
+
+config ZPA2326_I2C
+	tristate "support I2C bus connection"
+	depends on I2C && ZPA2326
+	help
+	  Say Y here to build I2C bus support for the Murata ZPA2326 pressure
+	  and temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called zpa2326_i2c.
+
+config ZPA2326_SPI
+	tristate "support SPI bus connection"
+	depends on SPI && ZPA2326
+	help
+	  Say Y here to build SPI bus support for the Murata ZPA2326 pressure
+	  and temperature sensor.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called zpa2326_spi.
+
+
 endmenu
diff --git a/drivers/iio/pressure/Makefile b/drivers/iio/pressure/Makefile
index 7f395be..fff7718 100644
--- a/drivers/iio/pressure/Makefile
+++ b/drivers/iio/pressure/Makefile
@@ -22,6 +22,9 @@ st_pressure-y := st_pressure_core.o
 st_pressure-$(CONFIG_IIO_BUFFER) += st_pressure_buffer.o
 obj-$(CONFIG_T5403) += t5403.o
 obj-$(CONFIG_HP206C) += hp206c.o
+obj-$(CONFIG_ZPA2326) += zpa2326.o
+obj-$(CONFIG_ZPA2326_I2C) += zpa2326_i2c.o
+obj-$(CONFIG_ZPA2326_SPI) += zpa2326_spi.o
 
 obj-$(CONFIG_IIO_ST_PRESS_I2C) += st_pressure_i2c.o
 obj-$(CONFIG_IIO_ST_PRESS_SPI) += st_pressure_spi.o
diff --git a/drivers/iio/pressure/zpa2326.c b/drivers/iio/pressure/zpa2326.c
new file mode 100644
index 0000000..7b76c34
--- /dev/null
+++ b/drivers/iio/pressure/zpa2326.c
@@ -0,0 +1,1766 @@
+/*
+ * Murata ZPA2326 pressure and temperature sensor IIO driver
+ *
+ * Copyright (c) 2016 Parrot S.A.
+ *
+ * Author: Gregor Boirie <gregor.boirie@parrot.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ *
+ * README:
+ * ------
+ *
+ * This driver supports the following IIO modes: INDIO_DIRECT_MODE,
+ * INDIO_BUFFER_SOFTWARE and INDIO_BUFFER_TRIGGERED.
+ * A hardware trigger is also implemented to dispatch registered IIO trigger
+ * consumers upon "sample ready" interrupts.
+ *
+ * ZPA2326 hardware supports 2 sampling mode: one shot and continuous.
+ *
+ * A complete one shot sampling cycle gets device out of low power mode,
+ * performs pressure and temperature measurements, then automatically switch
+ * back to low power mode. It is meant for on demand sampling with optimal power
+ * saving at the cost of lower sampling rate and higher software overhead.
+ * This is a natural candidate for IIO read_raw hook implementation
+ * (INDIO_DIRECT_MODE). It is also used for triggered buffering support to
+ * ensure explicit synchronization with external trigger events
+ * (INDIO_BUFFER_TRIGGERED).
+ *
+ * The continuous mode works according to a periodic hardware measurement
+ * process continuously pushing samples into an internal hardware fifo (for
+ * pressure samples only). Measurement cycle completion may be signaled by a
+ * "sample ready" interrupt.
+ * Typical software sequence of operations :
+ * - get device out of low power mode,
+ * - setup hardware sampling period,
+ * - at end of period, upon data ready interrupt: pop pressure samples out of
+ *   hardware fifo and fetch temperature sample
+ * - when no longer needed, stop sampling process by putting device into
+ *   low power mode.
+ * This mode is used to implement INDIO_BUFFER_SOFTWARE mode if device tree
+ * declares a valid interrupt line. It is not compatible with triggers driven
+ * acquisition.
+ *
+ * Note that hardware sampling frequency is taken into account for
+ * INDIO_BUFFER_SOFTWARE mode only as the highest sampling rate seems to be the
+ * most energy efficient.
+ *
+ * TODO:
+ *   - preset pressure threshold crossing / IIO events
+ *   - differential pressure sampling
+ *   - hardware samples averaging
+ */
+
+/* Comment out to enable really verbose logging. */
+/*#define DEBUG*/
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/regulator/consumer.h>
+#include <linux/pm_runtime.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+#include "zpa2326.h"
+
+/* 200 ms should be enought for the longest conversion time in one-shot mode. */
+#define ZPA_CONVERSION_TIMEOUT (HZ / 5)
+
+/* Registers map. */
+#define ZPA_REF_P_XL_REG                     ((u8)0x8)
+#define ZPA_REF_P_L_REG                      ((u8)0x9)
+#define ZPA_REF_P_H_REG                      ((u8)0xa)
+#define ZPA_RES_CONF_REG                     ((u8)0x10)
+#define ZPA_CTRL_REG0_REG                    ((u8)0x20)
+#	define ZPA_CTRL_REG0_ONE_SHOT        BIT(0)
+#	define ZPA_CTRL_REG0_ENABLE          BIT(1)
+#define ZPA_CTRL_REG1_REG                    ((u8)0x21)
+#	define ZPA_CTRL_REG1_MASK_DATA_READY ((u8)BIT(2))
+#define ZPA_CTRL_REG2_REG                    ((u8)0x22)
+#	define ZPA_CTRL_REG2_SWRESET         BIT(2)
+#define ZPA_CTRL_REG3_REG                    ((u8)0x23)
+#	define ZPA_CTRL_REG3_ODR_SHIFT       (4)
+#	define ZPA_CTRL_REG3_ENABLE_MEAS     BIT(7)
+#define ZPA_INT_SOURCE_REG                   ((u8)0x24)
+#	define ZPA_INT_SOURCE_DATA_READY     BIT(2)
+#define ZPA_THS_P_LOW_REG                    ((u8)0x25)
+#define ZPA_THS_P_HIGH_REG                   ((u8)0x26)
+#define ZPA_STATUS_REG                       ((u8)0x27)
+#	define ZPA_STATUS_P_DA               BIT(1)
+#	define ZPA_STATUS_FIFO_E             BIT(2)
+#	define ZPA_STATUS_P_OR               BIT(5)
+#define ZPA_PRESS_OUT_XL_REG                 ((u8)0x28)
+#define ZPA_PRESS_OUT_L_REG                  ((u8)0x29)
+#define ZPA_PRESS_OUT_H_REG                  ((u8)0x2a)
+#define ZPA_TEMP_OUT_L_REG                   ((u8)0x2b)
+#define ZPA_TEMP_OUT_H_REG                   ((u8)0x2c)
+
+/* Hardware sampling frequency descriptor. */
+struct zpa_frequency {
+	/* Stringified frequency in Hertz. */
+	const char *hz;
+	/* Output Data Rate word as expected by ZPA_CTRL_REG3_REG. */
+	u16         odr;
+};
+
+/*
+ * Keep these in strict ascending order: last array entry is expected to
+ * correspond to the highest sampling frequency.
+ */
+static const struct zpa_frequency zpa_sampling_frequencies[] = {
+	{ .hz = "1",  .odr = 1 << ZPA_CTRL_REG3_ODR_SHIFT },
+	{ .hz = "5",  .odr = 5 << ZPA_CTRL_REG3_ODR_SHIFT },
+	{ .hz = "11", .odr = 6 << ZPA_CTRL_REG3_ODR_SHIFT },
+	{ .hz = "23", .odr = 7 << ZPA_CTRL_REG3_ODR_SHIFT },
+};
+
+/* Return the highest hardware sampling frequency available. */
+static const struct zpa_frequency *zpa_highest_frequency(void)
+{
+	return &zpa_sampling_frequencies[ARRAY_SIZE(zpa_sampling_frequencies) -
+					 1];
+}
+
+/* Per-device internal private state. */
+struct zpa_private {
+	/* Buffered samples ready datum. */
+	s64                         timestamp;
+	/*
+	 * Underlying I2C / SPI bus adapter used to abstract slave register
+	 * accesses.
+	 */
+	const struct zpa_bus       *bus;
+	/*
+	 * Interrupt handler stores sampling operation status here for user
+	 * context usage.
+	 */
+	int                         result;
+	/*
+	 * Interrupt handler uses this to wake user context up at sampling
+	 * operation completion.
+	 */
+	struct completion           data_ready;
+	/*
+	 * Optional hardware / interrupt driven trigger used to notify external
+	 * devices a new sample is ready.
+	 */
+	struct iio_trigger         *trigger;
+	/* Flag indicating whether or not device has just been powered on. */
+	bool                        waken;
+	/*
+	 * Optional interrupt line: negative if not declared into DT, in
+	 * which case user context keeps polling status register to detect
+	 * sampling completion.
+	 */
+	int                         irq;
+	/* Current hardware sampling frequency. */
+	const struct zpa_frequency *frequency;
+	/* Optional power supply. */
+	struct regulator           *vdd;
+};
+
+/******************************************************************************
+ * Various helpers
+ ******************************************************************************/
+
+#define zpa_err(_idev, _format, _arg...) \
+	dev_err(zpa_iio2slave(_idev), _format, ##_arg)
+
+#define zpa_warn(_idev, _format, _arg...) \
+	dev_warn(zpa_iio2slave(_idev), _format, ##_arg)
+
+#define zpa_dbg(_idev, _format, _arg...) \
+	dev_dbg(zpa_iio2slave(_idev), _format, ##_arg)
+
+static struct zpa_private *zpa_iio2priv(const struct iio_dev *indio_dev)
+{
+	return (struct zpa_private *)iio_priv(indio_dev);
+}
+
+/*
+ * Fetch single byte from slave register.
+ * indio_dev: IIO device the slave is attached to.
+ * address:   address of register to read from.
+ *
+ * Returns the fetched byte when successful, a negative error code otherwise.
+ */
+static int zpa_read_byte(const struct iio_dev *indio_dev, u8 address)
+{
+	return zpa_iio2priv(indio_dev)->bus->zpa_read_byte(indio_dev, address);
+}
+
+/*
+ * Store single byte to slave register.
+ * indio_dev: IIO device the slave is attached to
+ * address:   address of register to write to
+ *
+ * Returns: zero when successful, a negative error code otherwise.
+ */
+static int zpa_write_byte(const struct iio_dev *indio_dev, u8 address, u8 value)
+{
+	return zpa_iio2priv(indio_dev)->bus->zpa_write_byte(indio_dev, address,
+							    value);
+}
+
+/*
+ * Fetch multiple bytes from a block of contiguous slave registers.
+ * indio_dev: IIO device the slave is attached to.
+ * address:   start address of contiguous registers block to read from.
+ * length:    number of bytes to fetch.
+ * value:     location to store fetched data into.
+ *
+ * Returns: zero when successful, a negative error code otherwise.
+ */
+static int zpa_read_block(const struct iio_dev *indio_dev,
+			  u8                    address,
+			  u8                    length,
+			  u8                   *value)
+{
+	return zpa_iio2priv(indio_dev)->bus->zpa_read_block(indio_dev, address,
+							    length, value);
+}
+
+/******************************************************************************
+ * Device operations handling
+ ******************************************************************************/
+
+/*
+ * Enable device, i.e. get out of low power mode.
+ *
+ * Required to access complete register space and to perform any sampling
+ * or control operations.
+ */
+static int zpa_enable_device(const struct iio_dev *indio_dev)
+{
+	int err = zpa_write_byte(indio_dev, ZPA_CTRL_REG0_REG,
+				 ZPA_CTRL_REG0_ENABLE);
+	if (err) {
+		zpa_err(indio_dev, "failed to enable device (%d)", err);
+		return err;
+	}
+
+	zpa_dbg(indio_dev, "enabled");
+	return 0;
+}
+
+/*
+ * Disable device, i.e. switch to low power mode.
+ *
+ * Only ZPA_DEVICE_ID_REG and ZPA_CTRL_REG0_REG registers may be accessed once
+ * device is in the disabled state.
+ */
+static int zpa_disable_device(const struct iio_dev *indio_dev)
+{
+	int err = zpa_write_byte(indio_dev, ZPA_CTRL_REG0_REG, 0);
+
+	if (err) {
+		zpa_err(indio_dev, "failed to disable device (%d)", err);
+		return err;
+	}
+
+	zpa_dbg(indio_dev, "disabled");
+	return 0;
+}
+
+/*
+ * Reset device to default hardware state.
+ *
+ * Disable sampling and empty hardware fifo.
+ * Device must be enabled before reset, i.e. not in low power mode.
+ */
+static int zpa_reset_device(const struct iio_dev *indio_dev)
+{
+	int err = zpa_write_byte(indio_dev, ZPA_CTRL_REG2_REG,
+				 ZPA_CTRL_REG2_SWRESET);
+	if (err) {
+		zpa_err(indio_dev, "failed to reset device (%d)", err);
+		return err;
+	}
+
+	/* There should be a 1 ms (Tpup) after getting out of reset. */
+	usleep_range(1000, 2000);
+
+	zpa_dbg(indio_dev, "reset");
+	return 0;
+}
+
+/*
+ * Start a single sampling cycle, i.e. in one shot mode.
+ *
+ * Device must have been previously enabled and configured for one shot mode.
+ * Device will automatically switch back to low power mode at end of cycle.
+ */
+static int zpa_start_oneshot(const struct iio_dev *indio_dev)
+{
+	int err = zpa_write_byte(indio_dev, ZPA_CTRL_REG0_REG,
+				 ZPA_CTRL_REG0_ENABLE | ZPA_CTRL_REG0_ONE_SHOT);
+	if (err) {
+		zpa_err(indio_dev, "failed to start one shot cycle (%d)", err);
+		return err;
+	}
+
+	zpa_dbg(indio_dev, "one shot cycle started");
+	return 0;
+}
+
+/*
+ * Power on device to allow subsequent configuration.
+ *
+ * Sampling will be disabled, preventing strange things from happening in our
+ * back. Hardware fifo content will be cleared.
+ * When successful, device will be left in the enabled state to allow further
+ * configuration.
+ */
+static int zpa_power_on(const struct iio_dev     *indio_dev,
+			const struct zpa_private *private)
+{
+	int err = regulator_enable(private->vdd);
+
+	if (err)
+		return err;
+
+	zpa_dbg(indio_dev, "powered on");
+
+	err = zpa_enable_device(indio_dev);
+	if (err)
+		goto off;
+
+	err = zpa_reset_device(indio_dev);
+	if (err)
+		goto disable;
+
+	return 0;
+
+disable:
+	zpa_disable_device(indio_dev);
+off:
+	regulator_disable(private->vdd);
+
+	zpa_dbg(indio_dev, "powered off");
+	return err;
+}
+
+/* Power off device, i.e. disable attached power regulator. */
+static int zpa_power_off(const struct iio_dev     *indio_dev,
+			 const struct zpa_private *private)
+{
+	int err = regulator_disable(private->vdd);
+
+	zpa_dbg(indio_dev, "powered off");
+
+	return err;
+}
+
+/*
+ * Setup device for one shot / on demand mode.
+ *
+ * Output Data Rate is configured for the highest possible rate so that
+ * conversion time and power consumption are reduced to a minimum.
+ * Note that hardware internal averaging machinery (not implemented in this
+ * driver) is not applicable in this mode.
+ *
+ * Device must have been previously enabled before calling zpa_config_oneshot().
+ */
+static int zpa_config_oneshot(const struct iio_dev *indio_dev,
+			      int                   irq)
+{
+	const struct zpa_frequency *freq = zpa_highest_frequency();
+	int                         err;
+
+	/* Setup highest available Output Data Rate for one shot mode. */
+	err = zpa_write_byte(indio_dev, ZPA_CTRL_REG3_REG, freq->odr);
+	if (err)
+		return err;
+
+	if (irq > 0)
+		/* Request interrupt when new sample is available. */
+		err = zpa_write_byte(indio_dev, ZPA_CTRL_REG1_REG,
+				     ~ZPA_CTRL_REG1_MASK_DATA_READY);
+	if (err) {
+		dev_err(zpa_iio2slave(indio_dev),
+			"failed to setup one shot mode (%d)", err);
+		return err;
+	}
+
+	dev_dbg(zpa_iio2slave(indio_dev), "one shot mode setup @%sHz",
+		freq->hz);
+
+	return 0;
+}
+
+/*
+ * Clear remaining entries in hardware fifo.
+ *
+ * min_count argument is a hint corresponding to the known minimum number of
+ * samples currently living in the fifo. This allows to reduce the number of bus
+ * accesses by skipping status register read operation as long as we know for
+ * sure there are still entries left.
+ */
+static int zpa_clear_fifo(const struct iio_dev *indio_dev,
+			  unsigned int          min_count)
+{
+	int err;
+
+	if (!min_count) {
+		/*
+		 * No hint: read status register to determine whether fifo is
+		 * empty or not.
+		 */
+		err = zpa_read_byte(indio_dev, ZPA_STATUS_REG);
+		if (err < 0)
+			goto err;
+
+		if (err & ZPA_STATUS_FIFO_E)
+			/* Fifo is empty: nothing to trash. */
+			return 0;
+	}
+
+	/* Clear fifo. */
+	do {
+		/*
+		 * A single fetch from pressure MSB register is enought to pop
+		 * values out of fifo.
+		 */
+		err = zpa_read_byte(indio_dev, ZPA_PRESS_OUT_H_REG);
+		if (err < 0)
+			goto err;
+
+		if (min_count) {
+			/*
+			 * We know for sure there are at least min_count entries
+			 * left in fifo. Skip status register read.
+			 */
+			min_count--;
+			continue;
+		}
+
+		err = zpa_read_byte(indio_dev, ZPA_STATUS_REG);
+		if (err < 0)
+			goto err;
+
+	} while (!(err & ZPA_STATUS_FIFO_E));
+
+	zpa_dbg(indio_dev, "fifo cleared");
+	return 0;
+
+err:
+	zpa_err(indio_dev, "failed to clear fifo (%d)", err);
+	return err;
+}
+
+/*
+ * Retrieve the most recent pressure sample from hardware fifo.
+ *
+ * Note that ZPA2326 hardware fifo stores pressure samples only.
+ */
+static int zpa_dequeue_pressure(const struct iio_dev *indio_dev, u32 *pressure)
+{
+	int err = zpa_read_byte(indio_dev, ZPA_STATUS_REG);
+
+	if (err < 0)
+		return err;
+
+	if (!(err & ZPA_STATUS_P_OR)) {
+		/*
+		 * Fifo has not overflown : retrieve newest sample. We need to
+		 * pop values out until fifo is empty : last fetched pressure is
+		 * the newest.
+		 * In nominal cases, we should find a single queued sample only.
+		 */
+		int cleared = -1;
+
+		do {
+			err = zpa_read_block(indio_dev, ZPA_PRESS_OUT_XL_REG, 3,
+					     (u8 *)pressure);
+			if (err)
+				return err;
+
+			err = zpa_read_byte(indio_dev, ZPA_STATUS_REG);
+			if (err < 0)
+				return err;
+
+			cleared++;
+		} while (!(err & ZPA_STATUS_FIFO_E));
+
+		if (cleared)
+			/*
+			 * Samples were pushed by hardware during previous
+			 * rounds but we didn't consume them fast enought:
+			 * inform user.
+			 */
+			zpa_warn(indio_dev, "cleared %d fifo entries", cleared);
+
+		return 0;
+	}
+
+	/* Fifo overrun : first sample dequeued from fifo is the newest. */
+	zpa_warn(indio_dev, "fifo overflow");
+
+	err = zpa_read_block(indio_dev, ZPA_PRESS_OUT_XL_REG, 3,
+			     (u8 *)pressure);
+	if (err)
+		return err;
+
+#define ZPA_FIFO_DEPTH (16U)
+	/* Hardware fifo may hold no more than 16 pressure samples. */
+	return zpa_clear_fifo(indio_dev, ZPA_FIFO_DEPTH - 1);
+}
+
+/* Enqueue new channel samples to IIO buffer. */
+static int zpa_fill_sample_buffer(struct iio_dev           *indio_dev,
+				  const struct zpa_private *private)
+{
+	struct {
+		u32 pressure;
+		u16 temperature;
+		u64 timestamp;
+	}   sample;
+	int err;
+
+	if (test_bit(0, indio_dev->active_scan_mask)) {
+		/* Get current pressure from hardware fifo. */
+		err = zpa_dequeue_pressure(indio_dev, &sample.pressure);
+		if (err) {
+			zpa_warn(indio_dev, "failed to fetch pressure (%d)",
+				 err);
+			return err;
+		}
+	}
+
+	if (test_bit(1, indio_dev->active_scan_mask)) {
+		/* Get current temperature. */
+		err = zpa_read_block(indio_dev, ZPA_TEMP_OUT_L_REG, 2,
+				     (u8 *)&sample.temperature);
+		if (err) {
+			zpa_warn(indio_dev, "failed to fetch temperature (%d)",
+				 err);
+			return err;
+		}
+	}
+
+	/*
+	 * Now push samples using timestamp stored either :
+	 *   - by hardware interrupt handler if interrupt is available: see
+	 *     zpa_handle_irq(),
+	 *   - or oneshot completion polling machinery : see
+	 *     zpa_trigger_oneshot().
+	 */
+	iio_push_to_buffers_with_timestamp(indio_dev, &sample,
+					   private->timestamp);
+	return 0;
+}
+
+/******************************************************************************
+ * Power management
+ ******************************************************************************/
+
+#ifdef CONFIG_PM
+static int zpa_runtime_suspend(struct device *slave)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(slave);
+
+	if (pm_runtime_autosuspend_expiration(slave))
+		/* Userspace changed autosuspend delay. */
+		return -EAGAIN;
+
+	return zpa_power_off(indio_dev, zpa_iio2priv(indio_dev));
+}
+
+static int zpa_runtime_resume(struct device *slave)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(slave);
+
+	return zpa_power_on(indio_dev, zpa_iio2priv(indio_dev));
+}
+
+const struct dev_pm_ops zpa_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+	SET_RUNTIME_PM_OPS(zpa_runtime_suspend, zpa_runtime_resume, NULL)
+};
+EXPORT_SYMBOL_GPL(zpa_pm_ops);
+
+/* Request the PM layer to power supply the device. */
+static int zpa_resume(const struct iio_dev *indio_dev)
+{
+	struct device *slave = zpa_iio2slave(indio_dev);
+	int            err = pm_runtime_get_sync(slave);
+
+	if (err < 0)
+		goto put;
+
+	if (err > 0) {
+		/*
+		 * Device was already power supplied: get it out of low power
+		 * mode.
+		 */
+		err = zpa_enable_device(indio_dev);
+		if (err)
+			goto put;
+
+		/* Inform caller device was already power supplied. */
+		return 1;
+	}
+
+	/* Inform caller device has just been brought back to life. */
+	return 0;
+
+put:
+	pm_runtime_put_noidle(slave);
+	return err;
+}
+
+/*
+ * Schedule a power down using autosuspend feature of PM layer.
+ *
+ * Device is switched to low power mode at first to save power even when
+ * attached regulator is a "dummy" one.
+ */
+static int zpa_suspend(const struct iio_dev *indio_dev)
+{
+	struct device *slave = zpa_iio2slave(indio_dev);
+	int            err = zpa_disable_device(indio_dev);
+
+	pm_runtime_mark_last_busy(slave);
+
+	if (err)
+		goto err;
+
+	err = pm_runtime_put_autosuspend(slave);
+	if (err) {
+		dev_warn(slave, "failed to autosuspend (%d)", err);
+		goto err;
+	}
+
+	return 0;
+
+err:
+	pm_runtime_put_noidle(slave);
+	return err;
+}
+
+/* Setup runtime power management with autosuspend support. */
+static void zpa_init_runtime(struct device *slave)
+{
+	pm_runtime_get_noresume(slave);
+	pm_runtime_set_active(slave);
+	pm_runtime_enable(slave);
+	pm_runtime_set_autosuspend_delay(slave, 1000);
+	pm_runtime_use_autosuspend(slave);
+	pm_runtime_mark_last_busy(slave);
+	pm_runtime_put_autosuspend(slave);
+}
+
+static void zpa_fini_runtime(struct device *slave)
+{
+	pm_runtime_disable(slave);
+	pm_runtime_set_suspended(slave);
+}
+#else /* !CONFIG_PM */
+static int zpa_resume(const struct iio_dev *indio_dev)
+{
+	return zpa_enable_device(indio_dev);
+}
+
+static int zpa_suspend(const struct iio_dev *indio_dev)
+{
+	return zpa_disable_device(indio_dev);
+}
+
+#define zpa_init_runtime(_slave)
+#define zpa_fini_runtime(_slave)
+#endif /* !CONFIG_PM */
+
+/******************************************************************************
+ * Interrupt handling
+ ******************************************************************************/
+
+/*
+ * Hardware interrupt handler.
+ *
+ * Timestamps buffered samples as soon as possible then schedule threaded bottom
+ * half.
+ */
+static irqreturn_t zpa_handle_irq(int irq, void *data)
+{
+	struct iio_dev *indio_dev = (struct iio_dev *)data;
+
+	if (iio_buffer_enabled(indio_dev)) {
+		struct zpa_private *priv = zpa_iio2priv(indio_dev);
+
+		/* Timestamping needed for buffered sampling only. */
+		priv->timestamp = iio_get_time_ns(indio_dev);
+	}
+
+	return IRQ_WAKE_THREAD;
+}
+
+/*
+ * Fetch interrupt status and acknowledge all interrupts.
+ *
+ * Called from threaded interrupt context.
+ */
+static int zpa_acknowledge_irq(const struct iio_dev     *indio_dev,
+			       const struct zpa_private *private)
+{
+	/*
+	 * Device works according to a level interrupt scheme: reading interrupt
+	 * status de-asserts interrupt line.
+	 */
+	int err = zpa_read_byte(indio_dev, ZPA_INT_SOURCE_REG);
+
+	if (err < 0)
+		return err;
+
+	/* Data ready is the only interrupt source we requested. */
+	if (!(err & ZPA_INT_SOURCE_DATA_READY)) {
+		zpa_warn(indio_dev, "unexpected interrupt status %02x", err);
+		return -ENODATA;
+	}
+
+	/* New sample available: notify our internal trigger consumers. */
+	iio_trigger_poll_chained(private->trigger);
+
+	return 0;
+}
+
+/*
+ * Interrupt bottom-half handler.
+ *
+ * Mainly ensures interrupt is caused by a real "new sample available"
+ * condition. This relies upon the ability to perform blocking / sleeping bus
+ * accesses to slave's registers. This is why zpa_handle_threaded_irq() is
+ * called from within a thread, i.e. not called from hard interrupt context.
+ */
+static irqreturn_t zpa_handle_threaded_irq(int irq, void *data)
+{
+	struct iio_dev     *indio_dev = (struct iio_dev *)data;
+	struct zpa_private *priv = zpa_iio2priv(indio_dev);
+	irqreturn_t         ret = IRQ_NONE;
+
+	priv->result = zpa_acknowledge_irq(indio_dev, priv);
+
+	if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE) {
+		/* Continuous sampling enabled. */
+
+		if (!priv->result)
+			/* Populate IIO buffer */
+			zpa_fill_sample_buffer(indio_dev, priv);
+		/*
+		 * Tell power management layer we've just used the device to
+		 * prevent from autosuspending to early.
+		 */
+		pm_runtime_mark_last_busy(zpa_iio2slave(indio_dev));
+
+		return (!priv->result) ? IRQ_HANDLED : IRQ_NONE;
+	}
+
+	if (priv->result)
+		/*
+		 * Interrupt happened but no new sample available: likely caused
+		 * by spurious interrupts, in which case, returning IRQ_NONE
+		 * allows to benefit from the generic spurious interrupts
+		 * handling.
+		 */
+		goto complete;
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+		priv->result = zpa_fill_sample_buffer(indio_dev, priv);
+
+	ret = IRQ_HANDLED;
+
+complete:
+	/*
+	 * Wake up direct or triggered buffer mode waiters: see
+	 * zpa_sample_oneshot() and zpa_trigger_oneshot().
+	 */
+	complete(&priv->data_ready);
+	return ret;
+}
+
+/* Wait for oneshot data ready interrupt. */
+static int zpa_wait_oneshot_completion(const struct iio_dev *indio_dev,
+				       struct zpa_private   *private)
+{
+	int err = wait_for_completion_interruptible_timeout(
+			&private->data_ready, ZPA_CONVERSION_TIMEOUT);
+
+	if (err > 0)
+		/*
+		 * Interrupt handler completed before timeout: return operation
+		 * status.
+		 */
+		return private->result;
+
+	/* Clear all interrupts just to be sure. */
+	zpa_read_byte(indio_dev, ZPA_INT_SOURCE_REG);
+
+	if (!err)
+		/* Timed out. */
+		err = -ETIME;
+
+	if (err != -ERESTARTSYS)
+		zpa_warn(indio_dev, "no one shot interrupt occurred (%d)", err);
+
+	return err;
+}
+
+/* Setup interrupt handling. */
+static int zpa_init_irq(struct device      *slave,
+			struct iio_dev     *indio_dev,
+			struct zpa_private *private,
+			int                 irq)
+{
+	int err;
+
+	if (irq <= 0) {
+		/*
+		 * Platform declared no interrupt line: device will be polled
+		 * for data availability.
+		 */
+		private->irq = -1;
+		dev_info(slave, "no interrupt found, running in polling mode");
+		return 0;
+	}
+
+	private->irq = irq;
+	init_completion(&private->data_ready);
+
+	/* Request handler to be scheduled into threaded interrupt context. */
+	err = devm_request_threaded_irq(slave, irq, zpa_handle_irq,
+					zpa_handle_threaded_irq,
+					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+					dev_name(slave), indio_dev);
+	if (err) {
+		dev_err(slave, "failed to request interrupt %d (%d)", irq, err);
+		return err;
+	}
+
+	dev_info(slave, "using interrupt %d", irq);
+	return 0;
+}
+
+/******************************************************************************
+ * Direct sampling
+ ******************************************************************************/
+
+/*
+ * Ensure exclusive access to prevent from modifying device setup in the back of
+ * ongoing operations.
+ * In the mean time, power on device to get access to the complete register map.
+ */
+static int zpa_claim_direct_mode(struct iio_dev *indio_dev)
+{
+	/* Gain exclusive access for userspace usage. */
+	int err = iio_device_claim_direct_mode(indio_dev);
+
+	if (err)
+		return err;
+
+	/* Bring device back to life. */
+	err = zpa_resume(indio_dev);
+	if (err < 0)
+		goto release;
+
+	return err;
+
+release:
+	/* Relinquish exclusive access. */
+	iio_device_release_direct_mode(indio_dev);
+	return err;
+}
+
+/* Release exclusive acces to device. Device is also powered down. */
+static void zpa_release_direct_mode(struct iio_dev *indio_dev)
+{
+	zpa_suspend(indio_dev);
+	iio_device_release_direct_mode(indio_dev);
+}
+
+/* Actively poll for one shot data ready. */
+static int zpa_poll_oneshot_completion(const struct iio_dev *indio_dev)
+{
+	unsigned long tmout = jiffies + ZPA_CONVERSION_TIMEOUT;
+	int           err;
+
+	/*
+	 * At least, 100 ms is needed for the device to complete its one-shot
+	 * cycle.
+	 */
+	if (msleep_interruptible(100))
+		return -ERESTARTSYS;
+
+	/* Poll for conversion completion in hardware. */
+	while (true) {
+		err = zpa_read_byte(indio_dev, ZPA_CTRL_REG0_REG);
+		if (err < 0)
+			goto err;
+
+		if (!(err & ZPA_CTRL_REG0_ONE_SHOT))
+			/* One-shot bit self clears at conversion end. */
+			break;
+
+		if (time_after(jiffies, tmout)) {
+			/* Prevent from waiting forever : let's time out. */
+			err = -ETIME;
+			goto err;
+		}
+
+		usleep_range(10000, 20000);
+	}
+
+	/*
+	 * In oneshot mode, pressure sample availability guarantees that
+	 * temperature conversion has also completed : just check pressure
+	 * status bit to keep things simple.
+	 */
+	err = zpa_read_byte(indio_dev, ZPA_STATUS_REG);
+	if (err < 0)
+		goto err;
+
+	if (!(err & ZPA_STATUS_P_DA)) {
+		/* No sample available. */
+		err = -ENODATA;
+		goto err;
+	}
+
+	return 0;
+
+err:
+	zpa_warn(indio_dev, "failed to poll one shot completion (%d)", err);
+	return err;
+}
+
+/* Retrieve a raw sample and convert it to CPU endianness. */
+static int zpa_fetch_raw_sample(const struct iio_dev *indio_dev,
+				enum iio_chan_type    type,
+				int                  *value)
+{
+	int err;
+
+	switch (type) {
+	case IIO_PRESSURE:
+		zpa_dbg(indio_dev, "fetching raw pressure sample");
+
+		err = zpa_read_block(indio_dev, ZPA_PRESS_OUT_XL_REG, 3,
+				     (u8 *)value);
+		if (err) {
+			zpa_warn(indio_dev, "failed to fetch pressure (%d)",
+				 err);
+			return err;
+		}
+
+		/* Pressure is a 24 bits wide little-endian unsigned int. */
+		*value = (((u8 *)value)[2] << 16) | (((u8 *)value)[1] << 8) |
+			 ((u8 *)value)[0];
+
+		return IIO_VAL_INT;
+
+	case IIO_TEMP:
+		zpa_dbg(indio_dev, "fetching raw temperature sample");
+
+		err = zpa_read_block(indio_dev, ZPA_TEMP_OUT_L_REG, 2,
+				     (u8 *)value);
+		if (err) {
+			zpa_warn(indio_dev, "failed to fetch temperature (%d)",
+				 err);
+			return err;
+		}
+
+		/* Temperature is a 16 bits wide little-endian signed int. */
+		*value = (int)le16_to_cpup((__le16 *)value);
+
+		return IIO_VAL_INT;
+
+	default:
+		BUG();
+	}
+}
+
+/* Perform a complete one shot sampling cycle. */
+static int zpa_sample_oneshot(struct iio_dev     *indio_dev,
+			      enum iio_chan_type  type,
+			      int                *value)
+{
+	/* Gain exclusive access to device. */
+	int                 err = zpa_claim_direct_mode(indio_dev);
+	struct zpa_private *priv = zpa_iio2priv(indio_dev);
+
+	if (err < 0)
+		return err;
+
+	if (err > 0) {
+		/*
+		 * We were already power supplied. Just clear hardware fifo to
+		 * get rid of samples acquired during previous rounds (if any).
+		 * Sampling operation always generates both temperature and
+		 * pressure samples. The latter are always enqueued into
+		 * hardware fifo. This may lead to situations were pressure
+		 * samples still sit into fifo when previous cycle(s) fetched
+		 * temperature data only.
+		 * Hence, we need to clear hardware fifo content to prevent from
+		 * getting outdated values at the end of current cycle.
+		 */
+		if (type == IIO_PRESSURE) {
+			err = zpa_clear_fifo(indio_dev, 0);
+			if (err)
+				goto release;
+		}
+	} else {
+		/*
+		 * We have just been power supplied, i.e. device is in default
+		 * "out of reset" state, meaning we need to reconfigure it
+		 * entirely.
+		 */
+		err = zpa_config_oneshot(indio_dev, priv->irq);
+		if (err)
+			goto release;
+	}
+
+	/* Start a sampling cycle in oneshot mode. */
+	err = zpa_start_oneshot(indio_dev);
+	if (err)
+		goto release;
+
+	/* Wait for sampling cycle to complete. */
+	zpa_dbg(indio_dev, "waiting for one shot completion");
+
+	if (priv->irq > 0)
+		err = zpa_wait_oneshot_completion(indio_dev, priv);
+	else
+		err = zpa_poll_oneshot_completion(indio_dev);
+
+	if (err)
+		goto release;
+
+	/* Retrieve raw sample value and convert it to CPU endianness. */
+	err = zpa_fetch_raw_sample(indio_dev, type, value);
+
+release:
+	zpa_release_direct_mode(indio_dev);
+	return err;
+}
+
+/******************************************************************************
+ * Buffering handling
+ ******************************************************************************/
+
+/*
+ * Reject external trigger attachment if setting up continuous hardware sampling
+ * mode.
+ */
+static int zpa_validate_trigger(struct iio_dev     *indio_dev,
+				struct iio_trigger *trigger)
+{
+	int ret = 0;
+
+	mutex_lock(&indio_dev->mlock);
+
+	if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE)
+		ret = -EBUSY;
+
+	mutex_unlock(&indio_dev->mlock);
+
+	return ret;
+}
+
+/* Finalize one shot cycle processing in triggered sampling mode. */
+static void zpa_complete_oneshot_trigger(const struct iio_dev *indio_dev)
+{
+	/*
+	 * Tell power management layer we've just used the device to prevent
+	 * from autosuspending to early.
+	 */
+	pm_runtime_mark_last_busy(zpa_iio2slave(indio_dev));
+
+	/* Inform attached trigger we are done. */
+	iio_trigger_notify_done(indio_dev->trig);
+}
+
+/*
+ * Perform an IIO buffered sampling round in one shot mode.
+ *
+ * Handler called by the IIO trigger currently attached to device. Allows to
+ * synchronize this device buffered sampling with external events (such as timer
+ * expiration, external device sample ready, etc...).
+ * Basically run the same sequence of operations as for zpa_sample_oneshot()
+ * with the following exceptions:
+ *   - hardware fifo is not cleared since already done at buffering enable time
+ *     and samples dequeueing always retrieves the most recent value,
+ *   - samples endianness is not processed since delegated to userspace in
+ *     buffered mode.
+ */
+static irqreturn_t zpa_trigger_oneshot(int irq, void *data)
+{
+	struct iio_poll_func *pf = data;
+	struct iio_dev       *indio_dev = pf->indio_dev;
+	struct zpa_private   *priv = zpa_iio2priv(indio_dev);
+
+	/* Start a one shot sampling cycle. */
+	if (zpa_start_oneshot(indio_dev))
+		goto err;
+
+	if (priv->irq <= 0) {
+		/* No interrupt available: poll for sampling completion. */
+		if (zpa_poll_oneshot_completion(indio_dev))
+			goto disable;
+
+		/* Only timestamp sample once it is ready. */
+		priv->timestamp = iio_get_time_ns(indio_dev);
+
+		/* Enqueue to IIO buffer / userspace. */
+		zpa_fill_sample_buffer(indio_dev, priv);
+	} else {
+		/* Interrupt handlers will timestamp and get samples for us. */
+		if (zpa_wait_oneshot_completion(indio_dev, priv))
+			goto disable;
+	}
+
+	zpa_complete_oneshot_trigger(indio_dev);
+	return IRQ_HANDLED;
+
+disable:
+	zpa_disable_device(indio_dev);
+err:
+	zpa_complete_oneshot_trigger(indio_dev);
+	return IRQ_NONE;
+}
+
+/*
+ * Get device ready for configuration of continuous / triggered sampling modes.
+ *
+ * Called with IIO device's lock held.
+ */
+static int zpa_preenable_ring(struct iio_dev *indio_dev)
+{
+	int err = zpa_resume(indio_dev);
+
+	if (err < 0)
+		return err;
+
+	if (err > 0) {
+		/*
+		 * We were already power supplied. Just clear hardware fifo to
+		 * get rid of samples acquired during previous rounds (if any).
+		 */
+		err = zpa_clear_fifo(indio_dev, 0);
+		if (err) {
+			zpa_suspend(indio_dev);
+			return err;
+		}
+
+		zpa_iio2priv(indio_dev)->waken = false;
+		return 0;
+	}
+
+	/* Tell zpa_postenable_ring() we have just been powered on. */
+	zpa_iio2priv(indio_dev)->waken = true;
+	return 0;
+}
+
+/*
+ * Configure and start continuous / triggered sampling.
+ *
+ * Called with IIO device's lock held.
+ * If an error is returned, IIO layer will call our postdisable hook for us,
+ * i.e. no need to explicitly power device off here.
+ */
+static int zpa_postenable_ring(struct iio_dev *indio_dev)
+{
+	const struct zpa_private *priv = zpa_iio2priv(indio_dev);
+	int                       err;
+
+	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+		/* Prepare device for triggered buffering usage. */
+
+		if (priv->waken) {
+			/*
+			 * We have just been power supplied, i.e. device is in
+			 * default "out of reset" state, meaning we need to
+			 * properly reconfigure it for on trigger demand usage.
+			 */
+			err = zpa_config_oneshot(indio_dev, priv->irq);
+			if (err)
+				return err;
+		}
+
+		/* Plug our own trigger event handler. */
+		err = iio_triggered_buffer_postenable(indio_dev);
+		if (err)
+			return err;
+
+		/*
+		 * Switch back to low power. A complete one shot sampling cycle
+		 * will be started upon trigger notification.
+		 */
+		return zpa_disable_device(indio_dev);
+	}
+
+	/* Prepare then start continuous sampling session. */
+
+	if (priv->waken) {
+		/*
+		 * We have just been power supplied, i.e. device is in default
+		 * "out of reset" state, meaning we need to unmask data ready
+		 * interrupt to process new samples.
+		 */
+		err = zpa_write_byte(indio_dev, ZPA_CTRL_REG1_REG,
+				     ~ZPA_CTRL_REG1_MASK_DATA_READY);
+		if (err)
+			goto err;
+	}
+
+	/* Start continuous sampling at required frequency. */
+	err = zpa_write_byte(indio_dev, ZPA_CTRL_REG3_REG,
+			     ZPA_CTRL_REG3_ENABLE_MEAS | priv->frequency->odr);
+	if (err)
+		goto err;
+
+	zpa_dbg(indio_dev, "continuous mode setup @%sHz", priv->frequency->hz);
+	return 0;
+
+err:
+	zpa_err(indio_dev, "failed to setup continuous mode (%d)", err);
+	return err;
+}
+
+/*
+ * Stop continuous / triggered sampling.
+ *
+ * Called with IIO device's lock held.
+ */
+static int zpa_predisable_ring(struct iio_dev *indio_dev)
+{
+	if (indio_dev->currentmode == INDIO_BUFFER_SOFTWARE) {
+		int irq = zpa_iio2priv(indio_dev)->irq;
+		int err;
+
+		/*
+		 * As device is working in continuous mode, handlers may be
+		 * accessing resources we are currently freeing...
+		 * Prevent this by disabling interrupt handlers and ensure
+		 * the device will generate no more interrupts unless explicitly
+		 * required to, i.e. by restoring back to default one shot mode.
+		 */
+		disable_irq(irq);
+
+		/*
+		 * Disable continuous sampling mode to restore settings for
+		 * one shot / direct sampling operations.
+		 */
+		err = zpa_write_byte(indio_dev, ZPA_CTRL_REG3_REG,
+				     zpa_highest_frequency()->odr);
+		if (err)
+			goto err;
+
+		/*
+		 * Now that device won't generate interrupts on its own,
+		 * acknowledge any currently active interrupts (may happen on
+		 * rare occasions while stopping continuous mode).
+		 */
+		err = zpa_read_byte(indio_dev, ZPA_INT_SOURCE_REG);
+		if (err < 0)
+			goto err;
+
+		/*
+		 * Re-enable interrupts only if we can guarantee the device will
+		 * generate no more interrupts to prevent handlers from
+		 * accessing released resources.
+		 */
+		enable_irq(irq);
+		return 0;
+
+err:
+		zpa_err(indio_dev,
+			"failed to stop buffering, leaving interrupt disabled... (%d)",
+			err);
+		return err;
+	}
+
+	/* Triggered buffering: unplug our own trigger event handler. */
+	return iio_triggered_buffer_predisable(indio_dev);
+}
+
+/* Called with IIO device's lock held. */
+static int zpa_postdisable_ring(struct iio_dev *indio_dev)
+{
+	return zpa_suspend(indio_dev);
+}
+
+static const struct iio_buffer_setup_ops zpa_ring_setup_ops = {
+	.preenable   = zpa_preenable_ring,
+	.postenable  = zpa_postenable_ring,
+	.predisable  = zpa_predisable_ring,
+	.postdisable = zpa_postdisable_ring,
+};
+
+/* Setup buffered sampling. */
+static int zpa_init_ring(struct device  *slave,
+			 struct iio_dev *indio_dev,
+			 int             irq)
+{
+	int err = devm_iio_triggered_buffer_setup(slave, indio_dev, NULL,
+						  zpa_trigger_oneshot,
+						  &zpa_ring_setup_ops);
+	if (err)
+		return err;
+
+	if (irq > 0)
+		/* Allow continuous hardware sampling if interrupt available. */
+		indio_dev->modes |= INDIO_BUFFER_SOFTWARE;
+
+	return 0;
+}
+
+/******************************************************************************
+ * Hardware trigger handling
+ ******************************************************************************/
+
+/*
+ * Using our own interrupt driven trigger to start a triggered buffer sampling
+ * round is pure nonsense: use continuous hardware sampling mode instead, i.e.
+ * INDIO_BUFFER_SOFTWARE. Or synchronize against an external trigger / device.
+ */
+static int zpa_validate_device(struct iio_trigger *trigger,
+			       struct iio_dev     *indio_dev)
+{
+	if (indio_dev == (struct iio_dev *)iio_trigger_get_drvdata(trigger))
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct iio_trigger_ops zpa_trigger_ops = {
+	.owner             = THIS_MODULE,
+	.validate_device   = zpa_validate_device,
+};
+
+/*
+ * Create an interrupt driven / hardware trigger allowing to notify external
+ * devices a new sample is ready.
+ */
+static int zpa_init_trigger(struct device      *slave,
+			    struct iio_dev     *indio_dev,
+			    struct zpa_private *private,
+			    int                 irq)
+{
+	struct iio_trigger *trigger;
+	int                 err;
+
+	if (irq <= 0)
+		return 0;
+
+	trigger = devm_iio_trigger_alloc(slave, "%s-sample-ready-dev%d",
+					 indio_dev->name, indio_dev->id);
+	if (!trigger)
+		return -ENOMEM;
+
+	/* Basic setup. */
+	trigger->dev.parent = slave;
+	trigger->ops = &zpa_trigger_ops;
+	iio_trigger_set_drvdata(trigger, indio_dev);
+
+	private->trigger = trigger;
+
+	/* Register to triggers space. */
+	err = devm_iio_trigger_register(slave, trigger);
+	if (err)
+		dev_err(slave, "failed to register hardware trigger (%d)", err);
+
+	return err;
+}
+
+/******************************************************************************
+ * Debugfs stuff
+ *
+ * Note this is mostly unusable with power management enabled systems since
+ * registers content is lost during power off -> on transitions.
+ ******************************************************************************/
+
+#if defined(CONFIG_DEBUG_FS)
+#define zpa_debugfs_ptr(_ptr) _ptr
+
+static int zpa_debugfs_read(struct iio_dev *indio_dev,
+			    u8              reg,
+			    unsigned int   *value)
+{
+	int err;
+
+	switch (reg) {
+	case ZPA_REF_P_XL_REG:
+	case ZPA_REF_P_L_REG:
+	case ZPA_REF_P_H_REG:
+	case ZPA_DEVICE_ID_REG:
+	case ZPA_RES_CONF_REG:
+	case ZPA_CTRL_REG0_REG:
+	case ZPA_CTRL_REG1_REG:
+	case ZPA_CTRL_REG2_REG:
+	case ZPA_CTRL_REG3_REG:
+	case ZPA_INT_SOURCE_REG: /* Will acknowledge interrupts. */
+	case ZPA_THS_P_LOW_REG:
+	case ZPA_THS_P_HIGH_REG:
+	case ZPA_STATUS_REG:
+	case ZPA_PRESS_OUT_XL_REG:
+	case ZPA_PRESS_OUT_L_REG:
+	case ZPA_PRESS_OUT_H_REG:  /* Will pop samples out of hardware fifo. */
+	case ZPA_TEMP_OUT_L_REG:
+	case ZPA_TEMP_OUT_H_REG:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	err = zpa_claim_direct_mode(indio_dev);
+	if (err < 0)
+		return err;
+
+	err = zpa_read_byte(indio_dev, reg);
+	if (err < 0)
+		goto release;
+
+	*value = err;
+	err = 0;
+
+release:
+	zpa_release_direct_mode(indio_dev);
+	return err;
+}
+
+static int zpa_debugfs_write(struct iio_dev *indio_dev,
+			     u8              reg,
+			     unsigned int    value)
+{
+	int err;
+
+	switch (reg) {
+	/* Read only registers */
+	case ZPA_DEVICE_ID_REG:
+	case ZPA_INT_SOURCE_REG:
+	case ZPA_STATUS_REG:
+	case ZPA_PRESS_OUT_XL_REG:
+	case ZPA_PRESS_OUT_L_REG:
+	case ZPA_PRESS_OUT_H_REG:
+	case ZPA_TEMP_OUT_L_REG:
+	case ZPA_TEMP_OUT_H_REG:
+		return -EPERM;
+
+	/* Read/write registers */
+	case ZPA_REF_P_XL_REG:
+	case ZPA_REF_P_L_REG:
+	case ZPA_REF_P_H_REG:
+	case ZPA_RES_CONF_REG:
+	case ZPA_CTRL_REG0_REG:
+	case ZPA_CTRL_REG1_REG:
+	case ZPA_CTRL_REG2_REG:
+	case ZPA_CTRL_REG3_REG:
+	case ZPA_THS_P_LOW_REG:
+	case ZPA_THS_P_HIGH_REG:
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	if (value > U8_MAX)
+		return -ERANGE;
+
+	err = zpa_claim_direct_mode(indio_dev);
+	if (err < 0)
+		return err;
+
+	err = zpa_write_byte(indio_dev, reg, value);
+
+	zpa_release_direct_mode(indio_dev);
+	return err;
+}
+
+static int zpa_debugfs_reg_access(struct iio_dev *indio_dev,
+				  unsigned int    reg,
+				  unsigned int    writeval,
+				  unsigned int   *readval)
+{
+	if (readval)
+		return zpa_debugfs_read(indio_dev, reg, readval);
+
+	return zpa_debugfs_write(indio_dev, reg, writeval);
+}
+#else
+#define zpa_debugfs_ptr(_ptr) NULL
+#endif
+
+/******************************************************************************
+ * IIO device handling
+ ******************************************************************************/
+
+static int zpa_read_raw(struct iio_dev             *indio_dev,
+			struct iio_chan_spec const *chan,
+			int                        *val,
+			int                        *val2,
+			long                        mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return zpa_sample_oneshot(indio_dev, chan->type, val);
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->type) {
+		case IIO_PRESSURE:
+			/*
+			 * Pressure resolution is 1/64 Pascal. Scale to kPascal
+			 * as required by IIO ABI.
+			 */
+			*val = 0;
+			*val2 = 1000000 / 64;
+			return IIO_VAL_INT_PLUS_NANO;
+
+		case IIO_TEMP:
+			/*
+			 * Temperature follows the equation:
+			 *     Temp[degC] = Tempcode * 0.00649 - 176.83
+			 * where:
+			 *     Tempcode is composed the raw sampled 16 bits.
+			 *
+			 * Hence, to produce a temperature in milli-degrees
+			 * Celsius according to IIO ABI, we need to apply the
+			 * following equation to raw samples:
+			 *     Temp[milli degC] = (Tempcode + Offset) * Scale
+			 * where:
+			 *     Offset = -176.83 / 0.00649
+			 *     Scale = 0.00649 * 1000
+			 */
+			*val = 6;
+			*val2 = 490000;
+			return IIO_VAL_INT_PLUS_MICRO;
+
+		default:
+			BUG();
+		}
+
+	case IIO_CHAN_INFO_OFFSET:
+		BUG_ON(chan->type != IIO_TEMP);
+		*val = -17683000 / 649;
+		*val2 = ((17683000 % 649) * 1000000000ULL) / 649ULL;
+		return IIO_VAL_INT_PLUS_NANO;
+
+	default:
+		BUG();
+	}
+}
+
+/* Current hardware sampling frequency sysfs getter. */
+static ssize_t zpa_show_frequency(struct device           *dev,
+				  struct device_attribute *attr,
+				  char                    *buf)
+{
+	const struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+
+	return sprintf(buf, "%s\n", zpa_iio2priv(indio_dev)->frequency->hz);
+}
+
+/* Current hardware sampling frequency sysfs setter. */
+static ssize_t zpa_store_frequency(struct device           *dev,
+				   struct device_attribute *attr,
+				   const char              *buf,
+				   size_t                   len)
+{
+	struct iio_dev     *indio_dev = dev_to_iio_dev(dev);
+	struct zpa_private *priv = zpa_iio2priv(indio_dev);
+	int                 f, err;
+
+	/* Check if requested frequency is supported. */
+	for (f = 0; f < ARRAY_SIZE(zpa_sampling_frequencies); f++)
+		if (sysfs_streq(zpa_sampling_frequencies[f].hz, buf))
+			break;
+	if (f == ARRAY_SIZE(zpa_sampling_frequencies))
+		return -EINVAL;
+
+	/* Don't allow changing frequency if buffered sampling is ongoing. */
+	err = iio_device_claim_direct_mode(indio_dev);
+	if (err)
+		return err;
+
+	priv->frequency = &zpa_sampling_frequencies[f];
+
+	iio_device_release_direct_mode(indio_dev);
+
+	return len;
+}
+
+static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
+			      zpa_show_frequency,
+			      zpa_store_frequency);
+
+/* Expose supported hardware sampling frequencies (Hz) through sysfs. */
+static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 5 11 23");
+
+static struct attribute *zpa_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group zpa_attribute_group = {
+	.attrs = zpa_attributes,
+};
+
+static const struct iio_chan_spec zpa_channels[] = {
+	[0] = {
+		.type                   = IIO_PRESSURE,
+		.channel                = 0,
+		.scan_index             = 0,
+		.scan_type              = {
+			.sign                   = 'u',
+			.realbits               = 24,
+			.storagebits            = 32,
+			.endianness             = IIO_LE,
+		},
+		.info_mask_separate     = BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_SCALE),
+	},
+	[1] = {
+		.type                   = IIO_TEMP,
+		.channel                = 1,
+		.scan_index             = 1,
+		.scan_type              = {
+			.sign                   = 's',
+			.realbits               = 16,
+			.storagebits            = 16,
+			.endianness             = IIO_LE,
+		},
+		.info_mask_separate     = BIT(IIO_CHAN_INFO_RAW) |
+					  BIT(IIO_CHAN_INFO_SCALE) |
+					  BIT(IIO_CHAN_INFO_OFFSET),
+	},
+	[2] = IIO_CHAN_SOFT_TIMESTAMP(2),
+};
+
+static const struct iio_info zpa_info = {
+	.driver_module      = THIS_MODULE,
+	.attrs              = &zpa_attribute_group,
+	.read_raw           = zpa_read_raw,
+	.debugfs_reg_access = zpa_debugfs_ptr(zpa_debugfs_reg_access),
+	.validate_trigger   = zpa_validate_trigger,
+};
+
+/* Allocate and initialize a basic ZPA IIO device. */
+static struct iio_dev *zpa_create_iio(struct device        *device,
+				      const char           *name,
+				      const struct zpa_bus *bus)
+{
+	struct iio_dev *indio_dev;
+
+	/* Allocate space to hold IIO device internal state. */
+	indio_dev = devm_iio_device_alloc(device, sizeof(struct zpa_private));
+	if (!indio_dev)
+		return NULL;
+
+	/* Setup for userspace synchronous on demand sampling. */
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->dev.parent = device;
+	indio_dev->channels = zpa_channels;
+	indio_dev->num_channels = ARRAY_SIZE(zpa_channels);
+	indio_dev->name = name;
+	indio_dev->info = &zpa_info;
+
+	/* Plug device's underlying bus abstraction. */
+	zpa_iio2priv(indio_dev)->bus = bus;
+
+	/* Init hardware sampling frequency to highest rate supported. */
+	zpa_iio2priv(indio_dev)->frequency = zpa_highest_frequency();
+
+	return indio_dev;
+}
+
+int zpa_probe(struct device        *slave,
+	      const char           *name,
+	      int                   irq,
+	      const struct zpa_bus *bus)
+{
+	struct iio_dev     *indio_dev = zpa_create_iio(slave, name, bus);
+	struct zpa_private *priv;
+	int                 err;
+
+	if (!indio_dev)
+		return -ENOMEM;
+
+	priv = zpa_iio2priv(indio_dev);
+
+	priv->vdd = devm_regulator_get(slave, "vdd");
+	if (IS_ERR(priv->vdd))
+		return PTR_ERR(priv->vdd);
+
+	err = zpa_power_on(indio_dev, priv);
+	if (err)
+		return err;
+
+	err = zpa_init_ring(slave, indio_dev, irq);
+	if (err)
+		goto disable;
+
+	err = zpa_init_trigger(slave, indio_dev, priv, irq);
+	if (err)
+		goto disable;
+
+	err = zpa_init_irq(slave, indio_dev, priv, irq);
+	if (err)
+		goto disable;
+
+	err = zpa_config_oneshot(indio_dev, irq);
+	if (err)
+		goto disable;
+
+	err = zpa_disable_device(indio_dev);
+	if (err)
+		goto off;
+
+	dev_set_drvdata(slave, indio_dev);
+
+	zpa_init_runtime(slave);
+
+	err = devm_iio_device_register(slave, indio_dev);
+	if (err) {
+		zpa_fini_runtime(slave);
+		goto off;
+	}
+
+	dev_dbg(slave, "%s barometer ready", name);
+	return 0;
+
+disable:
+	zpa_disable_device(indio_dev);
+off:
+	zpa_power_off(indio_dev, priv);
+	return err;
+}
+EXPORT_SYMBOL_GPL(zpa_probe);
+
+int zpa_remove(const struct device *slave)
+{
+	const struct iio_dev *indio_dev = dev_get_drvdata(slave);
+
+	zpa_fini_runtime(zpa_iio2slave(indio_dev));
+	zpa_disable_device(indio_dev);
+	zpa_power_off(indio_dev, zpa_iio2priv(indio_dev));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(zpa_remove);
+
+MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
+MODULE_DESCRIPTION("Core driver for Murata ZPA2326 pressure sensor");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/zpa2326.h b/drivers/iio/pressure/zpa2326.h
new file mode 100644
index 0000000..df105cb
--- /dev/null
+++ b/drivers/iio/pressure/zpa2326.h
@@ -0,0 +1,76 @@
+/*
+ * Murata ZPA2326 pressure and temperature sensor IIO driver
+ *
+ * Copyright (c) 2016 Parrot S.A.
+ *
+ * Author: Gregor Boirie <gregor.boirie@parrot.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#ifndef _ZPA2326_H
+#define _ZPA2326_H
+
+#include <linux/iio/iio.h>
+
+#define ZPA_DEVICE_ID_REG              ((u8)0xf)
+#define ZPA_DEVICE_ID                  (0xb9)
+
+/*
+ * struct zpa_bus - underlying I2C / SPI bus adapter for zpa2326 driver
+ * @zpa_read_byte:  fetch and return a single byte from slave register
+ * @zpa_write_byte: store a single byte to slave register
+ * @zpa_read_block: fetch data block from multiple contiguous slave registers
+ *
+ * Abtract slave register accesses.
+ */
+struct zpa_bus {
+	int (*zpa_read_byte)(const struct iio_dev *indio_dev, u8 address);
+	int (*zpa_write_byte)(const struct iio_dev *indio_dev,
+			      u8                    address,
+			      u8                    value);
+	int (*zpa_read_block)(const struct iio_dev *indio_dev,
+			      u8                    address,
+			      u8                    length,
+			      u8                   *value);
+};
+
+static inline struct device *zpa_iio2slave(const struct iio_dev *indio_dev)
+{
+	return indio_dev->dev.parent;
+}
+
+/*
+ * zpa_probe() - instantiate and register core zpa2326 IIO device
+ * @slave: device the IIO device will be a child of
+ * @name:  arbitrary name identify the device
+ * @irq:   interrupt line, negative if none
+ * @bus:   underlying bus adapter
+ */
+int zpa_probe(struct device        *slave,
+	      const char           *name,
+	      int                   irq,
+	      const struct zpa_bus *bus);
+
+/*
+ * zpa_remove() - unregister and destroy core zpa2326 IIO device
+ * @slave: device the IIO device to remove is a child of
+ */
+int zpa_remove(const struct device *slave);
+
+#ifdef CONFIG_PM
+#include <linux/pm.h>
+extern const struct dev_pm_ops zpa_pm_ops;
+#define ZPA_PM_OPS (&zpa_pm_ops)
+#else
+#define ZPA_PM_OPS (NULL)
+#endif
+
+#endif
diff --git a/drivers/iio/pressure/zpa2326_i2c.c b/drivers/iio/pressure/zpa2326_i2c.c
new file mode 100644
index 0000000..f43c41a
--- /dev/null
+++ b/drivers/iio/pressure/zpa2326_i2c.c
@@ -0,0 +1,188 @@
+/*
+ * Murata ZPA2326 I2C pressure and temperature sensor driver
+ *
+ * Copyright (c) 2016 Parrot S.A.
+ *
+ * Author: Gregor Boirie <gregor.boirie@parrot.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/of_device.h>
+#include "zpa2326.h"
+
+static const struct i2c_client *zpa_iio2client(const struct iio_dev *indio_dev)
+{
+	return to_i2c_client(zpa_iio2slave(indio_dev));
+}
+
+static int zpa_write_i2c_byte(const struct iio_dev *indio_dev, u8 address,
+			      u8 value)
+{
+	int                      err;
+	const struct i2c_client *client = zpa_iio2client(indio_dev);
+	u8                       buf[] = { address, value };
+	struct i2c_msg           msg = {
+		.addr  = client->addr,
+		.flags = client->flags,
+		.len   = ARRAY_SIZE(buf),
+		.buf   = buf
+	};
+
+	err = i2c_transfer(client->adapter, &msg, 1);
+	if (err < 0)
+		return err;
+
+	if (err != 1)
+		return -ENOMSG;
+
+	return 0;
+}
+
+static int _zpa_read_i2c_byte(const struct i2c_client *client, u8 address)
+{
+	int            err;
+	u8             byte;
+	struct i2c_msg msg[] = {
+		[0] = {
+			.addr  = client->addr,
+			.flags = client->flags,
+			.len   = 1,
+			.buf   = &address
+		},
+		[1] = {
+			.addr  = client->addr,
+			.flags = client->flags | I2C_M_RD,
+			.len   = 1,
+			.buf   = &byte
+		}
+	};
+
+	err = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (err < 0)
+		return err;
+
+	if (err != ARRAY_SIZE(msg))
+		return -ENOMSG;
+
+	return (int)byte;
+}
+
+static int zpa_read_i2c_byte(const struct iio_dev *indio_dev, u8 address)
+{
+	return _zpa_read_i2c_byte(zpa_iio2client(indio_dev), address);
+}
+
+static int zpa_read_i2c_block(const struct iio_dev *indio_dev,
+			      u8                    address,
+			      u8                    length,
+			      u8                   *value)
+{
+	int                      err;
+	const struct i2c_client *client = zpa_iio2client(indio_dev);
+	struct i2c_msg           msg[] = {
+		[0] = {
+			.addr  = client->addr,
+			.flags = client->flags,
+			.len   = 1,
+			.buf   = &address,
+		},
+		[1] = {
+			.addr  = client->addr,
+			.flags = client->flags | I2C_M_RD,
+			.len   = length,
+			.buf   = value
+		}
+	};
+
+	/* Set MSB to request register address auto increment. */
+	address |= (1U << 7);
+
+	err = i2c_transfer(client->adapter, msg, ARRAY_SIZE(msg));
+	if (err < 0)
+		return err;
+
+	if (err != ARRAY_SIZE(msg))
+		return -ENOMSG;
+
+	return 0;
+}
+
+static const struct zpa_bus zpa_i2c_bus = {
+	.zpa_read_byte  = &zpa_read_i2c_byte,
+	.zpa_write_byte = &zpa_write_i2c_byte,
+	.zpa_read_block = &zpa_read_i2c_block,
+};
+
+static int zpa_probe_i2c(struct i2c_client          *client,
+			 const struct i2c_device_id *id)
+{
+	int err;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	/*
+	 * Read identification register to check we are talking to the right
+	 * slave.
+	 */
+	err = _zpa_read_i2c_byte(client, ZPA_DEVICE_ID_REG);
+	if (err < 0)
+		return err;
+
+	/* Identification register bit 1 mirrors device address bit 0. */
+#define ZPA_SA0(_addr)          (_addr & BIT(0))
+#define ZPA_DEVICE_ID_SA0_SHIFT (1)
+	if (err != (ZPA_DEVICE_ID |
+		    (ZPA_SA0(client->addr) << ZPA_DEVICE_ID_SA0_SHIFT))) {
+		dev_err(&client->dev,
+			"found unexpected device with id %02x", err);
+		return -ENODEV;
+	}
+
+	return zpa_probe(&client->dev, id->name, client->irq, &zpa_i2c_bus);
+}
+
+static int zpa_remove_i2c(struct i2c_client *client)
+{
+	return zpa_remove(&client->dev);
+}
+
+static const struct i2c_device_id zpa_i2c_ids[] = {
+	{ "zpa2326", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(i2c, zpa_i2c_ids);
+
+#if defined(CONFIG_OF)
+static const struct of_device_id zpa_i2c_matches[] = {
+	{ .compatible = "murata,zpa2326" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, zpa_i2c_matches);
+#endif
+
+static struct i2c_driver zpa_i2c_driver = {
+	.driver = {
+		.name           = "zpa2326-i2c",
+		.of_match_table = of_match_ptr(zpa_i2c_matches),
+		.pm             = ZPA_PM_OPS,
+	},
+	.probe    = zpa_probe_i2c,
+	.remove   = zpa_remove_i2c,
+	.id_table = zpa_i2c_ids,
+};
+module_i2c_driver(zpa_i2c_driver);
+
+MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
+MODULE_DESCRIPTION("I2C driver for Murata ZPA2326 pressure sensor");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/pressure/zpa2326_spi.c b/drivers/iio/pressure/zpa2326_spi.c
new file mode 100644
index 0000000..a86e3b9
--- /dev/null
+++ b/drivers/iio/pressure/zpa2326_spi.c
@@ -0,0 +1,184 @@
+/*
+ * Murata ZPA2326 SPI pressure and temperature sensor driver
+ *
+ * Copyright (c) 2016 Parrot S.A.
+ *
+ * Author: Gregor Boirie <gregor.boirie@parrot.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+#include <linux/of_device.h>
+#include "zpa2326.h"
+
+/* Address bit 7 must be set to request a register read operation. */
+#define ZPA_SPI_ADDR_RD       BIT(7)
+/* Address bit 6 must be set to request register address auto increment. */
+#define ZPA_SPI_ADDR_AUTO_INC BIT(6)
+
+static struct spi_device *zpa_iio2spidev(const struct iio_dev *indio_dev)
+{
+	return to_spi_device(zpa_iio2slave(indio_dev));
+}
+
+static int zpa_write_spi_byte(const struct iio_dev *indio_dev,
+			      u8                    address,
+			      u8                    value)
+{
+	struct spi_transfer xfer;
+	u8                  buf[] = { address, value };
+
+	/* Zero-initialize to ensure forward compatibility. */
+	memset(&xfer, 0, sizeof(xfer));
+
+	/*
+	 * Register address write cycle followed by register content write
+	 * cycle.
+	 */
+	xfer.tx_buf = buf;
+	xfer.len = sizeof(buf);
+
+	return spi_sync_transfer(zpa_iio2spidev(indio_dev), &xfer, 1);
+}
+
+static int _zpa_read_spi_byte(struct spi_device *slave, u8 address)
+{
+	struct spi_transfer xfer[2];
+	u8                  buf;
+	int                 err;
+
+	/* Request read cycle. */
+	address |= ZPA_SPI_ADDR_RD;
+
+	/* Zero-initialize to ensure forward compatibility. */
+	memset(xfer, 0, sizeof(xfer));
+
+	/* Register address write cycle. */
+	xfer[0].tx_buf = &address;
+	xfer[0].len = sizeof(address);
+
+	/* Register content read cycle. */
+	xfer[1].rx_buf = &buf;
+	xfer[1].len = sizeof(buf);
+
+	err = spi_sync_transfer(slave, xfer, ARRAY_SIZE(xfer));
+	if (err)
+		return err;
+
+	return buf;
+}
+
+static int zpa_read_spi_byte(const struct iio_dev *indio_dev, u8 address)
+{
+	return _zpa_read_spi_byte(zpa_iio2spidev(indio_dev), address);
+}
+
+static int zpa_read_spi_block(const struct iio_dev *indio_dev,
+			      u8                    address,
+			      u8                    length,
+			      u8                   *value)
+{
+	struct spi_transfer xfer[2];
+
+	/* Request read cycle with register address auto increment. */
+	address |= ZPA_SPI_ADDR_RD | ZPA_SPI_ADDR_AUTO_INC;
+
+	/* Zero-initialize to ensure forward compatibility. */
+	memset(xfer, 0, sizeof(xfer));
+
+	/* First register address write cycle. */
+	xfer[0].tx_buf = &address;
+	xfer[0].len = sizeof(address);
+
+	/* Registers content read cycle (auto-increment). */
+	xfer[1].rx_buf = value;
+	xfer[1].len = length;
+
+	return spi_sync_transfer(zpa_iio2spidev(indio_dev), xfer,
+				 ARRAY_SIZE(xfer));
+}
+
+static const struct zpa_bus zpa_spi_bus = {
+	.zpa_read_byte  = &zpa_read_spi_byte,
+	.zpa_write_byte = &zpa_write_spi_byte,
+	.zpa_read_block = &zpa_read_spi_block,
+};
+
+static int zpa_probe_spi(struct spi_device *slave)
+{
+	int err;
+
+	/*
+	 * Enforce SPI slave settings to prevent from DT misconfiguration.
+	 *
+	 * Clock is idle high. Sampling happens on trailing edge, i.e., rising
+	 * edge. Maximum bus frequency is 1 mHz. Registers are 8 bits wide.
+	 */
+	slave->mode = SPI_MODE_3;
+	slave->max_speed_hz = min(slave->max_speed_hz, 1000U * 1000U);
+	slave->bits_per_word = 8;
+	err = spi_setup(slave);
+	if (err < 0)
+		return err;
+
+	/*
+	 * Read identification register to check we are talking to the right
+	 * slave.
+	 */
+	err = _zpa_read_spi_byte(slave, ZPA_DEVICE_ID_REG);
+	if (err < 0)
+		return err;
+
+	if (err != ZPA_DEVICE_ID) {
+		dev_err(&slave->dev,
+			"found unexpected device with id %02x", err);
+		return -ENODEV;
+	}
+
+	return zpa_probe(&slave->dev, spi_get_device_id(slave)->name,
+			 slave->irq, &zpa_spi_bus);
+}
+
+static int zpa_remove_spi(struct spi_device *slave)
+{
+	return zpa_remove(&slave->dev);
+}
+
+static const struct spi_device_id zpa_spi_ids[] = {
+	{ "zpa2326", 0 },
+	{ },
+};
+MODULE_DEVICE_TABLE(spi, zpa_spi_ids);
+
+#if defined(CONFIG_OF)
+static const struct of_device_id zpa_spi_matches[] = {
+	{ .compatible = "murata,zpa2326" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, zpa_spi_matches);
+#endif
+
+static struct spi_driver zpa_spi_driver = {
+	.driver = {
+		.name           = "zpa2326-spi",
+		.of_match_table = of_match_ptr(zpa_spi_matches),
+		.pm             = ZPA_PM_OPS,
+	},
+	.probe    = zpa_probe_spi,
+	.remove   = zpa_remove_spi,
+	.id_table = zpa_spi_ids,
+};
+module_spi_driver(zpa_spi_driver);
+
+MODULE_AUTHOR("Gregor Boirie <gregor.boirie@parrot.com>");
+MODULE_DESCRIPTION("SPI driver for Murata ZPA2326 pressure sensor");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4

