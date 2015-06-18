Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:31069 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753768AbbFRLpp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 18 Jun 2015 07:45:45 -0400
From: Cristina Ciocan <cristina.ciocan@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	Cristina Ciocan <cristina.ciocan@intel.com>
Subject: [PATCH v3 1/1] iio:light: Avago APDS9930 ALS and proximity sensor
Date: Thu, 18 Jun 2015 14:44:22 +0300
Message-Id: <1434627862-30908-2-git-send-email-cristina.ciocan@intel.com>
In-Reply-To: <1434627862-30908-1-git-send-email-cristina.ciocan@intel.com>
References: <1434627862-30908-1-git-send-email-cristina.ciocan@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added IIO driver for Avago's APDS9930 ALS and proximity sensor on top of
APDS9300, which offers ALS suuport.

It offers ACPI/DT support, irq and event handling, raw readings for both
ALS and proximity.

Datasheet for this device can be found at:
	http://www.avagotech.com/docs/AV02-3190EN

Signed-off-by: Cristina Ciocan <cristina.ciocan@intel.com>
---
 drivers/iio/light/apds9300.c | 1361 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 1248 insertions(+), 113 deletions(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 9ddde0c..68f8c78 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -1,7 +1,9 @@
 /*
- * apds9300.c - IIO driver for Avago APDS9300 ambient light sensor
+ * apds9300.c - IIO driver for Avago APDS9300 ambient light sensor and APDS9930
+ * ambient light and proximity sensor
  *
  * Copyright 2013 Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
+ * Copyright 2015 Intel
  *
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License.  See the file COPYING in the main
@@ -15,23 +17,45 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/interrupt.h>
+#include <linux/acpi.h>
+#include <linux/delay.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/events.h>

-#define APDS9300_DRV_NAME "apds9300"
-#define APDS9300_IRQ_NAME "apds9300_event"
+#include <linux/gpio/consumer.h>
+
+enum {
+	APDS9300_ID,
+	APDS9930_ID,
+};
+
+#define APDS9300_DRV_NAME	"apds9300"
+#define APDS9300_IRQ_NAME	"apds9300_event"
+#define APDS9300_GPIO_NAME	"apds9300_gpio"
+
+#define APDS9930_INIT_SLEEP	5 /* sleep for 5 ms before issuing commands */

 /* Command register bits */
 #define APDS9300_CMD	BIT(7) /* Select command register. Must write as 1 */
 #define APDS9300_WORD	BIT(5) /* I2C write/read: if 1 word, if 0 byte */
 #define APDS9300_CLEAR	BIT(6) /* Interrupt clear. Clears pending interrupt */

-/* Register set */
+/*
+ * Generic naming for the register that has the power on/off bits. Both APDS9300
+ * and APDS9930 are powered on/off by setting bits at address 0x0, but the
+ * registers are in naming and other bits meaning, thus set a generic naming for
+ * power purposes.
+ */
+#define APDS9300_POWER_ADDR	0x00
+
+/* Register set for APDS9300 */
 #define APDS9300_CONTROL	0x00 /* Control of basic functions */
 #define APDS9300_THRESHLOWLOW	0x02 /* Low byte of low interrupt threshold */
 #define APDS9300_THRESHHIGHLOW	0x04 /* Low byte of high interrupt threshold */
 #define APDS9300_INTERRUPT	0x06 /* Interrupt control */
+#define APDS9300_ID_REG		0x0a /* Part number */
 #define APDS9300_DATA0LOW	0x0c /* Low byte of ADC channel 0 */
 #define APDS9300_DATA1LOW	0x0e /* Low byte of ADC channel 1 */

@@ -39,20 +63,260 @@
 #define APDS9300_POWER_ON	0x03
 #define APDS9300_POWER_OFF	0x00

-/* Interrupts */
+/* Interrupt settings for APDS9300 */
 #define APDS9300_INTR_ENABLE	0x10
-/* Interrupt Persist Function: Any value outside of threshold range */
+/*
+ * Interrupt Persist Function for APDS9300 : Any value outside of threshold
+ * range
+ */
 #define APDS9300_THRESH_INTR	0x01

 #define APDS9300_THRESH_MAX	0xffff /* Max threshold value */

+/* Register set for APDS9930 (rw = read/write, r = read, w = write) */
+#define APDS9930_ENABLE_REG	0x00	/* rw-Enable of states and interrupts */
+#define APDS9930_ATIME_REG	0x01	/* rw-ALS ADC time*/
+#define APDS9930_PTIME_REG	0x02	/* rw-Proximity ADC time */
+#define APDS9930_WTIME_REG	0x03	/* rw-Wait time */
+#define APDS9930_AILTL_REG	0x04	/*
+					 * rw-ALS interrupt low threshold low
+					 * byte
+					 */
+#define APDS9930_AIHTL_REG	0x06	/*
+					 * rw-ALS interrupt high threshold low
+					 * byte
+					 */
+#define APDS9930_PILTL_REG	0x08	/*
+					 * rw-Proximity interrupt low threshold
+					 * low byte
+					 */
+#define APDS9930_PIHTL_REG	0x0A	/*
+					 * rw-Proximity interrupt high threshold
+					 * low byte
+					 */
+#define APDS9930_PERS_REG	0x0C	/* rw-Interrupt persistence filters */
+#define APDS9930_CONFIG_REG	0x0D	/* rw-Configuration */
+#define APDS9930_PPULSE_REG	0x0E	/* rw-Proximity pulse control */
+#define APDS9930_CONTROL_REG	0x0F	/* rw-Gain control register */
+#define APDS9930_ID_REG		0x12	/* r-Device ID */
+#define APDS9930_STATUS_REG	0x13	/* r-Device status */
+#define APDS9930_DATA0LOW	0x14	/* r-Ch0 ADC low data register */
+#define APDS9930_CDATAH_REG	0x15	/* r-Ch0 ADC high data register */
+#define APDS9930_DATA1LOW	0x16	/* r-Ch1 ADC low data register */
+#define APDS9930_IRDATAH_REG	0x17	/* r-Ch1 ADC high data register */
+#define APDS9930_PDATAL_REG	0x18	/* r-Proximity ADC low data register */
+#define APDS9930_POFFSET_REG	0x1E	/* rw-Proximity offset register */
+
+/* Useful bits per register for APDS9930 */
+
+/* Command register */
+#define APDS9930_CMD_TYPE_SPECIAL_FUNC	GENMASK(6, 5)	/* Special function */
+#define APDS9930_CMD_TYPE_PS		0x5	/* Proximity interrupt clear */
+#define APDS9930_CMD_TYPE_ALS		0x6	/* ALS interrupt clear */
+#define APDS9930_CMD_TYPE_BOTH		0x7	/* Both interrupt clear */
+
+/* Enable register for APDS9930 */
+#define APDS9930_SAI	BIT(6)	/* Sleep after interrupt */
+#define APDS9930_PIEN	BIT(5)	/* Proximity interrupt enable */
+#define APDS9930_AIEN	BIT(4)	/* ALS interrupt enable */
+#define APDS9930_WEN	BIT(3)	/* Wait enable */
+#define APDS9930_PEN	BIT(2)	/* Proximity enable */
+#define APDS9930_AEN	BIT(1)	/* ALS enable */
+#define APDS9930_PON	BIT(0)	/* Power ON */
+
+/* Persistence register for APDS9930 */
+#define APDS9930_PPERS_SHIFT	4	/* Proximity interrupt persistence */
+#define APDS9930_APERS_SHIFT	0	/* Interrupt persistence */
+
+/* Configuration register for APDS9930 */
+#define APDS9930_AGL_SHIFT	2	/* ALS gain level */
+#define APDS9930_WLONG_SHIFT	1	/* Wait long */
+#define APDS9930_PDL_SHIFT	0	/* Proximity drive level */
+
+/* Control register for APDS9930 */
+#define APDS9930_PDRIVE_SHIFT	6	/* LED drive strength */
+#define APDS9930_PDIODE_SHIFT	4	/* Proximity diode select */
+#define APDS9930_PGAIN_SHIFT	2	/* Proximity gain control */
+#define APDS9930_AGAIN_SHIFT	0	/* ALS gain control */
+
+/* Device ID - possible values for APDS9930 */
+#define APDS9930_DEVICE_ID	0x39
+
+/* Status register for APDS9930 */
+#define APDS9930_PSAT	BIT(6)	/* Proximity saturation */
+#define APDS9930_PINT	BIT(5)	/* Proximity interrupt */
+#define APDS9930_AINT	BIT(4)	/* ALS interrupt */
+#define APDS9930_PVALID	BIT(1)	/* PS valid */
+#define APDS9930_AVALID	BIT(0)	/* ALS valid */
+
+/* APDS9930 enabling and disabling register values */
+#define APDS9930_DISABLE_ALL	0	/* Disable and powerdown */
+#define APDS9930_ENABLE_ALL	0x37	/* Set all ALS & PS bits and power on */
+
+/* Default values for registers content for APDS9930 */
+#define APDS9930_DEF_ATIME	0xdb	/*
+					 * 50 ms - ALSIT value in order to
+					 * reject 50/60 Hz ripple; if higher
+					 * resolution is needed, increase ALSIT
+					 * with mutiples of 50
+					 */
+#define APDS9930_DEF_PTIME	0xff	/* 2.7 ms - min prox integration time */
+#define APDS9930_DEF_WTIME	0xff	/* 2.7 ms - min wait time */
+#define APDS9930_DEF_PPULSE	8	/* Min prox pulse count */
+#define APDS9930_DEF_PDRIVE	0	/* 100 mA of LED power */
+#define APDS9930_DEF_PDIODE	2	/* Ch1 diode (shifted value) */
+#define APDS9930_DEF_PGAIN	2	/* 4 x proximity gain */
+#define APDS9930_DEF_AGAIN	2	/* 16 x ALS gain */
+#define APDS9930_DEF_WEN	8	/* Enable wait */
+#define APDS9930_DEF_PEN	4	/* Enable proximity */
+#define APDS9930_DEF_AEN	2	/* Enable ALS */
+#define APDS9930_DEF_PON	1	/* Power ON */
+#define APDS9930_DEF_APERS	3	/*
+					 * Consecutive exceeding threshold
+					 * cycles to trigger ALS interrupt
+					 */
+#define APDS9930_DEF_PPERS	3	/*
+					 * Consecutive PS execeeding threshold
+					 * cycles to trigger PS interrupt
+					 */
+
+/*
+ * Interrupt threshold defaults - setting low to maximum will trigger a first
+ * interrupt to allow us to read the data registers status and properly set a
+ * threshold value to match the current environment.
+ *
+ * The default high threshold is set only for consistency, since the registers
+ * are checked against in order: first if the value of CDATA/PDATA is above LOW;
+ * if so, trigger interrupt and do not check the HIGH threshold.
+ */
+#define APDS9930_DEF_ALS_THRESH_LOW	0xffff
+#define APDS9930_DEF_ALS_THRESH_HIGH	0x0
+#define APDS9930_DEF_PS_THRESH_LOW	1023
+#define APDS9930_DEF_PS_THRESH_HIGH	0
+
+#define APDS9930_MIN_PS_THRESH		0	/* No object near the sensor */
+#define APDS9930_MAX_PS_THRESH		1023	/* Object in close proximity */
+#define APDS9930_DETECTION_PS_THRESH	600	/* Object detected near-by */
+
+/* Default, open air, coefficients (for Lux computation) */
+#define APDS9930_DEF_DF			52	/* Device factor */
+/*
+ * Material-depending coefficients (set to open air values). They are scaled for
+ * computation purposes by 100 (as stored in APDS9930_COEF_SCALE).
+ */
+#define APDS9930_DEF_LUX_DIVISION_SCALE	10000
+#define APDS9930_DEF_GA			49
+#define APDS9930_DEF_B			186
+#define APDS9930_DEF_C			74
+#define APDS9930_DEF_D			129
+#define APDS9930_COEF_SCALE		100
+
+/* Possible ALS gain values (with AGL cleared) */
+static const int apds9930_again_values[] = {1, 8, 16, 120};
+#define APDS9930_MAX_AGAIN_INDEX	3
+#define APDS9930_AGL_DIVISION_SCALE	6
+
+/*
+ * Percentages from the maximum CH0 value that indicate the recorded CH0 data is
+ * too low or too high - for AGAIN adapting purposes.
+ */
+#define APDS9930_CH0_HIGH_PERCENTAGE	90
+#define APDS9930_CH0_LOW_PERCENTAGE	10
+
+/*
+ * With how much (in percentages) must the CH0 value differ from one step to
+ * another in order to consider a significant change in light.
+ */
+#define APDS9930_ALS_HYSTERESIS		20
+
+/* DT or ACPI device properties names */
+#define APDS9930_GA_PROP	"avago,ga"
+#define APDS9930_COEF_B_PROP	"avago,coeff-B"
+#define APDS9930_COEF_C_PROP	"avago,coeff-C"
+#define APDS9930_COEF_D_PROP	"avago,coeff-D"
+#define APDS9930_DF_PROP	"avago,df"
+#define APDS9930_AGAIN_PROP	"avago,als-gain"
+#define APDS9930_ATIME_PROP	"avago,atime"
+#define APDS9930_PDRIVE_PROP	"avago,pdrive"
+#define APDS9930_PPULSE_PROP	"avago,ppcount"
+
+struct apds9930_coefficients {
+	/*
+	 * GA, B, C and D coefficients are scaled by 100 for computational
+	 * purposes
+	 */
+	int ga;
+	/*
+	 * This is 1, but needs to be set to a scaled value, thus if
+	 * we decide to change the scale, this coefficient must also
+	 * be changed.
+	 */
+	int coef_a;
+	int coef_b;
+	int coef_c;
+	int coef_d;
+	int df;
+};
+
+struct apds9930_platform_data {
+	/* Glass-influenced factors */
+	struct apds9930_coefficients coefs;
+
+	/* ALS platform data */
+	u8 again;	/* AGAIN value (index in apds9930_again_values[]) */
+	u8 atime;	/* ALS integration time */
+
+	/* Proximity platform data */
+	u8 pdrive;
+	u8 ppulse;
+};
+
+struct apds9300_threshold {
+	u16 low;
+	u16 high;
+};
+
+struct apds9930_data {
+	u8	alsit;
+	u16	ch0_max;
+	bool	agl_enabled;
+	bool	ps_enabled;
+	bool	ps_intr_enabled;
+	struct apds9300_threshold ps_thresh;
+};
+
+enum apds9300_intr {
+	ALS_INTR,
+	PS_INTR,
+};
+
 struct apds9300_data {
 	struct i2c_client *client;
+
+	/* Protect access to device data */
 	struct mutex mutex;
-	int power_state;
-	int thresh_low;
-	int thresh_hi;
-	int intr_en;
+
+	bool	power_state;
+	bool	als_enabled;
+	bool	als_intr_enabled;
+	struct apds9300_threshold als_thresh;
+
+	/* Register set */
+	u8	ch0_low_reg;
+	u8	ch1_low_reg;
+	u8	power_on_value;
+
+	/* Function pointers set */
+	unsigned long	(*calculate_lux)(struct apds9300_data *data,
+					 u16 ch0, u16 ch1);
+	int		(*set_intr_state)(struct apds9300_data *data,
+					  enum apds9300_intr intr,
+					  int state);
+	irq_handler_t	irq_handler;
+
+	/* APDS9930 platform and chip specific specific data */
+	struct apds9930_platform_data	*platform_data;
+	struct apds9930_data		*aux_data;
 };

 /* Lux calculation */
@@ -65,7 +329,9 @@ static const u16 apds9300_lux_ratio[] = {
 	347, 358, 368, 379, 390, 400,
 };

-static unsigned long apds9300_calculate_lux(u16 ch0, u16 ch1)
+static unsigned long apds9300_calculate_lux(
+			__attribute__((unused)) struct apds9300_data *data,
+			u16 ch0, u16 ch1)
 {
 	unsigned long lux, tmp;

@@ -90,6 +356,86 @@ static unsigned long apds9300_calculate_lux(u16 ch0, u16 ch1)
 	return lux / 100000;
 }

+/* Computes the ALS gain value for the next step and updates the current one */
+static void apds9930_update_als_gain(struct apds9300_data *data, u16 ch0)
+{
+	int current_index, next_index, err;
+	struct apds9930_data *apds9930 = data->aux_data;
+
+	/* Compute the value for the next measurement */
+	current_index	= data->platform_data->again;
+	next_index	= data->platform_data->again;
+
+	/* CH0 data too high, try to lower the ALS gain if possible */
+	if (ch0 >= (apds9930->ch0_max * APDS9930_CH0_HIGH_PERCENTAGE) / 100) {
+		if (next_index == 0 && !(apds9930->agl_enabled)) {
+			err = i2c_smbus_write_byte_data(
+					data->client,
+					APDS9300_CMD | APDS9930_CONFIG_REG,
+					1 << APDS9930_AGL_SHIFT);
+			if (!err)
+				apds9930->agl_enabled = true;
+		} else if (next_index > 0) {
+			next_index--;
+		}
+	}
+
+	/* CH0 data too low, try to increase the ALS gain if possible */
+	else if (ch0 <= (apds9930->ch0_max * APDS9930_CH0_LOW_PERCENTAGE)
+		 / 100) {
+		if (apds9930->agl_enabled) {
+			err = i2c_smbus_write_byte_data(
+					data->client,
+					APDS9300_CMD | APDS9930_CONFIG_REG,
+					0);
+			if (!err)
+				apds9930->agl_enabled = false;
+		} else if (next_index < APDS9930_MAX_AGAIN_INDEX) {
+			next_index++;
+		}
+	}
+
+	if (next_index != current_index) {
+		/* Update data's index value */
+		data->platform_data->again = next_index;
+
+		/* Update AGAIN for the next reading */
+		i2c_smbus_write_byte_data(
+			data->client,
+			APDS9300_CMD | APDS9930_CONTROL_REG,
+			data->platform_data->again << APDS9930_AGAIN_SHIFT |
+			APDS9930_DEF_PGAIN << APDS9930_PGAIN_SHIFT |
+			APDS9930_DEF_PDIODE << APDS9930_PDIODE_SHIFT |
+			data->platform_data->pdrive << APDS9930_PDRIVE_SHIFT);
+	}
+}
+
+static unsigned long apds9930_calculate_lux(struct apds9300_data *data,
+					    u16 ch0, u16 ch1)
+{
+	long int iac1, iac2, alsit_val, again_val, tmp_iac;
+	unsigned long int iac, lux;
+	struct apds9930_coefficients cf;
+
+	/* Lux equation from datasheet */
+	cf		= data->platform_data->coefs;
+	iac1		= cf.coef_a * ch0 - cf.coef_b * ch1;
+	iac2		= cf.coef_c * ch0 - cf.coef_d * ch1;
+	tmp_iac         = max(iac1, iac2);
+	iac             = (tmp_iac < 0) ? 0 : (unsigned long)tmp_iac;
+	alsit_val	= (int)(data->aux_data->alsit);
+	again_val	= apds9930_again_values[data->platform_data->again];
+	lux		= (iac * cf.ga * cf.df) /
+				(alsit_val * again_val *
+				 APDS9930_DEF_LUX_DIVISION_SCALE);
+
+	/* Update ALS gain */
+	apds9930_update_als_gain(data, ch0);
+
+	return data->aux_data->agl_enabled ?
+		(APDS9930_AGL_DIVISION_SCALE * lux) : lux;
+}
+
 static int apds9300_get_adc_val(struct apds9300_data *data, int adc_number)
 {
 	int ret;
@@ -98,8 +444,8 @@ static int apds9300_get_adc_val(struct apds9300_data *data, int adc_number)
 	if (!data->power_state)
 		return -EBUSY;

-	/* Select ADC0 or ADC1 data register */
-	flags |= adc_number ? APDS9300_DATA1LOW : APDS9300_DATA0LOW;
+	/* Select ADC0 or ADC1 ALS data register */
+	flags |= adc_number ? data->ch1_low_reg : data->ch0_low_reg;

 	ret = i2c_smbus_read_word_data(data->client, flags);
 	if (ret < 0)
@@ -125,7 +471,7 @@ static int apds9300_set_thresh_low(struct apds9300_data *data, int value)
 		dev_err(&data->client->dev, "failed to set thresh_low\n");
 		return ret;
 	}
-	data->thresh_low = value;
+	data->als_thresh.low = value;

 	return 0;
 }
