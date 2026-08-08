Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873193B7B83
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786161546; cv=none; b=W1sCV1X78aI4x4cNPIHMxN6tpKeQpXc6bgQf+IY5gZPSiHO/zOfpiqo1w0RVwiNx+oNzrj2z7GABUcGf23G4UMHTDk0/3L2yQHMK9rQskrrp3JdHm3a6WbvwMfYw9iHYAiqCc1X5J59BGEROgf0eYOSI4kO2wxH2wCB5S/8+pzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786161546; c=relaxed/simple;
	bh=lAS6V9MAqcWApu/3/HSXVhClPehcPza6w767sLpTNlI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sa6MVaUEFR62y263XKqFgkvsY/MHItSOzWCUBdwuHEGKtJEkBlyA59/3g195Xt/PcYBsDcuIYWur+OkN1E5XaMRFA2k8rEk0SxzLOiFpX3akNIhc6sZEvQMxCzBn5UXSAR0qe8cRFgIP5YsIGW/VQcra3tEL5SNiYeUEcsaqUnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eriwJAdJ; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eriwJAdJ"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5c38568d9e1so93637e0c.3
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 20:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786161543; x=1786766343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCu9EEJYvjKKKw6KIIpKa31vtWBqeSGX25tRhPYIKmQ=;
        b=eriwJAdJqhVQSdJPAg9Zhe5Nporrn5spxvYz+yBLmNEXfdEx4mUfXPRKDDFkUQnV6Q
         7YNXhPbaSiSVDIF6RL5jjkzGxiAhDXQQGNbiEz3EtLNFr2Bq5R/HrdsnqC/ft0iQFAkV
         O2Qq+0Mr3DeeAct67DkMZcy+WdElclncuHLPiyCdBMsZGQsl5RZMdUQSBG8tuG2HHl1s
         2cY6Xvez7IGgfEr3hxvSv7vwiu0BG/ZN3o331A1kJVvBrU7jyHUgOC1gJE0G7hWYWJgt
         elOPfTpmsGTzliwWzPlbeBmP6j2vVI8RiZno2BnTiQXoPuolo8ONrq5CJc1RYio8l2Tg
         npvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786161543; x=1786766343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OCu9EEJYvjKKKw6KIIpKa31vtWBqeSGX25tRhPYIKmQ=;
        b=GXYWzbH/rKuIztle3arH2bFi9fXq7toJ8mcZwdI2bzbqcwPx31b6pTvgb1AZ7T7yl8
         vZiFZpTkrC+PBFBgNSIfV/sBoJjcXG7WhLpO9K7X0au+nlRrQoNw4/UVB9Pj/oYIDNUU
         /fCm//5PbEG0cClRomEpJVPhAVk3uRn/8n+BkGS7RuVFAAa3fJp0rmpSG8S2+a4ZZtl5
         P5RIhfG/gMKGhyS6GWvcT0QM6hPEkM3mhftjKDjWZ4+5YkfxlankwABlG5ejun6r8W7P
         xSssKd4/aM0lxFlfI4PSSeHEBUU4AgE9FMti++I6jhLF54SZl1HIWp+AFzjPvRmdBBHI
         1H7g==
X-Forwarded-Encrypted: i=1; AHgh+Rpj4L3xVYugftRBKagQjfN+HFjUCDfRc6NiXO9b8h2+fV1ZkbSmlmLNCO3ysZhgmr405kG1I4e01oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSOqFGECbsNhVyv9oNDBGHhNYeyA2Kvno4VYnWNB1f4a1QAQSp
	ExmMVf1GMEBecVHGaGk10IuAKYvH3t8xJEf2Vn+KjvsIWseaIEUXTjn0
