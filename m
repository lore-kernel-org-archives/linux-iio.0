Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440342;
	b=UA+5qErtRnUJ1Os8ejdbzRYRDkPUiR1vIlcaZjqXegIRBW8giDDaZh8cPbrn+2LKs865
	 y0baozKjeTQrQdM0b+/7J87xiU3OATDBROdPYFDOuU2GI5fL52qCgpFXkmP6+enKVLigj
	 wTBR0lxoLbvHlDjCDPOcKe6lGWGZeJHgV9BzG2OdQlzCq4J+f7SntnTIdKAQU9zZckfY+
	 L6MVzccL/ikfDv4QqDaAc2SmFxMescjikYtgkhJvy5ixxndoGI5E3T0iZYJLHcrDpIPu5
	 kL67nTALS/hj35moKKJUBWgb1aJcB8heYmJuJ/Mejzt4fSy9DabR3gyBDPLuauvb+fA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440342;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=47Roz2ShdMvtfYiACxcQoWz44mZIKFEeV52/Z6Eg1vA=;
	b=3dBuTQWRMS81DgZo0CrZYnhXlJFbQyHIqDShHlkShwB13pgpAIh2ehjPde7WS22Xfz3u
	 N/1xj6Me21G7sGejQPfAYL58gk+kykvGL3k2cO5TeponRvj0a41el5ccWtFe5y2gI+EXy
	 E7kf/kPmRUHIt0V368yVvpzyT7Xgdhi2B40LzsMhMW0GvSNSVn28gKAgQ2BV71ugIP1Kv
	 qUHonbbpvePRkvOOEsj14BZFsyUM66hs+3YVWps1T+w4yRRhhMEAFvg1J9Wg9A/FwScqD
	 eJxMwEWuMYDmn1fZ5P0I0lFSrEBu0pH4kXSqjCR2UTMyHGr3R1E7P2q6QRfv2wfvSWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEDfAUWb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA60606A692;
	Mon, 23 Nov 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEDfAUWb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440341;
	b=v53TafGdn05UqacfdXmldvqzIfHMXMIDfZlE1nHV3Jmj8ELBYkatxbnxw8KAjQjkxxjY
	 BmWN6MrHakRe7b1M+UKFHAInyHX2yd0sQHmo4PqrRMS7UHw0j2qf2hfHgOq09uPh3ujOk
	 uHQRHCRtqjCeAbgmgMl934FG5xQyFhKDetX5TbNkWXyqaPaEvBcO37vsz8w1rhE+X7xWH
	 krHXdOv5f98m32ApOs7kA2iMe3w4dHKLG2Hi1I/qO6LPJbXriqatIiGUYQkZbndhnyCmt
	 1IbZt7aH9SeK5G7PVSI0a2SX8jJceMHHcoysEhqyzZAGP33MCsWXEoMNpYIU9SY1rbg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440341;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=47Roz2ShdMvtfYiACxcQoWz44mZIKFEeV52/Z6Eg1vA=;
	b=cziApHUymXy/5/HysxrB4xoPm0GC+j3Xo2Ces+KuGCSsgKUBF/oxTizU3MVcFElOQvev
	 uRlw2rRkpIm2mpNXH7wZZglfOO84Zd1A9kMjNa3TGHL264MkWZx65VdpVlrGftqygIPtB
	 +dCsqpvSqoXQVPXaTb4aFAULJnjUzHEV2cmetAJg+5f/C7ooWK4hYzLgozL2565YvfNIZ
	 9/lzF5iEgRwCeQWSJW2h/RceDuwXTqWZBk6LCCZKpcIfE4Z0bZNnXHYF8/q0kOJA/lybD
	 E0TosMcgu03XdukFRc0tLLRTwFbsHGLMAxB+hh8iKWObYT1XJ3+N3KTVrI3lVFnHBUw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 09D2D1F000D4;
	Mon, 23 Nov 2026 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440341;
	bh=47Roz2ShdMvtfYiACxcQoWz44mZIKFEeV52/Z6Eg1vA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BEDfAUWbd/ApjNqNxQCALfOk3JkVZZ4BMl7o3VoUff2F3XFQxKMlHVzGBaHoOz3LE
	 GQZhMPCRyIz2MiOV3hFjderLay9V9grU843lcryeGwkybhDrr7Kixs19NVmUKq86ZS
	 Qlzv+LwcxX0x6ox0w/SmO1UrZDDM59Sn3PJSDQrJK9jz2jxfG8cDLaMp3izDnLcyAk
	 tqvESO14mr9MyXKOtEfmw2XzdfqJmgjL2m4WbFUulocRy+VSntpwEsX8Kxfu1a/Bt/
	 /SD6hC5GMXaQ2PoFU92bIly2ypWdKW9SLaVTInBY0V9+BN5InfptFNr882FgxpVGaY
	 9cTg7Vjx+FY3A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8799E4C495;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 23 Nov 2026 15:25:26 +0200
