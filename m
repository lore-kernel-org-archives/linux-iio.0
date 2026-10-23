Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792747841;
	b=iYdHqBxAgUy0PCXE6/5xA8nJBnZmkk3d/p5QOklQEYoMqY3o0uvvUc3M/EQRCK0CZC5Q
	 +9dB3HwgjTwqrlU+OjM7MysowF6fHC3IvYYXZdaPZdWValzFODyW4ZwubVxO/0uCv+Qh0
	 tIfI3YSmG44p9QMWQ0SKlvIFQ59DRCZTRHewqo9tMJQTrJgrtePPNM7AJ2S0uf6tjgb+i
	 oCMvic2Rs5oEgX83GfnbhAouNxOORbrXzY2GcaND79VJ4/0c5j0ABTboM2bJ/FGHMQYOj
	 6QOAnn/Js2r9/z4bjcVJqrJOvzVG9VcrKcdxmGh7dxk56vrk9jS0TOjvYlslUDb4KaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747841;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R4AamfmiWjxAnYkbduF3NDoMYISaJ01c2pwRFA69PcU=;
	b=S3HFARWkPyigg8aLxnhPCMdYmLx3ytoir4/Ov3YKz2c/2pTiHZxgBJeGtC4FJu0+2xYT
	 A9pS0nD5Bz9rhaa6hQbJS0kv5Uy0pFKvgdUo8+jlsDiiFwAFNpyF+CuUlvU6SwQygpIf5
	 2W+ulk0Rwb97ZJ6kbM7InzgYMZYY7bfoduB/P2I2lEommZhOWWf0419yi1v4jx/zPp9sT
	 okhKJ62srIvp5XEgOEDt3FBP0rZQqzGiUF+CkSQt2m7Hmec0dSDaVnj9gaLmTGL6xgpkN
	 SvVGMrfVphnSqewzTBkXpca0PcU3CJG7H4k7y7FANftCw+GMNUlb2qppUt5/ZDQQzWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StYVIVMk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D560A2629;
	Fri, 23 Oct 2026 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=StYVIVMk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792747825;
	b=x+bzgXmYBepf7HCew4vxs01sQByLygCnpCZnBfPd7ukQNb2cpNfAeVhaHy7pX+BLWXZm
	 /tSFqtbzy5CEtHv+tiZ2jcdha8+2XFfLZruEOxv1khMZJuijaTeJi53k4U2K57Bnrqvsk
	 ghq+HWz1YXI8c/st/fJ8dtyx7Ge+gqt0hd7JEudneFG5+BdayVVsTxFUwETy9AMRG7TW3
	 AHT5D9/R/SL/zaK2mH3rTWuBDEyojjPRD9+yE75rIdiPrUzZH7LygTjCMeU5hFrxIIVkq
	 ZiXXaPce8xd15uu57mjLoN7e/0QRHRri0fyBbeJvxRzmCKG762F4i+LP1epdLhz+L1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792747825;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=R4AamfmiWjxAnYkbduF3NDoMYISaJ01c2pwRFA69PcU=;
	b=t+ghTIBPZnPUQqDhQpSGsU3mUavzHBD+N877JI5cYpblLCPL6nmGDqlTpwW3pY2oq6Z/
	 tdcWJIbaguINtMc4qoojtPHYWjkM035piijCZ9tMhs88iLGCOPwvAwpYmOhljU06670fO
	 Wm6kZ7IHTQE+5Wz3VLgBFGfkS1PhmEgF61BegUQwisgNzjI+W00mWYXrcb856kFOeNYIJ
	 5y7cNpNJC0vhe3Zu6PydhEbSevP+V4RtZGixvDC8aLTNqAZy9wpYBDogC/24jKM7P59p1
	 W5LuTHVVI+5MMc5i4ROzS9sJkikBjroxKiRhOK9+J8RqANGG1go5jlnKLh1xMB5kabg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 85C321F031E8;
	Fri, 23 Oct 2026 09:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792747825;
	bh=R4AamfmiWjxAnYkbduF3NDoMYISaJ01c2pwRFA69PcU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=StYVIVMkMKEQosynZo45nevw0TfLBykIe603+k+y0UI6rmmq1DCiNWqBZpDls3vnQ
	 842Y6MnJ6KpbOvK6VOsr24RQ29RbJ1WoH2srby4TA84a3OMBlaQWwxjPchmUuVYy0P
	 LHT8UuXb+Nwmo9dkqbqrp649QBZyqhalgIz+oa7Ndr8ZIPy8sFgxEAQKMDC62R1c87
	 y27FGPVWSjU88J3uSVivc+S3wMruDMco2b/mBeKSlBR3oxERtmUW9jwAahW7iaF+5f
	 3obdY65iuzRL/oGmhTa2eYzY8VDL97HKB/Hi221puosN06Ggx9niEH8fkEjMfIBu3s
	 9IpGpXFIjAdHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 85D7444474;
	Fri, 23 Oct 2026 09:30:21 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 23 Oct 2026 12:30:25 +0300
Subject: [PATCH v4 8/8] iio: imu: adis16607: Add calibration bias support
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
Message-Id: <20261023-adis16607-v4-8-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
In-Reply-To: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792747820; l=3210;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=2O9Md9H/5f7xIz5zm5QLl/OmXDIIRisepJv+lS3NV6M=;
 b=VKqFNgw5lTiUNcpM2vXGhumkljtk+VCaPs9sBUh0ipEVin+u1qW2b+4aEGWMkmDi+ZEsL7Up8
 EEfKW21pLZ9DKRQjPbntCWk3ANo61BYENuNlO8NVb7oppXZciqxSo9d
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

Add IIO_CHAN_INFO_CALIBBIAS support for the gyroscope and
accelerometer axes, backed by the device's per-axis bias registers
(XA/YA/ZA_BIAS, XG/YG/ZG_BIAS).

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16607.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
index 3c5b59820be1..f73df022e819 100644
--- a/drivers/iio/imu/adis16607.c
+++ b/drivers/iio/imu/adis16607.c
@@ -55,6 +55,12 @@
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
@@ -153,6 +159,15 @@ enum {
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
@@ -863,6 +878,7 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
 			      int *val, int *val2, long info)
 {
 	struct adis16607 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
 	int ret;
 	u32 tmp;
 
@@ -900,6 +916,16 @@ static int adis16607_read_raw(struct iio_dev *indio_dev,
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
@@ -918,6 +944,7 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
 			       int val, int val2, long info)
 {
 	struct adis16607 *st = iio_priv(indio_dev);
+	const int idx = chan->scan_index;
 	u32 tmp;
 
 	switch (info) {
@@ -925,6 +952,11 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
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
@@ -934,7 +966,8 @@ static int adis16607_write_raw(struct iio_dev *indio_dev,
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


