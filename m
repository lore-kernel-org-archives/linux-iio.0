Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795594184;
	b=2WPo+2ibGkhwdj5kobRqSm/aygxa5JU0JQGcLda7yPtdS75S1b2NaTaIKnkg3Hcoo6H5
	 D5zw9HQe67HIeBk0IyiIzG75W4r4phkEV2cNGaKd4NOBe4bv3leIzHSexWBVFryaDHy/E
	 gJg5yauiSjGzV2R1zjhQz44tiy7tpmlFt3AwuQSHbWVr00a1Q4/dd/G5zCHEGU2qGFKOI
	 Cs+ANhTLGWu8YY3NcLiogI8pNXq1I65l0OHTp6Fr7C664hBbk31GjVS0yf0iRhMm/rggA
	 3a7ch4v4kxoaOiQmvp6zrGtljpCOT196WWYhujV2AtGsJkLKzcG5NjCyFZ/Lwm1dBlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795594184;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=smbyugSDytNWTpgnwENCOQRYiqjRyjYnGZyua9J1QQI=;
	b=OtqmY4n+jr6rGa9AwfRWeKUcxqPthfMaDRwXsXlXJg98emABH5YlO9fpE+X19qTrO6+E
	 Xd+C7SFwQwhJHTDQqAO5dn2OG1MKDHI/i12el/hg7+kMlhLuO7YGnS6E2TxzJfUwQCrek
	 3g3JV9f07Sjb+ufiT/PVnQedR8z7fRZW/Xz/0gVmEMuMs25A5cNaAoD/gEnRQ3Fa5toa1
	 JXSgz4dzWD/A44oy+AHw0bEpsYFrvRV+8Xh/dmNS/sr/VEmS0gcOFEaxGxLSQfOy0E3Wm
	 L9CS/BjWUZO7fPTXz+ULQisQ1WTTQdcrqf/n7lvqSZAQ7V1ig2PX1d+yj3QAW+4h1lQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hxq/YTdR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBA2606A31E;
	Wed, 25 Nov 2026 08:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxq/YTdR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795594183;
	b=fGoQ5NPvZzg6iwZ03HdRR/AaA2aawFYKo6tWCl3Iyya9pL5RX4KOLg+xTNS0iUDttx/p
	 s/us+K7J5REWb4n4xz6Symrh8VGcVrRN+GmV4iKkElY+aE44TmIAjc2tL9b4VkvZTUXFS
	 NAB33XYKwQUXVAFnCdutvVN7VD8fIwFyKzytdCUwD+c/ToebwTpzd3Zd90WD4wgX3Owh4
	 wkBugrd79Y9XohxlvB+oCIzeazpcmXKBGpZwEVIfWNe7twhf6FVmiIbg02VrdKZibr46V
	 GQSGBsxBJK/pgL/vwJJWyrSKSP3ccFo5e9VnL66PX+Fhrok2KJDWW3ehLkdr1nX80Bw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795594183;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=smbyugSDytNWTpgnwENCOQRYiqjRyjYnGZyua9J1QQI=;
	b=KO8cyF/TW3jOug1I4EptZtPr3C/gqJ5eJrmlMPfaBlBbYWTGrWs35+x/ySdaXDiTBWfU
	 8//CiivAwYR/IM/ikYGnZf7bCj5Q+i8Vd22hg/GY2Fnoa7pDPvJUODLgz4ob4DaFM/iQv
	 3Z6q+DEWMm76vAJBVlENo93YAGbCCOON62ataiNXFkesU4sv+4Ijx1y8twy+fxtOfPUIv
	 Wz/vjuZDVTrmkbPE0RjjKBBNdskV3HIQS+PHgLfj+xQP9G8Qo6vZds8wpITP/Ur9kd9Mx
	 mUWwfZacD8+/xNbGsbeQC3ex+g6f1YIfUlQEG6og7/QZF0NohXByjxamhBVsL+tfAsg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CEC671F000C6;
	Wed, 25 Nov 2026 08:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795594183;
	bh=smbyugSDytNWTpgnwENCOQRYiqjRyjYnGZyua9J1QQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=hxq/YTdRMILHuF70V2TzqKx/rn46QkQDHpQyIrVduGDqor/qn32O2egpWXP/4gQi+
	 VEJvZ4MzS3dxSc80fbJc9N8NbrUsGVN25WMAIUNPFagqVMJ37xDuTV7Yh6wgw10vzj
	 MtYqFRVUPfgX8rCivKIYD3K4UXMc5TIjMXU/F6Id3xHImLGdI0sfEj/lWsHlwV/RYA
	 ogDgFnZkeez/brT8AVO7wV9JuVPOOJkjyTIKycYWbNhH/AZy09V1zREnaTPlSuIhI4
	 IC3lBuU1dkdbzbFp+GRGJzIWSSOPWAYGnQjcg7a6X9oB7xOfkcnONQOQf1HOhzRNwB
	 dqAtLdP7ZOKvQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 579054CDAB;
	Wed, 25 Nov 2026 08:09:34 +0000 (UTC)
