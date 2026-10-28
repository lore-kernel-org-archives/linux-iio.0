Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793226269;
	b=aghd4zOLCpL+5KyObj7YYAyIGnsoX0cFqUfewctqhnsCj1xaZg7/oVqBhb+aGhyhOtf9
	 gJGNt73zPCgKXcoq4LGsQV0DRevb6jkqdcOR/HN7ArrbMxE6gzSXoJhmw05oC7ci+Kas2
	 IS/X3huTCqN9qgSu60do5Hcu2uYhPhSW8PXsFDLw5CU+J0Lt9C2c25rnWZxbFTv06E4ub
	 2HEMorPJVZrpt/cHxKZXsZvjQ5GbSyHI58Z1BLPPY3WMfiWpXL0ptUwlH/6Q4IL6B4ryY
	 EWm+098by0m/Yr1Nnnmxu1/AmdWiwoeAyta78Nx2mpxc5zTjg0EYV91EuaQWkwN/deA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793226269;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jj8IIGFLEiUloe5ADfWrgSQMIReGe1WkFbLKic5cw30=;
	b=DIc6wDXlRXkUaAtMqYn2G/0rrThQKYegBuMZ9py+NTIm9TRbxCHVdCXU1knKEz+kNAoO
	 SeHFXfkkX32sNr+LWZFdmZxdj6+MfoH67ttB4zWRLblxrxpookbo4RJXOGfPstWRpXxcd
	 0XptXfida6OI5Te5J74V+5FHWGVA2kGQaIe6cvdyYxQuwB4+OYsCgBoJGH35v9e1W0nFU
	 per+7xaHtK7mk2AYg4CYN5BHNVfADWzyscdEum2F1BiZEDOKdmBNgLYU06+8hwOzfIyyj
	 vaBzmxEMaya8wxE2M8GVYgFOh6gfeMJC0NhqrnowS8dfkSDxTEoJBRuhBQHZ9NX1xDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7xum04W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0A606A320;
	Wed, 28 Oct 2026 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K7xum04W
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793226268;
	b=JboHPPhS/MGvtQBovEbiV0Gu82SEHOZvALA53C5sU00s59t3IsbXxB9Ft2ULdLnkp/40
	 ihWuyRbzt7hFelF76VBbhH48ceA7YbHGCXxOiOcJDjCf69c2Xk9TXmfCzh4SRjNyvR7Cy
	 NINpTeCr6PMtd5IeF2sp0IUEgSbGsqczltaGExMeXxmFeTL/pzRHVPikMan0Fazxsv9rY
	 6EMk3C61kFjNfqqibkM0LT8KXg/Ad3C75sNDbYPgaE7visdaDR9ViTfu3rulv5YTgqa5u
	 tBuCrJm6zGCPSjnbxThzN/AAaHk1pN98pozjjJlH/C6EUKVvQp0tm0gfl41pc/onbwA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793226268;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=jj8IIGFLEiUloe5ADfWrgSQMIReGe1WkFbLKic5cw30=;
	b=lYpiblZfvuyfn4sSjkUEjVe+7BDGoUIAw+smKoOtBa6N+b5x0nSdigC7Vnq4FQV7ivUM
	 5YIFiclLTyf/pUV3JrkjWOb9XDmaY1pqDxQIs3jQE069krXRHMvvxlhTPXModv7PONxcx
	 KNIcvH1cR+aRsg4mctExDCLL3NA4h8YzEUuVUMgkmGgLQGi0GEoycxN3eH6DoKX3n4tHh
	 ScjYeJ4H/curkx2puhaV0GWYoP8Oq856/WK1D0RFVUPlDsI55zW3SqW8Fe+0yIP9m7nwa
	 pvCKrQ0+zFju/r4EjFRjD6bw4elGqjpCGmXjz2cm3kvfNpcq7OH9bRwGddG8HS+un1A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2A8251F031E4;
	Wed, 28 Oct 2026 22:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793226268;
	bh=jj8IIGFLEiUloe5ADfWrgSQMIReGe1WkFbLKic5cw30=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=K7xum04W2mWSX8PtW5MtF2mW/Yb9uwhjysV/gfUCvwfjKiSvpqJiBP/lYV5CCmYEi
	 zie383XY2vNgD3KtqTaOr8mMGyZWQhyBh8dy0LTjwFa3XumNQGV9XECGYJBIg0Emzw
	 S/d6XhqrIZBt3kgEmajMtLJqC921inaI/GmvTdLoShH2NbO8bswvHCqoVCPKSjaD9X
	 CNgYY5Sxory8AOEN3Upm05B8AvlZCP8Zqp5nIrNFnVQcu6LDmLNQs35jB/L1JQy8b9
	 BCgCmcTNlugSDJfii5BYrQ8CGC6TVT7/m7pU9C2DJ2yUXPV7wN3lUAbpSV2JSGXeCv
	 PomSHWjDRjonQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AB711455EE;
	Wed, 28 Oct 2026 22:24:26 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Thu, 29 Oct 2026 00:24:29 +0200
