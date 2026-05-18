Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A0037757A
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779117712; cv=none; b=Ekx9LkWBoNAssrPU8fW2xqryZ1EibIflXoVP2gYXmP9o7d0nNNpQAYmWO5flVR6m6bI+08TJS3KpUrLSQsj4Ddvijjcl08jRKnJYeFfKjnI6Ky5Jwdjei/4KxkmTC9+ss6IrXCXqWYDi1ZSm3hh3Y8xT0s1Gi/0SXcHfwY9W74w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779117712; c=relaxed/simple;
	bh=pOWDUpJCx2X6yfGmJoGSzCzyS5RlMZeg3rxK0fekS9U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GkfpYl0Fsh/euUj1EDmadRtF142q4t644cZ9iW4aQi6nuKHq7hPPFf53++0DX5uUSZDOJR3lHNUaW1g/d7X44ktyyEzvTQ0asUPbeOFvRYj0r326j2rthYGqbamLoSYPKoiVRmxmLfvUM2Rklqld3EICXqgS2t3XzbGFI8SGeMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4/pADr2; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4/pADr2"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-956995b5bb6so581135241.3
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779117709; x=1779722509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gV6MQHljEoSOnCahWdPNGBjl3uJf30O9x4uLBaAxcH4=;
        b=m4/pADr2zW2fq9olyJEO/kHtp/dFZmTT9fnnhoNirQS5McRgUem/fgQWfxbDiEj7tY
         WbFiNWSdiF4qzAjvOM2z0A4TYVhqzZDXVe3E8Gm/u0VeDFjWMMrUZruQbpvz+99v2nIO
         ZlliAzddJrPO95wXmefbOOgZEon67b72XnuYwgZ8kpXvjmCCNBETk7SWWPbTVr0QrjCG
         Q2EOBzIPeDkKD5x9phGzjAbTmp+1Iqax1j41XD2v08WaGti0NBvjdcIqJpzEJIbTq5+S
         D0XFb9+ipTrGd/dC4PkYboJJF/9jtoqOVxtQ1R/sWqlFBFv6iFTJVk09ltM6hsjn5nm1
         dVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779117709; x=1779722509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gV6MQHljEoSOnCahWdPNGBjl3uJf30O9x4uLBaAxcH4=;
        b=iO1QqdG8qV0mLOXYTQA/h5aHQjOPxvAahPsT+96T6aJ1P2lH/oYeYOU5OPAZYytwsO
         /JP/90DztYFnJ2poUC6rRlHoItsTsyVIA9zVWAQB17o2B5XAOPJ4SUuWL9HOTDa8k+AN
         Ddlvx6+rhRm9SE9cLoWFGJRERS3V29GUZm1xjskbocWqzMTFTytD154nxmNzcfX7CUcg
         +pBO/57r6LjyrraN9PDT2o6yDoU8TpGr8NtspcxVtx7DbYPql56Ykd1cT76iAbNti5od
         Cu6mCtQlr7E6KGU6PeiefvBWP5FyP8J6Pw91MgscmumQnKYtCZa1rgyLTBKqZeoWw65m
         Auyw==
X-Gm-Message-State: AOJu0YzvSvBobvt9NdUEWtqqOEJmvExsDMovASk8k1stxSGhf6qMBNxK
	4RUvfXNXq/EVrPheFxkPoLjM7oZZbPuqrL3oVOjXIJ72tjLTio8tJJZ95s4lY6h0tXc=
X-Gm-Gg: Acq92OGjJiR5B8ZYoQusFhGqYwgYb4/Pi5vsvWbnJXdcWeGMwmlxz7rej2NxuYXYc1G
	Eu0KVpvtPiwkmy6Kg5vtNPlDnh/Zfy92Z5ZXHD3TyHGMUzAh526lSqHDHHL9lGoB8iW6RbHsRdX
	gx1MCObYiUa/ybjjT3PVYLWctvup58JAlcCjiN1oeXMT/Gjde2tlG7CSmtEwZYLaJjwDWDMlGeF
	J4iwk0FD/+oylWdpzkqOgLPOb+cAv5gwNHFDr9ie+p0UN9RaXMIKHGKCBmadWr6jA98eppm6Ca3
	/A5aWe7peIZ0y96pA6BBQYQn+KtgJYoicy5tEcTXsQCHm9ntO+RTHHb+RCH3b4mapreldXVyF5Y
	gvNMZpXz6t0ma0HJiEKdDjw3pAK8uXcahWwV01gboMlR3ABHwZtp1FrqOBsJz6zVHrwzoCHnh40
	POvQZpnf4ZP6EOxLkOLXjN5/O5sOdp7q4h
