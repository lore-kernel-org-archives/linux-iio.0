Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795007868;
	b=AelNukrP3/CzeJdcGqdYS5Bi42yNO8irpgizsi3QWbr8xmSxG/cSfmq3L1u9Fs5N48C+
	 zPH8Cr2c2LfOPYSibKVSGZL3kZx6kA4oxSBPMLB5vJFRSzrtJThdABVQjxAr7HHsNGWY+
	 zYsNvVoT/FITlUQZ3bNnr9HJBhrE0nIz1NfHMqNN60N1VUPK3Joik4tCMi6C1bzFvPmvF
	 LFxm28dYUyguvMvqNLOok354vM0NlWkzGj52JHfBi2tt2BXKJsFRtmVTsRH0TQa84fbkF
	 AdEDHiSSTzyMyyU4qhbE9XAeOPk7WqHMLF6MRL77etlBxvRxm+bbkRF70/xa8IcRSyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795007868;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FvbUom5BnQHkvLOwagwqQIXVwH3ZB87uwDsaz97UID4=;
	b=kpJ/9DeiNl7JYNwoGWhLUqR6i3dXsvcXJjc9Dt2R/scN81CgWtTw13X1oxFEJVb2jRnm
	 xgtmHFqAqY7VT9Vw4zwnWIdfqjZskiThvTPmo1FGwiz0i6rTtoB3xmbZhv3dJUe9hBSb/
	 3q9exBaQnyxg3+UCqHFH5rh4fbbpsJ6aPbIj4THYf+kmCielaq13DltlIaY37C5onukH/
	 t3ViV9p2bD5X0Qu9EMWOBRZcuyVLFlOuCQEooh5IW3DlwvuMjKjRKz/gm9x75794NcBlj
	 PS1iwLQ70WZXVlIBC0yD2HFc4wodoU3D2bLIF7VLvSdxF2LJJi15tlc81jg801+Njfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jN75OYMM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39A5606A33E;
	Wed, 18 Nov 2026 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jN75OYMM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795007868;
	b=HmUmOEDw8xYupONwH5flp3DICvVBK1B5giXf9jjB8Jv+Rv9UNVAa4WBAt4ixIqhPvndX
	 zAa6/9KCw2I6foUjUn+crIUQqPBqLgyJlIJBVOlWQlT6h5c3OnXcpHxul7Kr4mw2dGq2n
	 QR+ZxJ8/q16ahBGbhDYVbozLvmcgGqKjjXWzcLeqng+B+AdMVAVgXzjK3pfyY3Vj0q5NY
	 3bFn7IdWzKFEvWQdve9H4iLQ6H7wPjsd14q9UhKGRAv+fAOq7L5Zk8xXcAruv23H9wvVG
	 1kb6ckhkWSmyFuqvyVNIs7gX8hUGC/JrL4xINZ24ARKgKlnCXvDLJe7y0iAcAlg00wQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795007868;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=FvbUom5BnQHkvLOwagwqQIXVwH3ZB87uwDsaz97UID4=;
	b=gUeQXuthRnMCdHsSXKevUU4rRuVmZb++nAHMvlKfT5nTMQXX//gS0ez4KeAXSZc23M+z
	 c9onqCLDA7kZSL0DiURUB/XCgFaVlIlN/rP+zYZd6D5l8SjZpoWViFD6+Y2qc9fEJgYwq
	 hkJcdUol5CpErIHX2P3iqnogRvyVrfik9xpjkljv6ebxbpSeebffa8w6z+Vnk+M1hrb1c
	 P8Rv/0TLyQN/tQoo18tMa+xL5ncGpdQTlQlZKBleCJvcLEMw3eZzl/ezWQNJzzdfhWspz
	 Yt1PPBPpR9TSWxng6o9BTwB4FEN1koAcuJ0ra8j5858TysLfS504JgPschdQQPigBgg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BD5931F00929;
	Wed, 18 Nov 2026 13:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795007868;
	bh=FvbUom5BnQHkvLOwagwqQIXVwH3ZB87uwDsaz97UID4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=jN75OYMMeKggSKxn6MEuiwmD85DgFvubwuYna+5UlsKIEBCrTQJj+g5Mcdrc7Q6FW
	 6rhiQ1q8ouNnS8pA1sKr4DJKfGuwVstaYT+RRosi7SnfXi6kNsVayeWz+CdpeXknFV
	 hk/03VY04XyosTye6rTD9JUUp9ijYltw6UqrwukSCOyFXPhKkNVCTPj8qS0M3Ynnd+
	 tEmflruav/DZ/kycWRAH/fQxfhVhrOE1xQGdHs63OXNb0Guwd6r1Z+U2BZWwABKx6Q
	 Ba93gSt/gUFcutRPElFyz0B4YgxGFYs64pybZBZFzpDHSPxVLKwYU90n0lfFF1oQ0G
	 tg6g+TvbJYpxQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D78944ADB0;
	Wed, 18 Nov 2026 13:17:45 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Wed, 18 Nov 2026 15:17:49 +0200
