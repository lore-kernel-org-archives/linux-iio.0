Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC11C3E9C0D;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791535416; cv=none; b=LqEb6KfaStLWhPBici0NSdXYb9TD7EniKghhxfoFiKPtZkK74iKztFFbLFMDoi+8oF193XK62A1frStSBUzTKpI2b9jqD4zRv7ryKRCIEwSFdUmUtxCWS6rLUzI5LQozQFSNJ0Fhun9tgZzEZDxT/ZYl4FA1+XZGiFHDSpHshpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791535416; c=relaxed/simple;
	bh=m/qD6hdQdVLIFMAHHrbZhpROJWrq6WO2p/IJDFDClA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qRDvO4xEKGBku7W+baZHQ6OLWSmRFJHKrz/YqulHFoCsLDbERfQf4CfAtMSYBdlPA1Rog28ba5ZnUPQTSfNp8wNGOizbF3i/cj6MDvMJqTGopNY3WjgN8rUrOy0vYBLhXhuQN2nKCsmp9rfadxM5X6wB6WN0xg7sZdxdP9apKK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1D3FHb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1D3FHb9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74C77C4AF09;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791535415;
	bh=m/qD6hdQdVLIFMAHHrbZhpROJWrq6WO2p/IJDFDClA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=X1D3FHb9F7OwbTGd2wtBcYwf+I8Vj34wtqRjoc2aDbKp3dTBfxB9yQZ9ZOzgGS9NL
	 sltz6whRxsyJdA86IF52AiQ0gMrk9OiNwE3IsdNOjPpA9Imr8qPDsobsE4ORzYuE2J
	 VXddJlxKjLauKDlChW04M9zgYMtgm9KMrdape+E6/ZCuIwfsgd2ev/8/vpxlArMiyn
	 4a8iCiMV7os8KEk8vxKx94aqcl++vkd5NNIsSnpT1q+MaBy3dTCfqcOq0Z+g0int7u
	 vl+ff1FZ5Pz2ndCSmdaPia77L2qeg6cImEctb/+dqfBMsTvrS2qtY8mHr9042RcgNX
	 jBPgf6fnLzi5g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DAACA601A;
	Fri,  9 Oct 2026 08:43:35 +0000 (UTC)
From: Andrei Stancovici via B4 Relay <devnull+andrei.stancovici.analog.com@kernel.org>
Date: Fri, 09 Oct 2026 11:43:35 +0300
Subject: [PATCH 2/6] iio: adc: ltc2497: add LTC2493 support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-submission-ltc2493-support-v1-v1-2-3dad1d4b152a@analog.com>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
In-Reply-To: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andrei Stancovici <andrei.stancovici@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791535413; l=5031;
 i=andrei.stancovici@analog.com; s=20261009; h=from:subject:message-id;
 bh=BXIkVqJB1hwOznW3QxTWnj8Ejr/360wxni2bKrfYPu8=;
 b=r6vXcHM5MDD7BGU7MAFL1nDpq6By9FzYI76m96JrewbO2kdbicbMkxMF1BZ6jVHv68OcLX2hs
 jd8t2MMcjtgDdKAnKRVbgPpgLsWKLZSblqfIrOl8W7S2hMB64qC1z6/
X-Developer-Key: i=andrei.stancovici@analog.com; a=ed25519;
 pk=wgT+au+blAhVYxhwNgdx0woNl/1p+OCG484rnTRFrsE=
X-Endpoint-Received: by B4 Relay for andrei.stancovici@analog.com/20261009
 with auth_id=1140
X-Original-From: Andrei Stancovici <andrei.stancovici@analog.com>
Reply-To: andrei.stancovici@analog.com

From: Andrei Stancovici <andrei.stancovici@analog.com>

The LTC2493 is the 4-channel member of the LTC2499 family: 4 single-ended
inputs or 2 differential pairs, with the same command format and 24-bit
result. Add it with its own channel table.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2493fe.pdf
Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
---
 drivers/iio/adc/ltc2497-core.c | 36 ++++++++++++++++++++++++++++--------
 drivers/iio/adc/ltc2497.c      |  8 ++++++++
 drivers/iio/adc/ltc2497.h      |  1 +
 3 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-core.c
