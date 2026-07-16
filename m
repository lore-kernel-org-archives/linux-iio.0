Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2B541E6BB;
	Thu, 16 Jul 2026 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204077; cv=none; b=EY55bsCuCsW/JC8d/BJvpwoeK4QnpLAOKe9R3U4oTHGs0m3oHopozuVEU/wKkqbr60f89teFj4tdrGf3l6IaS7CoyC2jgB7x3Zr8Zfg9Xj/5QulaHDGS9MqEkJsIt+fyEoTuNtsz65112jBjb3QRn1mJWfoVItQdA9yBkaEABP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204077; c=relaxed/simple;
	bh=HyR/eo5tBb4Q7cGjKD/lBsOZgbeOOl0Kaa2H1BehuA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9r/cw+Ku19O2qssivdkJG1LpjxFGWLdeSMbreCmDRGThxE+34GFGo2SMfEq2PL/ju0JQGfBgGzY6nN7zWY3xa8rmWPgEbMFDhy8UkroNfJ0I6vFl8vveJS0g7cywA5h9Jvb6SE0a01ucZDZo3a5HHtYuOPOz7Al7m+mHqW3NYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7F8nuG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7F8nuG/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FCDCC4AF1D;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784204075;
	bh=HyR/eo5tBb4Q7cGjKD/lBsOZgbeOOl0Kaa2H1BehuA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=t7F8nuG/+xU4j+am23mohPiE24QDU4SG8CytKRkHEofQaz/ja11k0BxSuaoCnnnd4
	 IJQMzmKA52GT9C9BllSybIF0LgUDzZW27pVtNvC2ONUV/o7Mq8i38tRu5CFma3eKfy
	 oxx5yvG+dFDFXRXPrY/5ay6+Qk+rp0GGNGO2oCcFMdHPQyXVGBeZkB56Umq+g6bQ3Z
	 ef4Loz0fACqAC5RlRzy+/0EqnG9yAQcXeiKQy4m5SbxY3Fw24kL5himLKvcgO/fSgg
	 UZVDjasNVv44v5Qppb1SaTQrJcN4JZhILYcmJTJMUbC9XyjJQ9Cw3lrA9nJOUifIcM
	 uirS3FWwMkdfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA6C44519;
	Thu, 16 Jul 2026 12:14:35 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 16 Jul 2026 13:14:23 +0100
Subject: [PATCH v8 7/8] iio: dac: ad5686: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-ad5686-new-features-v8-7-ebb0051af5e5@analog.com>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
In-Reply-To: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784204073; l=3821;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=HVpJWaMY4JQgk+9g+vYOR9qz3Pg7ONQZGtM+R0PYMNU=;
 b=M8WmDWAZGQ7fXbS5aJWXnTNRivturvb8AWQTxIUvzK54JCjCBLzpx1+tnGJSzyVy0R+Y82ULN
 XFLSpnuFWGkDRmoz1PCBKWTClyiwxjTl7D74PjWZ25VkZS2yn4YRx4o
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Implement trigger handler by leveraging the LDAC gpio to update all DAC
channels at once when it is available. Also, the multiple channel writes
can be flushed at once with the sync() operation.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/Kconfig  |  2 ++
 drivers/iio/dac/ad5686.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 17529509da9d..d6d560c09e25 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -243,6 +243,8 @@ config LTC2688
 
 config AD5686
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config AD5686_SPI
 	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 68986dbaccea..99a9bd2ea714 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -21,7 +21,11 @@
 #include <linux/sysfs.h>
 #include <linux/wordpart.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "ad5686.h"
 
@@ -243,6 +247,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
 		.address = addr,				\
+		.scan_index = chan,				\
 		.scan_type = {					\
 			.sign = 'u',				\
 			.realbits = (bits),			\
@@ -467,6 +472,59 @@ const struct ad5686_chip_info ad5679r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
+static void do_ad5686_trigger_handler(struct iio_dev *indio_dev)
+{
+	struct ad5686_state *st = iio_priv(indio_dev);
+	u16 val[AD5686_MAX_CHANNELS] = { };
+	unsigned int scan_count, ch, i;
+	bool async_update;
+	u8 cmd;
+
+	if (iio_pop_from_buffer(indio_dev->buffer, val))
+		return;
+
+	guard(mutex)(&st->lock);
+
+	scan_count = bitmap_weight(indio_dev->active_scan_mask,
+				   iio_get_masklength(indio_dev));
+	async_update = st->ldac_gpio && scan_count > 1;
+	if (async_update) {
+		/* use LDAC to update all channels simultaneously */
+		cmd = AD5686_CMD_WRITE_INPUT_N;
+		gpiod_set_value_cansleep(st->ldac_gpio, 0);
+	} else {
+		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
+	}
+
+	i = 0;
+	iio_for_each_active_channel(indio_dev, ch) {
+		if (st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]))
+			break;
+	}
+
+	/*
+	 * If sync() is available, it is called here regardless of write
+	 * failure to allow bus implementation to reset. In that case, partial
+	 * writes are unlikely as the write operations would just queue up
+	 * the transfers.
+	 */
+	if (st->ops->sync)
+		st->ops->sync(st);
+
+	if (async_update)
+		gpiod_set_value_cansleep(st->ldac_gpio, 1);
+}
+
+static irqreturn_t ad5686_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	do_ad5686_trigger_handler(indio_dev);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
 		 const char *name, const struct ad5686_bus_ops *ops,
@@ -572,6 +630,13 @@ int ad5686_probe(struct device *dev,
 		return -EINVAL;
 	}
 
+	ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev, NULL,
+						  &ad5686_trigger_handler,
+						  IIO_BUFFER_DIRECTION_OUT,
+						  NULL, NULL);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad5686_probe, "IIO_AD5686");

-- 
2.43.0


