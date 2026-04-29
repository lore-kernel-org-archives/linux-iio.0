Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDF3FCB0F;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=QJguD+CQSbxMdobCxzUSQJgJPNso5ym3GxGNluHsoYZOeDMkmhwVM+DSKKXXZ4LpEd/TP1g2+f+2Eyp6a/SwXRGEFGw0+Er/NCHvLvH3uXfEIBlmU9RMWcycKH2Ca87jG3CIgQkEPqYHGy3z4s7XEPuomJPi24N5Kgg8Mdb9OCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=lU10aBiNaCnOCjpQ9vlIHxj+qef4u1iX9RvfOqGg1jo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeIvKnr+m8sc5MRxx+QQFg9am8p7mjds/fRDLukIba6T4YBFNZ3NTPVqM8oX8fnPsPk3XKVqG3SumU1OGA4uTlBjFyKCC48gQRw1R/o/CBAa9bPFzutWw/iUS1U287Lda1eBsF9rSc7jcyHGNjnJ53PPKlm4wj71doQhVvnrgCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bch9PDox; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bch9PDox"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73BD2C2BCF7;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468058;
	bh=lU10aBiNaCnOCjpQ9vlIHxj+qef4u1iX9RvfOqGg1jo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bch9PDoxWbqeyPW5/LK9A6uwfFDvMRtpF1UjUT7xXEj7dyyUQXcbbB/g2UzP6nFK3
	 rNL0le2usHR38kccwwKgyCZjIjDf+HFBMotmbcWbTSMmTRJIWvP5fv8Idt12he/6aS
	 kPjgoyK/qbX5QKWaQTMdwcWN4MLNQOXUEFfGGedfz7iLByhXgl7RnuK2ne4Hu31CeP
	 fKidb4uh1WmuaW2FyCve/lxsxhhhOqgnvInpzqksSfPHdM40d9B/VHiVfskrZIJTty
	 1yVlSv3C38SOYzVf9C/MwjI2BlEhRQRfnmoMySIB557ET4qlMbi0sRe7xq6DBGn326
	 Gaqw9RNPshPMw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C19ACCFA13;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:43 +0100
Subject: [PATCH v4 13/13] iio: dac: ad5686: create bus ops struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-13-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=7566;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=LuP1ax2zq6YT04bIBwYyw9AJEsK6qS3wccsB9OfuPxA=;
 b=tZSNC+Ace8IuxliSDceImaRkbkvwwKKuqGEYup4Ow0DVKkxhokbh84UNAYEJTr49gqHv8DrxD
 c1BGhMiHqoAAZ4mEtsNATf5ne8PsuVJjQIbaFL60nqs/hB3CtCiPUyt
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c |  7 ++++++-
 drivers/iio/dac/ad5686.c     | 32 ++++++++++++++------------------
 drivers/iio/dac/ad5686.h     | 29 +++++++++++++++++++++--------
 drivers/iio/dac/ad5696-i2c.c |  7 ++++++-
 4 files changed, 47 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 9493511d9e7f..7409624b954b 100644
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
index bf3dc3903346..5df2527b3a2e 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -30,18 +30,18 @@ static int ad5310_control_sync(struct ad5686_state *st)
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
@@ -137,7 +137,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
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
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
@@ -469,8 +466,7 @@ int ad5686_probe(struct device *dev,
 	st = iio_priv(indio_dev);
 
 	st->dev = dev;
-	st->write = write;
-	st->read = read;
+	st->ops = ops;
 	st->chip_info = chip_info;
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
@@ -515,8 +511,8 @@ int ad5686_probe(struct device *dev,
 			return ret;
 		break;
 	case AD5686_REGMAP:
-		ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
-				st->use_internal_vref ? 0 : AD5686_REF_BIT_MSK);
+		ret = ad5686_write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
+				   st->use_internal_vref ? 0 : AD5686_REF_BIT_MSK);
 		if (ret)
 			return ret;
 		break;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 4397ffd2e236..e8dc21ecc0c5 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -60,10 +60,15 @@ enum ad5686_regmap_type {
 
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
@@ -111,6 +116,7 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
  * struct ad5686_state - driver instance specific data
  * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
+ * @ops:		bus specific operations
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
@@ -122,11 +128,10 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
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
 
@@ -145,8 +150,16 @@ struct ad5686_state {
 
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
index 6943616eace3..6f3842ef8f9c 100644
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