index a6e34da83b81..96b365efd1e9 100644
--- a/drivers/iio/adc/ltc2497-core.c
+++ b/drivers/iio/adc/ltc2497-core.c
@@ -347,6 +347,22 @@ static const struct iio_chan_spec _name[] = {                           \
 LTC2497_DEFINE_CHANNELS(ltc2497core_channel, 0);
 LTC2497_DEFINE_CHANNELS(ltc2497core_channel_samp_freq, BIT(IIO_CHAN_INFO_SAMP_FREQ));
 
+/* The LTC2493 has 4 single-ended inputs and 2 differential pairs. */
+#define LTC2493_DEFINE_CHANNELS(_name, _extra_mask)                     \
+static const struct iio_chan_spec _name[] = {                           \
+	LTC2497_CHAN(0, LTC2497_SGL, "CH0", _extra_mask),               \
+	LTC2497_CHAN(1, LTC2497_SGL, "CH1", _extra_mask),               \
+	LTC2497_CHAN(2, LTC2497_SGL, "CH2", _extra_mask),               \
+	LTC2497_CHAN(3, LTC2497_SGL, "CH3", _extra_mask),               \
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF, _extra_mask),                \
+	LTC2497_CHAN_DIFF(0, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_CHAN_DIFF(1, LTC2497_DIFF | LTC2497_SIGN, _extra_mask), \
+	LTC2497_TEMP_CHANNEL,                                           \
+}
+
+LTC2493_DEFINE_CHANNELS(ltc2493_channel, 0);
+
 static const struct iio_info ltc2497core_info = {
 	.read_raw = ltc2497core_read_raw,
 	.read_avail = ltc2497core_read_avail,
@@ -370,15 +386,19 @@ int ltc2497core_probe(struct device *dev, struct iio_dev *indio_dev)
 
 	indio_dev->info = &ltc2497core_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	if (ddata->chip_info->has_speed_mode)
-		indio_dev->channels = ltc2497core_channel_samp_freq;
-	else
-		indio_dev->channels = ltc2497core_channel;
-	/* Only the ltc2499 has a temperature channel; it is the last entry. */
-	if (ddata->chip_info->has_temp)
+	if (ddata->chip_info->four_channel) {
+		indio_dev->channels = ltc2493_channel;
+		indio_dev->num_channels = ARRAY_SIZE(ltc2493_channel);
+	} else {
+		if (ddata->chip_info->has_speed_mode)
+			indio_dev->channels = ltc2497core_channel_samp_freq;
+		else
+			indio_dev->channels = ltc2497core_channel;
 		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel);
-	else
-		indio_dev->num_channels = ARRAY_SIZE(ltc2497core_channel) - 1;
+	}
+	/* Only the ltc2499 has a temperature channel; it is the last entry. */
+	if (!ddata->chip_info->has_temp)
+		indio_dev->num_channels--;
 
 	ret = ddata->result_and_measure(ddata, LTC2497_CONFIG_DEFAULT, NULL);
 	if (ret < 0)
diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index 15458d4e21a1..ea9dff3c0d73 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -18,6 +18,7 @@
 #include "ltc2497.h"
 
 enum ltc2497_chip_type {
+	TYPE_LTC2493,
 	TYPE_LTC2497,
 	TYPE_LTC2499,
 };
@@ -170,6 +171,11 @@ static void ltc2497_remove(struct i2c_client *client)
 }
 
 static const struct ltc2497_chip_info ltc2497_info[] = {
+	[TYPE_LTC2493] = {
+		.resolution = 24,
+		.name = "ltc2493",
+		.four_channel = true,
+	},
 	[TYPE_LTC2497] = {
 		.resolution = 16,
 		.name = NULL,
@@ -183,6 +189,7 @@ static const struct ltc2497_chip_info ltc2497_info[] = {
 };
 
 static const struct i2c_device_id ltc2497_id[] = {
+	{ .name = "ltc2493", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2493] },
 	{ .name = "ltc2497", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2497] },
 	{ .name = "ltc2499", .driver_data = (kernel_ulong_t)&ltc2497_info[TYPE_LTC2499] },
 	{ }
@@ -190,6 +197,7 @@ static const struct i2c_device_id ltc2497_id[] = {
 MODULE_DEVICE_TABLE(i2c, ltc2497_id);
 
 static const struct of_device_id ltc2497_of_match[] = {
+	{ .compatible = "lltc,ltc2493", .data = &ltc2497_info[TYPE_LTC2493] },
 	{ .compatible = "lltc,ltc2497", .data = &ltc2497_info[TYPE_LTC2497] },
 	{ .compatible = "lltc,ltc2499", .data = &ltc2497_info[TYPE_LTC2499] },
 	{ }
diff --git a/drivers/iio/adc/ltc2497.h b/drivers/iio/adc/ltc2497.h
index cee9a2f50b82..219f7d49854b 100644
--- a/drivers/iio/adc/ltc2497.h
+++ b/drivers/iio/adc/ltc2497.h
@@ -31,6 +31,7 @@ struct ltc2497_chip_info {
 	u32 resolution;
 	bool has_temp;
 	bool has_speed_mode;	/* SPD bit in the 2nd config byte (LTC2499/LTC2493) */
+	bool four_channel;	/* 4 inputs (LTC2493) instead of 16 */
 };
 
 struct ltc2497core_driverdata {

-- 
2.43.0