X-Gm-Gg: AR+sD10E38tbiIvIRjsEHa0wV92uByhOuAoLKwqEdyq53/XxU1A4vUYaU6lVrV+U0ZN
	e1elesS0eU3IL2JWEGcJOU/EjQh+fIr76Dcu5NWWAEUpFKDhxYrEZyRtzJtIwR52RW4wzeG6dsZ
	/+Lus80a6imzHV+yZVABoYUIM29tMmq/TcHKU6eyOWOvrLqWDPhveXqKGiff1xXrnUUhlY923Rw
	MQ9wCiwpuKSnfjQqJ1MAvkVaFg6UP2ls9gKmIJw017qJwag7ztRCHk1W0XHVS3XnzpzaPRCt5Du
	yR3Ib+/RUkD3llJNDIFZSk5yqQ18yfYCDxih4qK+OGnHYuzjrIs+ACuCBoeIISl7h19HlOPb7vT
	1Ok3R+9HS4QG64N56zzxZevRP+XQ/joPUa+7qiDv9uLonmTA0l9g0NUzRBWZSDJVIybxH75dojv
	uzRT9gkr79bI/x/p9vrcnOovFhxQJLllDq00t+Ms+M7e+FPnheTlULsqg0GO8=
X-Received: by 2002:a05:6102:2c81:b0:737:9edc:36f8 with SMTP id ada2fe7eead31-760e6ed513amr7243312137.1.1786161543362;
        Fri, 07 Aug 2026 20:59:03 -0700 (PDT)
Received: from [192.168.100.6] ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c40b212fa6sm1432936e0c.16.2026.08.07.20.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 20:59:02 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 07 Aug 2026 22:58:29 -0500
Subject: [PATCH v3 7/9] iio: adc: ti-ads1262: support triggered buffer
 sampling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-ads126x-v3-7-f89925d72792@gmail.com>
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
In-Reply-To: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10087; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=lAS6V9MAqcWApu/3/HSXVhClPehcPza6w767sLpTNlI=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFllKyvkfCSWVm3YEpzlKewotyZ21ZILx5vnfpdM+bl6F
 tv/cxPzO0pZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAiaWyMDKcCYj+/5WCaYVXY
 feg612nF/VvEp0Zz5XHxiz69dTn36XuG36wNK36VXH26f9kZ1XWHdhvk7/hdJXzAcFJpZOS1D5X
 3/3MCAA==
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add triggered buffer support and a data-ready (DRDY) hardware trigger.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ti-ads1262.c | 264 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 266 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index dbf76427912b..b9b561be8347 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1845,6 +1845,8 @@ config TI_ADS1262
 	tristate "Texas Instruments ADS1262"
 	depends on SPI
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS1262 and
 	  ADS1263 ADC chips.
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index d5464b4f2bfb..24a7ecb9fbd4 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -34,6 +34,9 @@
 #include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define ADS1262_OPCODE_NOP			0x00
 #define ADS1262_OPCODE_RESET			0x06
