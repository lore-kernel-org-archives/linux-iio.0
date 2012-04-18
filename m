Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:44834 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952Ab2DRNeW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:34:22 -0400
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 5/6] IIO: AT91: Add support for hardware triggers for the ADC
Date: Wed, 18 Apr 2012 15:33:55 +0200
Message-Id: <1334756036-15944-6-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1334756036-15944-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds support for the hardware triggers for both the
AT91SAM9G20-EK and AT91SAM9M10G45-EK evaluation board from Atmel.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/at91sam9260_devices.c |    3 +
 arch/arm/mach-at91/at91sam9g45_devices.c |    3 +
 arch/arm/mach-at91/board-sam9g20ek.c     |    1 +
 arch/arm/mach-at91/board-sam9m10g45ek.c  |    1 +
 drivers/staging/iio/adc/Kconfig          |    3 +
 drivers/staging/iio/adc/at91_adc.c       |  389 +++++++++++++++++++++++++++++-
 include/linux/platform_data/at91_adc.h   |    2 +
 7 files changed, 395 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
index 758c629..a870753 100644
--- a/arch/arm/mach-at91/at91sam9260_devices.c
+++ b/arch/arm/mach-at91/at91sam9260_devices.c
@@ -1415,6 +1415,9 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
 	if (test_bit(3, &data->channels_used))
 		at91_set_A_periph(AT91_PIN_PC3, 0);
 
+	if (data->use_external)
+		at91_set_A_periph(AT91_PIN_PA22, 0);
+
 	adc_data = *data;
 	platform_device_register(&at91_adc_device);
 }
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index 05bc673..4ee18af 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -1260,6 +1260,9 @@ void __init at91_add_device_adc(struct at91_adc_data *data)
 	if (test_bit(7, &data->channels_used))
 		at91_set_gpio_input(AT91_PIN_PD27, 0);
 
+	if (data->use_external)
+		at91_set_A_periph(AT91_PIN_PD28, 0);
+
 	adc_data = *data;
 	platform_device_register(&at91_adc_device);
 }
diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
index 2ce4e26..3bb6e4d 100644
--- a/arch/arm/mach-at91/board-sam9g20ek.c
+++ b/arch/arm/mach-at91/board-sam9g20ek.c
@@ -326,6 +326,7 @@ static void __init ek_add_device_buttons(void) {}
 
 static struct at91_adc_data ek_adc_data = {
 	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
+	.use_external = true,
 	.vref = 3300,
 };
 
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index fb122ba..192a050 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -322,6 +322,7 @@ static struct at91_tsadcc_data ek_tsadcc_data = {
  */
 static struct at91_adc_data ek_adc_data = {
 	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7),
+	.use_external = true,
 	.vref = 3300,
 };
 
diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
index 1494838..9ee7ed9 100644
--- a/drivers/staging/iio/adc/Kconfig
+++ b/drivers/staging/iio/adc/Kconfig
@@ -172,6 +172,9 @@ config AD7280
 config AT91_ADC
 	tristate "Atmel AT91 ADC"
 	depends on SYSFS && ARCH_AT91
+	select IIO_BUFFER
+	select IIO_SW_RING
+	select IIO_TRIGGER
 	help
 	  Say yes here to build support for Atmel AT91 ADC.
 
diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
index b3517bb..7c93cde 100644
--- a/drivers/staging/iio/adc/at91_adc.c
+++ b/drivers/staging/iio/adc/at91_adc.c
@@ -23,9 +23,33 @@
 #include "../iio.h"
 #include <linux/platform_data/at91_adc.h>
 
+#include "../buffer.h"
+#include "../ring_sw.h"
+#include "../trigger.h"
+#include "../trigger_consumer.h"
+
 #include <mach/at91_adc.h>
 #include <mach/cpu.h>
 