@@ -146,12 +492,15 @@ static int apds9300_set_thresh_hi(struct apds9300_data *data, int value)
 		dev_err(&data->client->dev, "failed to set thresh_hi\n");
 		return ret;
 	}
-	data->thresh_hi = value;
+	data->als_thresh.high = value;

 	return 0;
 }

-static int apds9300_set_intr_state(struct apds9300_data *data, int state)
+static int apds9300_set_intr_state(
+			struct apds9300_data *data,
+			__attribute__((unused)) enum apds9300_intr intr,
+			int state)
 {
 	int ret;
 	u8 cmd;
@@ -167,27 +516,107 @@ static int apds9300_set_intr_state(struct apds9300_data *data, int state)
 			"failed to set interrupt state %d\n", state);
 		return ret;
 	}
-	data->intr_en = state;
+	data->als_intr_enabled = state;

 	return 0;
 }

+static int apds9930_set_intr_state(struct apds9300_data *data,
+				   enum apds9300_intr intr,
+				   int state)
+{
+	int ret, enable_reg;
+	struct i2c_client *client = data->client;
+
+	ret = 0;
+
+	mutex_lock(&data->mutex);
+	state = !!state;
+	switch (intr) {
+	case ALS_INTR:
+		/* Check if the interrupt isn't already in the desired state */
+		if (state == data->als_intr_enabled)
+			break;
+
+		enable_reg = i2c_smbus_read_byte_data(
+					client,
+					APDS9300_CMD | APDS9930_ENABLE_REG);
+		if (enable_reg < 0) {
+			ret = enable_reg;
+			break;
+		}
+		if (state)
+			enable_reg |= APDS9930_AIEN;	/* enable */
+		else
+			enable_reg &= ~APDS9930_AIEN;	/* disable */
+
+		ret = i2c_smbus_write_byte_data(
+					data->client,
+					APDS9300_CMD | APDS9930_ENABLE_REG,
+					enable_reg);
+		if (!ret)
+			data->als_intr_enabled = state;
+		break;
+	case PS_INTR:
+		if (!data->aux_data) {
+			ret = -EINVAL;
+			break;
+		}
+
+		/* Check if the interrupt isn't already in the desired state */
+		if (state == data->aux_data->ps_intr_enabled)
+			break;
+
+		enable_reg = i2c_smbus_read_byte_data(
+					client,
+					APDS9300_CMD | APDS9930_ENABLE_REG);
+		if (enable_reg < 0) {
+			ret = enable_reg;
+			break;
+		}
+		if (state)
+			enable_reg |= APDS9930_PIEN;	/* enable */
+		else
+			enable_reg &= ~APDS9930_PIEN;	/* disable */
+
+		ret = i2c_smbus_write_byte_data(
+					data->client,
+					APDS9300_CMD | APDS9930_ENABLE_REG,
+					enable_reg);
+		if (!ret)
+			data->aux_data->ps_intr_enabled = state;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+	mutex_unlock(&data->mutex);
+
+	return ret;
+}
+
 static int apds9300_set_power_state(struct apds9300_data *data, int state)
 {
 	int ret;
 	u8 cmd;

-	cmd = state ? APDS9300_POWER_ON : APDS9300_POWER_OFF;
+	mutex_lock(&data->mutex);
+	cmd = state ? data->power_on_value : APDS9300_POWER_OFF;
 	ret = i2c_smbus_write_byte_data(data->client,
-			APDS9300_CONTROL | APDS9300_CMD, cmd);
+					APDS9300_POWER_ADDR | APDS9300_CMD,
+					cmd);
 	if (ret) {
 		dev_err(&data->client->dev,
 			"failed to set power state %d\n", state);
-		return ret;
+		goto out;
 	}
+	/* For APDS9300, power on also means ALS enabled, so mark them both */
+	if (!data->aux_data)
+		data->als_enabled = state;
 	data->power_state = state;
-
-	return 0;
+out:
+	mutex_unlock(&data->mutex);
+	return ret;
 }

 static void apds9300_clear_intr(struct apds9300_data *data)