Subject: [PATCH 2/7] iio: imu: adis: Add a kfifo buffer setup helper for
 FIFO devices
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-adis-fifo-v1-2-f6ad9e493e19@analog.com>
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
In-Reply-To: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
 Radu Sabau <radu.sabau@analog.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440327; l=8434;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=gsQHAC9QTe/dAmiHhtXzAdEosCoLWNzpLjvdYa7amHw=;
 b=5/Jr3WeuIC0narguV8H1Jyqs6VYr7pVcYOmkRto8Xj+9VK2/hKBPbinqfhyWSmLmRxCfpJDSh
 BIuiBx6MEp/D7xyREY9sA/N9mOu/V1Pjr9fNO2/Y2/ncnFV93mPCKPc
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Devices with a hardware FIFO (has_fifo) currently go through the
triggered buffer: the FIFO interrupt is requested with
iio_trigger_generic_data_rdy_poll() as its thread function, which calls
iio_trigger_poll() from the IRQ thread, and the samples are read from a
trigger handler. iio_trigger_poll() is meant to be called from hard
interrupt context, and the FIFO then depends on whatever trigger is
selected.

Add devm_adis_setup_kfifo_buffer() for such devices. It sets up a kfifo
buffer and requests the FIFO interrupt as a oneshot threaded IRQ running a
handler supplied by the driver, which reads the FIFO and pushes the
samples. The interrupt is requested disabled, and the driver enables and
disables it with enable_irq() and disable_irq() from its buffer setup
functions. This is done without the adis lock, which the handler takes.

The trigger/current_trigger attribute is user visible on the existing FIFO
devices, so add devm_adis_register_fifo_trigger() for them to keep it. It
registers a trigger with the usual name and sets INDIO_HARDWARE_TRIGGERED
so the attribute exists. The buffer runs in software mode, so the trigger
has no effect on it: writing it is accepted and ignored, as
hid-sensor-trigger does for the same reason. New drivers do not need it.

No driver uses the helpers yet.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/Kconfig        |  1 +
 drivers/iio/imu/adis_buffer.c  | 45 ++++++++++++++++++++++++++++++++++
 drivers/iio/imu/adis_trigger.c | 55 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/iio/imu/adis.h   | 32 ++++++++++++++++++++++++
 4 files changed, 133 insertions(+)

diff --git a/drivers/iio/imu/Kconfig b/drivers/iio/imu/Kconfig
index 8b91426f60d0..b00acccab061 100644
--- a/drivers/iio/imu/Kconfig
+++ b/drivers/iio/imu/Kconfig
@@ -151,6 +151,7 @@ config IIO_ADIS_LIB
 
 config IIO_ADIS_LIB_BUFFER
 	bool
+	select IIO_KFIFO_BUF
 	select IIO_TRIGGERED_BUFFER
 	help
 	  A set of buffer helper functions for the Analog Devices ADIS* device
diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
index 501da4eaef69..e49e02adeda6 100644
--- a/drivers/iio/imu/adis_buffer.c
+++ b/drivers/iio/imu/adis_buffer.c
@@ -15,6 +15,7 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/imu/adis.h>
@@ -220,3 +221,47 @@ devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis, struct iio_dev
 					adis);
 }
 EXPORT_SYMBOL_NS_GPL(devm_adis_setup_buffer_and_trigger_with_attrs, "IIO_ADISLIB");
+
+/**
+ * devm_adis_setup_kfifo_buffer() - Sets up a kfifo buffer for a FIFO adis device
+ * @adis: The adis device
+ * @indio_dev: The IIO device
+ * @thread_fn: Threaded interrupt handler which reads the device FIFO and
+ *	       pushes the samples to the buffer. It is called with @indio_dev
+ *	       as dev_id.
+ * @ops: Optional buffer setup functions, may be NULL.
+ * @buffer_attrs: Extra buffer attributes.
+ *
+ * Returns 0 on success, a negative error code otherwise.
+ *
+ * Unlike devm_adis_setup_buffer_and_trigger_with_attrs(), the samples are not
+ * captured from a trigger handler. The device FIFO interrupt is requested as a
+ * threaded oneshot IRQ running @thread_fn, and the data goes straight to a
+ * kfifo buffer. The IRQ is requested disabled and the driver enables and
+ * disables it with enable_irq() and disable_irq() from its buffer setup
+ * functions, without holding the adis lock. Devices which already had a
+ * trigger/current_trigger attribute can keep it with
+ * devm_adis_register_fifo_trigger().
+ */
+int devm_adis_setup_kfifo_buffer(struct adis *adis, struct iio_dev *indio_dev,
+				 irq_handler_t thread_fn,
+				 const struct iio_buffer_setup_ops *ops,
+				 const struct iio_dev_attr **buffer_attrs)
+{
+	int ret;
+
+	ret = devm_iio_kfifo_buffer_setup_ext(&adis->spi->dev, indio_dev, ops,
+					      buffer_attrs);
+	if (ret)
+		return ret;
+
+	if (adis->spi->irq) {
+		ret = devm_adis_request_fifo_irq(adis, indio_dev, thread_fn);
+		if (ret)
+			return ret;
+	}
+
+	return devm_add_action_or_reset(&adis->spi->dev, adis_buffer_cleanup,
+					adis);
+}
+EXPORT_SYMBOL_NS_GPL(devm_adis_setup_kfifo_buffer, "IIO_ADISLIB");
diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
index 3e6a7af6ab01..ea8661bff901 100644
--- a/drivers/iio/imu/adis_trigger.c
+++ b/drivers/iio/imu/adis_trigger.c
@@ -104,3 +104,58 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_NS_GPL(devm_adis_probe_trigger, "IIO_ADISLIB");
 
