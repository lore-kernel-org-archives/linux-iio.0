Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463391;
	b=c4Qy8qTIZk3tDFec3pAGYfiLzA77ef/LFcHdnc4WSM6DltESildCEzTE505q/ZF7Bwap
	 wcKiBCJSPZ+1bpkCCbx9wEMwZ3pfxeB63yHufvsNXZLTkcoxR/CPuuyUHZUXKuyzPUoJF
	 jFLq82XbGoLMpZwjd9pI0sLfxPKDPq6D1phL4DU5hH2g+jR4MVMyiTz+yOe8E76th5zBM
	 ierNYWblWT0L/Xx/mJF+aFnTZFstQUAGfn8fYt13mSdx/XvOyPgksTDtrOUuUW8+2DRQS
	 wR7zhNqqCAVLlalvJWP7JC1fTzGwGGDBkif8cYGnmPAgFCN1j1NxAYc8t5ZdacmngVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463391;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=FKRBXLDYVdFCJ4/5gtHKzvLnfTFU8JtXH7QpWXH0Wyg=;
	b=stq4KJEzY570OfUqEQ1t+jaGm6RZ6+bDvqVi4zRyJBGWSYAt1GCvYD5T+6tqlQpe4h29
	 BWttx9eELsTyhoudZ46FrCsRg9KCmzLag8l9QbI/w1eju61JHXZOeCezYqpoursIaOeCe
	 3e5LrfGUy6FYH8X7W1lxBfQodpx75ADJq9fxQa3zQVST8axljSgqhPcMj5Ayd3hrVLL7I
	 T+PI+hzrfLfzQ52H+13C6fYJS2WSmUFYTeFFyE4fbJKfMSG/opudMhOv+k4jsAFXF5sox
	 uDR8KFswVrbiZs+riWhyvw7jSXodc2rNYn5vRwtj6Av+fccGzXK7U+Wfvib2hV3Ue7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WuKwUk3h;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F7B606A6B9
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 19:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4F7B606A6B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WuKwUk3h
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb9d8e8e90so8457785e9.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 11:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795463389; x=1796068189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKRBXLDYVdFCJ4/5gtHKzvLnfTFU8JtXH7QpWXH0Wyg=;
        b=WuKwUk3hvyLU1RhLkirm6JV18FNUaB5chi1cvXL3xcm/x00Xuj7MeXyhGTFp8PSmAz
         UxM63nCjqxRmzAdZXdCUeBiko4UXAPeJXhka/n9S9hkzYXEC5OoJ2cNw1HGbe8POjfXG
         kd91ZZ3CAqLUMOeGuTRbq2Rqgya0K7g3sw4mFp85dVXfv6JasJO26RLWYkcQ2wu5gc/Z
         PtSb1j6j5IS+XaXuciyb4IVZaEHpLtctn3/oQc1+m8N8M90wZE8qGsQYWkEIaXIiEZpI
         IZrHBF/fudW01q85Lbg0hj4jRc2uAwRDxRWx041VZVOYYh+tRGctjhOiV+RrQMBILiUJ
         KL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795463389; x=1796068189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKRBXLDYVdFCJ4/5gtHKzvLnfTFU8JtXH7QpWXH0Wyg=;
        b=qwyg8rAzo8kqrN+vh7ANMncP7ZQkhF7NBMaiDIQaYrseAhe5mfN4HGyavaF2nLzqKB
         DKNm3H8AhLx7L9pmsF0D3tq04moPUOBPsCFYsX0D6xG18daxGOoFzqnnuA1+kIzOqf7t
         RrcBSmU135TErGNw6ovMBQIWq5BuR1IwybbkJ9O2j/MqX09D8rl0iK2HDTUakVvnISgZ
         Bf9HZgn1UZd1DhRfdtGVizHudkxysF/I3ppMj2tY0MMWjgrh6g8FXBZ3Ed6JMOhVQSYk
         nLGV2RMzUB6U4hgbXtnEUy/YYMF0OrIUTOsUayeF7X1ACMF+MRUY9QhX51U62gq9FtK+
         TYsg==
