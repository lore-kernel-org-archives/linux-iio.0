Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEA501F49;
	Thu, 15 Oct 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792056786; cv=none; b=THgosnX5hd/or6PiU0V24VuDzuJMVGVItCd+qFS4tXDnBi4UiNSfcgkVTzj5x+AQuIRumeeO9V7UIaP0+B/qB+bBWj6oZ2SQse4R4RViZoEDeclMZ2etZ+JzTlHW4thomS4Tf0mzRAbnd4dyaNPSae1UupBgt2anlrkrkzTdVSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792056786; c=relaxed/simple;
	bh=2gacG+rK/aleJZFCkM3hjdRus5wbEyNGCh5R5GHg1sk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CbuQ/AggJFM7BwmxDEEapaPrKxTyFKC5cA2kGPEheBN1oh10WDtuZNnsJIBoaS1wzeUDP39ztB/P3OMgB4TZ0EVY3yv5gmz3Z8TE7NrlbNlOmyuI7REPvq1n57+PCzgG2tEdpC9Uii2L2VjWLnlH5KvaAFlR3myFj6C2IzzCEnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rm22vkPk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rm22vkPk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9FEC4C4AF18;
	Thu, 15 Oct 2026 09:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792056785;
	bh=2gacG+rK/aleJZFCkM3hjdRus5wbEyNGCh5R5GHg1sk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rm22vkPk+a8vzW2SrTU/xt6C7K8QDaQdLTiu3ZB/M5LSKuv/E6/hRaSFBqmVyD1u7
	 Raccfuu2xrAo4CUrf/1aUDBKDwK7D57q89Ejj6PlHgFpISzjebEbPC6gTKtVwiBXnf
	 g2MgAZ5w7wIKm/GL0OVqEFKHwwJzLlFc/xS3mKHuznkn9Z9hm6qoyDp+S9PvxX4JPJ
	 W9w0SmU279R92Cq4cQOeXhNI60tQxkfdLl8GdxvKb+8gGHypKZOY8wHpW6BYSyzIu7
	 BSYr2JCj737BPDbrELlc0LQ8KuyNb61NpTraXBnKNc/tsPr+Dy2d6fQmXX3buhXOQb
	 ybiVn2PCL6fQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB46CC6B3D;
	Thu, 15 Oct 2026 09:33:05 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 15 Oct 2026 12:33:03 +0300
Subject: [PATCH v3 6/6] iio: imu: adis16607: Add calibration bias support
 for gyro/accel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-adis16607-v3-6-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
In-Reply-To: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>, 
 Radu Sabau <radu.sabau@analog.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792056783; l=3217;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=3lTyIODwK9PMg0XzafoCrDJgnkgJfCh8WNj2MHCE+ng=;
 b=FSqGpLthkWktuGn5ZnGF5TcCwb5f5ZPW5iWSAVgLiQJZUHQ2I3yeKH66Lexl1Yo129Dbef8bj
 YiD13wEqhrrAfhEP4CazDW+qEv1EG8zMOr+2F3s2qfnFubxbHDOHoi6
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
 drivers/iio/imu/adis16607.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index c16a33ee773f..3aeca5dfa882 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -53,6 +53,12 @@
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
@@ -151,6 +157,15 @@ enum {
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
@@ -962,6 +977,7 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2, long info)
 {
 	struct adis16607 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
 	int ret;
 	u32 tmp;
 
@@ -999,6 +1015,16 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
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
@@ -1017,6 +1043,7 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 			       int val, int val2, long info)
 {
 	struct adis16607 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
 	u32 tmp;
 
 	switch (info) {
@@ -1024,6 +1051,11 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 		tmp = val * 1000 + val2 / 1000;
 		return adis16607_set_freq(st, tmp);
 
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val < S16_MIN || val > S16_MAX)
+			return -EINVAL;
+		return adis_write_reg_16(&st->adis, adis16607_calib_bias[idx], val);
+
 	default:
 		return -EINVAL;
 	}
@@ -1033,7 +1065,8 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
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


