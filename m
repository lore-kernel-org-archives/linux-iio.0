Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794573216;
	b=IZSaF9aQTZOISvU1fsdpjsd2LpnuZXBbCwOz4KZjVGuq5x+kN7c1WCwOpLHkY4GGcapi
	 mJXvjFxmhExLSoBciXooYz4ESHZkhN8DmCOep1iXotV+YdWWHOnZSGD47pq5/Ra+6kMtX
	 TazqwWq+d1horYi1I4zvhf5nfWHWuF4Wc7q8LlV6lR+8JkScR21eAK+ckmCqq/2DzfPH/
	 KkHAufkMpl8mnD6QiucnSAn2EhbUeDxu6+WoaQER9GLcmv0QIyN50LgyGQB0+w+a6SKK3
	 iFYdNn1rN9nSTXa9w3rRbHtgJJRNdn1WTUNCEMjun8oFe/qp8aK5rVgFVT9C+aay80Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573216;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4L1sfhZulH0yXIFV7NmwnNMQtH3go5bkuFrJHd0aFEM=;
	b=uN/w+cb13KhsouaG/7RkvKXikveyZB/CiVa/hPP0sez1bWDhtZY5RIeKO4xOe3qIhWOV
	 DvZBys/rCTcLRhG3hc5AxgUpT4bFaiam8apRp4ZLRkSS+7JLaGtOLEiCFefvSmRxKMOHY
	 VRz9gYvqgNNHUOqqXjpoXJLcHu2yfM0by9ZEf7XcT9XL1wR8gKvZMCfbiRZi8gxDz9PKf
	 /9iNycJMRNNcaOKc4OvMgGPDPlrLNiC9yALcZAlgMuQlELjNoueyOQgxc15o739BEwLOf
	 AMT4QGhQjc+w0ZxQBdeoqihWC1yuBFHm/pB1b8+0O/YMeRL75XtZ7zc3UxF4hUl6xSQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsPKqlu4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3E9606A8A8;
	Fri, 13 Nov 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LsPKqlu4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794573216;
	b=Dj5E2mYXCghsPVeZ9aDQAHEbbtn2ruNrHQ26ctyGtBspFgdFkOOi7Xsp+yLiXT6wRgwX
	 O4wzxrrj1oqS+OnYMNUSpJwZfKjzwW6Pl6CS8q6EQPgu4nYQvEjxIiLn/DnwOU5SLOzln
	 1E7ltCVI1Pk/O+HOz0zmApWRggmhcDbX7/l4xl8ltVbF2TwK0o4WDUQ12YURQL4feCTt1
	 A0poKsHlNWA36AyFJpdY4MHJ42v5k3idaIuv5mZDOcvNtxShrrJVt2/SMEid6HDVwyFBW
	 taO0DPoIFAlLWmBZpHFgJj7kQCV3y3R1+Ohtyp3kIKR7TLwRjNVrodD6uFZhpVFqNuA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794573216;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4L1sfhZulH0yXIFV7NmwnNMQtH3go5bkuFrJHd0aFEM=;
	b=NlQB+8amRcRw/9LjWMImBEsfB8o+lZt4WByDc9dCTrT9k8Y2y8z6KECvy/Jn/YlAHms7
	 xZ/oWuYxA5bkT845jJaKFI6vYjen/0Qo0D5ANG/K+J9zZsfcfrNfTgZ359Fh57UPOfDka
	 k+vFVESAWAnYw11zy5uS32t/OpPuX0wl4YZC53IEqcmWp6whD6tLYf8gEtiQfsINxaGUl
	 O2fvQJYPEZrXCyP4RudUhETeJQr7Gm9HFfOB0jUS9c+u48/bnj76QocWArrjEPUlVoXXt
	 jJuktwwOVVdT/s4DEFLKfIlLacHzJcohIw9gFr5oQLRSG9WXCk4/D00KUkVQDmBumYQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 899891F00925;
	Fri, 13 Nov 2026 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794573216;
	bh=4L1sfhZulH0yXIFV7NmwnNMQtH3go5bkuFrJHd0aFEM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LsPKqlu4KjzVCsJ7QdnjMDdru0hHGIBJs/2HZI2HCKrQglDsaUQvDsG55H5/NapuE
	 XdnyQMu2dX7UnKmf+mpdzo1mxBXfrveAKt62o9ql0Ab7zX6YHbzYYDCpgtZ1klOXVS
	 Wffj0NYe9He4CzaLF2d2/sADkZVnZ0lEalbO0nIgciM8Hl7/wClkAm9RYs19iEvowf
	 Cv6UC/RARUw/4N5lN2MvJMUixsOYCxTh3SSD4K01i6VPHPVa3hsftSAyHXqx6QHWjs
	 +uY70XIC5IL5WhvVMbXmnwN8cxQbX3aZoIesWD8iBEG8CLHbuRyu1GXu6QtJw+/dpR
	 7wFJkAiXkMXiQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0D18D477B0;
	Fri, 13 Nov 2026 12:33:34 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 13 Nov 2026 14:33:38 +0200
Subject: [PATCH v6 8/8] iio: imu: adis16607: Add calibration bias support
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
Message-Id: <20261113-adis16607-v6-8-3f678719942a@analog.com>
References: <20261113-adis16607-v6-0-3f678719942a@analog.com>
In-Reply-To: <20261113-adis16607-v6-0-3f678719942a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux@analog.com, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794573212; l=3726;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=VnNIhnMUl2LvvkzsAw4PqZBgigIcUBDk4HP4t1NObL4=;
 b=LQjI363kyoQL/kJnjvxraTjBXjQYGku4ZXXvaMwlJrNhzabo+kpKO20Rcr+GG8tzM6Gz5L3dy
 UE1fQznpC4TDaTEOT0S0DGyCp1vl+UV5dFWiLs25arkUcHl2vuh517B
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
index cd5f875d4c56..84fd5b9ad8a5 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -56,6 +56,12 @@
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
@@ -167,15 +173,16 @@ enum {
 
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
@@ -1043,6 +1050,16 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
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
@@ -1081,6 +1098,14 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 		return adis16607_set_freq(st, tmp);
 	}
 
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
@@ -1095,7 +1120,8 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
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


