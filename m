Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2BB42C4FC
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 06:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791615234; cv=none; b=hyDZqLoukcdeXrN2K4MvEoKxHAFZpquy36HIN//CRLQvKHhUdii0Q5ZxHZil8/cDgrOCrNiCFdasUbbfizziH4Xmw1R4I4AFwFmgVrONlqepfkFxQNJLJ+q4DKIFRDqKyoZRT3btd/bgEsEtuygRLQQ80lfRQj1HNb0pw1SG04Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791615234; c=relaxed/simple;
	bh=pxiZlSXO0eCpHHI9uSO8w017WX80gEZgvedQJ+C6JB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGnrWT3+TzqotDwLdRaRq/7l7xmKa5+cxZGq3KHxuERkDQncpBUpJh6vL9krtRQ5wOEWYDSgg3HVC1PVGIKGv+l1VrV0ICzm6coz7rmQFYWbH9f09t/9mWgh74B9L4X+ixnMd0fFUTtyWL7OmR+m3rTW8Rjitl+XCk8XgD577mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhMMxctW; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhMMxctW"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-14394530ec6so344569c88.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 23:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791615232; x=1792220032; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E4iFs2iestrTWFwBHRgcKgOXIqLs+s5kh+DGG43xLgI=;
        b=jhMMxctWD1tJsrDBnZ3HKlDZFnE8q8+vZlncO2Ecz4saEbkEYiESBRXEvwPfGZ014/
         9i/askusX/wI2idb4+1puyB6AJYpz/ferRgdssKSKAPul0ArZeVL5N/vL3o2ByS+0NI2
         npHpd9A/ASugJEWDj8/eIIVM+ZftAlTpQ85EeOIFJNylXd4DhWFrest/Y+piFlNAhg2G
         BaKDdNMrMEd1HlfBJ5G+jtSjZeMy4H8KXvmxCdGAQzfcZTxQWioMJwwNv/yH/nwD2a8M
         G2sD89pinzk+YSihMJ6PdC/h6dlw7JIUXLApuxwT9XFeiZzru071kWYgCIzwgZJ+QnDZ
         1t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791615232; x=1792220032;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E4iFs2iestrTWFwBHRgcKgOXIqLs+s5kh+DGG43xLgI=;
        b=iE2uAJ3NvBtJKKBpciKHtN3rf6C5trfNG15nsUgO0pjM1WGmLQvEoRqeRhh74WfvlF
         xDVurATEihc+uzi6u+zkaARAqG0tmG7lSlmAE3xwK1o3c8A4EyF/RAYHOjYxX1Lsb1BU
         SZgErl6UVZAIoAy8l2AucsCOAv5wq87LeZ5a8JdVmNJVAx0fe781OUh6n/ZeHqXpEuow
         M8Vep2Tk+bOzNt0k/X0ATh3njiPekTU6Wh8V5z761aviPnQ38Q8zoBZQ8Nycp/t5qEne
         Ze5ZOJABSpkMCnZn50GCXUbmmRPlZKGv2V8OaFQwFmDsYGrKAG7NypXBMbRT2A4nLhni
         RAgg==
X-Forwarded-Encrypted: i=1; AKwUvBwZHPI9Xp1rwLP3Ivgz1vyZeOLd+v45sTguUMBUYxUlc2NKyqS8jbcq/BUNtGlN5ejLpLFFQ7E8aIo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJwXB3n8ZpbxoAEDIbaUdrts6GBx7I43cy8MCcsEzMu1Cj7Jhiv
	QgkxRZb3x87Sf+AfUWPexPt34EOdkpuIcmDaV4h3h1gjydxk1FbGhvnB