@@ -199,32 +628,474 @@ static void apds9300_clear_intr(struct apds9300_data *data)
 		dev_err(&data->client->dev, "failed to clear interrupt\n");
 }

-static int apds9300_chip_init(struct apds9300_data *data)
+static irqreturn_t apds9300_interrupt_handler(int irq, void *private)
+{
+	struct iio_dev *dev_info = private;
+	struct apds9300_data *data = iio_priv(dev_info);
+
+	iio_push_event(dev_info,
+		       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+		       iio_get_time_ns());
+
+	apds9300_clear_intr(data);
+
+	return IRQ_HANDLED;
+}
+
+/* Determine what has triggered the interrupt and clear it accordingly */
+static int apds9930_interrupt_clear(struct apds9300_data *data, u8 intr_status)
+{
+	u8 reg = APDS9300_CMD | APDS9930_CMD_TYPE_SPECIAL_FUNC;
+
+	switch (intr_status & (APDS9930_AINT | APDS9930_PINT)) {
+	case APDS9930_AINT:
+		reg |= APDS9930_CMD_TYPE_ALS;
+		break;
+	case APDS9930_PINT:
+		reg |= APDS9930_CMD_TYPE_PS;
+		break;
+	case (APDS9930_AINT & APDS9930_PINT):
+		reg |= APDS9930_CMD_TYPE_BOTH;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return i2c_smbus_read_byte_data(data->client, reg);
+}
+
+/*
+ * Update thresholds so as to generate interrupts when the CH0 data changes
+ * significantly since the last update; significantly is quantified by the
+ * hysteresis factor: if the ALS state changes with more than hysteresis %,
+ * update the thresholds.
+ */
+static void apds9930_update_als_thresholds(struct apds9300_data *data, u16 ch0)
+{
+	data->als_thresh.low	= (ch0 * (100 - APDS9930_ALS_HYSTERESIS)) / 100;
+	data->als_thresh.high	=
+		min((u16)((ch0 * (100 + APDS9930_ALS_HYSTERESIS)) / 100),
+		    data->aux_data->ch0_max);
+
+	i2c_smbus_write_word_data(
+			data->client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_AILTL_REG,
+			data->als_thresh.low);
+	i2c_smbus_write_word_data(
+			data->client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_AIHTL_REG,
+			data->als_thresh.high);
+}
+
+static void apds9930_update_ps_thresholds(struct apds9300_data *data, u16 ps)
+{
+	struct apds9930_data *apds9930 = data->aux_data;
+
+	if (ps <= apds9930->ps_thresh.low) {
+		/* Near to far => set limits to detect when it comes close */
+		apds9930->ps_thresh.low		= APDS9930_MIN_PS_THRESH;
+		apds9930->ps_thresh.high	= APDS9930_DETECTION_PS_THRESH;
+	} else if (ps >= apds9930->ps_thresh.high) {
+		/* Far to near => set limits to detect when it goes further */
+		apds9930->ps_thresh.low		= APDS9930_DETECTION_PS_THRESH;
+		apds9930->ps_thresh.high	= APDS9930_MAX_PS_THRESH;
+	}
+
+	/* Update thresholds */
+	i2c_smbus_write_word_data(
+			data->client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_PILTL_REG,
+			apds9930->ps_thresh.low);
+	i2c_smbus_write_word_data(
+			data->client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_PIHTL_REG,
+			apds9930->ps_thresh.high);
+}
+
+static irqreturn_t apds9930_interrupt_handler(int irq, void *private_data)
+{
+	struct iio_dev *indio_dev	= private_data;
+	struct apds9300_data *data	= iio_priv(indio_dev);
+	u8 status, enable_reg;
+	u16 ch0, ps_data;
+	int ret;
+
+	/* Disable ADCs converters while processing data */
+	enable_reg = i2c_smbus_read_byte_data(
+					data->client,
+					APDS9300_CMD | APDS9930_ENABLE_REG);
+	if (enable_reg < 0)
+		return IRQ_HANDLED;
+	ret = i2c_smbus_write_byte_data(data->client,
+					APDS9300_CMD | APDS9930_ENABLE_REG, 1);
+	if (ret < 0)
+		return IRQ_HANDLED;
+
+	/* Read status register to see what caused the interrupt */
+	status = i2c_smbus_read_byte_data(data->client,
+					  APDS9300_CMD | APDS9930_STATUS_REG);
+	if (status < 0)
+		goto err;
+
+	/* Push event to userspace */
+	if (status & APDS9930_AINT) {
+		/* Clear interrupt */
+		apds9930_interrupt_clear(data, status);
+
+		iio_push_event(indio_dev,
+			       IIO_MOD_EVENT_CODE(IIO_INTENSITY,
+						  0,
+						  IIO_MOD_LIGHT_BOTH,
+						  IIO_EV_TYPE_THRESH,
+						  IIO_EV_DIR_EITHER),
+			       iio_get_time_ns());
+
+		ch0 = i2c_smbus_read_word_data(data->client,
+					       APDS9300_CMD | APDS9300_WORD |
+					       APDS9930_DATA0LOW);
+		if (ch0 < 0)
+			goto err;
+
+		apds9930_update_als_gain(data, ch0);
+
+		/* Update ALS thresholds to environment */
+		apds9930_update_als_thresholds(data, ch0);
+	}
+
+	if (status & APDS9930_PINT) {
+		/* Clear interrupt */
+		apds9930_interrupt_clear(data, status);
+
+		iio_push_event(indio_dev,
+			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns());
+
+		ps_data = i2c_smbus_read_word_data(data->client,
+						   APDS9300_CMD |
+						   APDS9300_WORD |
+						   APDS9930_PDATAL_REG);
+		if (ps_data < 0)
+			goto err;
+
+		apds9930_update_ps_thresholds(data, ps_data);
+	}
+
+err:
+	/* Re-enable converters */
+	i2c_smbus_write_byte_data(data->client,
+				  APDS9300_CMD | APDS9930_ENABLE_REG,
+				  enable_reg);
+
+	return IRQ_HANDLED;
+}
+
+static void apds9300_set_registers(struct apds9300_data *data,
+				   u8 ch0_low_reg,
+				   u8 ch1_low_reg,
+				   u8 power_on_value)
+{
+	data->ch0_low_reg	= ch0_low_reg;
+	data->ch1_low_reg	= ch1_low_reg;
+	data->power_on_value	= power_on_value;
+}
+
+static void apds9300_set_functions(
+		struct apds9300_data *data,
+		unsigned long (*calculate_lux)(struct apds9300_data *data,
+					       u16 ch0, u16 ch1),
+		int (*set_intr_state)(struct apds9300_data *data,
+				      enum apds9300_intr intr,
+				      int state),
+		irq_handler_t irq_handler)
+{
+	data->calculate_lux	= calculate_lux;
+	data->set_intr_state	= set_intr_state;
+	data->irq_handler	= irq_handler;
+}
+
+static void apds9300_init(struct apds9300_data *data)
+{
+	apds9300_set_functions(data,
+			       apds9300_calculate_lux,
+			       apds9300_set_intr_state,
+			       apds9300_interrupt_handler);
+}
+
+/*
+ * Set the coefficients for APDS9930 to those specified in DT/ACPI if they
+ * exist, otherwise to default values.
+ */
+static void apds9930_set_platform_data(struct apds9300_data *data)
+{
+	struct apds9930_coefficients defaults = {
+		.ga	= APDS9930_DEF_GA,
+		.coef_a	= APDS9930_COEF_SCALE,
+		.coef_b	= APDS9930_DEF_B,
+		.coef_c	= APDS9930_DEF_C,
+		.coef_d	= APDS9930_DEF_D,
+		.df	= APDS9930_DEF_DF,
+	};
+	struct device *dev = &data->client->dev;
+
+	/*
+	 * Look for device properties and set them to proper value or to
+	 * default.
+	 */
+	if (device_property_read_u32(dev, APDS9930_GA_PROP,
+				     &data->platform_data->coefs.ga))
+		data->platform_data->coefs.ga = defaults.ga;
+
+	if (device_property_read_u32(dev, APDS9930_DF_PROP,
+				     &data->platform_data->coefs.df))
+		data->platform_data->coefs.df = defaults.df;
+
+	if (device_property_read_u32(dev, APDS9930_COEF_B_PROP,
+				     &data->platform_data->coefs.coef_b) ||
+	    device_property_read_u32(dev, APDS9930_COEF_C_PROP,
+				     &data->platform_data->coefs.coef_c) ||
+	    device_property_read_u32(dev, APDS9930_COEF_D_PROP,
+				     &data->platform_data->coefs.coef_d)) {
+		data->platform_data->coefs.coef_b	= defaults.coef_b;
+		data->platform_data->coefs.coef_c	= defaults.coef_c;
+		data->platform_data->coefs.coef_d	= defaults.coef_d;
+	}
+	data->platform_data->coefs.coef_a = defaults.coef_a;
+
+	if (device_property_read_u8(dev, APDS9930_ATIME_PROP,
+				    &data->platform_data->atime))
+		data->platform_data->atime = APDS9930_DEF_ATIME;
+
+	if (device_property_read_u8(dev, APDS9930_AGAIN_PROP,
+				    &data->platform_data->again))
+		data->platform_data->again = APDS9930_DEF_AGAIN;
+
+	/*
+	 * We expect for the AGAIN value to be the one in the register (0, 1, 2
+	 * or 3). If we do find device property AGAIN, but is not valid, fall
+	 * back to the default one.
+	 */
+	if (data->platform_data->again > APDS9930_MAX_AGAIN_INDEX)
+		data->platform_data->again = APDS9930_DEF_AGAIN;
+
+	if (device_property_read_u8(dev, APDS9930_PDRIVE_PROP,
+				    &data->platform_data->pdrive))
+		data->platform_data->pdrive = APDS9930_DEF_PDRIVE;
+
+	if (device_property_read_u8(dev, APDS9930_PPULSE_PROP,
+				    &data->platform_data->ppulse))
+		data->platform_data->ppulse = APDS9930_DEF_PPULSE;
+}
+
+/* Basic chip initialization, as described in the datasheet */
+static int apds9930_chip_registers_init(struct apds9300_data *data)
+{
+	struct i2c_client *client = data->client;
+	int ret;
+
+	/* Set timing registers default values (minimum) */
+	ret = i2c_smbus_write_byte_data(client,
+					APDS9300_CMD | APDS9930_ATIME_REG,
+					data->platform_data->atime);
+	if (ret < 0)
+		return ret;
+
+	ret = i2c_smbus_write_byte_data(client,
+					APDS9300_CMD | APDS9930_PTIME_REG,
+					APDS9930_DEF_PTIME);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(client,
+					APDS9300_CMD | APDS9930_WTIME_REG,
+					APDS9930_DEF_WTIME);
+	if (ret < 0)
+		return ret;
+
+	/* Interrupt threshold default settings */
+	ret = i2c_smbus_write_word_data(
+			client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_AILTL_REG,
+			APDS9930_DEF_ALS_THRESH_LOW);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_word_data(
+			client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_AIHTL_REG,
+			APDS9930_DEF_ALS_THRESH_HIGH);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_word_data(
+			client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_PILTL_REG,
+			APDS9930_DEF_PS_THRESH_LOW);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_word_data(
+			client,
+			APDS9300_CMD | APDS9300_WORD | APDS9930_PIHTL_REG,
+			APDS9930_DEF_PS_THRESH_HIGH);
+	if (ret < 0)
+		return ret;
+
+	/* Set persistence filters to default values */
+	ret = i2c_smbus_write_byte_data(
+				client,
+				APDS9300_CMD | APDS9930_PERS_REG,
+				APDS9930_DEF_APERS << APDS9930_APERS_SHIFT |
+				APDS9930_DEF_PPERS << APDS9930_PPERS_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	/* Reset the configuration register (do not wait long) */
+	ret = i2c_smbus_write_byte_data(client,
+					APDS9300_CMD | APDS9930_CONFIG_REG, 0);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Set proximity pulse count register (number of pulses to be generated
+	 * during the proximity accum state)
+	 */
+	ret = i2c_smbus_write_byte_data(client,
+					APDS9300_CMD | APDS9930_PPULSE_REG,
+					data->platform_data->ppulse);
+	if (ret < 0)
+		return ret;
+
+	/* Gain selection setting */
+	ret = i2c_smbus_write_byte_data(
+			client,
+			APDS9300_CMD | APDS9930_CONTROL_REG,
+			data->platform_data->again << APDS9930_AGAIN_SHIFT |
+			APDS9930_DEF_PGAIN << APDS9930_PGAIN_SHIFT |
+			APDS9930_DEF_PDIODE << APDS9930_PDIODE_SHIFT |
+			data->platform_data->pdrive << APDS9930_PDRIVE_SHIFT);
+	if (ret < 0)
+		return ret;
+
+	return apds9300_set_power_state(data, 1);
+}
+
+/* ALSIT = 2.73ms * (256 - ATIME), 2.73 = 5591/(2^11) */
+static inline u8 apds9930_atime_to_alsit(u8 atime_val)
+{
+	return (u8)(((256 - (u32)atime_val) * 5591) >> 11);
+}
+
+/* Computes maximum Ch0 data when atime is the given one. */
+static inline u16 apds9930_compute_max_ch0(u8 atime_val)
+{
+	return 1024 * (256 - (u32)atime_val) - 1;
+}
+
+static int apds9930_init(struct apds9300_data *data)
+{
+	data->platform_data = kmalloc(sizeof(*data->platform_data), GFP_KERNEL);
+	if (!data->platform_data)
+		return -ENOMEM;
+	data->aux_data = kmalloc(sizeof(*data->aux_data), GFP_KERNEL);
+	if (!data->aux_data)
+		return -ENOMEM;
+
+	apds9930_set_platform_data(data);
+
+	apds9300_set_functions(data,
+			       apds9930_calculate_lux,
+			       apds9930_set_intr_state,
+			       apds9930_interrupt_handler);
+
+	/* Init APDS9930 data to default values */
+	data->aux_data->alsit		= apds9930_atime_to_alsit(
+						data->platform_data->atime);
+	data->aux_data->ch0_max		= apds9930_compute_max_ch0(
+						APDS9930_DEF_ATIME);
+	data->aux_data->agl_enabled	= false;
+	data->als_enabled		= false;
+	data->aux_data->ps_enabled	= false;
+	data->als_intr_enabled		= false;
+	data->aux_data->ps_intr_enabled	= false;
+	data->als_thresh.low		= APDS9930_DEF_ALS_THRESH_LOW;
+	data->als_thresh.high		= APDS9930_DEF_ALS_THRESH_HIGH;
+	data->aux_data->ps_thresh.low	= APDS9930_DEF_PS_THRESH_LOW;
+	data->aux_data->ps_thresh.high	= APDS9930_DEF_PS_THRESH_HIGH;
+
+	return apds9930_chip_registers_init(data);
+}
+
+static int apds9300_chip_init(struct apds9300_data *data, int *device_index)
 {
 	int ret;

-	/* Need to set power off to ensure that the chip is off */
+	/*
+	 * Try to first read the APDS9930's ID reg since this reg does not exist
+	 * in APDS9300, so if it fails we are sure we did not read another
+	 * register from the other sensor.
+	 */
+	ret = i2c_smbus_read_byte_data(data->client,
+				       APDS9300_CMD | APDS9930_ID_REG);
+	if (ret == APDS9930_DEVICE_ID) {
+		dev_info(&data->client->dev,
+			 "identified APDS9930, chip id %i\n", ret);
+		*device_index = APDS9930_ID;
+		apds9300_set_registers(data,
+				       APDS9930_DATA0LOW,
+				       APDS9930_DATA1LOW,
+				       APDS9930_ENABLE_ALL);
+
+		return apds9930_init(data);
+	}
+	if (ret > 0) {
+		dev_err(&data->client->dev,
+			"wrong chip id %i for APDS9930\n", ret);
+		return -EINVAL;
+	}
+
+	/*
+	 * If APDS9930 identification failed, try to identify APDS9300. Need to
+	 * set power off to ensure that the chip is off.
+	 */
+	apds9300_set_registers(data,
+			       APDS9300_DATA0LOW,
+			       APDS9300_DATA1LOW,
+			       APDS9300_POWER_ON);
 	ret = apds9300_set_power_state(data, 0);
 	if (ret < 0)
 		goto err;
 	/*
 	 * Probe the chip. To do so we try to power up the device and then to
-	 * read back the 0x03 code
+	 * read back the 0x03 code for the APDS9300 sensor
 	 */
 	ret = apds9300_set_power_state(data, 1);
 	if (ret < 0)
 		goto err;
 	ret = i2c_smbus_read_byte_data(data->client,
-			APDS9300_CONTROL | APDS9300_CMD);
+				       APDS9300_CMD | APDS9300_CONTROL);
 	if (ret != APDS9300_POWER_ON) {
 		ret = -ENODEV;
 		goto err;
 	}
+
+	ret = i2c_smbus_read_byte_data(data->client,
+				       APDS9300_CMD | APDS9300_ID_REG);
+	if (ret < 0)
+		dev_err(&data->client->dev,
+			"error reading both APDS9300 and APDS9930 chip ids\n");
+	else {
+		dev_info(&data->client->dev,
+			 "identified APDS9300, chip id %i", ret);
+		*device_index = APDS9300_ID;
+		apds9300_init(data);
+	}
+
 	/*
-	 * Disable interrupt to ensure thai it is doesn't enable
+	 * Disable interrupt to ensure that it is doesn't enable
 	 * i.e. after device soft reset
 	 */
-	ret = apds9300_set_intr_state(data, 0);
+	ret = data->set_intr_state(data, ALS_INTR, 0);
 	if (ret < 0)
 		goto err;

@@ -235,37 +1106,94 @@ err:
 	return ret;
 }

+/* APDS9300 IIO functions */
 static int apds9300_read_raw(struct iio_dev *indio_dev,
 		struct iio_chan_spec const *chan, int *val, int *val2,
 		long mask)
 {
 	int ch0, ch1, ret = -EINVAL;
+	u16 ch;
 	struct apds9300_data *data = iio_priv(indio_dev);

 	mutex_lock(&data->mutex);
 	switch (chan->type) {
 	case IIO_LIGHT:
-		ch0 = apds9300_get_adc_val(data, 0);
-		if (ch0 < 0) {
-			ret = ch0;
+		switch (mask) {
+		case IIO_CHAN_INFO_PROCESSED:
+			if (!data->als_enabled) {
+				ret = -ENODATA;
+				break;
+			}
+
+			ch0 = apds9300_get_adc_val(data, 0);
+			if (ch0 < 0) {
+				ret = ch0;
+				break;
+			}
+			ch1 = apds9300_get_adc_val(data, 1);
+			if (ch1 < 0) {
+				ret = ch1;
+				break;
+			}
+			*val	= data->calculate_lux(data, ch0, ch1);
+			ret	= IIO_VAL_INT;
 			break;
-		}
-		ch1 = apds9300_get_adc_val(data, 1);
-		if (ch1 < 0) {
-			ret = ch1;
+		case IIO_CHAN_INFO_ENABLE:
+			*val	= data->als_enabled;
+			ret	= IIO_VAL_INT;
+			break;
+		default:
+			ret = -EINVAL;
 			break;
 		}
-		*val = apds9300_calculate_lux(ch0, ch1);
-		ret = IIO_VAL_INT;
 		break;
 	case IIO_INTENSITY:
+		if (!data->als_enabled) {
+			ret = -ENODATA;
+			break;
+		}
+
 		ret = apds9300_get_adc_val(data, chan->channel);
 		if (ret < 0)
 			break;
 		*val = ret;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_PROXIMITY:
+		if (!data->aux_data)
+			ret = -EINVAL;
+		else
+			switch (mask) {
+			case IIO_CHAN_INFO_RAW:
+				if (!data->aux_data->ps_enabled) {
+					ret = -ENODATA;
+					break;
+				}
+
+				/* Get proximity raw value */
+				ch = i2c_smbus_read_word_data(
+						data->client,
+						APDS9300_CMD | APDS9300_WORD |
+						APDS9930_PDATAL_REG);
+				if (ch < 0) {
+					ret = ch;
+					break;
+				}
+
+				*val	= APDS9930_MAX_PS_THRESH - (int)ch;
+				ret	= IIO_VAL_INT;
+				break;
+			case IIO_CHAN_INFO_ENABLE:
+				*val	= data->aux_data->ps_enabled;
+				ret	= IIO_VAL_INT;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
+		break;
 	default:
+		ret = -EINVAL;
 		break;
 	}
 	mutex_unlock(&data->mutex);
@@ -273,19 +1201,103 @@ static int apds9300_read_raw(struct iio_dev *indio_dev,
 	return ret;
 }

+/*
+ * For APDS9300, disabling the ALS means disabling the entire sensor, so power
+ * off.
+ */
+static int apds9300_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct apds9300_data *data = iio_priv(indio_dev);
+
+	if (mask != IIO_CHAN_INFO_ENABLE || chan->type != IIO_LIGHT)
+		return -EINVAL;
+
+	return apds9300_set_power_state(data, val);
+}
+
+static int apds9930_write_raw(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan, int val,
+			      int val2, long mask)
+{
+	struct apds9300_data *data	= iio_priv(indio_dev);
+	struct i2c_client *client	= data->client;
+	int ret				= 0;
+	u8 enable_reg, function_reg;
+	bool *feature_enabled;
+
+	if (mask != IIO_CHAN_INFO_ENABLE)
+		return -EINVAL;
+
+	mutex_lock(&data->mutex);
+
+	if (chan->type == IIO_LIGHT) {
+		feature_enabled = &data->als_enabled;
+	} else if (chan->type == IIO_PROXIMITY && data->aux_data) {
+		feature_enabled = &data->aux_data->ps_enabled;
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	val = !!val;
+	if (val == *feature_enabled)
+		goto out;
+
+	enable_reg = i2c_smbus_read_byte_data(
+					client,
+					APDS9300_CMD | APDS9930_ENABLE_REG);
+	if (enable_reg < 0) {
+		ret = enable_reg;
+		goto out;
+	}
+
+	function_reg = chan->type == IIO_LIGHT ? APDS9930_AEN : APDS9930_PEN;
+	if (val)
+		enable_reg |= function_reg;
+	else
+		enable_reg &= ~function_reg;
+	ret = i2c_smbus_write_byte_data(
+					client,
+					APDS9300_CMD | APDS9930_ENABLE_REG,
+					enable_reg);
+	if (ret < 0)
+		goto out;
+
+	*feature_enabled = val;
+out:
+	mutex_unlock(&data->mutex);
+	return ret;
+}
+
 static int apds9300_read_thresh(struct iio_dev *indio_dev,
 		const struct iio_chan_spec *chan, enum iio_event_type type,
 		enum iio_event_direction dir, enum iio_event_info info,
 		int *val, int *val2)
 {
 	struct apds9300_data *data = iio_priv(indio_dev);
+	struct apds9300_threshold thresh;
+
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		thresh = data->als_thresh;
+		break;
+	case IIO_PROXIMITY:
+		if (data->aux_data) {
+			thresh = data->aux_data->ps_thresh;
+			break;
+		}
+	default:
+		return -EINVAL;
+	}

 	switch (dir) {
 	case IIO_EV_DIR_RISING:
-		*val = data->thresh_hi;
+		*val = thresh.high;
 		break;
 	case IIO_EV_DIR_FALLING:
-		*val = data->thresh_low;
+		*val = thresh.low;
 		break;
 	default:
 		return -EINVAL;
@@ -319,7 +1331,15 @@ static int apds9300_read_interrupt_config(struct iio_dev *indio_dev,
 {
 	struct apds9300_data *data = iio_priv(indio_dev);

-	return data->intr_en;
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		return data->als_intr_enabled;
+	case IIO_PROXIMITY:
+		if (data->aux_data)
+			return data->aux_data->ps_intr_enabled;
+	default:
+		return -EINVAL;
+	}
 }

 static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
@@ -330,26 +1350,22 @@ static int apds9300_write_interrupt_config(struct iio_dev *indio_dev,
 	int ret;

 	mutex_lock(&data->mutex);
-	ret = apds9300_set_intr_state(data, state);
+	switch (chan->type) {
+	case IIO_INTENSITY:
+		ret = data->set_intr_state(data, ALS_INTR, state);
+		break;
+	case IIO_PROXIMITY:
+		ret = data->set_intr_state(data, PS_INTR, state);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
 	mutex_unlock(&data->mutex);

 	return ret;
 }

-static const struct iio_info apds9300_info_no_irq = {
-	.driver_module	= THIS_MODULE,
-	.read_raw	= apds9300_read_raw,
-};
-
-static const struct iio_info apds9300_info = {
-	.driver_module		= THIS_MODULE,
-	.read_raw		= apds9300_read_raw,
-	.read_event_value	= apds9300_read_thresh,
-	.write_event_value	= apds9300_write_thresh,
-	.read_event_config	= apds9300_read_interrupt_config,
-	.write_event_config	= apds9300_write_interrupt_config,
-};
-
 static const struct iio_event_spec apds9300_event_spec[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -364,43 +1380,133 @@ static const struct iio_event_spec apds9300_event_spec[] = {
 	},
 };

+/* Lux (processed Ch0 + Ch1) */
+#define APDS9300_LIGHT_CHAN {						\
+	.type			= IIO_LIGHT,				\
+	.info_mask_separate	= BIT(IIO_CHAN_INFO_PROCESSED) |	\
+			BIT(IIO_CHAN_INFO_ENABLE),			\
+}
+
+/*
+ * Ch0 photodiode (visible light + infrared); threshold
+ * triggered event
+ */
+#define APDS9300_INTENSITY_BOTH_CHAN {					\
+	.type			= IIO_INTENSITY,			\
+	.channel		= 0,					\
+	.modified		= true,					\
+	.channel2		= IIO_MOD_LIGHT_BOTH,			\
+	.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),		\
+	.event_spec		= apds9300_event_spec,			\
+	.num_event_specs	= ARRAY_SIZE(apds9300_event_spec),	\
+}
+
+/* Ch1 photodiode (infrared) */
+#define APDS9300_INTENSITY_IR_CHAN {				\
+	.type			= IIO_INTENSITY,		\
+	.channel		= 1,				\
+	.modified		= true,				\
+	.channel2		= IIO_MOD_LIGHT_IR,		\
+	.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW),	\
+}
+
 static const struct iio_chan_spec apds9300_channels[] = {
+	APDS9300_LIGHT_CHAN,
+	APDS9300_INTENSITY_BOTH_CHAN,
+	APDS9300_INTENSITY_IR_CHAN,
+};
+
+static const struct iio_chan_spec apds9930_channels[] = {
+	APDS9300_LIGHT_CHAN,
+	APDS9300_INTENSITY_BOTH_CHAN,
+	APDS9300_INTENSITY_IR_CHAN,
 	{
-		.type = IIO_LIGHT,
-		.channel = 0,
-		.indexed = true,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
-	}, {
-		.type = IIO_INTENSITY,
-		.channel = 0,
-		.channel2 = IIO_MOD_LIGHT_BOTH,
-		.indexed = true,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
-		.event_spec = apds9300_event_spec,
-		.num_event_specs = ARRAY_SIZE(apds9300_event_spec),
-	}, {
-		.type = IIO_INTENSITY,
-		.channel = 1,
-		.channel2 = IIO_MOD_LIGHT_IR,
-		.indexed = true,
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		/* Proximity channel; threshold triggered event */
+		.type			= IIO_PROXIMITY,
+		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_ENABLE),
+		.event_spec		= apds9300_event_spec,
+		.num_event_specs	= ARRAY_SIZE(apds9300_event_spec),
 	},
 };

