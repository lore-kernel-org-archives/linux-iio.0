Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0CB3446CE;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192699; cv=none; b=AqMng6LZv/wKFTkEVFOSoizQwLJ1w1YNuu2rye8EzRa7y/wc7MMH6fpTAQri5WtY9CW/cX4YF3ypIXGYHo64qX9hunDUqIWfmA9ZudLDkyqxCfpTquVQVrM5s0dohHgEbDMA/P/xSgCnL2PuYrAJ9C4YBJcmzK7Rxr9si5ce8Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192699; c=relaxed/simple;
	bh=QGNNtbE9rzWeyjGHb0lguGX2RFlZafDnG+4RP3YBs+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEYPnvq2/O/nT7zMDYFtR22HJT+l5tI5fLC9pr9qJkTyeX57LYcwhXw9AXWlz+dkcjb7OPxOkfOubDihvFHygXO884b8fbEo9hJBDL2RfKC5oNMhH0gNVFMevfQYHZvBDqUQwdj369gY2iibwmEnLEVyP/8lAnDmhAv+mqvvc/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdyjatgZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdyjatgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A62B8C2BCC7;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192699;
	bh=QGNNtbE9rzWeyjGHb0lguGX2RFlZafDnG+4RP3YBs+4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PdyjatgZ3IodB5KfhB7VyDgSO9F+ooV2A5Ks2Cq0+RTKaQBGKmXkCt5k/BRmyAcDZ
	 ZACAaV/KLV98K6DReNbxWMlHmlMGutuAEvF9LC3OS+WHRtFjN7TWoxZI2plfesl8II
	 ZrTZk65abW8+qni0MOeZ2TcohJzk5t7nrQNQklJsPX8EWSh6rDpXvjfpntbZ6ye/f0
	 inctX2Blsz8jpx3QQ61KvE2QxyXrEsCWhpw2DmNxDxY9QfKf8KMya1UOQSOZTT1Aba
	 LArxmCVpOv8MNUzbgoOyvKVl8hmrPGzPAin24MTifQd/48BO7F2C5LeM084VRHaZca
	 qNuZ26dzXOwpw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE56FF8864;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 26 Apr 2026 09:38:06 +0100
Subject: [PATCH 05/10] iio: dac: ad5686: fix ref bit initialization for
 single-channel parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-ad5686-fixes-v1-5-7c946a77794e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777192698; l=6149;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Fe+7DBfbc1bOX4qMy68JsRmkBHqJ6mp1cO2Eqei1XHc=;
 b=YKgGCL8qNTRYxCPahU84dgzrya0V2VS6zttmce+j85KanIQCPFngA6HD6Y5eE+dKEEB05x9wF
 Or4p2xif5MYALtguMYWGtECksGU60GaOhwDA7eTZAeexsHbdYXkNwUV
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

For single-channel parts the control register is used to enable the
internal voltage reference and perform powerdown control. The reference
enable bit position was ignored when writing the register at the probe
function (!!val was used). This patch adds a control_sync() function that
properly consumes the mask definitions with FIELD_PREP(). As further
cleanup, the created functions and definitions are also used in
ad5686_write_dac_powerdown(). Some local variables ended up being unused
(so removed) and st->use_internal_vref is initialized earlier in probe,
because it is also applicable to the AD5686_REGMAP case.

Fixes: be1b24d24541 ("iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 89 ++++++++++++++++++++++++++++--------------------
 drivers/iio/dac/ad5686.h |  3 +-
 2 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e67faef91164..843e425f656f 100644
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
 
 #include "ad5686.h"
 
@@ -20,6 +22,24 @@ static const char * const ad5686_powerdown_modes[] = {
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
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
@@ -65,8 +85,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	bool readin;
 	int ret;
 	struct ad5686_state *st = iio_priv(indio_dev);
-	unsigned int val, ref_bit_msk;
-	u8 shift, address = 0;
+	unsigned int val;
+	u8 address;
 
 	ret = kstrtobool(buf, &readin);
 	if (ret)
@@ -79,32 +99,34 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 
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
@@ -416,11 +438,8 @@ int ad5686_probe(struct device *dev,
 		 const char *name, ad5686_write_func write,
 		 ad5686_read_func read)
 {
-	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk;
-	bool has_external_vref;
-	u8 cmd;
+	struct ad5686_state *st;
 	int ret, i;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
@@ -438,8 +457,8 @@ int ad5686_probe(struct device *dev,
 	if (ret < 0 && ret != -ENODEV)
 		return ret;
 
-	has_external_vref = ret != -ENODEV;
-	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
+	st->use_internal_vref = ret == -ENODEV;
+	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
 
 	/* Set all the power down mode for all channels to 1K pulldown */
 	for (i = 0; i < st->chip_info->num_channels; i++)
@@ -457,29 +476,25 @@ int ad5686_probe(struct device *dev,
 
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
-		ref_bit_msk = 0;
+		ret = st->write(st, AD5686_CMD_INTERNAL_REFER_SETUP, 0,
+				st->use_internal_vref ? 0 : 1);
+		if (ret)
+			return ret;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	val = (has_external_vref | ref_bit_msk);
-
-	ret = st->write(st, cmd, 0, !!val);
-	if (ret)
-		return ret;
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 EXPORT_SYMBOL_NS_GPL(ad5686_probe, "IIO_AD5686");
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 6e3552c92e4b..7004d0d1d97a 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -44,8 +44,9 @@
 #define AD5686_CMD_READBACK_ENABLE_V2		0x5
 
 #define AD5310_REF_BIT_MSK			BIT(8)
+#define AD5310_PD_MSK				GENMASK(10, 9)
 #define AD5683_REF_BIT_MSK			BIT(12)
-
+#define AD5683_PD_MSK				GENMASK(14, 13)
 
 enum ad5686_regmap_type {
 	AD5310_REGMAP,

-- 
2.43.0