+#define AT91_TSADCC_TRGR		(0x08)
+#define AT91_TSADCC_TRGMOD_EXT_RISING	(1 << 0)
+#define AT91_TSADCC_TRGMOD_EXT_FALLING	(1 << 1)
+#define AT91_TSADCC_TRGMOD_EXT_ANY	(AT91_TSADCC_TRGMOD_EXT_RISING | AT91_TSADCC_TRGMOD_EXT_FALLING)
+#define AT91_TSADCC_TRGMOD_CONTINUOUS	(3 << 1)
+
+/**
+ * struct at91_adc_trigger - description of triggers
+ * @name:		name of the trigger advertised to the user
+ * @value:		value to set in the ADC's mode register to enable
+			the trigger
+ * @is_external:	is the trigger relies on an external pin ?
+ */
+struct at91_adc_trigger {
+	char	*name;
+	u8	value;
+	bool	is_external;
+};
+
 /**
  * struct at91_adc_desc - description of the ADC on the board
  * @clock:		ADC clock as specified by the datasheet, in Hz.
@@ -34,36 +58,99 @@
 			board, see the channels_used bitmask in the platform
 			data)
  * @startup_time:	startup time of the ADC in microseconds
+ * @triggers:		array of the triggers available on the board
+ * @trigger_register:	index of the register managing the hardware triggers
  */
 struct at91_adc_desc {
 	u32			clock;
 	u8			num_channels;
 	u8			startup_time;
+	struct at91_adc_trigger	*triggers;
+	u8			trigger_register;
 };
 
 struct at91_adc_state {
+	u16			*buffer;
 	unsigned long		channels_mask;
 	struct clk		*clk;
 	bool			done;
 	struct at91_adc_desc	*desc;
 	int			irq;
+	bool			irq_enabled;
 	u16			last_value;
 	struct mutex		lock;
 	void __iomem		*reg_base;
+	struct iio_trigger	**trig;
 	u32			vref_mv;
 	wait_queue_head_t	wq_data_avail;
 };
 
+static struct at91_adc_trigger at91_adc_trigger_sam9g45[] = {
+	[0] = {
+		.name = "external-rising",
+		.value = AT91_TSADCC_TRGMOD_EXT_RISING,
+		.is_external = true,
+	},
+	[1] = {
+		.name = "external-falling",
+		.value = AT91_TSADCC_TRGMOD_EXT_FALLING,
+		.is_external = true,
+	},
+	[2] = {
+		.name = "external-any",
+		.value = AT91_TSADCC_TRGMOD_EXT_ANY,
+		.is_external = true,
+	},
+	[3] = {
+		.name = "continuous",
+		.value = AT91_TSADCC_TRGMOD_CONTINUOUS,
+		.is_external = false,
+	},
+	[4] = {
+		.name = NULL,
+	},
+};
+
 static struct at91_adc_desc at91_adc_desc_sam9g45 = {
 	.clock = 13200000,
 	.num_channels = 8,
 	.startup_time = 40,
+	.triggers = at91_adc_trigger_sam9g45,
+	.trigger_register = AT91_TSADCC_TRGR,
+};
+
+static struct at91_adc_trigger at91_adc_trigger_sam9g20[] = {
+	[0] = {
+		.name = "timer-counter-0",
+		.value = AT91_ADC_TRGSEL_TC0 | AT91_ADC_TRGEN,
+		.is_external = false,
+	},
+	[1] = {
+		.name = "timer-counter-1",
+		.value = AT91_ADC_TRGSEL_TC1 | AT91_ADC_TRGEN,
+		.is_external = false,
+	},
+	[2] = {
+		.name = "timer-counter-2",
+		.value = AT91_ADC_TRGSEL_TC2 | AT91_ADC_TRGEN,
+		.is_external = false,
+	},
+	[3] = {
+		.name = "external",
+		.value = AT91_ADC_TRGSEL_EXTERNAL | AT91_ADC_TRGEN,
+		.is_external = true,
+	},
+	[4] = {
+		.name = NULL,
+	},
 };
 
 static struct at91_adc_desc at91_adc_desc_sam9g20 = {
 	.clock = 5000000,
 	.num_channels = 4,
 	.startup_time = 10,
+	.triggers = at91_adc_trigger_sam9g20,
+	.trigger_register = AT91_ADC_MR,
 };
 
 static int at91_adc_select_soc(struct at91_adc_state *st)
@@ -94,6 +181,48 @@ static inline void at91_adc_reg_write(struct at91_adc_state *st,
 	writel_relaxed(val, st->reg_base + reg);
 }
 