X-Gm-Gg: AYBFou2jyksRIUZTZMBx+90bwOfQWPv4P6Nn/lqxK6JZ6YL4g5nA4U19UF2M7tBXGnu
	4bV/eayzkZSEsAIGrJ2Q4QiKmXO/dfthzwZ88teExseAXzZ7lIO44yweJIn3ScK3QOYhXhwltiB
	ddBzZCwIJWy+71B1+mLuDtoMs/IPPqgxhK1MMC+L8fSwcxwRvvgMbf5oC2GmDx0d448OOxDQwNd
	yrEuvb+qiKO189zP/mBB7Lmq/TMmK4L93B3DsUv0i+UT3AaG82I+477415O7owDV5UEncjK19z2
	9z2MpyhbeBNnw5fw005+Mxc/nbZ6Dj5c3DgYE73ZtuevaATktV/YL79ARAoiArL0r1F/jhV94oL
	wcbm9WucrlxaVZBUJ8PkIsUpz7NELIHo7XdsKngsbN7BJcX89FdJHV3h2RxXn6vVRjA+YNDB/Vh
	8tF7UHkhLy7OBa1k4rPsx8jkie/+zKRlKe1SQjzWoOs0dKbDOF+jAJI9xhe4/h60xhwBe6wSnYt
	M9seQdQP0h3213aqSSkM9VbzS2bbj+AQkVrQ0E=
X-Received: by 2002:a05:7022:b052:20b0:152:9e88:daaa with SMTP id a92af1059eb24-16a62eaad21mr5893871c88.36.1791615231668;
        Fri, 09 Oct 2026 23:53:51 -0700 (PDT)
