Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795465585;
	b=CJFgV5EZ3rqz0OBeYim6kP1roic0Gl8yhqT/Ae36V7eT/Lh+0kzmuauRob1s9oVBiQq+
	 CuTnPO8RqTyzkfeEievoSB3vUHqD906u8kyaFgH/xBSqpo5Qet8bnEYK8rPvPM9RJ2ltM
	 zDr9PYOd3TIx9foLhfvg42mFj12J/W04hV568PYTXSjMelYxSBEqg3qp4IouYi6xOSH6Y
	 JiktStO0Ur8v64oRP6kgiitwuhH+9uA6d6YP7Yzls1698OAkA2dvwL+ayA98wG49p9IOl
	 uCmIQ1i++ZUoNQrBYX8RAfL6SZy0dARHgXqDkY+hQmaFCFmJz0zHordwSGWgsosbuqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795465585;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NQ48N7WWkZ+c+s4V0T47yLDwNjedp7a0tZsuMHqD3Go=;
	b=EMfOeXAfITONNN0JRV7e+jRQJXms+ozBnAwKaBOxpflBiuPCGGunJECbQJoQbOYobCbx
	 VNOeVLfGYp4JaaIdiwEi4bpd46twP9Tv7rWYXRf4ebroQcOzvfU6C/ygymihsIon9fRj0
	 uOk3tV6W04Ib7FxI6bxbh5b62wF6u/xYKMYyuNiIXuJg7V939kmwZBdXpWJ3gjSvg8/AB
	 hykTJyswAI3A0IiEyqsmD8LiWUxmZxiCQt5pT4O+pl7ZV74Zx1+w7xIpvX/dhmffjP1gX
	 cFpT1iv/m3+rlIhp3ma2LXgT7XQBP+aJLuy5fbZtguA/embuawFZQsnvJZ11dJ1SOyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j9nSIYwX;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB7606A6AE
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 20:26:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45EB7606A6AE
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=j9nSIYwX
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a9be758734so2297191f8f.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 12:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795465584; x=1796070384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQ48N7WWkZ+c+s4V0T47yLDwNjedp7a0tZsuMHqD3Go=;
        b=j9nSIYwX9ihcFMpmtUR6hNHIo1cHJ+LzzBhJnKdh9hkVA5oFY8tlzk4B/vc3G2Yerv
         KSRQPxgPsRMPTHbYh5GO9VFH5+0CBFOHVSUNNNanJVhYBP96/JWeB2Y2o2gxpIgNeJic
         RR0DQOcaY2imOtd39OuMfZOivZNm79jP+pOQKUU2hI/QEtlgfn3hhPcuxiIKlGJWQuGu
         ZHXx+SpBkHrRm0xHzx9ZG0I9ima2b0hPzKu0FEigvCFTa2uGGDu9qF9J4TIvghjNw9SN
         xvAFvd3VaEAMWl53kjYY9jh4VNtdt7u3Lx0q0OGAZPqhUI2QLd06TJoeKip/5Jol1eNY
         zzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795465584; x=1796070384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQ48N7WWkZ+c+s4V0T47yLDwNjedp7a0tZsuMHqD3Go=;
        b=ORwR6wfTdAvkQpyUeWVwHRKT6wYv2iKoLbO0FWSo8HpkSWnE/pRA9ibRRILWgJqwQF
         lJr3NJApmH4aYYQMNnj+m11m66rPDaFZLTkU/s9xR0hA72GDGXkC3GT3G2E7QTFk6GXs
         iQ8B37z8qFRPz/veFG2+/OjyEqr76B5gWr0H4EIYr5lZiFwoZOyyywX5BGYYu6lR6oEV
         /EWYN31jX9iP8easmh4h530s/er+FubMCpjklSDp1ED5/WrJ1PIj7fjuA6TtJ6HTSZc5
         6iofLbJLFgfLRoIaQfL4lDbfatH0CVXsQarGS1ud6Po+3iUzeAI6eQlVeHEOUK+XJ2hY
         Dp7A==
X-Forwarded-Encrypted: i=1; AL+hErGYum48AVSPRBZ0I2gAft0dlLoxdpDjDZ49rhYRLpaj0Y2YMyMFBTgPTRnGBZs6IYmITzu73UM4daU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9B1r0k94qssfbbLwW1cOPtfLXi4HgdlB0Rx4cImTBvr+jmYOZy
	v3VoQkYERyULT9M7saBiOA8rgxeK6rAfXvFy5EI3FulW54rriG1uk3d2MGkxPbJ+rEA=
