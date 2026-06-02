Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3B377553;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418033; cv=none; b=iF11LuneOVHulDA+OXcANVCrBofhf59/JmZ7nwdmMjOmbmkfGpLiFuEISG4Wkp99iSgUxfYTNKUdDZ2JzZ+7/4n3wjsFspo1iKUMt/fZP7O8klVIB2Y0GztowiXqPxG/u9eVjqFyGpKKzVbaHmeLLHUmqg0MmaTedU+WueSBu70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418033; c=relaxed/simple;
	bh=qsMK8Q2HM6jTGoQPEbrRSvbyVLrZlkP5fRZbE+xOgYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUJfTu/j5OoWnofXD6f938iA7DP7NEOwX4pYbfeUc1WbwHIJMN33cAjk381jvdYF9v9giMhN84PAn8biqjwfPEn7T6/nxDJWbgyMOCifPr1+KBbaCjbbT74lLtJDU/w9WHeR86NwwRjfN4MB4TmBVdYScBXEOGkR3huCuJdOH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twLLZfCL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twLLZfCL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABA96C2BCC7;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418033;
	bh=qsMK8Q2HM6jTGoQPEbrRSvbyVLrZlkP5fRZbE+xOgYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=twLLZfCLW3M5hjfRLntb9hJiCNy/XPY9HzvKMWljRpaRh1kyDzCOOsIOHg4TGgsPL
	 vidx1qtU4sAa1bislzL5vImsKqSEsjrmGTqAp//mF9sQmLmRl9sT32Qt3OGXCY4FDA
	 uigfXaZRkeP/M+/VpIKH6twiP1mUGL9SQ0L5x7w0f9L8QljAYhHrFzoVrOKgJuX7VP
	 q5WnerDOK1DpNwuo8G5HeBy2NArRp2C3pYSB1kWIOXZXBJv5qv5GDDGLYOIjbviuGV
	 qdnIQBgajWNhqGnycdMe6mhnikL2GNpgnrX40HvXCDHWaUYuaEs9m1wg7p2CD4RDsx
	 1ntPYKgrOtb+w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03BDCD5BD1;
	Tue,  2 Jun 2026 16:33:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 02 Jun 2026 17:33:59 +0100
Subject: [PATCH 12/12] iio: dac: ad5686: add gain control support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ad5686-new-features-v1-12-691e01883d27@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=7911;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=vqAOSWmQzVBmJ7L7sOnIK3s3iVYpw9YgEy4GB79ktSg=;
 b=dbzjSv28Hz9cjn/9A2b1SXPj75QVaExCRn6xGJq1sKrP1p5R7gOYRQtQWr5aFmy7siCN9juIk
 LFAio8o6v/8C2SFAFUn87XkJRLRndVNbMkFcOdJ4oO3rmN8n8KyZY8X
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Most of the supported devices rely on a GAIN pin to control a 2x
multiplier applied to the output voltage. Other devices, e.g. the
single-channel ones, provides a gain control through a bit field in the
control register. Some designs might have the GAIN pin hardwired to
VDD/VLOGIC or GND, which would still be fine for this patch, that allows
the scale property to be configurable with two available options.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 96 +++++++++++++++++++++++++++++++++++++++++++++---
 drivers/iio/dac/ad5686.h |  8 ++++
 2 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 54b953018cfa..fabe967c5225 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -13,10 +13,12 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/kstrtox.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 #include <linux/wordpart.h>
 
 #include <linux/iio/buffer.h>
@@ -39,7 +41,8 @@ static int ad5310_control_sync(struct ad5686_state *st)
 
 	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
 			    FIELD_PREP(AD5310_PD_MSK, pd_val & AD5686_PD_MSK) |
-			    FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+			    FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1) |
+			    FIELD_PREP(AD5310_GAIN_BIT_MSK, st->double_scale ? 1 : 0));
 }
 
 static int ad5683_control_sync(struct ad5686_state *st)
@@ -48,7 +51,8 @@ static int ad5683_control_sync(struct ad5686_state *st)
 
 	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
 			    FIELD_PREP(AD5683_PD_MSK, pd_val & AD5686_PD_MSK) |
-			    FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+			    FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1) |
+			    FIELD_PREP(AD5683_GAIN_BIT_MSK, st->double_scale ? 1 : 0));
 }
 
 static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
@@ -191,9 +195,14 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 			GENMASK(chan->scan_type.realbits - 1, 0);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->vref_mv;
-		*val2 = chan->scan_type.realbits;
-		return IIO_VAL_FRACTIONAL_LOG2;
+		if (st->double_scale) {
+			*val = st->scale_avail[2];
+			*val2 = st->scale_avail[3];
+		} else {
+			*val = st->scale_avail[0];
+			*val2 = st->scale_avail[1];
+		}
+		return IIO_VAL_INT_PLUS_NANO;
 	}
 	return -EINVAL;
 }
