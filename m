Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6F533F595;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395739; cv=none; b=ejuSjecgVOGxvKPT6BdkS0NPbwiLLK5TnpsqUqVhJdlWZ9Q8OslWQ46UaAnPHsivVb53ZrGq8W35jCet9QDJO0nbJgm3T3GfCXE++DdpYFcR2JYAG2vUL9ulvdyEgJtKn0neA2LGmXaUN39nPFBJ9xG75fxjaQgdbSIXTFymor4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395739; c=relaxed/simple;
	bh=krVf7p9/XSPfP4ZSXyTzfe8GH35a+0rXDoreKCFWalU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ewnO4iwa3Og9ysUcKQAXLviuM7GpThZMLT1nZ8ULBer3OK6oRgVBfrQ/XF38hPGOfPtJ9CgKZR77/smOuXsDtz8Pdy0aWd4Ki89157DRgfHxtvjfvgdpm9YaEcRL0U+g9JMs1jzaG8yYZU9hr0JtQ6u0MQ6DYB51FopLEVjO7lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCEYzCod; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCEYzCod"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 505CBC2BCF4;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777395739;
	bh=krVf7p9/XSPfP4ZSXyTzfe8GH35a+0rXDoreKCFWalU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=TCEYzCodqnOyok4lr0w++nzAR1pI7/WSJxwlShZpgIoPB6qlaf5krnSAnLay7u0BS
	 sRW7E2pkJTQR81P4OuY1jYSz/YVw535KP4jJv0h4HgS2Ky9OM693JEyCQ/dvOt6/CS
	 31JXe1LdjLMJgOGlZGtbGqgyLDA7kcCZIV7wp2hezLYOJYPt6KbCsZrpAulcoM/bb8
	 NylhTgT4KFsJAKVb2MljtepqEKCgL6JWX+oCWJDRHSrwNrJCWh2NUJ2rJhE8+cEWXD
	 pyv0+v/+vKd9MMdpMla9hJYCqbVvShpkVVbb5fjqSbpAKY8MAJ7Dx8k0njbDgCfD5m
	 dA9lJkgA1tBzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EF2FF8878;
	Tue, 28 Apr 2026 17:02:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 28 Apr 2026 18:02:24 +0100
Subject: [PATCH v3 09/11] iio: dac: ad5686: add control_sync() for
 single-channel devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-ad5686-fixes-v3-9-9cff7bd67a15@analog.com>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
In-Reply-To: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777395737; l=6004;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=mlPsPJGibSn9jC1Ml4iLk03xG0zqfBHDGLMjfkzY0iQ=;
 b=js4HiExFXCHo96955rM5EBJ0tge7QwFCjlAg19mEciZxCDqMs7PVHehnoXdhSCQ9tmcyO1J5c
 iV1pwrMxXuxCW6nxk1FMDEi33m94P+ATkBOKLMWiMl4V2Ie5wxadHuN
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Create ad5310_control_sync() and ad5683_control_sync() functions that
properly consumes the mask definitions with FIELD_PREP(). This allows to
reuse a function that updates the control register with cached values,
without relying on confusing logic that depends on st->use_internal_vref,
which is initialized earlier in ad5686_probe() because it is also
applicable to the AD5686_REGMAP case, removing the need for the
has_external_vref. The change cleans up ad5686_write_dac_powerdown() and
ad5686_probe(), organizing the code for feature extension, e.g. gain
control support for single-channel devices.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 88 ++++++++++++++++++++++++++++--------------------
 drivers/iio/dac/ad5686.h |  4 +++
 2 files changed, 56 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index ce0fcb4db065..73a3178ac2b8 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -6,11 +6,13 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/err.h>
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
+#include <linux/wordpart.h>
 
 #include <linux/iio/iio.h>
 
@@ -22,6 +24,24 @@ static const char * const ad5686_powerdown_modes[] = {
 	"three_state"
 };
 