X-Gm-Gg: AZFdTZdJ1sqygDY0j5PH6NQV84cI4mhK5GxJ1NGZ+rerDbY6q8W3Bgp6xoNrxroMGWP
	M/SQewlhu7uc64/7D9D6WMlfaZmNydAw+SQUAA5XeyoAHqib/mYBRB2Wx8pwK7DIHtp8VpBmS7z
	4SstgJaVOtwqkIx0atxSFYj76Hlhu+C9z506oQgJAz7Qk6QGC/rXuq4rsXKMOHT61QUwv8MTmjm
	6vor09smE1aWWP3JyzvJxzONJP6ifsHZnMIr640fiuYOmQ5wmeBUXcZQe6spGHZgKXB+btOR1lQ
	cmaV9ER2Zt6Q/jHXC2TAoWiPDRIxMGQ5ffS6OHANkZmHv8GTrVcs31LYuQJXmJsoQLZKl3e9+Vq
	37dLFdSxrrVinWaT5a9Ajg2fiS0um1MJ1xzA/dUxHQfk0OZ+BH2gYpqfNpRzks6miMcPhgwvd05
	fwjKcs8GqGooWiFvmWucy6jva95g1fHrzFEc+7mWA78fPegI4EElH4rn5NwaycFly0f5py2HMei
	t0mPg6VBc82yiVBsKYeWq4Gt+e2wuFZE09j4Stm755RrCC30Qw7wKZTEed9gxkBWm6s5jf+2LBo
	9OkTQCcApZ6D2ay1yqD8AnuzMLbQk87SyO5Xr0IGF8RKjIh6DRrq+HAZ6BJRHg8vSUrVnWXz+M7
	0qeBx9AiLrEY=
X-Received: by 2002:a05:6000:46cb:b0:48d:ecba:3cf8 with SMTP id ffacd0b85a97d-4abb3956786mr18544591f8f.43.1795465583237;
        Mon, 23 Nov 2026 12:26:23 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6baa3c4dsm20108713f8f.46.2026.11.23.12.26.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 12:26:22 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] iio: magnetometer: mmc5633: Add mount matrix support
Date: Mon, 23 Nov 2026 21:26:15 +0100
Message-ID: <20261123202616.17334-5-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123202616.17334-1-gerard@teslabs.com>
References: <20261123202616.17334-1-gerard@teslabs.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read the mount matrix from the firmware and expose it, so that user
space can account for how the sensor is oriented on the board.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 drivers/iio/magnetometer/mmc5633.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index 316b431477dd..adc08cb28600 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -92,6 +92,7 @@ struct mmc5633_data {
 	struct regmap *regmap;
 	struct i3c_device *i3cdev;
 	struct mutex mutex; /* protect to finish one whole measurement */
+	struct iio_mount_matrix orientation;
 };
 
 static int mmc5633_samp_freq[][2] = {
@@ -101,6 +102,20 @@ static int mmc5633_samp_freq[][2] = {
 	{ 6, 600000 },
 };
 
+static const struct iio_mount_matrix *
+mmc5633_get_mount_matrix(const struct iio_dev *indio_dev,
+			 const struct iio_chan_spec *chan)
+{
+	struct mmc5633_data *data = iio_priv(indio_dev);
+
+	return &data->orientation;
+}
+
+static const struct iio_chan_spec_ext_info mmc5633_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, mmc5633_get_mount_matrix),
+	{ }
+};
+
 #define MMC5633_CHANNEL(_axis) { \
 	.type = IIO_MAGN, \
 	.modified = 1, \
@@ -109,6 +124,7 @@ static int mmc5633_samp_freq[][2] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 				    BIT(IIO_CHAN_INFO_SCALE), \
+	.ext_info = mmc5633_ext_info, \
 }
 
 static const struct iio_chan_spec mmc5633_channels[] = {
@@ -485,6 +501,10 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
 
 	fsleep(MMC5633_POWER_ON_US);
 
+	ret = iio_read_mount_matrix(dev, &data->orientation);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to read mount matrix\n");
+
 	indio_dev->info = &mmc5633_info;
 	indio_dev->name = name;
 	indio_dev->channels = mmc5633_channels;
-- 
2.45.2

