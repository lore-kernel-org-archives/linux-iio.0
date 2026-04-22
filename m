Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED13344044;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=XWLklfX+ZaWTJc8OoEak+MKQZ6wl/hhyac7fbapr6k2ijjv5IUPXiSY6NfCBDe7tzbjPt1JQKCb7QaNvdVxuWRXrYf1SvM4on4WxeW2N/t8DMzwQwcmJrKpcJ1ERjYz97e1G5zirwSvsVC6xKJI7EPG/hSgN2EE2TOySFycGVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=sQoCI/ekQ1NhAv+hxshxm+zS5jKkGMxUF4Dn9I85syI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wdhp0yiDX6LkSmy7ItNfSVPT0ckqjuBojAB9j44oTxHBVQ7L8jSxhlUsEG0j7q3MzE5Bubucqnt2KgMnGTEwaPmvzTcWV1iZ4lldVjoimWt7RjvNTQZ6i11hVBskc6n4s42xOxalZ0U1F0XrsCJa3oAdAhmhp0Fqgqejuw+hAaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTwSmo4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTwSmo4q"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99CADC2BCC9;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=sQoCI/ekQ1NhAv+hxshxm+zS5jKkGMxUF4Dn9I85syI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fTwSmo4q13rkhU7191MEdjGEw8afI06L12DJ3NgCPYXqIRaQS9n/QdN00kzyfq7f4
	 LK794F+B9xwdHv4tY6EnSibA24kQNo6dD8kgxH7eBsGvF02YIJQZzxLp8jeOqR5PjM
	 DDHQUPvLD2WiKJr++wazEQKsBLhNHIdG+HaHiV6q1Oj9bx8/iAHZh8U7C8wJHyWPsQ
	 ymD7W0jQ1kxMrRI1KtMP939GprQjGTtEEsyQcQ3KDOsKfevu+/BRoGmE6X0ti1wUBc
	 yWLsZzMXjb+huIQw5yBCPJJesqB3MV2Xq1rOsHzDgvnKJAkFqIPOd//UruChpnio46
	 KP23SnuAk8blA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2E3F9EDF6;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:45 +0100
Subject: [PATCH 11/22] iio: dac: ad5686: fix ref bit initialization for
 single-channel parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-11-ed7dca001d1b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=5789;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Ph++WbScG/7DVMcdVEOFz61aSBSuj4HHept6UKwK5DA=;
 b=YOonYJNp/Q5LUaeNFisr7IUNPZxcGhUJyk42pDA0ba8tNHdDyJKKfukjB9eLUXyhjjfCTSpdE
 NhbCCzr8FaKApAc2JTAJaZC+ok2BJbGC5o7CQgjlApvT6nqwtYMxlLA
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
function. This patch adds a control_sync() function that properly consumes
the mask definitions with FIELD_PREP(). As further cleanup, the created
functions and definitions are also used in ad5686_write_dac_powerdown().
Some local variables ended up being unused (so removed) and
st->use_internal_vref is initialized earlier in probe.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 79 +++++++++++++++++++++++++++---------------------
 drivers/iio/dac/ad5686.h |  3 +-
 2 files changed, 46 insertions(+), 36 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index e67faef91164..4ca9cd5b6e38 100644
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
+			 FIELD_PREP(AD5310_REF_BIT_MSK, !st->use_internal_vref));
+}
+
+static int ad5683_control_sync(struct ad5686_state *st)
+{
+	unsigned int pd_val = st->pwr_down_mask & st->pwr_down_mode;
+
+	return st->write(st, AD5686_CMD_CONTROL_REG, 0,
+			 FIELD_PREP(AD5683_PD_MSK, pd_val) |
+			 FIELD_PREP(AD5683_REF_BIT_MSK, !st->use_internal_vref));
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
+	u8 address = 0;
 
 	ret = kstrtobool(buf, &readin);
 	if (ret)
@@ -79,30 +99,26 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
-		shift = 9;
-		ref_bit_msk = AD5310_REF_BIT_MSK;
+		ret = ad5310_control_sync(st);
 		break;
 	case AD5683_REGMAP:
-		shift = 13;
-		ref_bit_msk = AD5683_REF_BIT_MSK;
+		ret = ad5683_control_sync(st);
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
+			val = lower_16_bits(val);
+		}
+		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
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
 
 	return ret ? ret : len;
 }
@@ -416,11 +432,8 @@ int ad5686_probe(struct device *dev,
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
@@ -438,8 +451,8 @@ int ad5686_probe(struct device *dev,
 	if (ret < 0 && ret != -ENODEV)
 		return ret;
 
-	has_external_vref = ret != -ENODEV;
-	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
+	st->use_internal_vref = ret == -ENODEV;
+	st->vref_mv = st->use_internal_vref ? st->chip_info->int_vref_mv : ret / 1000;
 
 	/* Set all the power down mode for all channels to 1K pulldown */
 	for (i = 0; i < st->chip_info->num_channels; i++)
@@ -457,29 +470,25 @@ int ad5686_probe(struct device *dev,
 
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
+				!st->use_internal_vref);
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