Subject: [PATCH v7 7/7] iio: imu: adis16607: Add calibration bias support
 for gyro/accel
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
Message-Id: <20261118-adis16607-v7-7-707609737691@analog.com>
References: <20261118-adis16607-v7-0-707609737691@analog.com>
In-Reply-To: <20261118-adis16607-v7-0-707609737691@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795007863; l=3767;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=3VzfRtvC0ERGRGObzZxXu+fBJ1PeqdpLPu8YVQorLqs=;
 b=eML4+7DD8J0CndG1i0iADoUej0vBFnx360tuYlS79yM1QS0en2Wr104tRvbnFINkKrDmpPCOQ
 OjrCPH7cC3nBWlthkwQIPYc1SYSjyrb9kc6Z5wCS7gABp5j8yeJE9im
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 8bit

From: Radu Sabau <radu.sabau@analog.com>

Add IIO_CHAN_INFO_CALIBBIAS support for the gyroscope and
accelerometer axes, backed by the device's per-axis bias registers
(XA/YA/ZA_BIAS, XG/YG/ZG_BIAS).

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 40 +++++++++++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index f8f0edcb5d6b..749ed7445f73 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -49,6 +49,12 @@
 #define ADIS16607_REG_SOFT_RESET	0x36
 #define ADIS16607_REG_SELF_TEST		0x39
 #define ADIS16607_REG_DEC_RATE		0x3A
+#define ADIS16607_REG_XA_BIAS		0x3B
+#define ADIS16607_REG_YA_BIAS		0x3C
+#define ADIS16607_REG_ZA_BIAS		0x3D
+#define ADIS16607_REG_XG_BIAS		0x3E
+#define ADIS16607_REG_YG_BIAS		0x3F
+#define ADIS16607_REG_ZG_BIAS		0x40
 #define ADIS16607_REG_DIGITAL_STATUS	0x4E
 
 /* SPI Half-Duplex lock value */
@@ -129,15 +135,16 @@ enum {
 
 struct adis16607_chan_regs {
 	u16 raw_reg;
+	u16 calib_bias_reg;	/* 0 if the channel has no calibbias support */
 };
 
 static const struct adis16607_chan_regs adis16607_chan_regs[] = {
-	[ADIS16607_SCAN_ACCEL_X]   = { ADIS16607_REG_X_ACCEL },
-	[ADIS16607_SCAN_ACCEL_Y]   = { ADIS16607_REG_Y_ACCEL },
-	[ADIS16607_SCAN_ACCEL_Z]   = { ADIS16607_REG_Z_ACCEL },
-	[ADIS16607_SCAN_GYRO_X]    = { ADIS16607_REG_X_GYRO },
-	[ADIS16607_SCAN_GYRO_Y]    = { ADIS16607_REG_Y_GYRO },
-	[ADIS16607_SCAN_GYRO_Z]    = { ADIS16607_REG_Z_GYRO },
+	[ADIS16607_SCAN_ACCEL_X]   = { ADIS16607_REG_X_ACCEL, ADIS16607_REG_XA_BIAS },
+	[ADIS16607_SCAN_ACCEL_Y]   = { ADIS16607_REG_Y_ACCEL, ADIS16607_REG_YA_BIAS },
+	[ADIS16607_SCAN_ACCEL_Z]   = { ADIS16607_REG_Z_ACCEL, ADIS16607_REG_ZA_BIAS },
+	[ADIS16607_SCAN_GYRO_X]    = { ADIS16607_REG_X_GYRO, ADIS16607_REG_XG_BIAS },
+	[ADIS16607_SCAN_GYRO_Y]    = { ADIS16607_REG_Y_GYRO, ADIS16607_REG_YG_BIAS },
+	[ADIS16607_SCAN_GYRO_Z]    = { ADIS16607_REG_Z_GYRO, ADIS16607_REG_ZG_BIAS },
 	[ADIS16607_SCAN_DELTVEL_X] = { ADIS16607_REG_X_DELTVEL },
 	[ADIS16607_SCAN_DELTVEL_Y] = { ADIS16607_REG_Y_DELTVEL },
 	[ADIS16607_SCAN_DELTVEL_Z] = { ADIS16607_REG_Z_DELTVEL },
@@ -653,6 +660,16 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
 		/* Temperature: 0 raw counts = 25°C; offset = 25000 mdeg / 5 mdeg per LSB = 5000 */
 		*val = 5000;
 		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBBIAS: {
+		u16 reg = adis16607_chan_regs[chan->address].calib_bias_reg;
+		u16 tmp16;
+
+		ret = adis_read_reg_16(&st->adis, reg, &tmp16);
+		if (ret)
+			return ret;
+		*val = sign_extend32(tmp16, 15);
+		return IIO_VAL_INT;
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = adis16607_get_freq(st, &tmp);
 		if (ret)
@@ -685,6 +702,14 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 		      val2 / (MICROHZ_PER_HZ / MILLIHZ_PER_HZ);
 		return adis16607_set_freq(st, tmp);
 
+	case IIO_CHAN_INFO_CALIBBIAS: {
+		u16 reg = adis16607_chan_regs[chan->address].calib_bias_reg;
+
+		if (val < S16_MIN || val > S16_MAX)
+			return -EINVAL;
+		return adis_write_reg_16(&st->adis, reg, val);
+	}
+
 	default:
 		return -EINVAL;
 	}
@@ -695,7 +720,8 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 		.type = (_type),					       \
 		.modified = 1,						       \
 		.channel2 = (_mod),					       \
-		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		       \
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		       \
+				      BIT(IIO_CHAN_INFO_CALIBBIAS),	       \
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	       \
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
 		.address = (_idx),					       \

-- 
2.43.0


