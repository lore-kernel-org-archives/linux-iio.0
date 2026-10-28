Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793226269;
	b=U5DoT5Avx/22dK2cRotLHfTYluaEHSoYrS2e/dALDW1cfcxOIackH6D59sktlLB/5WcJ
	 I390/022mLZHUjD9TAURIdNCSYfsD22oAUQT/aGvME9efNnf7sG98W1cFa1b11mqB4jPG
	 fYkwnXODJ/+MHcAWt+rDpegFGgP6SJK6POJX3jFo2PsIDhK0NjhNH7VSscNzlZD6WTReX
	 rqWEKw4ryENbCTySGzfq/zv1G7Om5O/Uwcv0jYdyGw6aLt8vNoLEg02ltoW42RX6Oszs9
	 gey6yfknHUD+WsHtEDH0Xfw8KG8yxN+esfgk9NEMPtBpzGtYPyCC6t3uwTnlVW7G+2A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226269;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6JteruuYFKqK2qjAQ+bINGAUfyjKeOOAshoIWEKW9DA=;
	b=g1F++Fgm9NmRPt4R5RYaAy4PKS03kqLPoRAIfbjt4YhKK9f6Giw4G8CFgOeIquYLyVwO
	 /2sA+svBWRdeeVS09CP/hoIPifw4ZBW8vlqDXbtfx98f0BIr8rqg3a4iYT23sxhiCEjtC
	 QjlptK3shWPOGfQBhJQ4S5Xfv/E9FldjudIw5c1TdSdYaFO2qSKYPdSUhUxW97T1fwAaH
	 w1B+ISjnA5y7JWtxqX66yq9a2RZb2dvQ8VFomBXvzydurA3xSSZFU7DkVEZUDqiSbnSEj
	 QWycyQ+9I0UnLhC84q7OX5sjg0EhX3OQHpsiOTbut1z0J3KrRrVlKgB+YgegPwQZfBA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8A2jBRq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A393606A322;
	Wed, 28 Oct 2026 22:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O8A2jBRq
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793226269;
	b=2RIg8onTKcG4jNEVptCHQpJGFTOH1ofkmKwjv06sPe6ilIhuW2/xne7vPOmm3sQzxWPc
	 SwAQpIr6yU9M56nXo9llm23P7puNwaKYGLOWy5potG8xaTt7tkbqWYqKcg5lUF4WiyTl5
	 KKXrTI7n4WbgY4UVsui9Fj/02ugcF8w3V+VvhAoA/nqQBtY+oXBKQW0yCuL14mJlBWYOq
	 WEO5+fG71k+SYlTIkkjpvoYJUPosnx+1tt3vT7wEfjUv6ZKiKZXfUYO+YIpJnixFHe1t2
	 iMDQmPm/uGv9WiLgbvYts3Ivk3zeR0nCLiXarXfbl/e3DwT1OFuYJWjCP8z/hEs1mbA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793226269;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=6JteruuYFKqK2qjAQ+bINGAUfyjKeOOAshoIWEKW9DA=;
	b=XTyyRBemxLevoLnjIbpF5gghY5WAH3n7D6dwofbqK6o2zB71zEKuTZR3Yf0e+dSeD39t
	 pUN20u3qBZc8BU1IpschjjDIqFF9S8a55HHqrE0Yjg1SnULyz7gAbpt5aFtvXIrTVQvnu
	 uVhhSdzPHOm34S3aGxvGP640//0hkLxFtbdTq2QqwPu/VyUGhNBay+97ae4A/9wzfGDl6
	 YUu/sLRerQynJt5IxymrGOFoH+GSBHSBt+MPiyFkUG4nZgHJAORlWF7aqJMbcxaKkc4Or
	 FhfLEb5HNfJlF8ygeNV408Kz11NcxAbFen/HhvjTjJUQNvtXf6+haOpv5h57JsZic6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 203421F031E0;
	Wed, 28 Oct 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226269;
	bh=6JteruuYFKqK2qjAQ+bINGAUfyjKeOOAshoIWEKW9DA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=O8A2jBRqMycVtaI55vCTlh6Gt076E0VM7XkSws2hligFHzDjSqWOJsBMScNctdI/R
	 92thDgZwVhukSJTcfYdYlsZ/mU7wiZLgRWZwMD3Fy1rOprZEuV8m22iAeT5f/bltTC
	 cc2hXFjttfkQz0taka3jPjq2Pu3dwPpF/EbZd3Mqh85+O7pc8S/NeLyn7qSdMpjiuz
	 ap0RPqgaD9RESy1OzQFPPov6Gv/KHiSOQeFI9wG0NKMnLNFym5WiqkTZDC09pX6UbU
	 p+BZOv9BuovgIVroqUFymhw78r5PnB0Mtx84ECCOfkSx0y1m+AKYw8XGQ8Wm8Rjk/E
	 lpGWFHRFPsesA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9E9CF455EA;
	Wed, 28 Oct 2026 22:24:26 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Thu, 29 Oct 2026 00:24:28 +0200
Subject: [PATCH v3 3/4] iio: adc: ltc2497: select the channel set per
 device
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
Message-Id: <20261029-submission-ltc2493-support-v1-v3-3-c7dd5f877c3b@analog.com>
References: <20261029-submission-ltc2493-support-v1-v3-0-c7dd5f877c3b@analog.com>
In-Reply-To: <20261029-submission-ltc2493-support-v1-v3-0-c7dd5f877c3b@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793226265; l=5702;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=Nf5hH6TBOt/zTpIFaIzCQBPLGE7n6D6DuKoTSgdJLX8=;
 b=07+4DD+bx5WNyrGw1X61s38DIq0Al2dEcPFBo/hNxRYHrXvHczHQkRbTb8uYkC4hWF4pzHFFI
 pCbvLE+uWE/ABdOzmPkNSsP0lDGxDtXBlSuH40+S2xPLPNZIdUqRy1D
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com
Content-Transfer-Encoding: 8bit

