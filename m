Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC263750DB;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418033; cv=none; b=Yi4OQxhN6tHqKYTndiwU8513HGWRkQjfxyrsIkftVDBXzfbBSEKXB0R+dr90W6CEp7I5viQkDqk0iDYghR7yntApmPrNe2iTdKYuFYgh/svJCeucOr1TNK8AmBigxYC+Y61WC7X/H8kr/KwUBfa1PARK7C3O9/y2Rf3TWmvMX0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418033; c=relaxed/simple;
	bh=xoxiNijWqkSxyRa+DL1gBCKIDk4MEnYqXu1H4fCap5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c3BPIuf5OwDdRoJE10opA04eL80txSmEul03MqHxDIsiAXGOPToMgvQxJ1pgHYRfaP9KMUkPP+a9MAJIlZSIyvYVkJdwAxHzH8wLN8wEZ2DTUn5DgX4rbCKQ99hIzHywcIMp+U3VXV/lJagMiDJDtwrmH3fp1sWTjOxdWOOKkIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAJc0Yd1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAJc0Yd1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71FD5C2BCF7;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418033;
	bh=xoxiNijWqkSxyRa+DL1gBCKIDk4MEnYqXu1H4fCap5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eAJc0Yd1Fv9N62++nxvw4bAwtoM3QMnjAvuQHOFZpF+7HrtrdwU7kHmnlq1odaEGV
	 aQbDMK5vD9P0Jtvk0geNJlO5IhfiPVILKDBEdKqEqunKBeylGBP+D0l8Py24zg7x3p
	 kpQMxPqsyIZ6GNU27lkA+5KDFuwnTIyUP/VOmepmh/KGSIb1tRQvVib4bpKO0k3orR
	 EcwdkI/Uo4LronpQ8U6J/BrzYnUgZKKrXYVrkmx1MgccQuHOuWqaMNuHO2ZxHQVwO+
	 qerNQ+EVOd/DZE2HsJoCXT4yOqncZvr/q411fyN/wsuiiMQAz5lCf/rEu0Brk2fc6y
	 G4ULB1Xv5OXRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A363CD6E57;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 02 Jun 2026 17:33:57 +0100
Subject: [PATCH 10/12] iio: dac: ad5686: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
In-Reply-To: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=3523;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=NkwPSM/HeIv2TIXju9nekbHoT2W+fYgNfc8kUZ545qg=;
 b=c/nRUD3meAVZeSmZCksdOe5Y+XPs5RMMtGVq3bhKB6U/r/WExqoXDiFZYMYRhSNZKSB2PiLob
 lqaS1TYWJGUABQNb/sQIU7bEnSC2fJoTMClJCzBNu3xY6/B0463pXPZ
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
 drivers/iio/dac/ad5686.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

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
index a4cc0f86ea54..5052df44ab1c 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -19,7 +19,11 @@
 #include <linux/sysfs.h>
 #include <linux/wordpart.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #include "ad5686.h"
 
@@ -245,6 +249,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
 		.address = addr,				\
+		.scan_index = chan,				\
 		.scan_type = {					\
 			.sign = 'u',				\
 			.realbits = (bits),			\
@@ -469,6 +474,53 @@ const struct ad5686_chip_info ad5679r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
+static irqreturn_t ad5686_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_buffer *buffer = indio_dev->buffer;
+	struct ad5686_state *st = iio_priv(indio_dev);
+	u16 val[AD5686_MAX_CHANNELS] = { };
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
+		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
+		if (ret)
+			goto cleanup;
+	}
+
+	if (st->ops->sync)
+		ret = st->ops->sync(st); /* flush all pending transfers */
+
+cleanup:
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
@@ -569,6 +621,13 @@ int ad5686_probe(struct device *dev,
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