+static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *idev = pf->indio_dev;
+	struct at91_adc_state *st = iio_priv(idev);
+	struct iio_buffer *buffer = idev->buffer;
+	int len = 0;
+
+	if (!bitmap_empty(idev->active_scan_mask, idev->masklength)) {
+		int i, j;
+		for (i = 0, j = 0;
+		     i < bitmap_weight(idev->active_scan_mask,
+				       idev->masklength);
+		     i++) {
+			j = find_next_bit(buffer->scan_mask,
+					  idev->masklength,
+					  j);
+			st->buffer[i] = at91_adc_reg_read(st, AT91_ADC_CHR(j));
+			j++;
+			len += 2;
+		}
+	}
+
+	if (buffer->scan_timestamp) {
+		s64 *timestamp = (s64 *)((u8 *)st->buffer + ALIGN(len,
+								  sizeof(s64)));
+		*timestamp = pf->timestamp;
+	}
+
+	buffer->access->store_to(buffer, (u8 *)st->buffer, pf->timestamp);
+
+	iio_trigger_notify_done(idev->trig);
+	st->irq_enabled = true;
+
+	/* Needed to ACK the DRDY interruption */
+	at91_adc_reg_read(st, AT91_ADC_LCDR);
+
+	enable_irq(st->irq);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
 {
 	struct iio_dev *idev = private;
@@ -103,13 +232,16 @@ static irqreturn_t at91_adc_eoc_trigger(int irq, void *private)
 	if (!(status & AT91_ADC_DRDY))
 		return IRQ_HANDLED;
 
-	if (status & st->channels_mask) {
-		st->done = true;
+	if (iio_buffer_enabled(idev)) {
+		disable_irq_nosync(irq);
+		st->irq_enabled = false;
+		iio_trigger_poll(idev->trig, iio_get_time_ns());
+	} else {
 		st->last_value = at91_adc_reg_read(st, AT91_ADC_LCDR);
+		st->done = true;
+		wake_up_interruptible(&st->wq_data_avail);
 	}
 
-	wake_up_interruptible(&st->wq_data_avail);
-
 	return IRQ_HANDLED;
 }
 
@@ -121,10 +253,10 @@ static int at91_adc_channel_init(struct iio_dev *idev,
 	int bit, idx = 0;
 
 	idev->num_channels = bitmap_weight(&pdata->channels_used,
-					   st->desc->num_channels);
+					   st->desc->num_channels) + 1;
 
 	chan_array = devm_kzalloc(&idev->dev,
-				  idev->num_channels * sizeof(struct iio_chan_spec),
+				  (idev->num_channels + 1) * sizeof(struct iio_chan_spec),
 				  GFP_KERNEL);
 
 	if (chan_array == NULL)
@@ -135,6 +267,7 @@ static int at91_adc_channel_init(struct iio_dev *idev,
 		chan->type = IIO_VOLTAGE;
 		chan->indexed = 1;
 		chan->channel = bit;
+		chan->scan_index = idx;
 		chan->scan_type.sign = 'u';
 		chan->scan_type.realbits = 10;
 		chan->scan_type.storagebits = 16;
@@ -142,6 +275,13 @@ static int at91_adc_channel_init(struct iio_dev *idev,
 		idx++;
 	}
 
+	(chan_array + idx)->type = IIO_TIMESTAMP;
+	(chan_array + idx)->channel = -1;
+	(chan_array + idx)->scan_index = idx;
+	(chan_array + idx)->scan_type.sign = 's';
+	(chan_array + idx)->scan_type.realbits = 64;
+	(chan_array + idx)->scan_type.storagebits = 64;
+
 	idev->channels = chan_array;
 	return idev->num_channels;
 }
@@ -151,6 +291,223 @@ static void at91_adc_channel_remove(struct iio_dev *idev)
 	devm_kfree(&idev->dev, (void*)idev->channels);
 }
 