X-Received: by 2002:a05:6102:5e8d:b0:631:28c1:155c with SMTP id ada2fe7eead31-63a3cd1ef4dmr7688206137.7.1779117708535;
        Mon, 18 May 2026 08:21:48 -0700 (PDT)
Received: from localhost ([2804:30c:1f02:6000:8b59:7c96:762e:9faa])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cad98d4e3fsm7878946d6.8.2026.05.18.08.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 08:21:47 -0700 (PDT)
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
X-Google-Original-From: Marcelo Schmitt <marcelo.schmitt@analog.com>
Date: Mon, 18 May 2026 12:22:03 -0300
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: [PATCH v1 3/4] iio: adc: ltc2378: Enable high-speed data capture
Message-ID: <580ce8e03cdbda8ec20fed2e26f2226872ffcef3.1779117444.git.marcelo.schmitt1@gmail.com>
References: <cover.1779117444.git.marcelo.schmitt1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779117444.git.marcelo.schmitt1@gmail.com>

From: Marcelo Schmitt <marcelo.schmitt@analog.com>

Make use of SPI transfer offloading to speed up data capture, enabling data
acquisition at faster sample rates (up to 2 MSPS).

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/Kconfig                  |  12 +
 drivers/iio/adc/Makefile                 |   1 +
 drivers/iio/adc/ltc2378-offload-buffer.c | 297 +++++++++++++++++++++++
 drivers/iio/adc/ltc2378.c                |  62 +++++
 drivers/iio/adc/ltc2378.h                |  34 +++
 5 files changed, 406 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2378-offload-buffer.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 70fec8e3e891..b5368ee783f7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -944,6 +944,7 @@ config LTC2378
 	depends on SPI
 	depends on GPIOLIB || PWM
 	select IIO_BUFFER
+	imply LTC2378_OFFLOAD_BUFFER
 	help
 	  Say yes here to build support for Analog Devices LTC2378-20 and
 	  similar analog to digital converters.
@@ -951,6 +952,17 @@ config LTC2378
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2378.
 
+config LTC2378_OFFLOAD_BUFFER
+	bool "Offloaded data capture with LTC2378"
+	depends on SPI && LTC2378
+	depends on SPI_OFFLOAD=y
+	depends on PWM=y
+	depends on SPI_OFFLOAD_TRIGGER_PWM=y
+	depends on IIO_BUFFER_DMA=y
+	depends on IIO_BUFFER_DMAENGINE=y
+	help
+	  Say yes here to build support for high speed data capture with LTC2378
+
 config LTC2471
 	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 1814fb78dde3..2fa5dce0ceea 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2309) += ltc2309.o
 obj-$(CONFIG_LTC2378) += ltc2378.o
