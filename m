Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6A3D093C
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 06:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787899139; cv=none; b=qFMC4M/L+OEPGLR7ru+wKM4cf2FT9ZP5Ldf8s8/5G2IH5LgzHAWObrnbmbmGOz/8AAX2axqSW7XB/9hkOhr1DhKQTq5VjjGhuXdZUy7dhXTQw5y+9I6F+x5VHHayAlKWwwxqIU08ZdJyhvAzNanN7NqJpZOH9+cc+6FeWPhgo5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787899139; c=relaxed/simple;
	bh=TMHFl5L/alFHgu3VeMCweylXc4tFsdHYF8XBRmES1Hk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmPNJQfJUmD7P+XEoPBR5WBbaPpvdXqBESawoepmqv3rGHFfwyu0z/jOttVK7hCcCJmXHZQ0WMbYZicj7xItU2Y+uV3WxvEUA8/6L+KF7Zy0zXVWJ0Dzyx8/BJf2tM8mVF2yHgCpX0qJB9BZNzz/T1hz3YlJzVhhJuPELKZkKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkpH2jx2; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkpH2jx2"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-9690c99c917so274926241.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 23:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787899135; x=1788503935; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XsfiQ/UpYrylb/xt1NWt3tkBeV1xOu5S1pAOKlyMNac=;
        b=YkpH2jx2WUPEK2FUQ76rBHBHzkB3GGooxRO0p6pK3VlvN+H3lY7Q3lcFYjEb8bu44v
         BT2VCiazsE3wqBe+PnOgHdKTwGotFLg7YCU6MgIP/2rQak0h6BEMQl2olGYyj6f3e2Wh
         SeoqgAk85IbI4yqv99ejMgUxZrjpHJbwOs9ZAqiDJtG2cAVJLn8dPwQH0cWwfhyo+YQS
         mTth4Cm4gK0m3WeOxthZprUpWSARZuEWPOp7FMGdodGKppabrwDmkVrNZJuh8FEW3ApE
         FG/D/v2A8fb9eaKMxynHgT6QSqQAARPBO/EGwkfbFc/CTiAw+UxnR8rgF9FldbPaEt0T
         K1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787899135; x=1788503935;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XsfiQ/UpYrylb/xt1NWt3tkBeV1xOu5S1pAOKlyMNac=;
        b=O5QmS44EZlYlIJdPpwdcrSSxwMNQUE+ugHVP+1UStWT4eTc1WOZdPCGfVxMJrsyYMM
         u5CsuwYT7U+cefs1wFpCwaaHVDvvRtx7GFZ0rjkjhr9rPwOIz+9b4jkMgQG26aXAAFkt
         B5erysVAxxA/BnIEoiJzK1jb/KLVSSmo8nMqhzD4XcN8zUGIQArggBazxMPUB3s/pzvg
         Git/kG+gWwTEd2NDWPergJyk2uBwr8L7iuM45/JdSGFYozfiZFcbcVehyT+C8R9BOhzY
         RbG07q3Yq4BsOy8sv3z0GU+LBwTKwU1TWBO4MkasmCcNtzmGRBbtzNoHo03ZN8MzRZ+y
         KqhQ==
X-Forwarded-Encrypted: i=1; AHgh+RoegS9yhBHGzurA9lT+LCOFdAEeP86iSoZwSiphFTXCm7HN0OBCYRsrmPknzJN/J6Uxzg7/a/ocLNY=@vger.kernel.org
X-Gm-Message-State: AFuF++kOadLqttawB6WI4IYD8DspmP/QWSeILwjquYE1gk2/pkltPDrV
	KKIhGbDTrV4rfIcVByaN6dhptu/nuiwUQla/bU7ffewbM6TFLawXIRL8
X-Gm-Gg: AR+sD11D8fOs25LuEKE/x5aGNAJEbizRyQGs3FTlWWgufVOfMaakPNqDZYyE+lG3ri4
	U74Ez3VN6e/MWw79fFdk3gHhxDuf9IxH5PeiP8XMUprVwP3hF+2yGVPujl2khjnpP6baXJdil3g
	cJ0H3ss3wXUVdNJw7fs8RJeBSI+Fw/uYgM4jDchGOqeIwDJwleESCCW8/8rHTr5X9HgEOLfevow
	XNHwHDqBkd8suk97DSk1NVJ6uODPy9tb7Z97wYETjUIA6sin+AWCV5echrG/e7hN8CqodBXFBan
	8HP8tkN9ZtWbW/3g10x5BlDkP+OmiS23npZsEyKHQb8KnPzxmlPpRpvjM6UhWGw0NaVt7facjb/
	I3JC+ZFv7yBBXxUV+rWyOfI8wpTx8ZiNv4Td6kcyoOl1shatq5RpvqQpk5zLKk8qdjr9XVPZbOy
	AHFB3CVjg7TKZuva2y/2WJa9gs0ruOfN1nk+9I0yTQpLtBnu/UXd7gmluNmBAfR8Bw
X-Received: by 2002:a05:6102:5128:b0:780:7e65:f0ab with SMTP id ada2fe7eead31-7859822155fmr1205317137.1.1787899134840;
        Thu, 27 Aug 2026 23:38:54 -0700 (PDT)