+static u8 at91_adc_get_trigger_value_by_name(struct iio_dev *idev,
+					     struct at91_adc_trigger *triggers,
+					     const char *trigger_name)
+{
+	u8 value = 0;
+	int i;
+
+	for (i = 0; (triggers + i) != NULL; i++) {
+		char *name = kasprintf(GFP_KERNEL,
+				"%s-dev%d-%s",
+				idev->name,
+				idev->id,
+				triggers[i].name);
+		if (name == NULL)
+			return -ENOMEM;
+
+		if (strcmp(trigger_name, name) == 0) {
+			value = triggers[i].value;
+			kfree(name);
+			break;
+		}
+
+		kfree(name);
+	}
+
+	return value;
+}
+
+static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
+{
+	struct iio_dev *idev = trig->private_data;
+	struct at91_adc_state *st = iio_priv(idev);
+	struct iio_buffer *buffer = idev->buffer;
+	u32 status = at91_adc_reg_read(st, st->desc->trigger_register);
+	u8 value;
+	u8 bit;
+
+	value = at91_adc_get_trigger_value_by_name(idev,
+						   st->desc->triggers,
+						   idev->trig->name);
+	if (value == 0)
+		return -EINVAL;
+
+	if (state) {
+		size_t datasize = buffer->access->get_bytes_per_datum(buffer);
+
+		st->buffer = kmalloc(datasize, GFP_KERNEL);
+		if (st->buffer == NULL)
+			return -ENOMEM;
+
+		at91_adc_reg_write(st,
+				   st->desc->trigger_register,
+				   status | value);
+
+		for_each_set_bit(bit, buffer->scan_mask,
+				 st->desc->num_channels) {
+			struct iio_chan_spec const *chan = idev->channels + bit;
+			at91_adc_reg_write(st, AT91_ADC_CHER,
+					   AT91_ADC_CH(chan->channel));
+		}
+
+		at91_adc_reg_write(st, AT91_ADC_IER, AT91_ADC_DRDY);
+
+	} else {
+		at91_adc_reg_write(st, AT91_ADC_IDR, AT91_ADC_DRDY);
+
+		at91_adc_reg_write(st, st->desc->trigger_register,
+				   status & ~value);
+
+		for_each_set_bit(bit, buffer->scan_mask,
+				 st->desc->num_channels) {
+			struct iio_chan_spec const *chan = idev->channels + bit;
+			at91_adc_reg_write(st, AT91_ADC_CHDR,
+					   AT91_ADC_CH(chan->channel));
+		}
+		kfree(st->buffer);
+	}
+
+	return 0;
+}
+
+static const struct iio_trigger_ops at91_adc_trigger_ops = {
+	.owner = THIS_MODULE,
+	.set_trigger_state = &at91_adc_configure_trigger,
+};
+
+static struct iio_trigger *at91_adc_allocate_trigger(struct iio_dev *idev,
+						     struct at91_adc_trigger *trigger)
+{
+	struct iio_trigger *trig = iio_allocate_trigger("%s-dev%d-%s",
+							idev->name,
+							idev->id,
+							trigger->name);
+	int ret;
+
+	if (trig == NULL)
+		return NULL;
+
+	trig->dev.parent = idev->dev.parent;
+	trig->private_data = idev;
+	trig->ops = &at91_adc_trigger_ops;
+
+	ret = iio_trigger_register(trig);
+	if (ret < 0)
+		return NULL;
+
+	return trig;
+}
+
+static int at91_adc_trigger_init(struct iio_dev *idev,
+				 struct at91_adc_data *pdata)
+{
+	struct at91_adc_state *st = iio_priv(idev);
+	int i, ret;
+
+	st->trig = kcalloc(sizeof(st->desc->triggers),
+			   sizeof(st->trig),
+			   GFP_KERNEL);
+
+	if (st->trig == NULL) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	for (i = 0; st->desc->triggers[i].name != NULL; i++) {
+		if (st->desc->triggers[i].is_external && !(pdata->use_external))
+			continue;
+
+		st->trig[i] = at91_adc_allocate_trigger(idev,
+							st->desc->triggers + i);
+		if (st->trig[i] == NULL) {
+			dev_err(&idev->dev,
+				"Could not allocate trigger %d\n", i);
+			ret = -ENOMEM;
+			goto error_trigger;
+		}
+	}
+
+	return 0;
+
+error_trigger:
+	for (i--; i >= 0; i--) {
+		iio_trigger_unregister(st->trig[i]);
+		iio_free_trigger(st->trig[i]);
+	}
+	kfree(st->trig);
+error_ret:
+	return ret;
+}
+
+static void at91_adc_trigger_remove(struct iio_dev *idev)
+{
+	struct at91_adc_state *st = iio_priv(idev);
+	int i;
+
+	for (i = 0; st->desc->triggers[i].name != NULL; i++) {
+		iio_trigger_unregister(st->trig[i]);
+		iio_free_trigger(st->trig[i]);
+	}
+
+	kfree(st->trig);
+}
+
+static const struct iio_buffer_setup_ops at91_adc_buffer_ops = {
+	.preenable = &iio_sw_buffer_preenable,
+	.postenable = &iio_triggered_buffer_postenable,
+	.predisable = &iio_triggered_buffer_predisable,
+};
+
+static int at91_adc_buffer_init(struct iio_dev *idev)
+{
+	int ret;
+
+	idev->buffer = iio_sw_rb_allocate(idev);
+	if (!idev->buffer) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+
+	idev->pollfunc = iio_alloc_pollfunc(&iio_pollfunc_store_time,
+					    &at91_adc_trigger_handler,
+					    IRQF_ONESHOT,
+					    idev,
+					    "%s-consumer%d",
+					    idev->name,
+					    idev->id);
+	if (idev->pollfunc == NULL) {
+		ret = -ENOMEM;
+		goto error_pollfunc;
+	}
+
+	idev->setup_ops = &at91_adc_buffer_ops;
+	idev->modes |= INDIO_BUFFER_TRIGGERED;
+
+	ret = iio_buffer_register(idev,
+				  idev->channels,
+				  idev->num_channels);
+	if (ret)
+		goto error_register;
+
+	return 0;
+
+error_register:
+	iio_dealloc_pollfunc(idev->pollfunc);
+error_pollfunc:
+	iio_sw_rb_free(idev->buffer);
+error_ret:
+	return ret;
+}
+
+static void at91_adc_buffer_remove(struct iio_dev *idev)
+{
+	iio_buffer_unregister(idev);
+	iio_dealloc_pollfunc(idev->pollfunc);
+	iio_sw_rb_free(idev->buffer);
+}
+
 static int at91_adc_read_raw(struct iio_dev *idev,
 			     struct iio_chan_spec const *chan,
 			     int *val, int *val2, long mask)