@@ -215,6 +224,63 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
 				    chan->address, val << chan->scan_type.shift);
+	case IIO_CHAN_INFO_SCALE:
+		if (val == st->scale_avail[0] && val2 == st->scale_avail[1])
+			st->double_scale = false;
+		else if (val == st->scale_avail[2] && val2 == st->scale_avail[3])
+			st->double_scale = true;
+		else
+			return -EINVAL;
+
+		switch (st->chip_info->regmap_type) {
+		case AD5310_REGMAP:
+			return ad5310_control_sync(st);
+		case AD5683_REGMAP:
+			return ad5683_control_sync(st);
+		case AD5686_REGMAP:
+			/*
+			 * even if the gain pin is hardwired on the board, the
+			 * user is able to control the scale such that it
+			 * matches the actual gain setting.
+			 */
+			gpiod_set_value_cansleep(st->gain_gpio,
+						 st->double_scale ? 1 : 0);
+			return 0;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5686_write_raw_get_fmt(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan,
+				    long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5686_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct ad5686_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*vals = st->scale_avail;
+		*length = ARRAY_SIZE(st->scale_avail);
+		return IIO_AVAIL_LIST;
 	default:
 		return -EINVAL;
 	}
@@ -223,6 +289,8 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5686_info = {
 	.read_raw = ad5686_read_raw,
 	.write_raw = ad5686_write_raw,
+	.write_raw_get_fmt = ad5686_write_raw_get_fmt,
+	.read_avail = ad5686_read_avail,
 };
 
 static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
@@ -244,6 +312,7 @@ static const struct iio_chan_spec_ext_info ad5686_ext_info[] = {
 		.channel = chan,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE),\
 		.address = addr,				\
 		.scan_index = chan,				\
 		.scan_type = {					\
@@ -470,6 +539,16 @@ const struct ad5686_chip_info ad5679r_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
+static void ad5686_init_scale_avail(struct ad5686_state *st)
+{
+	int realbits = st->chip_info->channels[0].scan_type.realbits;
+	s64 tmp;
+
+	tmp = 2ULL * st->vref_mv * NANO >> realbits;
+	st->scale_avail[2] = div_s64_rem(tmp, NANO, &st->scale_avail[3]);
+	st->scale_avail[0] = div_s64_rem(tmp >> 1, NANO, &st->scale_avail[1]);
+}
+
 static irqreturn_t ad5686_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -569,6 +648,13 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
 				     "Failed to get LDAC GPIO\n");
 
+	st->gain_gpio = devm_gpiod_get_optional(dev, "gain", GPIOD_OUT_LOW);
+	if (IS_ERR(st->gain_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->gain_gpio),
+				     "Failed to get GAIN GPIO\n");
+
+	ad5686_init_scale_avail(st);
+
 	udelay(5); /* power-up time */
 	reset_control_assert(rstc);
 	udelay(1); /* reset pulse: comfortably bigger than the spec */
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index bc793179db09..455d6bbefdfe 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -40,9 +40,11 @@
 #define AD5686_CMD_CONTROL_REG			0x4
 #define AD5686_CMD_READBACK_ENABLE_V2		0x5
 
+#define AD5310_GAIN_BIT_MSK			BIT(7)
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5310_PD_MSK				GENMASK(10, 9)
 
+#define AD5683_GAIN_BIT_MSK			BIT(11)
 #define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5683_PD_MSK				GENMASK(14, 13)
 
@@ -124,9 +126,12 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
  * @chip_info:		chip model specific constants, available modes etc
  * @ops:		bus specific operations
  * @ldac_gpio:		LDAC pin GPIO descriptor
+ * @gain_gpio:		GAIN pin GPIO descriptor
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
+ * @scale_avail:	pre-calculated available scale values
+ * @double_scale:	flag to indicate the gain multiplier is applied
  * @use_internal_vref:	set to true if the internal reference voltage is used
  * @lock:		lock to protect access to state fields, which includes
  *			the data buffer during regmap ops
@@ -138,9 +143,12 @@ struct ad5686_state {
 	const struct ad5686_chip_info	*chip_info;
 	const struct ad5686_bus_ops	*ops;
 	struct gpio_desc		*ldac_gpio;
+	struct gpio_desc		*gain_gpio;
 	unsigned short			vref_mv;
 	unsigned int			pwr_down_mask;
 	unsigned int			pwr_down_mode;
+	int				scale_avail[4];
+	bool				double_scale;
 	bool				use_internal_vref;
 	struct mutex			lock;
 	void				*bus_data;

-- 
2.43.0


