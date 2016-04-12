Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	devicetree@vger.kernel.org,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH 4/4 v4] iio: st_sensors: support open drain mode
Date: Tue, 12 Apr 2016 15:01:19 +0200
Message-Id: <1460466079-15392-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

Some types of ST Sensors can be connected to the same IRQ line
as other peripherals using open drain. Add a device tree binding
and a sensor data property to flip the right bit in the interrupt
control register to enable open drain mode on the INT line.

If the line is set to be open drain, also tag on IRQF_SHARED
to the IRQ flags when requesting the interrupt, as the whole
point of using open drain interrupt lines is to share them with
more than one peripheral (wire-or).

Cc: devicetree@vger.kernel.org
Cc: Giuseppe Barba <giuseppe.barba@st.com>
Cc: Denis Ciocca <denis.ciocca@st.com>
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v3->v4:
- Rename DT bool property st,int-pin-open-drain to int-pin-open-drain
- Rob Herring ACKed st,int-pin-open-drain but not including his ACK
  on this even though it's close
ChangeLog v2->v3:
- Rebase on top of the patches fixing the other issues (handling
  IRQ status check and channel reading bug).
ChangeLog v1->v2:
- Rebased to fit the new patch order.
---
 Documentation/devicetree/bindings/iio/st-sensors.txt |  3 +++
 drivers/iio/accel/st_accel_core.c                    |  8 ++++++++
 drivers/iio/common/st_sensors/st_sensors_core.c      | 20 ++++++++++++++++++++
 drivers/iio/common/st_sensors/st_sensors_trigger.c   | 13 +++++++++++++
 drivers/iio/pressure/st_pressure_core.c              |  8 ++++++++
 include/linux/iio/common/st_sensors.h                |  6 ++++++
 include/linux/platform_data/st_sensors_pdata.h       |  2 ++
 7 files changed, 60 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st-sensors.txt b/Documentation/devicetree/bindings/iio/st-sensors.txt
index d4b87cc1e446..11a4fde6e370 100644
--- a/Documentation/devicetree/bindings/iio/st-sensors.txt
+++ b/Documentation/devicetree/bindings/iio/st-sensors.txt
@@ -16,6 +16,9 @@ Optional properties:
 - st,drdy-int-pin: the pin on the package that will be used to signal
   "data ready" (valid values: 1 or 2). This property is not configurable
   on all sensors.
+- int-pin-open-drain: the interrupt/data ready line will be configured
+  as open drain, which is useful if several sensors share the same
+  interrupt line.
 
 Sensors may also have applicable pin control settings, those use the
 standard bindings from pinctrl/pinctrl-bindings.txt.
diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 4df4c278af23..f06f4329db5b 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -96,6 +96,8 @@
 #define ST_ACCEL_2_DRDY_IRQ_INT2_MASK		0x10
 #define ST_ACCEL_2_IHL_IRQ_ADDR			0x22
 #define ST_ACCEL_2_IHL_IRQ_MASK			0x80
+#define ST_ACCEL_2_OD_IRQ_ADDR			0x22
+#define ST_ACCEL_2_OD_IRQ_MASK			0x40
 #define ST_ACCEL_2_MULTIREAD_BIT		true
 
 /* CUSTOM VALUES FOR SENSOR 3 */
@@ -177,6 +179,8 @@
 #define ST_ACCEL_5_DRDY_IRQ_INT2_MASK		0x20
 #define ST_ACCEL_5_IHL_IRQ_ADDR			0x22
 #define ST_ACCEL_5_IHL_IRQ_MASK			0x80
+#define ST_ACCEL_5_OD_IRQ_ADDR			0x22
+#define ST_ACCEL_5_OD_IRQ_MASK			0x40
 #define ST_ACCEL_5_IG1_EN_ADDR			0x21
 #define ST_ACCEL_5_IG1_EN_MASK			0x08
 #define ST_ACCEL_5_MULTIREAD_BIT		false