-static irqreturn_t apds9300_interrupt_handler(int irq, void *private)
+static const struct iio_info apds9300_info_no_irq = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= apds9300_read_raw,
+	.write_raw	= apds9300_write_raw,
+};
+
+static const struct iio_info apds9300_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= apds9300_read_raw,
+	.write_raw		= apds9300_write_raw,
+	.read_event_value	= apds9300_read_thresh,
+	.write_event_value	= apds9300_write_thresh,
+	.read_event_config	= apds9300_read_interrupt_config,
+	.write_event_config	= apds9300_write_interrupt_config,
+};
+
+static const struct iio_info apds9930_info_no_irq = {
+	.driver_module	= THIS_MODULE,
+	.read_raw	= apds9300_read_raw,
+	.write_raw	= apds9930_write_raw,
+};
+
+static const struct iio_info apds9930_info = {
+	.driver_module		= THIS_MODULE,
+	.read_raw		= apds9300_read_raw,
+	.write_raw		= apds9930_write_raw,
+	.read_event_value	= apds9300_read_thresh,
+	.read_event_config	= apds9300_read_interrupt_config,
+	.write_event_config	= apds9300_write_interrupt_config,
+};
+
+/* iio_dev data for APDS9300 and APDS9930 */
+struct apds9300_iio_dev_info {
+	const struct iio_chan_spec	*channels;
+	const int			num_channels;
+	const struct iio_info		*irq_info;
+	const struct iio_info		*no_irq_info;
+};
+
+static const struct apds9300_iio_dev_info apds9300_info_tbl[] = {
+	[APDS9300_ID] = {
+		.channels	= apds9300_channels,
+		.num_channels	= ARRAY_SIZE(apds9300_channels),
+		.irq_info	= &apds9300_info,
+		.no_irq_info	= &apds9300_info_no_irq,
+	},
+	[APDS9930_ID] = {
+		.channels	= apds9930_channels,
+		.num_channels	= ARRAY_SIZE(apds9930_channels),
+		.irq_info	= &apds9930_info,
+		.no_irq_info	= &apds9930_info_no_irq,
+	},
+};
+
+static int apds9300_gpio_probe(struct i2c_client *client,
+			       struct apds9300_data *data)
 {
-	struct iio_dev *dev_info = private;
-	struct apds9300_data *data = iio_priv(dev_info);
+	struct device *dev;
+	struct gpio_desc *gpio;
+	int ret;

-	iio_push_event(dev_info,
-		       IIO_UNMOD_EVENT_CODE(IIO_INTENSITY, 0,
-					    IIO_EV_TYPE_THRESH,
-					    IIO_EV_DIR_EITHER),
-		       iio_get_time_ns());
+	if (!client)
+		return -EINVAL;

-	apds9300_clear_intr(data);
+	dev = &client->dev;

-	return IRQ_HANDLED;
+	gpio = devm_gpiod_get_index(dev, APDS9300_GPIO_NAME, 0);
+	if (IS_ERR(gpio)) {
+		dev_err(dev, "ACPI GPIO get index failed\n");
+		return PTR_ERR(gpio);
+	}
+
+	ret =  gpiod_direction_input(gpio);
+	if (ret)
+		return ret;
+
+	return gpiod_to_irq(gpio);
 }

 static int apds9300_probe(struct i2c_client *client,
@@ -408,7 +1514,7 @@ static int apds9300_probe(struct i2c_client *client,
 {
 	struct apds9300_data *data;
 	struct iio_dev *indio_dev;
-	int ret;
+	int ret, device_index;

 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -418,32 +1524,43 @@ static int apds9300_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;

-	ret = apds9300_chip_init(data);
-	if (ret < 0)
-		goto err;
-
 	mutex_init(&data->mutex);

-	indio_dev->dev.parent = &client->dev;
-	indio_dev->channels = apds9300_channels;
-	indio_dev->num_channels = ARRAY_SIZE(apds9300_channels);
-	indio_dev->name = APDS9300_DRV_NAME;
-	indio_dev->modes = INDIO_DIRECT_MODE;
+	/* Recommended wait time after power on. */
+	msleep(APDS9930_INIT_SLEEP);

-	if (client->irq)
-		indio_dev->info = &apds9300_info;
-	else
-		indio_dev->info = &apds9300_info_no_irq;
+	/* Check chip ID to differentiate chips (9300/9930) */
+	ret = apds9300_chip_init(data, &device_index);
+	if (ret < 0)
+		goto err;

-	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev, client->irq,
-				NULL, apds9300_interrupt_handler,
-				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
-				APDS9300_IRQ_NAME, indio_dev);
+	indio_dev->dev.parent	= &client->dev;
+	indio_dev->channels	= apds9300_info_tbl[device_index].channels;
+	indio_dev->num_channels	= apds9300_info_tbl[device_index].num_channels;
+	indio_dev->name		= APDS9300_DRV_NAME;
+	indio_dev->modes	= INDIO_DIRECT_MODE;
+
+	if (client->irq <= 0)
+		client->irq = apds9300_gpio_probe(client, data);
+
+	if (client->irq > 0) {
+		indio_dev->info = apds9300_info_tbl[device_index].irq_info;
+
+		ret = devm_request_threaded_irq(&client->dev,
+						client->irq,
+						NULL,
+						data->irq_handler,
+						IRQF_TRIGGER_FALLING |
+						IRQF_ONESHOT,
+						APDS9300_IRQ_NAME,
+						indio_dev);
 		if (ret) {
 			dev_err(&client->dev, "irq request error %d\n", -ret);
 			goto err;
 		}
+	} else {
+		indio_dev->info = apds9300_info_tbl[device_index].no_irq_info;
+		dev_info(&client->dev, "no irq\n");
 	}

 	ret = iio_device_register(indio_dev);
@@ -453,20 +1570,29 @@ static int apds9300_probe(struct i2c_client *client,
 	return 0;

 err:
-	/* Ensure that power off in case of error */
+	/* Ensure that power is off in case of error */
 	apds9300_set_power_state(data, 0);
+
 	return ret;
 }

 static int apds9300_remove(struct i2c_client *client)
 {
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct apds9300_data *data = iio_priv(indio_dev);
+	struct iio_dev *indio_dev	= i2c_get_clientdata(client);
+	struct apds9300_data *data	= iio_priv(indio_dev);

 	iio_device_unregister(indio_dev);

 	/* Ensure that power off and interrupts are disabled */
-	apds9300_set_intr_state(data, 0);
+	data->set_intr_state(data, ALS_INTR, 0);
+
+	if (data->aux_data) {
+		data->set_intr_state(data, PS_INTR, 0);
+
+		kfree(data->platform_data);
+		kfree(data->aux_data);
+	}
+
 	apds9300_set_power_state(data, 0);

 	return 0;
@@ -505,18 +1631,26 @@ static SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend, apds9300_resume);
 #define APDS9300_PM_OPS NULL
 #endif

+static const struct acpi_device_id apds9300_acpi_table[] = {
+	{ "APDS9300", APDS9300_ID },
+	{ "APDS9930", APDS9930_ID },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, apds9300_acpi_table);
+
 static struct i2c_device_id apds9300_id[] = {
-	{ APDS9300_DRV_NAME, 0 },
+	{ "apds9300",  APDS9300_ID },
+	{ "apds9930",  APDS9930_ID },
 	{ }
 };
-
 MODULE_DEVICE_TABLE(i2c, apds9300_id);

 static struct i2c_driver apds9300_driver = {
 	.driver = {
-		.name	= APDS9300_DRV_NAME,
-		.owner	= THIS_MODULE,
-		.pm	= APDS9300_PM_OPS,
+		.name			= APDS9300_DRV_NAME,
+		.owner			= THIS_MODULE,
+		.pm			= APDS9300_PM_OPS,
+		.acpi_match_table	= ACPI_PTR(apds9300_acpi_table),
 	},
 	.probe		= apds9300_probe,
 	.remove		= apds9300_remove,
@@ -527,5 +1661,6 @@ module_i2c_driver(apds9300_driver);

 MODULE_AUTHOR("Kravchenko Oleksandr <o.v.kravchenko@globallogic.com>");
 MODULE_AUTHOR("GlobalLogic inc.");
-MODULE_DESCRIPTION("APDS9300 ambient light photo sensor driver");
-MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Cristina Ciocan <cristina.ciocan@intel.com>");
+MODULE_DESCRIPTION("APDS9300 ALS and APDS9930 ALS & proximity sensors driver");
+MODULE_LICENSE("GPL v2");
--
1.8.1.2

