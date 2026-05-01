Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E999537FF59;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626922; cv=none; b=PXzXQFFFkSNJDHNKw/9QM26o1vLaEE3dj0uWGAxf0jzUrxy2m0v1aR1QbexoiRtNAIXA1aU3cTyBhcFvYja8idX9QWB7FjtRW3h2zTvuy90A6+eW3qk9Sasv3NxjZOZwsGGy9vEpbLl6g1d036Ff0TQZdXve9oGPrsFrxRT+YRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626922; c=relaxed/simple;
	bh=/vz/Et57/ETkKqO/2fI8BIAP8N2wyHZmnMQrgdd/wog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KdFzlmuoGnOpszMFu0roes+H5hZqKU+uct+wArikAR/Nt3HrGspLAGTBMl5fCzaxeRtgAXV4tztOe8x74cVVolHFHovgmOQJ48oogqHMLDeKzljj7XFA5SkqbU+TAF1KRSxR2OqyZ2cf9NlxTFjVOjx6F3wxls2CXH+AYTqgt8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QU/RPUFG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QU/RPUFG"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BAAEEC2BCF4;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626921;
	bh=/vz/Et57/ETkKqO/2fI8BIAP8N2wyHZmnMQrgdd/wog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QU/RPUFGSc4B1RHYe99LbqTfgb/8OwLAXUv2buGqe0/7kfs1bvZzav+GQwNKE8eoP
	 3YtGJbWXUC3ASrEUm8WIt/PhIQ9zaYyd0bHNHbEuO9rdHN8Z1Noxic+o0ol7vTKNgq
	 X3a8DBuLH1sOc+SHbs9RUpXZwqtFiv3QhCS6S66gk55r8HQih82m67T47eh3LK8/cR
	 Of/klaktTNatgO5HZg3Cet7V4cwVSAzP2lCKky2E8paUUOwPNCmLHh7QZth6udCW9o
	 vEKnvESibwiQzRQ1FbPav5IoALq1vI936QMWSVTU5BwaEGVXGnQY1WAaZbL9WobyOs
	 iAMWgVDV22zOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F8FF885A;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:14:57 +0100
Subject: [PATCH v5 04/12] iio: dac: ad5686: fix powerdown control on
 dual-channel devices
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-4-0b2f45488418@analog.com>
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=4523;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=W7kLkmqYDobLBwqnuuqx8gF9sREn36byIbemRQVPp+E=;
 b=5nhT/9K6wJDAnvGlUYMjh+DiE1zRsg09lPbdQx0qhhet7cVMnQ3V8VNNdyclP6pVcXtynxss1
 jgLsI8hhYj5D/lc3IqAZDd9lH6/XiRHa2If5jwlPsw6kGPaxjJwkpP/
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Fix powerdown control by using a proper bit shift for the powerdown mask
values. During initialization, powerdown bits are initialized so that
unused bits are set to 1 and the correct bit shift is used. Dual-channel
devices use one-hot encoding in the address and that reflects on the
position of the powerdown bits, which are not channel-index based
for that case. Quad-channel devices also use one-hot encoding for the
channel address but the result of log2(address) coincides with the channel
index value. The issue was introduced when first adding support for
dual-channel devices, which overlooked powerdown control differences.

Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 69358dd66cbc..c607251b82a0 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -25,24 +25,35 @@ static const char * const ad5686_powerdown_modes[] = {
 	"three_state"
 };
 
+static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
+{
+	if (chan->channel == chan->address)
+		return chan->channel * 2;
+
+	/* one-hot encoding is used in dual/quad channel devices */
+	return __ffs(chan->address) * 2;
+}
+
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
+	return ((st->pwr_down_mode >> shift) & 0x3) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
-	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
+	st->pwr_down_mode &= ~(0x3 << shift);
+	st->pwr_down_mode |= (mode + 1) << shift;
 
 	return 0;
 }
@@ -57,10 +68,10 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
-				       (0x3 << (chan->channel * 2))));
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3 << shift)));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -82,9 +93,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	if (readin)
-		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
+		st->pwr_down_mask |= 0x3 << ad5686_pd_mask_shift(chan);
 	else
-		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
+		st->pwr_down_mask &= ~(0x3 << ad5686_pd_mask_shift(chan));
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -464,7 +475,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk;
+	unsigned int val, ref_bit_msk, shift;
 	bool has_external_vref;
 	u8 cmd;
 	int ret, i;
@@ -488,9 +499,18 @@ int ad5686_probe(struct device *dev,
 	has_external_vref = ret != -ENODEV;
 	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
 
+	/* Initialize masks to all ones provided the max shift (last channel) */
+	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
+	st->pwr_down_mask = GENMASK(shift + 1, 0);
+	st->pwr_down_mode = GENMASK(shift + 1, 0);
+
 	/* Set all the power down mode for all channels to 1K pulldown */
-	for (i = 0; i < st->chip_info->num_channels; i++)
-		st->pwr_down_mode |= (0x01 << (i * 2));
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
+		st->pwr_down_mask &= ~(0x3 << shift); /* powered up state */
+		st->pwr_down_mode &= ~(0x3 << shift);
+		st->pwr_down_mode |= 0x01 << shift;
+	}
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5686_info;

-- 
2.43.0