From: Raffaele Tranfaglia via B4 Relay <devnull+raffaele.tranfaglia.gmail.com@kernel.org>
Date: Wed, 25 Nov 2026 08:09:31 +0000
Subject: [PATCH v2 2/3] regmap: mask values to val_bits on write
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261125-regmap-kunit-val-bits-v2-2-81db3b79cd3f@gmail.com>
References: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
In-Reply-To: <20261125-regmap-kunit-val-bits-v2-0-81db3b79cd3f@gmail.com>
To: Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 linux-sound@vger.kernel.org, Neo Chang <YLCHANG2@nuvoton.com>, 
 Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795594173; l=3996;
 i=raffaele.tranfaglia@gmail.com; s=20261011; h=from:subject:message-id;
 bh=CpFxrUBFq4HChQ2hs185G3VYqsVjVNBbMpd8HrGPNY8=;
 b=I98w6ILxy/+xwRNqwo1EZi+6UekgRn4J/gmM3RWF2aO03gLHzHFrmSATpLsUk8jl/gW97Shur
 2kwXzlL3HSqBCXvpBr/TrL9ucAeTdMPymb+CoYd2snqOthrFepT1gkA
X-Developer-Key: i=raffaele.tranfaglia@gmail.com; a=ed25519;
 pk=mweuSGNM6vguCTdqa+aiHwMXdgk70suj2wolzCp6XGM=
X-Endpoint-Received: by B4 Relay for raffaele.tranfaglia@gmail.com/20261011
 with auth_id=1160
X-Original-From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
Reply-To: raffaele.tranfaglia@gmail.com
Content-Transfer-Encoding: 7bit

From: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>

regmap_write() takes an unsigned int, also for regmaps with val_bits
smaller than 32. What happens to the bits above val_bits depends on the
bus and on the cache type:

- buses with a raw write() go through the value formatters, which drop
  the bits that do not fit in the formatted value;
- buses and users with only reg_write() get the value unmodified. Some
  of them, like the SMBus backends of regmap-i2c, then return -EINVAL;
- the cache may store a value that differs from the one written to the
  device.

For example the adux1020 driver writes ~u16, which is promoted to int,
to a 16-bit register. This works on I2C adapters and fails with -EINVAL
on SMBus-only ones.

Mask the value to val_bits in _regmap_write(), before updating the
cache, so that all buses and cache types behave the same. Do the same
for the values cached by _regmap_multi_reg_write(), which does not use
_regmap_write() on devices supporting multi register writes.

val_bits is documented as mandatory, but some users providing their own
reg_read() and reg_write() leave it at 0, for example because their
registers have different sizes. Do not mask values for these.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Raffaele Tranfaglia <raffaele.tranfaglia@gmail.com>
---
 drivers/base/regmap/internal.h |  1 +
 drivers/base/regmap/regmap.c   | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index ea375cc8ae87..6a7efb10127b 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -33,6 +33,7 @@ struct regmap_format {
 	size_t reg_bytes;
 	size_t pad_bytes;
 	size_t val_bytes;
+	unsigned int val_mask;
 	s8 reg_shift;
 	void (*format_write)(struct regmap *map,
 			     unsigned int reg, unsigned int val);
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 45b5b4f76b0c..eab1bd2043ce 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -6,6 +6,7 @@
 //
 // Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
+#include <linux/bits.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/export.h>
@@ -1082,6 +1083,12 @@ struct regmap *__regmap_init(struct device *dev,
 	map->format.reg_shift = config->reg_shift;
 	map->format.reg_bytes = BITS_TO_BYTES(config->reg_bits);
 	map->format.val_bytes = BITS_TO_BYTES(config->val_bits);
+	/* Some users with their own register accessors don't set val_bits */
+	if (config->val_bits > 0 &&
+	    config->val_bits < BITS_PER_TYPE(map->format.val_mask))
+		map->format.val_mask = GENMASK(config->val_bits - 1, 0);
+	else
+		map->format.val_mask = UINT_MAX;
 	map->format.buf_size = BITS_TO_BYTES(config->reg_bits + config->val_bits + config->pad_bits);
 	if (config->reg_stride)
 		map->reg_stride = config->reg_stride;
@@ -1986,6 +1993,9 @@ int _regmap_write(struct regmap *map, unsigned int reg,
 	if (!regmap_writeable(map, reg))
 		return -EIO;
 
+	/* Make sure that the cache and the device see the same value */
+	val &= map->format.val_mask;
+
 	if (!map->cache_bypass && !map->defer_caching) {
 		ret = regcache_write(map, reg, val);
 		if (ret != 0)
@@ -2014,6 +2024,8 @@ int _regmap_write(struct regmap *map, unsigned int reg,
  * @reg: Register to write to
  * @val: Value to be written
  *
+ * If the regmap_config sets val_bits, any bits of @val above it are ignored.
+ *
  * A value of zero will be returned on success, a negative errno will
  * be returned in error cases.
  */
@@ -2611,7 +2623,7 @@ static int _regmap_multi_reg_write(struct regmap *map,
 
 	if (!map->cache_bypass) {
 		for (i = 0; i < num_regs; i++) {
-			unsigned int val = regs[i].def;
+			unsigned int val = regs[i].def & map->format.val_mask;
 			unsigned int reg = regs[i].reg;
 			ret = regcache_write(map, reg, val);
 			if (ret) {

-- 
2.56.0