Subject: [PATCH v3 4/4] iio: adc: ltc2497: add LTC2493 support
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
Message-Id: <20261029-submission-ltc2493-support-v1-v3-4-c7dd5f877c3b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793226265; l=4895;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=HMOt8+O4iAcZt1O9Bo/3/1otGda9wp6zawFttSIvbBk=;
 b=KHB0M1q9DcYZ4AxeEKHIHs5tI5yISDR1/tozj+Xj20g2+1ZmupYvl4Jl8NgD4XcGcC6XHipLw
 QaZS66PuSQICVgArQiWLXObVmVuT1+cPrCGnlxvhZNYdA9hk/1QnGJO
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com
Content-Transfer-Encoding: 8bit

From: Andrei Stancovici <andrei.stancovici@analog.com>

The LTC2493 is the 4-channel member of the LTC2499 family: 4 single-ended
inputs or 2 differential pairs, 24-bit result, and the same command
format, internal PTAT temperature sensor, 2x speed mode and line-frequency
rejection as the LTC2499.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>

---
Changes in v3:
- The channel-set mechanism moved to the preceding patch, so this one
  adds only the LTC2493: its channel table and channel set, its
  chip_info entry, and the I2C and OF identifiers. No chip_info entry of
  an already supported part is touched (Nuno Sá).
- The LTC2493 channel table is defined once, for the speed-mode layout
  the part actually uses; v2 also generated a second variant that
  nothing selected.
- Revalidated on hardware with the full series applied: LTC2493 41/41,
  LTC2499 36/36, LTC2497 24/24.
---
 drivers/iio/adc/ltc2497-core.c | 20 ++++++++++++++++++++
 drivers/iio/adc/ltc2497.c      | 11 +++++++++++
 drivers/iio/adc/ltc2497.h      |  1 +
 3 files changed, 32 insertions(+)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index 576a7c0a0f9b..6659f848256c 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -420,6 +420,20 @@ static const struct iio_chan_spec _name[] = {                           \
 LTC2497_DEFINE_CHANNELS(ltc2497core_channel, 0);
 LTC2497_DEFINE_CHANNELS(ltc2497core_channel_samp_freq, BIT(IIO_CHAN_INFO_SAMP_FREQ));
 
+static const struct iio_chan_spec ltc2493_channel[] = {
+	LTC2497_CHAN(0, LTC2497_SGL, "CH0", BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_CHAN(1, LTC2497_SGL, "CH1", BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_CHAN(2, LTC2497_SGL, "CH2", BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_CHAN(3, LTC2497_SGL, "CH3", BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF, BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF, BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN,
+			  BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN,
+			  BIT(IIO_CHAN_INFO_SAMP_FREQ)),
+	LTC2497_TEMP_CHANNEL,
+};
+
 /*
  * The temperature channel is the last entry of each table, so a part without
  * the sensor stops one short of it.
@@ -436,6 +450,12 @@ const struct ltc2497_channel_set ltc2497_chanset_ltc2499 = {
 };
 EXPORT_SYMBOL_NS_GPL(ltc2497_chanset_ltc2499, "LTC2497");
 
+const struct ltc2497_channel_set ltc2497_chanset_ltc2493 = {
+	.channels	= ltc2493_channel,
+	.num_channels	= ARRAY_SIZE(ltc2493_channel),
+};
+EXPORT_SYMBOL_NS_GPL(ltc2497_chanset_ltc2493, "LTC2497");
+
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
 	.read_avail = ltc2497core_read_avail,
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 984f15eb06f6..3bbb6d91d41c 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -19,6 +19,7 @@
 #include "ltc2497.h"
 
 enum ltc2497_chip_type {
+	TYPE_LTC2493,
 	TYPE_LTC2497,
 	TYPE_LTC2499,
 };
@@ -173,6 +174,14 @@ static void ltc2497_remove(struct i2c_client *client)
 }
 
 static const struct ltc2497_chip_info ltc2497_info[] = {
+	[TYPE_LTC2493] = {
+		.resolution = 24,
+		.name = "ltc2493",
+		.channel_set = &ltc2497_chanset_ltc2493,
+		.has_temp = true,
+		.has_speed_mode = true,
+		.has_rejection_mode = true,
+	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
@@ -189,6 +198,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 };
 
 static const struct i2c_device_id ltc2497_id[] = {
+	{ .name = "ltc2493", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2493] },
 	{ .name = "ltc2497", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
 	{ .name = "ltc2499", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
 	{ }
@@ -196,6 +206,7 @@ static const struct i2c_device_id ltc2497_id[] = {
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
+	{ .compatible = "lltc,ltc2493", .data = &ltc2497_info[TYPE_LTC2493] },
 	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
 	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
 	{ }
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index 7335c6c0af84..8de35df74f28 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -55,6 +55,7 @@ struct ltc2497_channel_set {
 
 extern const struct ltc2497_channel_set ltc2497_chanset_ltc2497;
 extern const struct ltc2497_channel_set ltc2497_chanset_ltc2499;
+extern const struct ltc2497_channel_set ltc2497_chanset_ltc2493;
 
 struct ltc2497_chip_info {
 	const char *name;

-- 
2.43.0


