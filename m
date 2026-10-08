Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4794718C8;
	Thu,  8 Oct 2026 08:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448345; cv=none; b=li37UZTa2gOSsunvWznVKxgUJCNLdxanHsQYMpOM2W0/MaIzCZLh18acVL4angJN08GJT9HpENRr4QvJKcZpwTg3g+bhemIf/VqgJIZMfcPhirgx+ct/qL1USMs9jQ/gRc3V1e7A/0UceisUvMQaDadTL6VVgoautFuVytt5wg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448345; c=relaxed/simple;
	bh=OWGneP4WrVeKCz0imjaKvqwPhESELZ+lcPJvoER204Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LCU5DrPrgv+xT8B5XXOAxVbdWLFBrkdQIiADl1HzRebEvQ62IQhGZ5jZUEir0wdidbuGs8UPyrxMfnZi8J+HNXqFse0gPPJy0rENKjWHxQshEt91Ml23htGzNLJo7KUEhPgVm8SuMF2Fz9PDR3qpbA76Mecq0pFYO8HRtMSdwbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXlMD2Jy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXlMD2Jy"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3AA43C2BD05;
	Thu,  8 Oct 2026 08:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791448345;
	bh=OWGneP4WrVeKCz0imjaKvqwPhESELZ+lcPJvoER204Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HXlMD2JyjX085EiA7BL80hAfxUwf9aumxX3BxT4qBQAFg22rTSvlLkrmPZvRVnVkb
	 B0bvrC5OpQDWBCN3KBegRmkf8NPPeWTEEfSmVgggNU6jim/OBUYWeWAg1JTIG8aVAN
	 LlddXflj1fkSBZcQ+8ZelGcssZYkdAwCiAAdY5dn82/bbSCeBAu05S+oDg82t4bjJR
	 sMxNxeRNELqncEsgyeK8mR3MCFOE4JV+uxJK3u5Mheqx+7Qm4wIlLidFdtkCQptg33
	 YV5hHxuD+QP88ERCPt3VUEbzB3TSiBknSyKNx1CS4dvMv/x+XRA4hHulrwu4FNpvra
	 lSP7KP5e9cTjg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EE3CA6007;
	Thu,  8 Oct 2026 08:32:25 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 08 Oct 2026 11:31:58 +0300
Subject: [PATCH v2 6/6] iio: imu: adis16607: Add calibration bias support
 for gyro/accel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-adis16607-v2-6-7c94df80878a@analog.com>
References: <20261008-adis16607-v2-0-7c94df80878a@analog.com>
In-Reply-To: <20261008-adis16607-v2-0-7c94df80878a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791448343; l=3152;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=4ib0sH9y/1k11gp8lRJBrH6VBfdmoC+xbIdqPkw76ys=;
 b=aFeE2Cfy8XERr/0HgNbzzYigQYT9mNhzYJiBJiSC07B3dXd1b8pgmB8AZk8FJRxBk2kix0mmK
 nIOT7dr5rU8Ae5QImcsQb9EWPmAiy+pz+DnTmMOsErmFaSLicN3ZpCN
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com

From: Radu Sabau <radu.sabau@analog.com>

Add IIO_CHAN_INFO_CALIBBIAS support for the gyroscope and
accelerometer axes, backed by the device's per-axis bias registers
(XA/YA/ZA_BIAS, XG/YG/ZG_BIAS).

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index 0147eba0b173..d4b3a8a9fd08 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -54,6 +54,12 @@
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
@@ -152,6 +158,15 @@ enum {
 	ADIS16607_SCAN_TEMP,
 };
 
+static const u32 adis16607_calib_bias[] = {
+	[ADIS16607_SCAN_ACCEL_X] = ADIS16607_REG_XA_BIAS,
+	[ADIS16607_SCAN_ACCEL_Y] = ADIS16607_REG_YA_BIAS,
+	[ADIS16607_SCAN_ACCEL_Z] = ADIS16607_REG_ZA_BIAS,
+	[ADIS16607_SCAN_GYRO_X] = ADIS16607_REG_XG_BIAS,
+	[ADIS16607_SCAN_GYRO_Y] = ADIS16607_REG_YG_BIAS,
+	[ADIS16607_SCAN_GYRO_Z] = ADIS16607_REG_ZG_BIAS,
+};
+
 /*
  * SPI Half-Duplex read operation for ADIS16607.
  * Protocol:
@@ -945,6 +960,7 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2, long info)
 {
 	struct adis16607 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
 	int ret;
 	u32 tmp;
 
@@ -982,6 +998,16 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
 		*val = 5000;
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_CALIBBIAS: {
+		u16 tmp16;
+
+		ret = adis_read_reg_16(&st->adis, adis16607_calib_bias[idx], &tmp16);
+		if (ret)
+			return ret;
+		*val = sign_extend32(tmp16, 15);
+		return IIO_VAL_INT;
+	}
+
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = adis16607_get_freq(st, &tmp);
 		if (ret)
@@ -1000,6 +1026,7 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 			       int val, int val2, long info)
 {
 	struct adis16607 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
 	u32 tmp;
 
 	switch (info) {
@@ -1007,6 +1034,9 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 		tmp = val * 1000 + val2 / 1000;
 		return adis16607_set_freq(st, tmp);
 
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return adis_write_reg_16(&st->adis, adis16607_calib_bias[idx], val);
+
 	default:
 		return -EINVAL;
 	}
@@ -1016,7 +1046,8 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 	.type = (_type), \
 	.modified = 1, \
 	.channel2 = (_mod), \
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			      BIT(IIO_CHAN_INFO_CALIBBIAS), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
 	.address = (_address), \

-- 
2.43.0


