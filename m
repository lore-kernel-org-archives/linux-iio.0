Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83273D45C3;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212160; cv=none; b=cB4oqTpEjXkJkqg/kw1XcJLB1fbC8w8ga+oyz013Er+ZkKtb+OQ7Ul6XuaLOSdxJRkMlHmIElk0H9X9OiIJc+7W2fcMIGSt9NGLrLANRpZV1nWyYkpPtc0ZXbFa+MIOcMKLuWPNo+9kC/DI9GwK6/xfVoAstxnp+VMWWHoukTBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212160; c=relaxed/simple;
	bh=nlhFi0+ZyQf9kzwGsim/ExgSvXu9UoDsuyatyANwIWA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H3zP+/x4pGdbYNVzGZ9gdLC53TLl66gxGucuDoxy75BWE5GjYmD1DTNCzPhhb5pdYNiiIfB6Bn3jIhjyv9X8f7LcLS2WFVCExA26lJJ7oWQVYRlRi+UbdTB3ojIm7b5axqbC7vaGu2p4OzYwpeWx9NKJMZKREyMMutPfb+tzShY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yhaal/bN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yhaal/bN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D3A9C4AF0E;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782212160;
	bh=nlhFi0+ZyQf9kzwGsim/ExgSvXu9UoDsuyatyANwIWA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Yhaal/bNrUIqMak/VleKH/UVlxnpfIYQQadfeIPXHaWy+gZAepj4NgCDtab49BsEb
	 yvMg2CFiLzHh6TLhtNUnn5+TXnsw9kOHwN2czaK7UB2ec3vd1UsmsB4zsRp5pRFAU/
	 o4+H2gvtX2/onxMHuNl16bwYhXHfHDTMjms9mgEZMx19ZIdDjyvaU5lSkaciyMLkfx
	 B6DjUxHUhLkYam9aptc0yACJzUmxqpJ8Q/Pj64ghRoMt3HxfaV2ifgEOCLyweROndB
	 xo5UIypCeAUMpEBtlirs8cX1ZNMG+tmlyCY/z0eA30BnjhSz45/WCxJFHpC8S1UmMx
	 XbaZ6VbtAacDQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477B5CDB480;
	Tue, 23 Jun 2026 10:56:00 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 23 Jun 2026 11:55:51 +0100
Subject: [PATCH v4 11/12] iio: dac: ad5686: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-ad5686-new-features-v4-11-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
In-Reply-To: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782212158; l=3795;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=gdlVi1Bh5/6Mxt1rZP0vBPg5nT7eoX/OeePSTXjI6tg=;
 b=ifnBqoVzQ92cbsDLN5yCV9Bzoj3AgHnHX3GCAuXwAiJHmLktoZhMEsWteE4wCYhqRWhNXYR19
 LhafoWEPr0kBcenwDDjLwuJJsvDXWHlafDWjnxMjB5D85cxEZuJ5TaE
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

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/Kconfig  |  2 ++
 drivers/iio/dac/ad5686.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 657c68e75542..5f14fcd780e2 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -240,6 +240,8 @@ config LTC2688
 
 config AD5686
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config AD5686_SPI
 	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index db175e77b0b7..4dc681eb077d 100644
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
@@ -467,6 +472,60 @@ const struct ad5686_chip_info ad5679r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
+static irqreturn_t ad5686_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_buffer *buffer = indio_dev->buffer;
+	struct ad5686_state *st = iio_priv(indio_dev);
+	u16 val[AD5686_MAX_CHANNELS] = { };
+	unsigned int scan_count, ch, i;
+	bool async_update;
+	int ret;
+	u8 cmd;
+
+	ret = iio_pop_from_buffer(buffer, val);
+	if (ret) {
+		iio_trigger_notify_done(indio_dev->trig);
+		return IRQ_HANDLED;
+	}
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
+		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
+		if (ret)
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
+
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
 		 const char *name, const struct ad5686_bus_ops *ops,
@@ -569,6 +628,13 @@ int ad5686_probe(struct device *dev,
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


