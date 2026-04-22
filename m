Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7A34D389;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869185; cv=none; b=odqt/SVSYGd55psnGGFOHFiYoz13tsS/r7uxKiWCv9NVao117onPm4ARmpjBOOGXNUyVsI5RTJdlO50U+FcW/YC0Tg7lzGLy6G8fCAjpGBgqdNh2KGHDJqzpIGPRIUc3/7R9vSER/jl5dMV6XATsVb6Z7p0DuoRvi40Fp8bE/z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869185; c=relaxed/simple;
	bh=pxNfPBV9abv2iiYKCM3CIOnVBpKtnMS17H+Wr7KVeQc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PfcS9Qzgq8xIXdjP+Qz3iu65IYBfSk7bBnrNBb6/2wGnjP66vtUuSueYoJfcMNin9NnEFqVKYozBLy7lGAHNR/mCs5IdoMZbEROCnVuvkglIgYlrPyX+5ZXvWJFXKTqQXwCcxW2mG7UBSb2GwjSzTEUv4vJNyEOPyyiPFfPNvqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=htWpR2/K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="htWpR2/K"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2D35C4AF16;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=pxNfPBV9abv2iiYKCM3CIOnVBpKtnMS17H+Wr7KVeQc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=htWpR2/KEpwQAhd1AsDroXpwocx294Gt1L+ik3SXfGEafb1tYb25Z4gBZfyU+FaCW
	 AhDRzKxbVsJpqjj37AzOVDo+t+3n9sTM1Wq39iVjd+aGz/QAjhU8JvO6Qf8Oxf75LV
	 MO+uN858fsUbliIUOS50p0yUJ5PHlQ1rNiHuRVYjoHe2zcFYmay+cH7eyxXDgdmXtp
	 XIAiPzqXVvbDyvAXubfmhTmKNicpIIDGEXV6kuOnnw4DV+WCwNmVNXL4WuJHbs1QU7
	 Amuu9/eYrw7Ms5KohDIPA9bMyJO+sv0kQ8v+9LNAUcT9d51YghwpHE/19/VbonOcXT
	 FMGGV0nRoUoRw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6470F9EDF3;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:49 +0100
Subject: [PATCH 15/22] iio: dac: ad5686: create bus ops struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-15-ed7dca001d1b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=7997;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=uPClgrlUPxOW/10rckm79pZao0inPAAnozDn4pnLyIU=;
 b=wZDih8DVfYFcM/5Tu4xEMM01KygTMLWVe4b+INQfC1gIa4k9Y1xC9UjpG3DexSddC1IFJycdr
 lnakbLON2f3DpUuCjrKW/SvDFXXG2EiF6b1jMI9it90DJJCYE8k+TtV
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Create struct with bus operations, including a sync() operation that will
be used to flush multiple channel writes at once. Auxiliary functions
ad5686_write() and ad5686_read() are created and ad5686_probe() now
receives an ops struct pointer rather than individual read and write
functions. Documentation header of ad5686_state struct is updated
accordingly (adjusting renamed fields and formatting).

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c |  7 ++++++-
 drivers/iio/dac/ad5686.c     | 32 ++++++++++++++------------------
 drivers/iio/dac/ad5686.h     | 44 ++++++++++++++++++++++++++++++++------------
 drivers/iio/dac/ad5696-i2c.c |  7 ++++++-
 4 files changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 6c9b70880da9..9c00e016e67c 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -91,10 +91,15 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
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
index 4989404a7b6e..fddcc77ab794 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -27,18 +27,18 @@ static int ad5310_control_sync(struct ad5686_state *st)
 {
 	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
 
-	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
-			 FIELD_PREP(AD5310_PD_MSK, pd_val) |
-			 FIELD_PREP(AD5310_REF_BIT_MSK, !st->use_internal_vref));
+	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
+			    FIELD_PREP(AD5310_PD_MSK, pd_val) |
+			    FIELD_PREP(AD5310_REF_BIT_MSK, !st->use_internal_vref));
 }
 
 static int ad5683_control_sync(struct ad5686_state *st)
 {
 	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
 
-	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
-			 FIELD_PREP(AD5683_PD_MSK, pd_val) |
-			 FIELD_PREP(AD5683_REF_BIT_MSK, !st->use_internal_vref));
+	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
+			    FIELD_PREP(AD5683_PD_MSK, pd_val) |
+			    FIELD_PREP(AD5683_REF_BIT_MSK, !st->use_internal_vref));
 }
 
 static inline int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