@@ -368,6 +372,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_int2 = ST_ACCEL_2_DRDY_IRQ_INT2_MASK,
 			.addr_ihl = ST_ACCEL_2_IHL_IRQ_ADDR,
 			.mask_ihl = ST_ACCEL_2_IHL_IRQ_MASK,
+			.addr_od = ST_ACCEL_2_OD_IRQ_ADDR,
+			.mask_od = ST_ACCEL_2_OD_IRQ_MASK,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.multi_read_bit = ST_ACCEL_2_MULTIREAD_BIT,
@@ -557,6 +563,8 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 			.mask_int2 = ST_ACCEL_5_DRDY_IRQ_INT2_MASK,
 			.addr_ihl = ST_ACCEL_5_IHL_IRQ_ADDR,
 			.mask_ihl = ST_ACCEL_5_IHL_IRQ_MASK,
+			.addr_od = ST_ACCEL_5_OD_IRQ_ADDR,
+			.mask_od = ST_ACCEL_5_OD_IRQ_MASK,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.multi_read_bit = ST_ACCEL_5_MULTIREAD_BIT,
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index f5a2d445d0c0..a61eb8ab41b0 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -301,6 +301,14 @@ static int st_sensors_set_drdy_int_pin(struct iio_dev *indio_dev,
 		return -EINVAL;
 	}
 
+	if (pdata->open_drain) {
+		if (!sdata->sensor_settings->drdy_irq.addr_od)
+			dev_err(&indio_dev->dev,
+				"open drain requested but unsupported.\n");
+		else
+			sdata->int_pin_open_drain = true;
+	}
+
 	return 0;
 }
 
@@ -321,6 +329,8 @@ static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
 	else
 		pdata->drdy_int_pin = defdata ? defdata->drdy_int_pin : 0;
 
+	pdata->open_drain = of_property_read_bool(np, "int-pin-open-drain");
+
 	return pdata;
 }
 #else
@@ -374,6 +384,16 @@ int st_sensors_init_sensor(struct iio_dev *indio_dev,
 			return err;
 	}
 
+	if (sdata->int_pin_open_drain) {
+		dev_info(&indio_dev->dev,
+			 "set interrupt line to open drain mode\n");
+		err = st_sensors_write_data_with_mask(indio_dev,
+				sdata->sensor_settings->drdy_irq.addr_od,
+				sdata->sensor_settings->drdy_irq.mask_od, 1);
+		if (err < 0)
+			return err;
+	}
+
 	err = st_sensors_set_axis_enable(indio_dev, ST_SENSORS_ENABLE_ALL_AXIS);
 
 	return err;
diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index 6a8c98327945..da72279fcf99 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -64,6 +64,19 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
 			"rising edge\n", irq_trig);
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
+
+	/*
+	 * If the interrupt pin is Open Drain, by definition this
+	 * means that the interrupt line may be shared with other
+	 * peripherals. But to do this we also need to have a status
+	 * register and mask to figure out if this sensor was firing
+	 * the IRQ or not, so we can tell the interrupt handle that
+	 * it was "our" interrupt.
+	 */
+	if (sdata->int_pin_open_drain &&
+	    sdata->sensor_settings->drdy_irq.addr_stat_drdy)
+		irq_trig |= IRQF_SHARED;
+
 	err = request_threaded_irq(irq,
 			iio_trigger_generic_data_rdy_poll,
 			NULL,
diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index 1cd37eaa4a57..9e9b72a8f18f 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -64,6 +64,8 @@
 #define ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK	0x20
 #define ST_PRESS_LPS331AP_IHL_IRQ_ADDR		0x22
 #define ST_PRESS_LPS331AP_IHL_IRQ_MASK		0x80
+#define ST_PRESS_LPS331AP_OD_IRQ_ADDR		0x22
+#define ST_PRESS_LPS331AP_OD_IRQ_MASK		0x40
 #define ST_PRESS_LPS331AP_MULTIREAD_BIT		true
 #define ST_PRESS_LPS331AP_TEMP_OFFSET		42500
 
@@ -104,6 +106,8 @@
 #define ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK	0x10
 #define ST_PRESS_LPS25H_IHL_IRQ_ADDR		0x22
 #define ST_PRESS_LPS25H_IHL_IRQ_MASK		0x80
+#define ST_PRESS_LPS25H_OD_IRQ_ADDR		0x22
+#define ST_PRESS_LPS25H_OD_IRQ_MASK		0x40
 #define ST_PRESS_LPS25H_MULTIREAD_BIT		true
 #define ST_PRESS_LPS25H_TEMP_OFFSET		42500
 #define ST_PRESS_LPS25H_OUT_XL_ADDR		0x28
@@ -226,6 +230,8 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.mask_int2 = ST_PRESS_LPS331AP_DRDY_IRQ_INT2_MASK,
 			.addr_ihl = ST_PRESS_LPS331AP_IHL_IRQ_ADDR,
 			.mask_ihl = ST_PRESS_LPS331AP_IHL_IRQ_MASK,
+			.addr_od = ST_PRESS_LPS331AP_OD_IRQ_ADDR,
+			.mask_od = ST_PRESS_LPS331AP_OD_IRQ_MASK,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.multi_read_bit = ST_PRESS_LPS331AP_MULTIREAD_BIT,
@@ -313,6 +319,8 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.mask_int2 = ST_PRESS_LPS25H_DRDY_IRQ_INT2_MASK,
 			.addr_ihl = ST_PRESS_LPS25H_IHL_IRQ_ADDR,
 			.mask_ihl = ST_PRESS_LPS25H_IHL_IRQ_MASK,
+			.addr_od = ST_PRESS_LPS25H_OD_IRQ_ADDR,
+			.mask_od = ST_PRESS_LPS25H_OD_IRQ_MASK,
 			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
 		},
 		.multi_read_bit = ST_PRESS_LPS25H_MULTIREAD_BIT,
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index d8da075bfda0..d029ffac0d69 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -122,6 +122,8 @@ struct st_sensor_bdu {
  * @mask_int2: mask to enable/disable IRQ on INT2 pin.
  * @addr_ihl: address to enable/disable active low on the INT lines.
  * @mask_ihl: mask to enable/disable active low on the INT lines.
+ * @addr_od: address to enable/disable Open Drain on the INT lines.
+ * @mask_od: mask to enable/disable Open Drain on the INT lines.
  * @addr_stat_drdy: address to read status of DRDY (data ready) interrupt
  * struct ig1 - represents the Interrupt Generator 1 of sensors.
  * @en_addr: address of the enable ig1 register.
@@ -133,6 +135,8 @@ struct st_sensor_data_ready_irq {
 	u8 mask_int2;
 	u8 addr_ihl;
 	u8 mask_ihl;
+	u8 addr_od;
+	u8 mask_od;
 	u8 addr_stat_drdy;
 	struct {
 		u8 en_addr;
@@ -215,6 +219,7 @@ struct st_sensor_settings {
  * @odr: Output data rate of the sensor [Hz].
  * num_data_channels: Number of data channels used in buffer.
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
+ * @int_pin_open_drain: Set the interrupt/DRDY to open drain.
  * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
  * @tf: Transfer function structure used by I/O operations.
  * @tb: Transfer buffers and mutex used by I/O operations.
@@ -236,6 +241,7 @@ struct st_sensor_data {
 	unsigned int num_data_channels;
 
 	u8 drdy_int_pin;
+	bool int_pin_open_drain;
 
 	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
 
diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
index 753839187ba0..79b0e4cdb814 100644
--- a/include/linux/platform_data/st_sensors_pdata.h
+++ b/include/linux/platform_data/st_sensors_pdata.h
@@ -16,9 +16,11 @@
  * @drdy_int_pin: Redirect DRDY on pin 1 (1) or pin 2 (2).
  *	Available only for accelerometer and pressure sensors.
  *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
+ * @open_drain: set the interrupt line to be open drain if possible.
  */
 struct st_sensors_platform_data {
 	u8 drdy_int_pin;
+	bool open_drain;
 };
 
 #endif /* ST_SENSORS_PDATA_H */
-- 
2.4.3