@@ -225,6 +228,7 @@ struct ads1262_channel {
 struct ads1262 {
 	struct spi_device *spi;
 	struct regmap *regmap;
+	struct iio_trigger *trig;
 	struct gpio_desc *reset_gpiod;
 	struct gpio_desc *start_gpiod;
 	unsigned long clk_rate;
@@ -241,8 +245,16 @@ struct ads1262 {
 	bool need_avss_uV;
 	bool bipolar_supply;
 
+	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan_buffer,
+				   ADS1262_MAX_CHANNEL_COUNT);
+
 	/* Protects transfer buffers and concurrent SPI transfers */
 	struct mutex xfer_lock;
+	struct spi_message msg;
+	struct spi_transfer xfer;
+
+	u8 tx[11] __aligned(IIO_DMA_MINALIGN);
+	u8 rx[11] __aligned(IIO_DMA_MINALIGN);
 };
 
 static const u32 ads1262_data_rate_div[] = {
@@ -708,10 +720,242 @@ static const struct iio_info ads1262_iio_info = {
 	.debugfs_reg_access = ads1262_debugfs_reg_access,
 };
 
+static int ads1262_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	unsigned int weight;
+	unsigned long i;
+	int ret;
+
+	weight = bitmap_weight(indio_dev->active_scan_mask,
+			       iio_get_masklength(indio_dev));
+
+	if (weight > 1) {
+		/*
+		 * Multiple channels use software sequencing: a single
+		 * contiguous transfer rewrites the per-channel configuration
+		 * registers in two (non-contiguous) groups.
+		 *
+		 * Group 1: write protocol (2 bytes) + MODE0, MODE1, MODE2,
+		 * INPMUX (4 registers).
+		 *
+		 * Group 2: write protocol (2 bytes) + IDACMUX, IDACMAG,
+		 * REFMUX (3 registers).
+		 *
+		 * Total: 11 bytes
+		 */
+		st->xfer.len = 11;
+	} else {
+		/*
+		 * A single channel is read by command (RDATA1), so the transfer
+		 * holds the command byte plus the 4 conversion bytes.
+		 *
+		 * Total: 5 bytes
+		 */
+		st->xfer.len = 5;
+
+		/*
+		 * When only one channel is enabled, we can't really avoid SPI
+		 * activity from happening when the auxiliary ADC is in use,
+		 * thus we have to read from the data-holding register (command
+		 * mode).
+		 */
+		memset(st->tx, 0, st->xfer.len);
+		st->tx[0] = ADS1262_OPCODE_RDATA1;
+
+		i = find_first_bit(indio_dev->active_scan_mask,
+				   iio_get_masklength(indio_dev));
+		ret = ads1262_channel_enable(st, &indio_dev->channels[i]);
+		if (ret)
+			return ret;
+	}
+
+	ret = ads1262_set_runmode(st, ADS1262_RUNMODE_CONTINUOUS);
+	if (ret)
+		return ret;
+
+	ret = spi_optimize_message(st->spi, &st->msg);
+	if (ret)
+		return ret;
+
+	ret = ads1262_dev_start(st);
+	if (ret) {
+		spi_unoptimize_message(&st->msg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ads1262_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	unsigned int weight;
+
+	ads1262_dev_stop(st);
+	spi_unoptimize_message(&st->msg);
+
+	weight = bitmap_weight(indio_dev->active_scan_mask,
+			       iio_get_masklength(indio_dev));
+	if (weight > 1) {
+		regcache_drop_region(st->regmap, ADS1262_MODE0_REG,
+				     ADS1262_INPMUX_REG);
+		regcache_drop_region(st->regmap, ADS1262_IDACMUX_REG,
+				     ADS1262_REFMUX_REG);
+	}
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ads1262_buffer_ops = {
+	.preenable = ads1262_buffer_preenable,
+	.postdisable = ads1262_buffer_postdisable,
+};
+
+static int ads1262_enable_and_read_last(struct ads1262 *st,
+					const struct iio_chan_spec *spec,
+					__be32 *val)
+{
+	struct ads1262_channel *chan;
+	int ret;
+
+	lockdep_assert_held(&st->xfer_lock);
+
+	if (spec) {
+		guard(mutex)(&st->chan_lock);
+
+		chan = &st->channels[spec->scan_index];
+
+		/* Group 1: MODE0, MODE1, MODE2, INPMUX */
+		st->tx[0] = ADS1262_MODE0_REG | ADS1262_OPCODE_WREG;
+		st->tx[1] = ADS1262_INPMUX_REG - ADS1262_MODE0_REG;
+		st->tx[2] = FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_chop) |
+			    FIELD_PREP(ADS1262_MODE0_IDAC_CHOP_MASK, chan->idac_chop) |
+			    FIELD_PREP(ADS1262_MODE0_RUNMODE_MASK, ADS1262_RUNMODE_CONTINUOUS) |
+			    FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
+		st->tx[3] = FIELD_PREP(ADS1262_MODE1_FILTER_MASK, ADS1262_FILTER_FIR);
+		st->tx[4] = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
+			    FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain);
+		st->tx[5] = FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel) |
+			    FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2);
+
+		/* Group 2: IDACMUX, IDACMAG, REFMUX */
+		st->tx[6] = ADS1262_IDACMUX_REG | ADS1262_OPCODE_WREG;
+		st->tx[7] = ADS1262_REFMUX_REG - ADS1262_IDACMUX_REG;
+		st->tx[8] = FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]) |
+			    FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
+		st->tx[9] = FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]) |
+			    FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);
+		st->tx[10] = FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->ref_p) |
+			     FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->ref_n);
+	} else {
+		memset(st->tx, 0, sizeof(st->tx));
+	}
+
+	ret = spi_sync(st->spi, &st->msg);
+	if (ret)
+		return ret;
+
+	memcpy(val, st->rx, sizeof(*val));
+
+	return 0;
+}
+
+static int ads1262_fill_buffer_mult(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	unsigned int chan;
+	__be32 val;
+	int i = -1;
+	int ret;
+
+	/*
+	 * This routine enables and reads channels in a full-duplex fashion.
+	 *
+	 * When a channel is enabled, the previous conversion is clocked out of
+	 * the shift data register on the same transfer (Section 9.4.7.1). This
+	 * allows for low latency software sequencing but forbids any
+	 * communication with the chip in-between or data corruption may occur,
+	 * hence the need to take the xfer_lock for the whole operation.
+	 */
+	guard(mutex)(&st->xfer_lock);
+
+	iio_for_each_active_channel(indio_dev, chan) {
+		ret = ads1262_enable_and_read_last(st, &indio_dev->channels[chan],
+						   &val);
+		if (ret)
+			return ret;
+
+		/*
+		 * After writing to the channel configuration registers, the
+		 * conversion-cycle is restarted and the data registers are
+		 * cleared. This means we have to reinit the completion after
+		 * enabling to avoid reading stale data.
+		 */
+		reinit_completion(&st->drdy);
+
+		if (i > -1)
+			st->scan_buffer[i] = val;
+		i++;
+
+		ret = ads1262_wait_for_conversion(st);
+		if (ret)
+			return ret;
+	}
+
+	return ads1262_enable_and_read_last(st, NULL, &st->scan_buffer[i]);
+}
+
+static int ads1262_fill_buffer_one(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->xfer_lock);
+
+	ret = spi_sync(st->spi, &st->msg);
+	if (ret)
+		return ret;
+
+	/* In command mode the conversion data is found at offset 1 */
+	memcpy(st->scan_buffer, &st->rx[1], sizeof(*st->scan_buffer));
+
+	return 0;
+}
+
+static irqreturn_t ads1262_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ads1262 *st = iio_priv(indio_dev);
+	s64 ts = pf->timestamp;
+	unsigned int weight;
+	int ret;
+
+	weight = bitmap_weight(indio_dev->active_scan_mask,
+			       iio_get_masklength(indio_dev));
+
+	if (weight == 1)
+		ret = ads1262_fill_buffer_one(indio_dev);
+	else
+		ret = ads1262_fill_buffer_mult(indio_dev);
+	if (ret)
+		goto out_notify_done;
+
+	iio_push_to_buffers_with_ts(indio_dev, st->scan_buffer,
+				    sizeof(st->scan_buffer), ts);
+
+out_notify_done:
+	iio_trigger_notify_done(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
 static irqreturn_t ads1262_irq_handler(int irq, void *dev_id)
 {
 	struct ads1262 *st = dev_id;
 
+	iio_trigger_poll(st->trig);
 	complete(&st->drdy);
 
 	return IRQ_HANDLED;
@@ -1414,6 +1658,10 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	st->spi = spi;
 	init_completion(&st->drdy);
 
+	st->xfer.tx_buf = st->tx;
+	st->xfer.rx_buf = st->rx;
+	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
+
 	ret = devm_mutex_init(dev, &st->chan_lock);
 	if (ret)
 		return ret;
@@ -1459,6 +1707,22 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to configure device\n");
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ads1262_trigger_handler,
+					      &ads1262_buffer_ops);
+	if (ret)
+		return ret;
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy", info->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
+	iio_trigger_set_drvdata(st->trig, st);
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return ret;
+
 	/*
 	 * REVISIT: This chip has software polling capabilities, which could be
 	 * used to stop depending on the 'drdy' IRQ.

-- 
2.55.0