X-Forwarded-Encrypted: i=1; AL+hErHg21Dj+AYzAbzjfIYjJGd/ZcNFh4YE9zcyGSGL+U445h1xJqay+XI7KKZmWylZr+Ydt855h2HzGZo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GyTcDIy2g1zNQHiOXOiKGDdL2oRcke8+0fPYUPUeO8Bg4jrjS
	w/LdeaHoVOC4yBRpdaKsVVfOWfiZruvC6q7q2JcMHzseqgyRXgx7X/AptpSSaHMxSW/OtpPNcE9
	ozzFw0WZ4vQ==
X-Gm-Gg: AZFdTZcp9nmPHYJHwTj8Gq0sOu6DUFeIO36VwIN1ORwPMNrr0xoJQmzu5TQeqsNijCA
	QcvBgnz/qjHwpEin5643ZNjRXT2XPC2Ym8hpDm8RptBtuxdIwcYDnY5aioyPqSzJr1yVbLCffjN
	3+1+3F7KRnKR0jLTMONh9B7Z1WFzpUlCWeWSBuITdoUXWZDupVWwZwSroDECv+GWsQsSsMbCou3
	SOphCoe/42y6rreU6C++9OxmW5dJ+r4kJbLcJbUWpx5y+3KFjGKJl0nyCvmU9Y0GRzyDnN+4nho
	/inRRCu9Oh3A/k7scwaouL0Vl+Q4X/PDB7a5ZWDAcxt/M4sIyelrQWOuHYeQa/zpEPWWEtbQjk+
	YORv28BOq5vMO1p0AqQ8C1Lj5U1/eNe8lRt4MIw9VOKlwgx+48yv1R7Ms9V+R6hK2xfuWLr0HFz
	Qr9+Ns6MyzJVRT4SZVzq1Gqfr+cNkFnAXrC5WaP9+sD5jvypFTe/PC92DLGI1gLwYsChgXZbs/V
	ZXtOhyvrDzO00Q+bamsBZTBri/AlcsytOYEBunFf+7x00Z/MPOp5f+sSwvPwbZANgikomR3fVcl
	+pBy9lxLyetWPvaPI9vwj4+cd2wlxsgX/ptdoJqmIgtPWzMO8hCtsXc+DfW1TDNyI+cEPx9CqIG
	3DjfrPaQYcHw=
X-Received: by 2002:a05:600c:5487:b0:4bb:5de1:e92c with SMTP id 5b1f17b1804b1-4bb88813157mr261425675e9.26.1795463389367;
        Mon, 23 Nov 2026 11:49:49 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb90660cb4sm300924125e9.2.2026.11.23.11.49.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 11:49:49 -0800 (PST)
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
Subject: [PATCH v3 4/4] iio: magnetometer: mmc5633: Add mount matrix support
Date: Mon, 23 Nov 2026 20:49:43 +0100
Message-ID: <20261123194943.57601-5-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261123194943.57601-1-gerard@teslabs.com>
References: <20261123194943.57601-1-gerard@teslabs.com>
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
index 584ed957e0ac..c92c40665e6d 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -85,6 +85,7 @@ struct mmc5633_data {
 	struct regmap *regmap;
 	struct i3c_device *i3cdev;
 	struct mutex mutex; /* protect to finish one whole measurement */
+	struct iio_mount_matrix orientation;
 };
 
 static int mmc5633_samp_freq[][2] = {
@@ -94,6 +95,20 @@ static int mmc5633_samp_freq[][2] = {
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
@@ -102,6 +117,7 @@ static int mmc5633_samp_freq[][2] = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
 				    BIT(IIO_CHAN_INFO_SCALE), \
+	.ext_info = mmc5633_ext_info, \
 }
 
 static const struct iio_chan_spec mmc5633_channels[] = {
@@ -482,6 +498,10 @@ static int mmc5633_common_probe(struct regmap *regmap, char *name,
 
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