+obj-$(CONFIG_LTC2378_OFFLOAD_BUFFER) += ltc2378-offload-buffer.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
diff --git a/drivers/iio/adc/ltc2378-offload-buffer.c b/drivers/iio/adc/ltc2378-offload-buffer.c
new file mode 100644
index 000000000000..ed09f9a55f93
--- /dev/null
+++ b/drivers/iio/adc/ltc2378-offload-buffer.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2026 Analog Devices, Inc.
+ * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
+ */
+
+#include <linux/err.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/types.h>
+#include <linux/kstrtox.h>
+#include <linux/limits.h>
+#include <linux/linkage.h>
+#include <linux/math.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/pwm.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/types.h>
+#include <linux/time64.h>
+
+#include "ltc2378.h"
+
+/*
+ * SPI offload wiring schema
+ *
+ *     +-------------+         +-------------+
+ *     |         CNV |<-----+--| GPIO        |
+ *     |             |      +--| PWM0        |
+ *     |             |         |             |
+ *     |             |      +--| PWM1        |
+ *     |             |      |  +-------------+
+ *     |             |      +->| TRIGGER     |
+ *     |             |         |             |
+ *     |     ADC     |         |    SPI      |
+ *     |             |         | controller  |
+ *     |             |         |             |
+ *     |         SDI |<--------| SDO         |
+ *     |         SDO |-------->| SDI         |
+ *     |        SCLK |<--------| SCLK        |
+ *     +-------------+         +-------------+
+ *
+ */
+static int ltc2378_update_conversion_rate(struct ltc2378_state *st, int freq_Hz)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+	unsigned int min_read_offset, offload_period_ns;
+	struct pwm_waveform cnv_wf = { };
+	u64 target = LTC2378_TCNV_HIGH_NS;
+	u64 offload_offset_ns;
+	int ret;
+
+	if (freq_Hz == 0)
+		return -EINVAL;
+
+	if (freq_Hz < 1 || freq_Hz > st->info->max_sample_rate_hz)
+		return -ERANGE;
+
+	/* Configure CNV PWM waveform */
+	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_Hz);
+
+	/*
+	 * Ensure CNV high time meets minimum requirement (20ns).
+	 * The PWM hardware may round the duty cycle, so iterate
+	 * until we get at least the minimum required high time.
+	 */
+	do {
+		cnv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
+		if (ret)
+			return ret;
+		target += 10;  /* Increment by PWM duty cycle period */
+	} while (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS);
+
+	/*
+	 * Configure SPI offload PWM trigger.
+	 * The trigger should fire after tBUSYLH + tCONV + tDSDOBUSYL.
+	 * Minimum time needed: TBUSYLH (13ns) + TCONV (part-specific) + TDSDOBUSYL (5ns)
+	 *
+	 * Use the same period as CNV PWM to avoid timing issues.
+	 * Convert back from period to frequency for the SPI offload API.
+	 */
+	offload_period_ns = cnv_wf.period_length_ns;
+	config->periodic.frequency_hz = DIV_ROUND_UP(HZ_PER_GHZ, offload_period_ns);
+	min_read_offset = LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_TDSDOBUSYL_NS;
+	offload_offset_ns = min_read_offset;
+	do {
+		config->periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, config);
+		if (ret)
+			return ret;
+		offload_offset_ns += 10;
+	} while (config->periodic.offset_ns < min_read_offset);
+
+	st->cnv_wf = cnv_wf;
+	st->cnv_Hz = DIV_ROUND_CLOSEST_ULL(HZ_PER_GHZ, cnv_wf.period_length_ns);
+
+	return 0;
+}
+
+static ssize_t sampling_frequency_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct ltc2378_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit(buf, "%u\n", st->cnv_Hz);
+}
+
+static ssize_t sampling_frequency_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = kstrtouint(buf, 10, &val);
+	if (ret)
+		goto out_store;
+
+	ret = ltc2378_update_conversion_rate(st, val);
+
+out_store:
+	iio_device_release_direct(indio_dev);
+	return ret ?: len;
+}
+
+static IIO_DEVICE_ATTR_RW(sampling_frequency, 0);
+
+static ssize_t sampling_frequency_available_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "[%u %u %u]\n",
+			  1, 1, st->info->max_sample_rate_hz);
+}
+
+static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
+
+static struct attribute *ltc2378_offload_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+const struct attribute_group ltc2378_offload_attribute_group = {
+	.attrs = ltc2378_offload_attributes,
+};
+EXPORT_SYMBOL_NS_GPL(ltc2378_offload_attribute_group, "IIO_LTC2378");
+
+static int ltc2378_prepare_offload_message(struct device *dev,
+					   struct ltc2378_state *st)
+{
+	st->offload_xfer.bits_per_word = st->info->resolution;
+	/*
+	 * Ideally, we would ask the offload provider what data word sizes are
+	 * supported so we could use smaller words for less precise ADCs.
+	 * Though, the currently available SPI offloading hardware only supports
+	 * pushing 32-bit sized data elements to DMA memory. Because of that,
+	 * we hardcode set 4 byte sized transfers.
+	 */
+	st->offload_xfer.len = 4;
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+
+	/* Initialize message with offload */
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return devm_spi_optimize_message(dev, st->spi, &st->offload_msg);
+}
+
+static int ltc2378_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
+	if (ret)
+		return ret;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_pwm_disable;
+
+	return 0;
+
+out_pwm_disable:
+	pwm_disable(st->cnv_trigger);
+	return ret;
+}
+
+static int ltc2378_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ltc2378_offload_buffer_ops = {
+	.postenable = &ltc2378_offload_buffer_postenable,
+	.predisable = &ltc2378_offload_buffer_predisable,
+};
+
+static int ltc2378_spi_offload_setup(struct iio_dev *indio_dev,
+				     struct ltc2378_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+
+	indio_dev->setup_ops = &ltc2378_offload_buffer_ops;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma), "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
+static int ltc2378_pwm_get(struct ltc2378_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->cnv_trigger = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
+				     "failed to get cnv pwm\n");
+
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
+static const struct spi_offload_config ltc2378_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_device *spi)
+{
+	struct ltc2378_state *st = iio_priv(indio_dev);
+	struct device *dev = &spi->dev;
+	int ret;
+
+	st->offload = devm_spi_offload_get(dev, spi, &ltc2378_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+
+	ret = ltc2378_spi_offload_setup(indio_dev, st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to setup SPI offload\n");
+
+	ret = ltc2378_pwm_get(st);
+	if (ret)
+		return ret;
+
+	/*
+	 * Start with a slower sampling rate so there is some room for
+	 * adjusting the sampling frequency without hitting the maximum
+	 * conversion rate.
+	 */
+	ret = ltc2378_update_conversion_rate(st, st->info->max_sample_rate_hz >> 4);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to sampling frequency\n");
+
+	ret = ltc2378_prepare_offload_message(&spi->dev, st);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to optimize SPI message\n");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(ltc2378_offload_buffer_setup, "IIO_LTC2378");
+
+MODULE_IMPORT_NS("IIO_LTC2378");
diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 7916500c470c..fdbe919d45d5 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -42,101 +42,141 @@ static const struct ltc2378_chip_info ltc2378_chip_info[] = {
 	[ID_LTC2338_18] = {
 		.name = "ltc2338-18",
 		.resolution = 18,
+		.max_sample_rate_hz = HZ_PER_MHZ,
+		.tconv_ns = 527,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2364_16] = {
 		.name = "ltc2364-16",
 		.resolution = 16,
+		.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+		.tconv_ns = 3000,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2364_18] = {
 		.name = "ltc2364-18",
 		.resolution = 18,
+		.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+		.tconv_ns = 3000,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2367_16] = {
 		.name = "ltc2367-16",
 		.resolution = 16,
+		.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+		.tconv_ns = 1500,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2367_18] = {
 		.name = "ltc2367-18",
 		.resolution = 18,
+		.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+		.tconv_ns = 1500,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2368_16] = {
 		.name = "ltc2368-16",
 		.resolution = 16,
+		.max_sample_rate_hz = HZ_PER_MHZ,
+		.tconv_ns = 527,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2368_18] = {
 		.name = "ltc2368-18",
 		.resolution = 18,
+		.max_sample_rate_hz = HZ_PER_MHZ,
+		.tconv_ns = 527,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2369_18] = {
 		.name = "ltc2369-18",
 		.resolution = 18,
+		.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+		.tconv_ns = 412,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2370_16] = {
 		.name = "ltc2370-16",
 		.resolution = 16,
+		.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+		.tconv_ns = 322,
 		.out_format = IIO_SCAN_FORMAT_UNSIGNED_INT,
 	},
 	[ID_LTC2376_16] = {
 		.name = "ltc2376-16",
 		.resolution = 16,
+		.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+		.tconv_ns = 3000,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2376_18] = {
 		.name = "ltc2376-18",
 		.resolution = 18,
+		.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+		.tconv_ns = 3000,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2376_20] = {
 		.name = "ltc2376-20",
 		.resolution = 20,
+		.max_sample_rate_hz = 250 * HZ_PER_KHZ,
+		.tconv_ns = 3000,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2377_16] = {
 		.name = "ltc2377-16",
 		.resolution = 16,
+		.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+		.tconv_ns = 1500,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2377_18] = {
 		.name = "ltc2377-18",
 		.resolution = 18,
+		.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+		.tconv_ns = 1500,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2377_20] = {
 		.name = "ltc2377-20",
 		.resolution = 20,
+		.max_sample_rate_hz = 500 * HZ_PER_KHZ,
+		.tconv_ns = 1500,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2378_16] = {
 		.name = "ltc2378-16",
 		.resolution = 16,
+		.max_sample_rate_hz = HZ_PER_MHZ,
+		.tconv_ns = 527,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2378_18] = {
 		.name = "ltc2378-18",
 		.resolution = 18,
+		.max_sample_rate_hz = HZ_PER_MHZ,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
+		.tconv_ns = 527,
 	},
 	[ID_LTC2378_20] = {
 		.name = "ltc2378-20",
 		.resolution = 20,
+		.max_sample_rate_hz = HZ_PER_MHZ,
+		.tconv_ns = 675,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2379_18] = {
 		.name = "ltc2379-18",
 		.resolution = 18,
+		.max_sample_rate_hz = 1600 * HZ_PER_KHZ,
+		.tconv_ns = 412,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 	[ID_LTC2380_16] = {
 		.name = "ltc2380-16",
 		.resolution = 16,
+		.max_sample_rate_hz = 2 * HZ_PER_MHZ,
+		.tconv_ns = 322,
 		.out_format = IIO_SCAN_FORMAT_SIGNED_INT,
 	},
 };
@@ -226,6 +266,9 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info ltc2378_iio_info = {
+#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
+	.attrs = &ltc2378_offload_attribute_group,
+#endif
 	.read_raw = &ltc2378_read_raw,
 };
 
@@ -236,6 +279,7 @@ static int ltc2378_probe(struct spi_device *spi)
 	unsigned int num_iio_chans = 1;
 	struct iio_dev *indio_dev;
 	struct ltc2378_state *st;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
@@ -280,6 +324,23 @@ static int ltc2378_probe(struct spi_device *spi)
 	st->xfer.rx_buf = &st->scan.data;
 	st->xfer.len = BITS_TO_BYTES(ltc2378_chan->scan_type.storagebits);
 
+	ret = ltc2378_offload_buffer_setup(indio_dev, spi);
+	if (ret == -ENODEV) {
+		/* SPI offloading is unavailable. Fall back to triggered buffer. */
+		dev_notice(dev, "buffered data capture not supported\n");
+	} else if (ret) {
+		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
+	} else {
+		/*
+		 * Currently, the available offload hardware + DMA configuration
+		 * only supports pushing data to IIO buffers in CPU endianness.
+		 * That also requires we apply no shift to scan elements to
+		 * correctly read ADC sample data.
+		 */
+		ltc2378_chan->scan_type.shift = 0;
+		ltc2378_chan->scan_type.endianness = IIO_CPU;
+	}
+
 	indio_dev->channels = ltc2378_chan;
 	indio_dev->num_channels = num_iio_chans;
 
@@ -350,3 +411,4 @@ MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analog.com>");
 MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
 MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_LTC2378");
diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
index 515f7e8a4f2e..17c329b18333 100644
--- a/drivers/iio/adc/ltc2378.h
+++ b/drivers/iio/adc/ltc2378.h
@@ -9,7 +9,14 @@
 #define __DRIVERS_IIO_ADC_LTC2378_H__
 
 #include <linux/iio/iio.h>
+#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
+#include <linux/pwm.h>
+#endif
 #include <linux/spi/spi.h>
+#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/types.h>
+#endif
 #include <linux/types.h>
 #include <linux/units.h>
 
@@ -20,6 +27,8 @@
 struct ltc2378_chip_info {
 	const char *name;
 	int resolution;
+	unsigned int max_sample_rate_hz;
+	unsigned int tconv_ns;
 	const char out_format;
 };
 
@@ -29,6 +38,16 @@ struct ltc2378_state {
 	struct spi_device *spi;
 	struct spi_transfer xfer;
 	int ref_uV;
+#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
+	unsigned int cnv_Hz;
+	struct pwm_waveform cnv_wf;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_message offload_msg;
+	struct spi_transfer offload_xfer;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
+#endif
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the
@@ -45,4 +64,19 @@ struct ltc2378_state {
 	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
+#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
+extern const struct attribute_group ltc2378_offload_attribute_group;
+#endif
+
+#ifdef CONFIG_LTC2378_OFFLOAD_BUFFER
+int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_device *spi);
+#else
+static inline int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev,
+					       struct spi_device *spi)
+{
+	might_sleep();
+	return -ENODEV;
+}
+#endif
+
 #endif /* __DRIVERS_IIO_ADC_LTC2378_H__ */
-- 
2.53.0

