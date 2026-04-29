Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D43FCB15;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=tfX0pr/1aJBAeI2sUXtzOxKSTG2Bv68Tgu/E+L768knMRfbtVzfav4c0xT+apteC5fsRkSOZUuwMvgXROK4EH99T4r9guW8c+uiE4LveyM0eXEEzxvJ+fD0BAxI57AlkR2G3csh4xub/Vtn6WBPoenvdcvxRfRVfOFO8zfADcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=iPrMO31/+/fx+412Uc1izl2un9j/z5gdSUXz+F111kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9tPAw57SgVJE+ekDCEKOFuJiBB4gpnDsDTTj3HPyKP5qYqHwYjP+lB5pk5D6WGn7vffqkOxGO+O5fEXAZONsn3gExANS+Mp4Bn+EGJgEBwU4pyqTqC9DZjDk6qpO6YthPBlZjpSdbafklh8dFJ58trEoHvuNPEBI98focGs/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTDYRP7d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTDYRP7d"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C30DC2BCC4;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468058;
	bh=iPrMO31/+/fx+412Uc1izl2un9j/z5gdSUXz+F111kM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jTDYRP7dczKWiE2HanXF/UPJ+LsWp90A79adU3S1Sf6QkIAeyLLzlqTCi84UoYf7L
	 UblkQ+9oPNbiyF+NV/+U/sNKtIJqtEtb3B1Uzl1Bipa2uTM4y9PGoK4eodZdqljl/M
	 UEtJ3kTekBekj2/qwREUBfpaibRqFiPo9U2I+pIhlL9HuNivJSX9366nnRk9bmaAh9
	 RwZ/OlNreRMGhUeIe2q2QRN6d1tVDZgU8f2LbFgXKtCvVLZDNpv8RdekuEpTETLnq+
	 igBWpgxuqud/FvzBW9qIQo7i7WPMygDTZHdfWcoaJwwtKjk08+3cvdPOzj8RwIRrHn
	 WkW36P1y+k30g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F6BFF8875;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:41 +0100
Subject: [PATCH v4 11/13] iio: dac: ad5686: add control_sync() for
 single-channel devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-11-bb8f1cbd68e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=6326;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=XSe5vaMQORw7mcD7Wxjsqs0Rww8Q+L26YaLGRXd+7NI=;
 b=MsVJ91aG4iSfoMlGkguMQ3+Qyedj4wxkFclze1W0ylZDVt1VdyC9PsO1PlX5wscqs3Jyw0kYC
 BzOtaQByY2CB2bPajLWuHZ9sg5sse2xkRzP1GAtU+eXdui+IQrbBdXb
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 88 ++++++++++++++++++++++++++++--------------------
 drivers/iio/dac/ad5686.h |  7 ++--
 2 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 0590716191c1..bf3dc3903346 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/bitops.h>
 #include <linux/errno.h>
 #include <linux/export.h>
@@ -13,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sysfs.h>
+#include <linux/wordpart.h>
 
 #include <linux/iio/iio.h>
 
@@ -24,6 +26,24 @@ static const char * const ad5686_powerdown_modes[] = {
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
@@ -82,8 +102,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	bool readin;
 	int ret;
 	struct ad5686_state *st = iio_priv(indio_dev);
-	unsigned int val, ref_bit_msk;
-	u8 shift, address = 0;
+	unsigned int val;
+	u8 address;
 
 	ret = kstrtobool(buf, &readin);
 	if (ret)
@@ -98,32 +118,34 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 
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
@@ -437,9 +459,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk, shift;
-	bool has_external_vref;
-	u8 cmd;
+	unsigned int shift;
 	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -457,8 +477,8 @@ int ad5686_probe(struct device *dev,
 	if (ret < 0 && ret != -ENODEV)
 		return ret;
 
-	has_external_vref = ret != -ENODEV;
-	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
+	st->use_internal_vref = ret == -ENODEV;
+	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
 
 	/* Initialize masks to all ones provided the max shift (last channel) */
 	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
@@ -485,29 +505,25 @@ int ad5686_probe(struct device *dev,
 
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
index b9eee3ad4dc8..0ba4168195f5 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -44,9 +44,12 @@
 #define AD5686_CMD_READBACK_ENABLE_V2		0x5
 
 #define AD5310_REF_BIT_MSK			BIT(8)
-#define AD5683_REF_BIT_MSK			BIT(12)
-#define AD5686_REF_BIT_MSK			BIT(0)
+#define AD5310_PD_MSK				GENMASK(10, 9)
 
+#define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5683_PD_MSK				GENMASK(14, 13)
+
+#define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5686_PD_MSK				GENMASK(1, 0)
 
 enum ad5686_regmap_type {

-- 
2.43.0