+/**
+ * devm_adis_request_fifo_irq() - Requests the FIFO interrupt of an adis device
+ * @adis: The adis device
+ * @indio_dev: The IIO device
+ * @thread_fn: Threaded interrupt handler, called with @indio_dev as dev_id
+ *
+ * Requests the (level triggered) FIFO interrupt as a oneshot threaded IRQ. The
+ * IRQ is requested disabled: the driver enables it with enable_irq() once the
+ * device FIFO is running and disables it with disable_irq() before stopping
+ * it, without holding the adis lock as @thread_fn takes it.
+ *
+ * Returns 0 on success or a negative error code
+ */
+int devm_adis_request_fifo_irq(struct adis *adis, struct iio_dev *indio_dev,
+			       irq_handler_t thread_fn)
+{
+	int ret;
+
+	ret = adis_validate_irq_flag(adis);
+	if (ret)
+		return ret;
+
+	adis->irq_flag |= IRQF_NO_AUTOEN;
+
+	return devm_request_threaded_irq(&adis->spi->dev, adis->spi->irq, NULL,
+					 thread_fn, adis->irq_flag | IRQF_ONESHOT,
+					 indio_dev->name, indio_dev);
+}
+EXPORT_SYMBOL_NS_GPL(devm_adis_request_fifo_irq, "IIO_ADISLIB");
+
+/**
+ * devm_adis_register_fifo_trigger() - Registers the legacy trigger of a FIFO device
+ * @adis: The adis device
+ * @indio_dev: The IIO device
+ *
+ * Registers an IIO trigger named after the device. It is never used to push
+ * samples, as the data goes to a kfifo buffer. It only keeps the
+ * trigger/current_trigger interface of devices that always had it, so writing
+ * it is accepted but has no effect. New drivers do not need it.
+ *
+ * Returns 0 on success or a negative error code
+ */
+int devm_adis_register_fifo_trigger(struct adis *adis, struct iio_dev *indio_dev)
+{
+	adis->trig = devm_iio_trigger_alloc(&adis->spi->dev, "%s-dev%d",
+					    indio_dev->name,
+					    iio_device_id(indio_dev));
+	if (!adis->trig)
+		return -ENOMEM;
+
+	indio_dev->modes |= INDIO_HARDWARE_TRIGGERED;
+
+	return devm_iio_trigger_register(&adis->spi->dev, adis->trig);
+}
+EXPORT_SYMBOL_NS_GPL(devm_adis_register_fifo_trigger, "IIO_ADISLIB");
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index c9016f636530..4f87321a2d5e 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -569,6 +569,16 @@ devm_adis_setup_buffer_and_trigger_with_attrs(struct adis *adis,
 
 int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
 
+int devm_adis_setup_kfifo_buffer(struct adis *adis, struct iio_dev *indio_dev,
+				 irq_handler_t thread_fn,
+				 const struct iio_buffer_setup_ops *ops,
+				 const struct iio_dev_attr **buffer_attrs);
+
+int devm_adis_request_fifo_irq(struct adis *adis, struct iio_dev *indio_dev,
+			       irq_handler_t thread_fn);
+
+int devm_adis_register_fifo_trigger(struct adis *adis, struct iio_dev *indio_dev);
+
 int adis_update_scan_mode(struct iio_dev *indio_dev,
 			  const unsigned long *scan_mask);
 
@@ -590,6 +600,28 @@ static inline int devm_adis_probe_trigger(struct adis *adis,
 	return 0;
 }
 
+static inline int
+devm_adis_setup_kfifo_buffer(struct adis *adis, struct iio_dev *indio_dev,
+			     irq_handler_t thread_fn,
+			     const struct iio_buffer_setup_ops *ops,
+			     const struct iio_dev_attr **buffer_attrs)
+{
+	return 0;
+}
+
+static inline int
+devm_adis_request_fifo_irq(struct adis *adis, struct iio_dev *indio_dev,
+			   irq_handler_t thread_fn)
+{
+	return 0;
+}
+
+static inline int
+devm_adis_register_fifo_trigger(struct adis *adis, struct iio_dev *indio_dev)
+{
+	return 0;
+}
+
 #define adis_update_scan_mode NULL
 
 #endif /* CONFIG_IIO_BUFFER */

-- 
2.43.0


