Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793611547;
	b=NpSERnQ4Jo+SZ9WZY+tP3k4Jz6Z5YL9G6wLqGNZ3/7L5wHN66scq/wkDXWxOoP5N6b8N
	 +RDMO4T9o9rWpCzbhJ48bEfqV9A4ALpzpf+MdSSqfkRf8izJoVrK9ltMoYq7XCWGv7VnS
	 /vnVj8AhuhydHJIH5r6BwZtouZw+N5/sdfXcfaqiql4id9gM/LhLg3ayIvWAfHl2fkuVJ
	 JlTwzT9hS/X6s0l+zIwku+bPRLxq6OUmSfElmWybalbF6FAX7Wx/S2pntlSvNpmlVpp0u
	 9pa7Is5C5q5ytimYN5TwpBTJhE+FAMZxTqTGKgHgHpBAkQljirPknZbPNlkRAuRAyFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611547;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lG5dENJ3CxPUXycCg0G9BKxbX2oi0f5u5p3XFbvHy94=;
	b=HDo5i0C+WaXdBDxFz0iIUG/CxSfN5LjN/2sIxqavHLlxAVj1075+DyW8BiM2v49/uyI/
	 37NLiuF1lsB+tmGLZ+qmf9aStO+INIBpBXkTT2BjeGKcVVXw40Cp04x4fzQA46aRZD+z0
	 yNjNY/n/5lntJ/YKsM7NXoo/NBswPyqseO0ukPnIkfzzGmGHkzzJ/Xo2yPYOL03XPV08I
	 MmI8XQvFzVUGOm4z7S+JF/zX3HYOGDs8htOGbPGcTEXmyxVi1GWcS+0XeUhrQ/gjs/exj
	 0MfnmzBGibEbU0XJvnRjrWL0guZ7san2Lb9iSd4A7FKXHKHFViKnQwXngmvrSt0+oBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/ys455q";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E2D606A33B;
	Mon,  2 Nov 2026 09:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/ys455q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793611546;
	b=II/yrsVkXBhvbkBfmk6QCqgG7cskCtxO3QJZd/dMxDJi7hQo0kAUkopvzQKeJ+1BUzPf
	 lNmk/cysZlgNjX1LkENucKR3lScICM0WO/1VfDwJ+OBXf74dMlbUeIfdLkssueXfnLP0Y
	 FYmoFj/JB3E+RVEOgyi87G/EqZeuqtan8LBxQ3HRxmXfa+Nnw9jqPPNo21LeCI3h/EsWA
	 6ktcFHzqmXjFBqhp1WpKkV/BYHU9R3s7gkD1qxpCrMBEQA7BRM/MpA9IXCTd7bislikJr
	 +7JltAQ7Y2x+9VsKgYAqgeHcl90Yi4+8PnL3BgOW3pVFSB9Z8SMAiznlcMWpCY0T1Mg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793611546;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lG5dENJ3CxPUXycCg0G9BKxbX2oi0f5u5p3XFbvHy94=;
	b=wO1l8E5+5tqvzxr+u/apxci21yMGkv7BQGlJ/WS5VK9SXmAtf/AiV6xsx0tpyyyjpD/b
	 gPQMeCFEG5X41O/oy5x6EIQ/G9Rp0tBDwKAAwEF/STaY+sFVhKyusjokkRGsquDRZWM/i
	 hV2AfusceFodSCY3JysOCM3txTcRfdWADbmQ46caONUIF4U0aBzAoTk3Ue8DNsSX4YuKV
	 648UIUGzfdZjNHXkPN82ryfkGpoV5w9re9DkA433+4bRH1r8fDSWsLb5Ye8Y9rKYaIDsc
	 WqYe+oBhStpKqulbZ23KzJ9/sraMBNkPuaCqs7pxshj143nvTHXSEiGCgb4mprGnDxA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CC05A1F00A25;
	Mon,  2 Nov 2026 09:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793611546;
	bh=lG5dENJ3CxPUXycCg0G9BKxbX2oi0f5u5p3XFbvHy94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=R/ys455qpZzm6pU1Cz0C1Nvf4ZtTbRdJnISpn7HUgq6c0/H/cQhxSosGWAemN78OH
	 giufNJOwMSYqbW68eDToaDnFf0e0FmMgkXSpsJzB+b+UhYL5lQi+6Fvr7MqQbNaa6V
	 lvlj/lAADdVSjfbR7eHa+o4g9SQ2LKvCQStkWNqc2ozBv8rprCiHrjZwHR0LiChpNm
	 /kaZMwpI29S/vY9ds5tmoUzSqlD+N+duGMBxsuOd0HBwq4X+FjszTjLxEDYkleikNb
	 TqlzMA3pj+GRyyPtRU97duZ7Qtu2NPNXl17F6ZxIuKA3nBKJJv4OX7P6urXAH9hfop
	 t4aj4oQIZNu3w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 14DD046459;
	Mon,  2 Nov 2026 09:25:41 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 02 Nov 2026 11:25:44 +0200
Subject: [PATCH v5 8/8] iio: imu: adis16607: Add calibration bias support
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
Message-Id: <20261102-adis16607-v5-8-4f98b0d271ac@analog.com>
References: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
In-Reply-To: <20261102-adis16607-v5-0-4f98b0d271ac@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793611539; l=3771;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=XSKYww/o1vH0pbkIDQNdQXg29aw/PkeH3UrhLPjkzlQ=;
 b=AQqlRshKUVcwEgILUz+Pmk2VkN9dl1ZhYGnb/t46KdI8SRdj+ZpPcXYRIKyArxjfa79E5ycTT
 u57HfkB9Bg/CNH9r/EQlzxUe0DR4J94G61oo0keLkZh+8Xx6RsRnpN3
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
 drivers/iio/imu/adis16607.c | 39 ++++++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index 58504d351de1..ab80e0909bf6 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -57,6 +57,12 @@
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
@@ -168,15 +174,16 @@ enum {
 
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
@@ -1030,6 +1037,16 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
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
@@ -1067,6 +1084,13 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 		      val2 / (MICROHZ_PER_HZ / MILLIHZ_PER_HZ);
 		return adis16607_set_freq(st, tmp);
 	}
+	case IIO_CHAN_INFO_CALIBBIAS: {
+		u16 reg = adis16607_chan_regs[chan->address].calib_bias_reg;
+
+		if (val < S16_MIN || val > S16_MAX)
+			return -EINVAL;
+		return adis_write_reg_16(&st->adis, reg, val);
+	}
 	default:
 		return -EINVAL;
 	}
@@ -1081,7 +1105,8 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
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


