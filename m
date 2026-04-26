Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F690346AFD;
	Sun, 26 Apr 2026 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192700; cv=none; b=dlefY5qlZz0WOsk9chpLTdt4M3LggJfsYO2piqKu2M9z9U9zDV/KKTCreqTppfAxoYd4nnZiZP+M9CdB4tmKpvPv23uJRmbDIjEJB67LF4cRcIHu07FoE+WriVfQnQmz+kzcoVQTy83o0G8zVHRkfq6LTIGknG20bIEtkRpIW5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192700; c=relaxed/simple;
	bh=z66o5gdYmR1MofyPIGVtT4R/6Zfmb/l909tCLhQH504=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TETswkr9wXN4T2x5FYqhstkUV443i8pQ5nfXqa1xYUFoccgCL6WQCYipZAs8Z0WwT4LpC+voAHFC8AUfLMj/3taOBAwVgNrG4Ngm+VD1Hp82lP+OJpgsbP3SJT0GByrenYynTUMEd+U7Vs3UKIWe1aVINwoCTuGwhziN8MLs1zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDdaq1KP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDdaq1KP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04F13C2BCB9;
	Sun, 26 Apr 2026 08:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192700;
	bh=z66o5gdYmR1MofyPIGVtT4R/6Zfmb/l909tCLhQH504=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=uDdaq1KP4YIAMPc1ec0U/ZjduyUTk08oYoJAEZgaRpE0p9TePoCLiWv8Q5oiHbVb0
	 P6iCO8Hrahg8wmUr2hyM9nrKhpbDsj8gKzd6sGWgEmUBwYT9nx4tBDOfeXaEuoNk/F
	 ACgLFldARX7KOaMO+sudgT3k1nImrdFqoXTH4XtqFZRrQjc4kPpZbvU8NHDmYztZ4T
	 LtLTlkuyHrB93muUIQN7t22LV82mEOAc+s8Dr+I0Apc6CTJGF6ixgL/RIszXlWs68y
	 hjCQs+42GHA83GJaRGMpH3dqI8Kw885mfT4SQ2QTiN9OfBUQPsiippx286M948IkXA
	 Ti7pemYi6JF6w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0946FF885D;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 26 Apr 2026 09:38:11 +0100
Subject: [PATCH 10/10] iio: dac: ad5686: create bus ops struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-ad5686-fixes-v1-10-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
In-Reply-To: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777192698; l=7468;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=bK22PGl2VrIUK5DK/y4pieYUa43QpgH09CHKivfjINY=;
 b=fVu1ipzQHekJ35CkveskcP//upkXsT8pz8qUtzglNFfXSoUGVqH6vUCAXfCi91JDzJGPdeBsg
 ORarXJIj8WPCcvtkyQoemDxaMxS88IVGFe5I9Se3EUyLV/EPULnlQbi
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Create struct with bus operations, which will be used to extend bus
implementation features. Auxiliary functions ad5686_write() and
ad5686_read() are created and ad5686_probe() now receives an ops struct
pointer rather than individual read and write functions.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c |  7 ++++++-
 drivers/iio/dac/ad5686.c     | 30 ++++++++++++++----------------
 drivers/iio/dac/ad5686.h     | 29 +++++++++++++++++++++--------
 drivers/iio/dac/ad5696-i2c.c |  7 ++++++-
 4 files changed, 47 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 8fef0e6d33ff..857b9e4f54ab 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -92,10 +92,15 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
 	return be32_to_cpu(st->data[2].d32);
 }
 
+static const struct ad5686_bus_ops ad5686_spi_ops = {
+	.write = ad5686_spi_write,
+	.read = ad5686_spi_read,
+};
+
 static int ad5686_spi_probe(struct spi_device *spi)
 {
 	return ad5686_probe(&spi->dev, spi_get_device_match_data(spi),
-			    spi->modalias, ad5686_spi_write, ad5686_spi_read);
+			    spi->modalias, &ad5686_spi_ops);
 }
 
 static const struct spi_device_id ad5686_spi_id[] = {
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index ab498ec2ed5c..490faed85976 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -26,18 +26,18 @@ static int ad5310_control_sync(struct ad5686_state *st)
 {
 	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
 
-	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
-			 FIELD_PREP(AD5310_PD_MSK, pd_val) |
-			 FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
+			    FIELD_PREP(AD5310_PD_MSK, pd_val) |
+			    FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
 }
 
 static int ad5683_control_sync(struct ad5686_state *st)
 {
 	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
 
-	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
-			 FIELD_PREP(AD5683_PD_MSK, pd_val) |
-			 FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
+			    FIELD_PREP(AD5683_PD_MSK, pd_val) |
+			    FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
 }
 
 static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
@@ -136,7 +136,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 			address = 0x0;
 			val = lower_16_bits(val);
 		}