Received: from [192.168.100.70] (host-200-61-172-117.iplanisp.com.ar. [200.61.172.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb5e9sm13009650eec.20.2026.10.09.23.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 23:53:51 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Sat, 10 Oct 2026 03:52:47 -0300
Subject: [PATCH v5 08/10] iio: adc: ti-ads1262: support triggered buffer
 sampling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261010-ads126x-v5-8-49e331cb2fed@gmail.com>
References: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
In-Reply-To: <20261010-ads126x-v5-0-49e331cb2fed@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11937; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=pxiZlSXO0eCpHHI9uSO8w017WX80gEZgvedQJ+C6JB8=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFknHzwLj37+qaxexsJw365246X77sQvt2s9sZdVK3+34
 S22l2s/dZSyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBE4l4yMswNEcrtr4mXdJ7y
 TmJp0lwHa2aOsgZN9ScvvK0lbq1e/5/hn5kFx9MTBSHPmpqLf4oWrk6TvSDtP23J18PHjTZts2F
 q4AcA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add triggered buffer support and a data-ready (DRDY) hardware trigger.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ti-ads1262.c | 299 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 301 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 06aa84a3f145..6d5df9c041ac 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1904,6 +1904,8 @@ config TI_ADS1262
 	tristate "Texas Instruments ADS1262"
 	depends on SPI
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS1262 and
 	  ADS1263 ADC chips.
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 49d4bf206be0..0606e712feec 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -32,6 +32,9 @@
 #include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define ADS1262_OPCODE_NOP			0x00
 #define ADS1262_OPCODE_RESET			0x06
@@ -190,6 +193,7 @@
 #define ADS1262_MON_CHANNEL_COUNT		4
 #define ADS1262_EXT_REF_COUNT			3
 #define ADS1262_REGMAP_WRITE_SZ			8
+#define ADS1262_SPI_XFER_SZ			13
 
 #define ADS1262_ADC1_RESOLUTION			32
 
@@ -216,6 +220,7 @@ struct ads1262_channel {
 struct ads1262 {
 	struct spi_device *spi;
 	struct regmap *regmap;
+	struct iio_trigger *trig;
 	struct gpio_desc *start_gpiod;
 	size_t num_channels;
 	struct ads1262_channel *channels __counted_by_ptr(num_channels);
@@ -224,6 +229,8 @@ struct ads1262 {
 	/* protects channel state */
 	struct mutex chan_lock;
 	struct completion drdy;
+	struct spi_message msg;
+	struct spi_transfer xfer;
 	unsigned long clk_rate_hz;
 	bool bipolar_supply;
 	int avdd_uV;
@@ -233,6 +240,11 @@ struct ads1262 {
 	u32 rref_ohms[ADS1262_EXT_REF_COUNT][ADS1262_EXT_REF_COUNT];
 	int refp_uV[ADS1262_EXT_REF_COUNT];
 	int refn_uV[ADS1262_EXT_REF_COUNT];
+	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan_buffer,
+				   ADS1262_FW_CHANNEL_COUNT +
+				   ADS1262_MON_CHANNEL_COUNT);
+	u8 tx[ADS1262_SPI_XFER_SZ] __aligned(IIO_DMA_MINALIGN);
+	u8 rx[ADS1262_SPI_XFER_SZ];
 };
 
 static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
@@ -833,10 +845,278 @@ static const struct iio_info ads1262_iio_info = {
 	.fwnode_xlate = ads1262_fwnode_xlate,
 };
 
+static int ads1262_buffer_postenable_mult(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+
+	if (indio_dev->trig == st->trig) {
+		dev_err_once(dev, "the DRDY trigger doesn't support multiple channel sampling\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * When multiple channels are selected, we use a single transfer to both
+	 * enable channels, start and then read conversions with a full-duplex
+	 * optimized method. The transfer buffer holds up to four contiguous
+	 * commands: two register write commands, and start and stop commands if
+	 * no START GPIO is provided.
+	 *
+	 * The buffer is arranged as follows:
+	 *
+	 *     byte 0-1: write protocol header
+	 *     byte 2-5: MODE0, MODE1, MODE2, INPMUX register data
+	 *     byte 6-7: write protocol header
+	 *     byte 8-10: IDACMUX, IDACMAG, REFMUX register data
+	 *     byte 11: START1 command
+	 *     byte 12: STOP1 command
+	 */
+	if (st->start_gpiod)
+		st->xfer.len = 11;
+	else
+		st->xfer.len = 13;
+
+	static_assert(13 <= ADS1262_SPI_XFER_SZ);
+
+	return spi_optimize_message(st->spi, &st->msg);
+}
+
+static int ads1262_buffer_postenable_one(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	unsigned long i;
+	int ret;
+
+	i = find_first_bit(indio_dev->active_scan_mask,
+			   iio_get_masklength(indio_dev));
+	ret = ads1262_channel_enable(st, &indio_dev->channels[i]);
+	if (ret)
+		return ret;
+
+	ret = ads1262_set_runmode(st, ADS1262_RUNMODE_CONTINUOUS);
+	if (ret)
+		return ret;
+
+	static_assert(5 <= ADS1262_SPI_XFER_SZ);
+
+	st->xfer.len = 5;
+	memset(st->tx, 0, st->xfer.len);
+	/*
+	 * When only one channel is selected, we can't really avoid concurrent
+	 * device activity from happening between the DRDY signal and data
+	 * retrieval, thus we read by command. The transfer buffer holds the
+	 * command (RDATA1) plus the 4 conversion bytes (5 bytes total).
+	 */
+	st->tx[0] = ADS1262_OPCODE_RDATA1;
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
+static int ads1262_buffer_postenable(struct iio_dev *indio_dev)
+{
+	int ret;
+
+	if (iio_validate_scan_mask_onehot(indio_dev,
+					  indio_dev->active_scan_mask))
+		ret = ads1262_buffer_postenable_one(indio_dev);
+	else
+		ret = ads1262_buffer_postenable_mult(indio_dev);
+
+	return ret;
+}
+
+static int ads1262_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+
+	if (iio_validate_scan_mask_onehot(indio_dev,
+					  indio_dev->active_scan_mask)) {
+		ads1262_dev_stop(st);
+	} else {
+		regcache_drop_region(st->regmap, ADS1262_MODE0_REG,
+				     ADS1262_INPMUX_REG);
+		regcache_drop_region(st->regmap, ADS1262_IDACMUX_REG,
+				     ADS1262_REFMUX_REG);
+	}
+
+	spi_unoptimize_message(&st->msg);
+
+	return 0;
+}
+
+static const struct iio_buffer_setup_ops ads1262_buffer_ops = {
+	.postenable = ads1262_buffer_postenable,
+	.predisable = ads1262_buffer_predisable,
+};
+
+static void ads1262_channel_prep_tx(struct ads1262 *st,
+				    const struct iio_chan_spec *spec)
+{
+	struct ads1262_channel *chan = &st->channels[spec->scan_index];
+	u8 runmode;
+
+	guard(mutex)(&st->chan_lock);
+
+	/*
+	 * Input chopping and IDAC rotation modes require the continuous
+	 * conversion mode.
+	 *
+	 * This condition only matters when we have an START GPIO, in which case
+	 * the pulse mode is preferred for its predictability: one conversion
+	 * per rising edge. Briefly pulsing the START GPIO (4 uS) should have
+	 * the same effect almost every time, unless the pulse lasts more than
+	 * ~208 uS, which should be rare even if the task is preempted.
+	 *
+	 * If we rely solely on conversion control commands, both modes are
+	 * equivalent because START1 and STOP1 commands are send contiguously on
+	 * the same transfer.
+	 */
+	if (chan->input_chop || chan->idac_chop)
+		runmode = ADS1262_RUNMODE_CONTINUOUS;
+	else
+		runmode = ADS1262_RUNMODE_PULSE;
+
+	st->tx[0] = ADS1262_MODE0_REG | ADS1262_OPCODE_WREG;
+	st->tx[1] = ADS1262_INPMUX_REG - ADS1262_MODE0_REG;
+	st->tx[2] = FIELD_PREP(ADS1262_MODE0_INPUT_CHOP_MASK, chan->input_chop) |
+		    FIELD_PREP(ADS1262_MODE0_IDAC_CHOP_MASK, chan->idac_chop) |
+		    FIELD_PREP(ADS1262_MODE0_RUNMODE_MASK, runmode) |
+		    FIELD_PREP(ADS1262_MODE0_REFREV_MASK, chan->ref_reversal);
+	st->tx[3] = FIELD_PREP(ADS1262_MODE1_FILTER_MASK, chan->filter);
+	st->tx[4] = FIELD_PREP(ADS1262_MODE2_DR_MASK, chan->data_rate) |
+		    FIELD_PREP(ADS1262_MODE2_GAIN_MASK, chan->gain);
+	st->tx[5] = FIELD_PREP(ADS1262_INPMUX_MUXP_MASK, spec->channel) |
+		    FIELD_PREP(ADS1262_INPMUX_MUXN_MASK, spec->channel2);
+
+	st->tx[6] = ADS1262_IDACMUX_REG | ADS1262_OPCODE_WREG;
+	st->tx[7] = ADS1262_REFMUX_REG - ADS1262_IDACMUX_REG;
+	st->tx[8] = FIELD_PREP(ADS1262_IDACMUX_MUX1_MASK, chan->idac_mux[0]) |
+		    FIELD_PREP(ADS1262_IDACMUX_MUX2_MASK, chan->idac_mux[1]);
+	st->tx[9] = FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, chan->idac_mag[0]) |
+		    FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, chan->idac_mag[1]);
+	st->tx[10] = FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, chan->ref_p) |
+		     FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, chan->ref_n);
+
+	/*
+	 * If we have an START GPIO, the transfer length is 11 so these last two
+	 * bytes are ignored.
+	 */
+	st->tx[11] = ADS1262_OPCODE_START1;
+	st->tx[12] = ADS1262_OPCODE_STOP1;
+}
+
+static int ads1262_fill_buffer_mult(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+	unsigned int chan;
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
+		ads1262_channel_prep_tx(st, &indio_dev->channels[chan]);
+
+		reinit_completion(&st->drdy);
+
+		ret = spi_sync(st->spi, &st->msg);
+		if (ret)
+			return ret;
+
+		if (st->start_gpiod) {
+			gpiod_set_value_cansleep(st->start_gpiod, 1);
+			fsleep(4);
+			gpiod_set_value_cansleep(st->start_gpiod, 0);
+		}
+
+		if (i > -1)
+			memcpy(&st->scan_buffer[i], st->rx, sizeof(st->scan_buffer[i]));
+		i++;
+
+		ret = ads1262_wait_for_conversion(st);
+		if (ret)
+			return ret;
+	}
+
+	memset(st->tx, 0, st->xfer.len);
+	ret = spi_sync(st->spi, &st->msg);
+	if (ret)
+		return ret;
+
+	memcpy(&st->scan_buffer[i], st->rx, sizeof(st->scan_buffer[i]));
+
+	return 0;
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
@@ -1585,6 +1865,9 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->spi = spi;
 	init_completion(&st->drdy);
+	st->xfer.tx_buf = st->tx;
+	st->xfer.rx_buf = st->rx;
+	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
 
 	ret = devm_mutex_init(dev, &st->chan_lock);
 	if (ret)
@@ -1628,6 +1911,22 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
+					      ads1262_trigger_handler,
+					      &ads1262_buffer_ops);
+	if (ret)
+		return ret;
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy", indio_dev->name,
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
 	 * used to stop depending on the DRDY signal.

-- 
2.55.0

