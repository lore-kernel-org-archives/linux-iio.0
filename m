Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBDD3603E1;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869185; cv=none; b=kVKIQgRgD2tvKfh3/4SKVXHg5yimHxr2hJOnArfB8R3j1mmWiVeSlujwyS5x3Ned4ZR+bCjJOkfPfRd8jaoWhBVzTKh9ktAqurqF8WPJ/lHKSetjC4vKJYdB0p11l/72TMNfVay3Vgez39FNcYWs8yFwYT0jGzfrt2/N16o349k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869185; c=relaxed/simple;
	bh=dV2Vf7Kj1xLGuXV3YDzzCt7K7isy1Z1mBtR4HJ/idCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DVhE9JJgf7I1Rkg7ic2vQZ9Z04hYrQo4kHXAUeZ7K748+MV/dkJ9EPenIeXWVJv12kSRls5etUJksmlYO1cOa9dtXnsfiWEhjBMHifPfLomARLTSW+JDXEim9HbKP1BSXqqRW6fUI7WM8sjpV+Z44Swtx0HOr/hR/bEu13xJeS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQJkw0ng; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQJkw0ng"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D663C2BCFA;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869185;
	bh=dV2Vf7Kj1xLGuXV3YDzzCt7K7isy1Z1mBtR4HJ/idCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PQJkw0ngmL1E0hQP+pNuvOhTLtZHjv4+zyv//sE8OaGwB8VSTQnucoBhVo06W9eBA
	 SxHucZBnPft5GWqLhjkVz3z9SUSl5NfRqPGry5y5+c9Btnkd+1nDF4o2tG1KXKGINs
	 loo58X7O0Rze/Mgo5e/243qD0ADPKU+WxVJmPAPJHBKl5kedr6mAZlrMXqVOM3mZ75
	 ZyPLRjvW1Z5aqzDbF4oBA5mh/VJGF7o3klhZPUluAqQc6XW3FmwROT5v+UUIRDNZoX
	 qIZ4iz8dPMypPE8eBeSApnBb9nfnWsJJI6i/ZCeQNOm+mQITsq0zpp2xb8ZkJFoTbJ
	 NemrPowidbueQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37527F9EDF6;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:55 +0100
Subject: [PATCH 21/22] iio: dac: ad5686: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-21-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=3587;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=n/jQcRuYKzz2K1D7fdN2/Uolo6lmFJ6ohrN+/ywPH1A=;
 b=8goP76zj/wMm+SjuSmvAExMrATiZuEpHhx17kq6AfjB6Pb6MTqC2fmN1FtDaYzg8r9irxnzEG
 1+gUKCYPOUJBQvcmyLuHUoshgO+k41cgOvWObU0vwb1ERh2qtM6Y3ro
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Trigger handler is implemented by leveraging the LDAC gpio when it is
available. Multiple channel writes can be flushed at once with the sync()
operation.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/Kconfig  |  2 ++
 drivers/iio/dac/ad5686.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 8ef4a87d6d6a..bb4d3bdabef2 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -229,6 +229,8 @@ config LTC2688
 
 config AD5686
 	tristate
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 
 config AD5686_SPI
 	tristate "Analog Devices AD5686 and similar multi-channel DACs (SPI)"
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index a065c614c874..bec951afe8d0 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -16,6 +16,11 @@
 #include <linux/sysfs.h>
 #include <linux/wordpart.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
+
 #include "ad5686.h"
 
 static const char * const ad5686_powerdown_modes[] = {
@@ -227,6 +232,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
 		.address = addr,				\
+		.scan_index = chan,				\
 		.scan_type = {					\
 			.sign = 'u',				\
 			.realbits = (bits),			\
@@ -506,6 +512,55 @@ const struct ad5686_chip_info ad5679r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
+static irqreturn_t ad5686_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_buffer *buffer = indio_dev->buffer;
+	struct ad5686_state *st = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	u16 val[AD5686_MAX_CHANNELS];
+	int ret, ch, i = 0;
+	bool async_update;
+	u8 cmd;
+
+	ret = iio_pop_from_buffer(buffer, val);
+	if (ret)
+		goto out;
+
+	mutex_lock(&st->lock);
+
+	async_update = st->ldac_gpio && bitmap_weight(indio_dev->active_scan_mask,
+						      iio_get_masklength(indio_dev)) > 1;
+	if (async_update) {
+		/* use ldac to update all channels simultaneously */
+		cmd = AD5686_CMD_WRITE_INPUT_N;
+		gpiod_set_value_cansleep(st->ldac_gpio, 0);
+	} else {
+		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
+	}
+
+	iio_for_each_active_channel(indio_dev, ch) {
+		chan = &indio_dev->channels[ch];
+		ret = st->ops->write(st, cmd, chan->address,
+				     val[i++] << chan->scan_type.shift);
+		if (ret)
+			break;
+	}
+
+	if (!ret && st->ops->sync)
+		ret = st->ops->sync(st); /* flush all pending transfers */
+
+	if (async_update)
+		gpiod_set_value_cansleep(st->ldac_gpio, 1);
+
+	mutex_unlock(&st->lock);
+out:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
 		 const char *name, const struct ad5686_bus_ops *ops,
@@ -599,6 +654,13 @@ int ad5686_probe(struct device *dev,
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