-		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
+		ret = ad5686_write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
 		if (ret)
 			return ret;
 		break;
@@ -160,7 +160,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		ret = st->read(st, chan->address);
+		ret = ad5686_read(st, chan->address);
 		if (ret < 0)
 			return ret;
 		*val = (ret >> chan->scan_type.shift) &
@@ -189,8 +189,8 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
 			return -EINVAL;
 
-		return st->write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
-				 chan->address, val << chan->scan_type.shift);
+		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				    chan->address, val << chan->scan_type.shift);
 	default:
 		return -EINVAL;
 	}
@@ -447,8 +447,7 @@ EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
-		 const char *name, ad5686_write_func write,
-		 ad5686_read_func read)
+		 const char *name, const struct ad5686_bus_ops *ops)
 {
 	struct iio_dev *indio_dev;
 	struct ad5686_state *st;
@@ -462,8 +461,7 @@ int ad5686_probe(struct device *dev,
 	st = iio_priv(indio_dev);
 
 	st->dev = dev;
-	st->write = write;
-	st->read = read;
+	st->ops = ops;
 	st->chip_info = chip_info;
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
@@ -505,8 +503,8 @@ int ad5686_probe(struct device *dev,
 			return ret;
 		break;
 	case AD5686_REGMAP:
-		ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
-				st->use_internal_vref ? 0 : 1);
+		ret = ad5686_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
+				   st->use_internal_vref ? 0 : 1);
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 8043cb4ab3cf..679831881ae2 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -56,10 +56,15 @@ enum ad5686_regmap_type {
 
 struct ad5686_state;
 
-typedef int (*ad5686_write_func)(struct ad5686_state *st,
-				 u8 cmd, u8 addr, u16 val);
-
-typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
+/**
+ * struct ad5686_bus_ops - bus specific read/write operations
+ * @read: read a register value at the given address
+ * @write: write a command, address and value to the device
+ */
+struct ad5686_bus_ops {
+	int (*read)(struct ad5686_state *st, u8 addr);
+	int (*write)(struct ad5686_state *st, u8 cmd, u8 addr, u16 val);
+};
 
 /**
  * struct ad5686_chip_info - chip specific information
@@ -107,6 +112,7 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
  * struct ad5686_state - driver instance specific data
  * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
+ * @ops:		bus specific operations
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
@@ -118,11 +124,10 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
 struct ad5686_state {
 	struct device			*dev;
 	const struct ad5686_chip_info	*chip_info;
+	const struct ad5686_bus_ops	*ops;
 	unsigned short			vref_mv;
 	unsigned int			pwr_down_mask;
 	unsigned int			pwr_down_mode;
-	ad5686_write_func		write;
-	ad5686_read_func		read;
 	bool				use_internal_vref;
 	struct mutex			lock;
 
@@ -141,8 +146,16 @@ struct ad5686_state {
 
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
-		 const char *name, ad5686_write_func write,
-		 ad5686_read_func read);
+		 const char *name, const struct ad5686_bus_ops *ops);
 
+static inline int ad5686_write(struct ad5686_state *st, u8 cmd, u8 addr, u16 val)
+{
+	return st->ops->write(st, cmd, addr, val);
+}
+
+static inline int ad5686_read(struct ad5686_state *st, u8 addr)
+{
+	return st->ops->read(st, addr);
+}
 
 #endif /* __DRIVERS_IIO_DAC_AD5686_H__ */
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index fd047c01f8f6..30c48d937a38 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -62,10 +62,15 @@ static int ad5686_i2c_write(struct ad5686_state *st,
 	return (ret != 3) ? -EIO : 0;
 }
 
+static const struct ad5686_bus_ops ad5686_i2c_ops = {
+	.write = ad5686_i2c_write,
+	.read = ad5686_i2c_read,
+};
+
 static int ad5686_i2c_probe(struct i2c_client *i2c)
 {
 	return ad5686_probe(&i2c->dev, i2c_get_match_data(i2c),
-			    i2c->name, ad5686_i2c_write, ad5686_i2c_read);
+			    i2c->name, &ad5686_i2c_ops);
 }
 
 static const struct i2c_device_id ad5686_i2c_id[] = {

-- 
2.43.0