@@ -137,7 +137,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 		} else {
 			val = lower_16_bits(val);
 		}
-		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
+		ret = ad5686_write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
 		break;
 	default:
 		ret = -EINVAL;
@@ -160,7 +160,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
-		ret = st->read(st, chan->address);
+		ret = ad5686_read(st, chan->address);
 		mutex_unlock(&st->lock);
 		if (ret < 0)
 			return ret;
@@ -190,10 +190,8 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&st->lock);
-		ret = st->write(st,
-				AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
-				chan->address,
-				val << chan->scan_type.shift);
+		ret = ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
+				   chan->address, val << chan->scan_type.shift);
 		mutex_unlock(&st->lock);
 		break;
 	default:
@@ -454,8 +452,7 @@ EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
-		 const char *name, ad5686_write_func write,
-		 ad5686_read_func read)
+		 const char *name, const struct ad5686_bus_ops *ops)
 {
 	struct iio_dev *indio_dev;
 	struct ad5686_state *st;
@@ -468,8 +465,7 @@ int ad5686_probe(struct device *dev,
 	st = iio_priv(indio_dev);
 
 	st->dev = dev;
-	st->write = write;
-	st->read = read;
+	st->ops = ops;
 	st->chip_info = chip_info;
 
 	ret = devm_regulator_get_enable_optional(dev, "vdd");
@@ -525,8 +521,8 @@ int ad5686_probe(struct device *dev,
 			return ret;
 		break;
 	case AD5686_REGMAP:
-		ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
-				!st->use_internal_vref);
+		ret = ad5686_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
+				   !st->use_internal_vref);
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 7004d0d1d97a..55f49dbbbd39 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -56,10 +56,17 @@ enum ad5686_regmap_type {
 
 struct ad5686_state;
 
-typedef int (*ad5686_write_func)(struct ad5686_state *st,
-				 u8 cmd, u8 addr, u16 val);
-
-typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
+/**
+ * ad5686_bus_ops - bus specific read/write operations
+ * @read: read a register value at the given address
+ * @write: write a command, address and value to the device
+ * @sync: ensure the completion of the write operation (optional)
+ */
+struct ad5686_bus_ops {
+	int (*read)(struct ad5686_state *st, u8 addr);
+	int (*write)(struct ad5686_state *st, u8 cmd, u8 addr, u16 val);
+	int (*sync)(struct ad5686_state *st);
+};
 
 /**
  * struct ad5686_chip_info - chip specific information
@@ -106,24 +113,23 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
 
 /**
  * struct ad5686_state - driver instance specific data
- * @spi:		spi_device
+ * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
+ * @ops:		bus specific operations
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
  * @use_internal_vref:	set to true if the internal reference voltage is used
- * @lock		lock to protect the data buffer during regmap ops
- * @data:		spi transfer buffers
+ * @lock:		lock to protect the data buffer during regmap ops
+ * @data:		transfer buffers
  */
-
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
 
@@ -142,8 +148,22 @@ struct ad5686_state {
 
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
-		 const char *name, ad5686_write_func write,
-		 ad5686_read_func read);
+		 const char *name, const struct ad5686_bus_ops *ops);
 
+static inline int ad5686_write(struct ad5686_state *st, u8 cmd, u8 addr, u16 val)
+{
+	int ret;
+
+	ret = st->ops->write(st, cmd, addr, val);
+	if (ret)
+		return ret;
+
+	return st->ops->sync ? st->ops->sync(st) : 0;
+}
+
+static inline int ad5686_read(struct ad5686_state *st, u8 addr)
+{
+	return st->ops->read(st, addr);
+}
 
 #endif /* __DRIVERS_IIO_DAC_AD5686_H__ */
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 237f4b5df021..51cd765d80f3 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -61,10 +61,15 @@ static int ad5686_i2c_write(struct ad5686_state *st,
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