Received: from [192.168.100.153] ([2800:bf0:61:1127:ab87:5602:531c:8dfb])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97e849d8494sm454195241.1.2026.08.27.23.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 23:38:54 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Fri, 28 Aug 2026 01:38:23 -0500
Subject: [PATCH v4 08/10] iio: adc: ti-ads1262: support triggered buffer
 sampling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260828-ads126x-v4-8-1dc27e9c0260@gmail.com>
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
In-Reply-To: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12103; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=TMHFl5L/alFHgu3VeMCweylXc4tFsdHYF8XBRmES1Hk=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkTdd7s10k9Nkf2uOexEwlWfGe0a16aP3p0qql5oc5lh
 WDXecIvOkpZGMS4GGTFFFnaExZ9exSV99bvQOh9mDmsTCBDGLg4BWAi3DmMDNf4nsiedMkw1hN+
 /eflptx/Z5gXz335rFex0Hv2oZ82V+8z/I/InVq5qiMkslVon+yzJRnpXKel95h0qLxy593F7NE
 eyAUA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Add triggered buffer support and a data-ready (DRDY) hardware trigger.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 drivers/iio/adc/Kconfig      |   2 +
 drivers/iio/adc/ti-ads1262.c | 305 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 307 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index e51ce42bce94..2b60ade01e90 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1864,6 +1864,8 @@ config TI_ADS1262
 	tristate "Texas Instruments ADS1262"
 	depends on SPI
 	select REGMAP
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  If you say yes here you get support for Texas Instruments ADS1262 and
 	  ADS1263 ADC chips.
diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
index 04566d00d7cb..3f6d34a08b29 100644
--- a/drivers/iio/adc/ti-ads1262.c
+++ b/drivers/iio/adc/ti-ads1262.c
@@ -33,6 +33,9 @@
 #include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define ADS1262_OPCODE_NOP			0x00
 #define ADS1262_OPCODE_RESET			0x06
@@ -191,6 +194,7 @@
 #define ADS1262_MON_CHANNEL_COUNT		4
 #define ADS1262_EXT_REF_COUNT			3
 #define ADS1262_REGMAP_WRITE_SZ			8
+#define ADS1262_SPI_XFER_SZ			13
 #define ADS1262_MONITOR_ADDR_OFFSET		100
 
 #define ADS1262_ADC1_RESOLUTION			32
@@ -214,6 +218,7 @@ struct ads1262_channel {
 struct ads1262 {
 	struct spi_device *spi;
 	struct regmap *regmap;
+	struct iio_trigger *trig;
 	struct gpio_desc *start_gpiod;
 	struct regulator *avdd_supply;
 	struct regulator *avss_supply;
@@ -224,6 +229,8 @@ struct ads1262 {
 	/* protects channel state */
 	struct mutex chan_lock;
 	struct completion drdy;
+	struct spi_message msg;
+	struct spi_transfer xfer;
 	unsigned long clk_rate;
 	u8 dev_id;
 	bool bipolar_supply;
@@ -232,6 +239,11 @@ struct ads1262 {
 	u32 rref_ohms[ADS1262_EXT_REF_COUNT][ADS1262_EXT_REF_COUNT];
 	int refp_uV[ADS1262_EXT_REF_COUNT];
 	int refn_uV[ADS1262_EXT_REF_COUNT];
+	IIO_DECLARE_BUFFER_WITH_TS(__be32, scan_buffer,
+				   ADS1262_FW_CHANNEL_COUNT +
+				   ADS1262_MON_CHANNEL_COUNT);
+	u8 tx[ADS1262_SPI_XFER_SZ] __aligned(IIO_DMA_MINALIGN);
+	u8 rx[ADS1262_SPI_XFER_SZ];
 };
 
 static const char * const ads1262_device_id_to_name[] = {
@@ -837,10 +849,284 @@ static const struct iio_info ads1262_iio_info = {
 	.fwnode_xlate = ads1262_fwnode_xlate,
 };
 
+static int ads1262_buffer_postenable_mult(struct iio_dev *indio_dev)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
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
+static bool ads1262_validate_scan_mask(struct iio_dev *indio_dev,
+				       const unsigned long *scan_mask)
+{
+	struct ads1262 *st = iio_priv(indio_dev);
+
+	if (st->trig && indio_dev->trig == st->trig)
+		return iio_validate_scan_mask_onehot(indio_dev, scan_mask);
+
+	return true;
+}
+
+static const struct iio_buffer_setup_ops ads1262_buffer_ops = {
+	.postenable = ads1262_buffer_postenable,
+	.predisable = ads1262_buffer_predisable,
+	.validate_scan_mask = ads1262_validate_scan_mask,
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
@@ -1609,6 +1895,9 @@ static int ads1262_spi_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	st->spi = spi;
 	init_completion(&st->drdy);
+	st->xfer.tx_buf = st->tx;
+	st->xfer.rx_buf = st->rx;
+	spi_message_init_with_transfers(&st->msg, &st->xfer, 1);
 
 	ret = devm_mutex_init(dev, &st->chan_lock);
 	if (ret)
@@ -1654,6 +1943,22 @@ static int ads1262_spi_probe(struct spi_device *spi)
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

