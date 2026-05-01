Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58FD83815E8;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626922; cv=none; b=DeaDnHEvxoHMBZDaSIij04gEWN8tm1AkYpnyMB/t0EHk25L7Q7HN6+ofhkpv3B1PBUkWmfZzVR3vVd1qgoa2OgNMOp2ZrMvZTxNAqpyuEBE0cOiYNTuLEl2/XVWsCj1ikG7vxwzHjc6PrrZH0xr/29cttvOuAD0O3j55X1MOwgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626922; c=relaxed/simple;
	bh=FjmjF5sRlW0vvlgaR9iIiuIzxWP3S/xJbLbY0+BIlv0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GHVLY2OPRBYrxHj0LUXizsBZUhUO3Y22OOU/5Up+DyBJfJNiOyYgEVBzJQ5SH5sqvXmfuhM6YS08OyZoRuky6gGdhA94o9Al+eMSXef9y6EYRuGuX5JZFtjBsuhP384HPYCm/JKLvuoOkzSkmW3PrknUu39cAHmT9qJyaXhn74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IWRoI4gl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IWRoI4gl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D44DC2BCF6;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626922;
	bh=FjmjF5sRlW0vvlgaR9iIiuIzxWP3S/xJbLbY0+BIlv0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IWRoI4glfMgmE4zyR4EbUNxrmIV2y1pVQ2RBo1nOygQuVnI1O95yUCOfsXzzw69Xp
	 Fr/Os5wxPm+2mmUw04gqJ5YL0hFVuYljn7SsfGRzNUdKdRTMbEkia8CDqxMMI4pujT
	 V51TftyZKE7j+LFEGbK6qwndRzZJD1lEK7ORFlx5uWMpCyz3CH4egFDUvGLmHmFp33
	 QNEv+ECbopQdj7yCDgXo/03amwbA6CMHnsM8GGPvOBr5hvSM1cDkSaCD5w7IOp42z/
	 E4uWBnAGU2lcgSIwDXUrwbrALsgxR2s8RHJsYidqot+zIr1eWUzF7wCRE93y20JL7p
	 +MaXjclJJZSxw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3669BCD3424;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:15:05 +0100
Subject: [PATCH v5 12/12] iio: dac: ad5686: create bus ops struct
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-12-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
In-Reply-To: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=7630;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=R3ZcXIDA8Ei+0XBUOZtKsoDqu9PKMLX4OLhx5MnXzf0=;
 b=pNzgcwNp6mfiNpncULm36VVKS69kFTxBX/7rHcHR1QHxsF2V8jXQUyPCCN9T3yMxnN+gQ1T6K
 R49neFVqGSvAimE0e1uA8M4Mv1T8xWagrtarYcyM/EvenzgvjZ89+xu
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
index b94efa6de16e..8ebd1d4c73d4 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -30,18 +30,18 @@ static int ad5310_control_sync(struct ad5686_state *st)
 {
 	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
 
-	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
-			 FIELD_PREP(AD5310_PD_MSK, pd_val & AD5686_PD_MSK) |
-			 FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
+			    FIELD_PREP(AD5310_PD_MSK, pd_val & AD5686_PD_MSK) |
+			    FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
 }
 
 static int ad5683_control_sync(struct ad5686_state *st)
 {
 	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
 
-	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
-			 FIELD_PREP(AD5683_PD_MSK, pd_val & AD5686_PD_MSK) |
-			 FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+	return ad5686_write(st, AD5686_CMD_CONTROL_REG, 0,
+			    FIELD_PREP(AD5683_PD_MSK, pd_val & AD5686_PD_MSK) |
+			    FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
 }
 
 static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
@@ -148,7 +148,7 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 			address = 0x0;
 			val = lower_16_bits(val);
 		}
-		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
+		ret = ad5686_write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
 		if (ret)
 			return ret;
 		break;
@@ -171,7 +171,7 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
-		ret = st->read(st, chan->address);
+		ret = ad5686_read(st, chan->address);
 		mutex_unlock(&st->lock);
 		if (ret < 0)
 			return ret;
@@ -201,10 +201,8 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
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
@@ -465,8 +463,7 @@ EXPORT_SYMBOL_NS_GPL(ad5679r_chip_info, "IIO_AD5686");
 
 int ad5686_probe(struct device *dev,
 		 const struct ad5686_chip_info *chip_info,
-		 const char *name, ad5686_write_func write,
-		 ad5686_read_func read)
+		 const char *name, const struct ad5686_bus_ops *ops)
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
@@ -479,8 +476,7 @@ int ad5686_probe(struct device *dev,
 	st = iio_priv(indio_dev);
 
 	st->dev = dev;
-	st->write = write;
-	st->read = read;
+	st->ops = ops;
 	st->chip_info = chip_info;
 
 	ret = devm_regulator_get_enable_read_voltage(dev, "vcc");
@@ -524,8 +520,8 @@ int ad5686_probe(struct device *dev,
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
index 4c38dd43d4bb..51fb5a8cb756 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -64,10 +64,15 @@ enum ad5686_regmap_type {
 
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
@@ -115,6 +120,7 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
  * struct ad5686_state - driver instance specific data
  * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
+ * @ops:		bus specific operations
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
@@ -126,11 +132,10 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
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
 
@@ -149,8 +154,16 @@ struct ad5686_state {
 
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
index e15b01d0b768..6250c227293c 100644
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