From: Andrei Stancovici <andrei.stancovici@analog.com>

Ahead of adding a part with a different channel map, describe each
layout as a channel set in the core and let chip_info point at the one
its part uses. Probe takes the channel array and its length from there
instead of picking a table and trimming the count itself.

No functional change.

Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>

---
Changes in v3:
- New patch. The channel-set mechanism is introduced before the LTC2493
  so that the patch adding the part does not change the chip_info of the
  parts already supported (Nuno Sá).
- chip_info references a channel set directly rather than carrying the
  single-ended input count for the core to match against a keyed table.
  That removes the probe-time search and its -EINVAL path. The count had
  no remaining user once the search was gone, so it is removed with it;
  the direct reference is what now carries the relationship the integer
  added in v2 was standing in for (Jonathan Cameron, Nuno Sá).
- pahole, struct ltc2497_chip_info, before -> after: LP64 16 -> 24
  bytes, ILP32 12 -> 16 bytes, no holes either way. The driver holds
  four of these, all static and const. The ILP32 figures were taken
  from a standalone build of the struct by the host compiler; no 32-bit
  kernel toolchain was available here.
- Verified as no functional change on hardware: the complete sysfs
  attribute tree of the LTC2497 and the LTC2499, names and values, is
  identical across this patch, and both parts still pass their full
  suites at this commit (LTC2499 36/36, LTC2497 24/24).
---
 drivers/iio/adc/ltc2496.c      |  1 +
 drivers/iio/adc/ltc2497-core.c | 27 ++++++++++++++++++---------
 drivers/iio/adc/ltc2497.c      |  2 ++
 drivers/iio/adc/ltc2497.h      | 13 +++++++++++++
 4 files changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ltc2496.c b/drivers/iio/adc/ltc2496.c
index 5b5b6ab28850..ffddd6368755 100644
--- a/drivers/iio/adc/ltc2496.c
+++ b/drivers/iio/adc/ltc2496.c
@@ -89,6 +89,7 @@ static void ltc2496_remove(struct spi_device *spi)
 static const struct ltc2497_chip_info ltc2496_info = {
 	.resolution = 16,
 	.name = NULL,
+	.channel_set = &ltc2497_chanset_ltc2497,
 };
 
 static const struct of_device_id ltc2496_of_match[] = {
diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index c218d87d3a62..576a7c0a0f9b 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -420,6 +420,22 @@ static const struct iio_chan_spec _name[] = {                           \
 LTC2497_DEFINE_CHANNELS(ltc2497core_channel, 0);
 LTC2497_DEFINE_CHANNELS(ltc2497core_channel_samp_freq, BIT(IIO_CHAN_INFO_SAMP_FREQ));
 
+/*
+ * The temperature channel is the last entry of each table, so a part without
+ * the sensor stops one short of it.
+ */
+const struct ltc2497_channel_set ltc2497_chanset_ltc2497 = {
+	.channels	= ltc2497core_channel,
+	.num_channels	= ARRAY_SIZE(ltc2497core_channel) - 1,
+};
+EXPORT_SYMBOL_NS_GPL(ltc2497_chanset_ltc2497, "LTC2497");
+
+const struct ltc2497_channel_set ltc2497_chanset_ltc2499 = {
+	.channels	= ltc2497core_channel_samp_freq,
+	.num_channels	= ARRAY_SIZE(ltc2497core_channel_samp_freq),
+};
+EXPORT_SYMBOL_NS_GPL(ltc2497_chanset_ltc2499, "LTC2497");
+
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
 	.read_avail = ltc2497core_read_avail,
@@ -443,15 +459,8 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (ddata->chip_info->has_speed_mode)
-		indio_dev->channels = ltc2497core_channel_samp_freq;
-	else
-		indio_dev->channels = ltc2497core_channel;
-	/* Only the ltc2499 has a temperature channel; it is the last entry. */
-	if (ddata->chip_info->has_temp)
-		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
-	else
-		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel) - 1;
+	indio_dev->channels = ddata->chip_info->channel_set->channels;
+	indio_dev->num_channels = ddata->chip_info->channel_set->num_channels;
 
 	if (ddata->chip_info->has_rejection_mode) {
 		struct iio_chan_spec *channels;
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 4cccd3b7c8ef..984f15eb06f6 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -176,10 +176,12 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
+		.channel_set = &ltc2497_chanset_ltc2497,
 	},
 	[TYPE_LTC2499] = {
 		.resolution = 24,
 		.name = "ltc2499",
+		.channel_set = &ltc2497_chanset_ltc2499,
 		.has_temp = true,
 		.has_speed_mode = true,
 		.has_rejection_mode = true,
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 3a3fd82b21a3..7335c6c0af84 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -44,8 +44,21 @@ enum ltc2497_rejection {
 	LTC2499_REJECT_60,
 };
 
+/*
+ * The set of channels a part exposes.  Each supported channel layout has one
+ * of these in the core; a part names its own through chip_info.
+ */
+struct ltc2497_channel_set {
+	const struct iio_chan_spec	*channels;
+	unsigned int			num_channels;
+};
+
+extern const struct ltc2497_channel_set ltc2497_chanset_ltc2497;
+extern const struct ltc2497_channel_set ltc2497_chanset_ltc2499;
+
 struct ltc2497_chip_info {
 	const char *name;
+	const struct ltc2497_channel_set *channel_set;
 	u32 resolution;
 	bool has_temp;
 	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */

-- 
2.43.0