+static int ad5310_control_sync(struct ad5686_state *st)
+{
+	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
+
+	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
+			 FIELD_PREP(AD5310_PD_MSK, pd_val) |
+			 FIELD_PREP(AD5310_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+}
+
+static int ad5683_control_sync(struct ad5686_state *st)
+{
+	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
+
+	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
+			 FIELD_PREP(AD5683_PD_MSK, pd_val) |
+			 FIELD_PREP(AD5683_REF_BIT_MSK, st->use_internal_vref ? 0 : 1));
+}
+
 static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
 {
 	if (chan->channel == chan->address)
@@ -80,8 +100,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	bool readin;
 	int ret;
 	struct ad5686_state *st = iio_priv(indio_dev);
-	unsigned int val, ref_bit_msk;
-	u8 shift, address = 0;
+	unsigned int val;
+	u8 address;
 
 	ret = kstrtobool(buf, &readin);
 	if (ret)
@@ -96,32 +116,34 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
-		shift = 9;
-		ref_bit_msk = AD5310_REF_BIT_MSK;
+		ret = ad5310_control_sync(st);
+		if (ret)
+			return ret;
 		break;
 	case AD5683_REGMAP:
-		shift = 13;
-		ref_bit_msk = AD5683_REF_BIT_MSK;
+		ret = ad5683_control_sync(st);
+		if (ret)
+			return ret;
 		break;
 	case AD5686_REGMAP:
-		shift = 0;
-		ref_bit_msk = 0;
 		/* AD5674R/AD5679R have 16 channels and 2 powerdown registers */
-		if (chan->channel > 0x7)
+		val = st->pwr_down_mask & st->pwr_down_mode;
+		if (chan->channel > 0x7) {
 			address = 0x8;
+			val = upper_16_bits(val);
+		} else {
+			address = 0x0;
+			val = lower_16_bits(val);
+		}
+		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	val = ((st->pwr_down_mask & st->pwr_down_mode) << shift);
-	if (!st->use_internal_vref)
-		val |= ref_bit_msk;
-
-	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC,
-			address, val >> (address * 2));
-
-	return ret ? ret : len;
+	return len;
 }
 
 static int ad5686_read_raw(struct iio_dev *indio_dev,
@@ -435,9 +457,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk, shift;
-	bool has_external_vref;
-	u8 cmd;
+	unsigned int shift;
 	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -455,8 +475,8 @@ int ad5686_probe(struct device *dev,
 	if (ret < 0 && ret != -ENODEV)
 		return ret;
 
-	has_external_vref = ret != -ENODEV;
-	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
+	st->use_internal_vref = ret == -ENODEV;
+	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
 
 	/* Set all the power down mode for all channels to 1K pulldown */
 	st->pwr_down_mode = ~0U;
@@ -480,29 +500,25 @@ int ad5686_probe(struct device *dev,
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
-		cmd = AD5686_CMD_CONTROL_REG;
-		ref_bit_msk = AD5310_REF_BIT_MSK;
-		st->use_internal_vref = !has_external_vref;
+		ret = ad5310_control_sync(st);
+		if (ret)
+			return ret;
 		break;
 	case AD5683_REGMAP:
-		cmd = AD5686_CMD_CONTROL_REG;
-		ref_bit_msk = AD5683_REF_BIT_MSK;
-		st->use_internal_vref = !has_external_vref;
+		ret = ad5683_control_sync(st);
+		if (ret)
+			return ret;
 		break;
 	case AD5686_REGMAP:
-		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = AD5686_REF_BIT_MSK;
+		ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
+				st->use_internal_vref ? 0 : AD5686_REF_BIT_MSK);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	val = has_external_vref ? ref_bit_msk : 0;
-
-	ret = st->write(st, cmd, 0, val);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad5686_probe, "IIO_AD5686");
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index caadc7403da1..09c87e15c37e 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -44,7 +44,11 @@
 #define AD5686_CMD_READBACK_ENABLE_V2		0x5
 
 #define AD5310_REF_BIT_MSK			BIT(8)
+#define AD5310_PD_MSK				GENMASK(10, 9)
+
 #define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5683_PD_MSK				GENMASK(14, 13)
+
 #define AD5686_REF_BIT_MSK			BIT(0)
 
 

-- 
2.43.0