@@ -344,14 +701,30 @@ static int __devinit at91_adc_probe(struct platform_device *pdev)
 	st->vref_mv = pdata->vref;
 	st->channels_mask = pdata->channels_used;
 
+	ret = at91_adc_buffer_init(idev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't initialize the buffer.\n");
+		goto error_free_channels;
+	}
+
+	ret = at91_adc_trigger_init(idev, pdata);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Couldn't setup the triggers.\n");
+		goto error_unregister_buffer;
+	}
+
 	ret = iio_device_register(idev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Couldn't register the device.\n");
-		goto error_free_channels;
+		goto error_remove_triggers;
 	}
 
 	return 0;
 
+error_remove_triggers:
+	at91_adc_trigger_remove(idev);
+error_unregister_buffer:
+	at91_adc_buffer_remove(idev);
 error_free_channels:
 	at91_adc_channel_remove(idev);
 error_disable_clk:
@@ -379,6 +752,8 @@ static int __devexit at91_adc_remove(struct platform_device *pdev)
 	struct at91_adc_state *st = iio_priv(idev);
 
 	iio_device_unregister(idev);
+	at91_adc_trigger_remove(idev);
+	at91_adc_buffer_remove(idev);
 	at91_adc_channel_remove(idev);
 	clk_disable(st->clk);
 	clk_unprepare(st->clk);
diff --git a/include/linux/platform_data/at91_adc.h b/include/linux/platform_data/at91_adc.h
index 8b51ee6..8750d80 100644
--- a/include/linux/platform_data/at91_adc.h
+++ b/include/linux/platform_data/at91_adc.h
@@ -10,10 +10,12 @@
 /**
  * struct at91_adc_data - platform data for ADC driver
  * @channels_used:	channels in use on the board as a bitmask
+ * @use_external:	does the board has external triggers availables
  * @vref:		Reference voltage for the ADC in millivolts
  */
 struct at91_adc_data {
 	unsigned long	channels_used;
+	bool		use_external;
 	u16		vref;
 };
 
-- 
1.7.5.4

