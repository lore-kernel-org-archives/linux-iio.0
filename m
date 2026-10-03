Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBC1221F39
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790986855; cv=none; b=rvJOO1VeMPslTL+cJKP4ucwLktY0NsiA8LTf9R6sr+AN/p2etWsf7HovtrRxF20LP+D4HjdHV402ZiQOhfpUp115ZGI++rUTfjib3B4AE/PwGxLVYM52ELMPZJHGgTdZHjBvC6nz0224JNK1EjidBkH2+MotWa0NEmaOUx4jgNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790986855; c=relaxed/simple;
	bh=phHVyhkBq6WW2dGFHPayWZAYWb6ZtXc/UAE+zzHdWko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRT2Gz3PA/vY0NmUb1yJDlNRLg+EwCyTl/pBwwM2iSmQkM3M/sKcUn48Ra8gUgtPS76kPOzLLa4zRYCRZXGMFXMHChgid4yaGgjziCp41FYWr1lxcYL/h/t2tim5+liaJfQkBt37XTg2Swxo6Kf3ccrzv4SipEM7sxVPWyzzqtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtcBRO1m; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtcBRO1m"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso2894265e9.3
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790986852; x=1791591652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmLVoYCEqpGvzC/JRx86RBjZQ9D0YR0XuwarLTK66A4=;
        b=PtcBRO1mQs/bEL7B6pIUR3LnWBIfR7Hz+t+gqv5nODb/uClRV9VbY+3gqzkWecP/rm
         ZI9IZqSa5rLYEXXXuhJ1leaM16W+VbruehkuDlpXEMAiRZR/b2zfRz4MrMc6Gq6ZjVkE
         /VDrfIf/9JFxf+AdRj2+X9LRG+b/68/qyHIAoAzPu2jfUv6rooMiokBFfMcC6cdQFiC5
         6/miydywG3M3ha29FNS0rRtWRqMXsdT/OZvPp4ov878BT7UBdI+YAntbT3rbTVYnXzxb
         zi5O5zxLAHetM7igpy5gt/Mr1ayH3XO18uVeddUmb32clh2FDg4OkK1ny6Uugxhgg2HZ
         jgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790986852; x=1791591652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmLVoYCEqpGvzC/JRx86RBjZQ9D0YR0XuwarLTK66A4=;
        b=hvZEHiY13JwvAjys6Jpzwd5eGol3p+D37ldLPub79IxNzRkpJ+29Ibl0tfi4Lvt9A6
         SSby7bv3VmOPySKFLuJ1AEKTSf+oOsuUhTw8HLyL7e7fDp5FGrdW+JTyFvzUo4JxTt+n
         LLYJ5J1Ck0M3sZfu+IN8upDeK9t25BYKBTqJaFCAnEjB74Mj0+d8HmkHaSg+pcpdJDvy
         cfhJ5UvJu/gwQb4UBwMZDAGIg7fBQc//waHJ3JcoOF4hKKuK+n8/s/n12vP+AIA0ifNy
         xzAe6ZPUJYyjeE66j5VQfNJM7GbpbU/XJSwU8FFC+V7isOhsUp7Q46CdoLldOZRbg2sk
         8TPw==
X-Gm-Message-State: AFuF++k5XIkxP3KF4+bYZyvzs1JuzD64hm8gB949cCg5WQihcibUEYZm
	F645+KpaYV4meeNltLBeuZfsHPRba4IyGDZ8va1049J2FqzO0JpfzfH89uWRvJTO
X-Gm-Gg: AYBFou0CbW1QIsu5ru19b3/joOqox06Iorx/lEEx77rgrsxm0yZ4eMV1mxQHpadNnXe
	iQ8C42rrBGPrTQU56JyPTpfB9J4iAmwMknAqdX/z6uL6Ka6M0EQbhJZyvr+qC/qJ109lRsJd/Cu
	WHmobxtzZsGbazrk3FBqEqDwlvTIeg+idhjxllZF0GcYpFmTxe1admHh+jVtrKjeKo1ZLc4FA+z
	fNndskji1IXkRQEmBMzjrCxgdEQ0PoR9r+SRFZThSzTG6tvJCbzAVE0+3rGTOccsivBXrn6YR/V
	XnCvvC8GJh/VysJYDZw3NfFk1mZo4GwPCw8xK9i5UwXHDWV8bx5PCcxfavckNFaVUGHfouLD5v7
	FYLBx2+FrVpLlZY+V3+5++OY3ZFnItoHEcoDzYQvJbulTlQJov0lbsptZaM6jNsf6aflP3qKrVa
	4aYkMzt5f2AMHLzw0n5NdMLRo791l6aeP7qOSEZ6yBlsewoMpuTuK+n+mEa+jeAjDKIwVY2cYVp
	tzmlnrIEC+aHRJjvAIMhqHModBFJTSPPteYrGyj1aNI/UXYvzyHORQmkVlfvE8Sh7jEDLNINRQR
	CXfSOPvT4FFUoVWORg==
X-Received: by 2002:a05:600c:a41:b0:4a0:23f:8b0d with SMTP id 5b1f17b1804b1-4a1680b9df0mr12675635e9.2.1790986851580;
        Fri, 02 Oct 2026 17:20:51 -0700 (PDT)
Received: from SegFaultinator.localdomain ([37.142.148.246])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a02752aeb3sm124836705e9.0.2026.10.02.17.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 17:20:51 -0700 (PDT)
From: Yuval Saar <thefireking@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	maxwell@maxwelld.cc,
	Yuval Saar <thefireking@gmail.com>
Subject: [PATCH v3 1/2] iio: adc: mcp3422: describe parts with chip_info
Date: Sat,  3 Oct 2026 03:16:46 +0300
Message-ID: <20261003001647.1975549-2-thefireking@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003001647.1975549-1-thefireking@gmail.com>
References: <20260919195507.94130-1-thefireking@gmail.com>
 <20261003001647.1975549-1-thefireking@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver encodes MCP3421-8 differences as integer ids and switches
on them in probe. Point i2c_device_id.driver_data at a per-chip
structure instead, and keep the channel list and 3 SPS support there.

Compile tested. No hardware.

Assisted-by: LLM
Signed-off-by: Yuval Saar <thefireking@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 103 ++++++++++++++++++++++++++------------
 1 file changed, 70 insertions(+), 33 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 36ba00edf..92825aaf2 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -76,10 +76,16 @@ static const int mcp3422_sign_extend[4] = {
 	[MCP3422_SRATE_15] = 15,
 	[MCP3422_SRATE_3] = 17 };
 
+struct mcp3422_chip_info {
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	bool supports_3sps;
+};
+
 /* Client data (each client gets its own) */
 struct mcp3422 {
 	struct i2c_client *i2c;
-	u8 id;
+	const struct mcp3422_chip_info *chip_info;
 	u8 config;
 	u8 pga[4];
 	struct mutex lock;
@@ -223,7 +229,7 @@ static int mcp3422_write_raw(struct iio_dev *iio,
 			temp = MCP3422_SRATE_15;
 			break;
 		case 3:
-			if (adc->id > 4)
+			if (!adc->chip_info->supports_3sps)
 				return -EINVAL;
 			temp = MCP3422_SRATE_3;
 			break;
@@ -261,7 +267,7 @@ static ssize_t mcp3422_show_samp_freqs(struct device *dev,
 {
 	struct mcp3422 *adc = iio_priv(dev_to_iio_dev(dev));
 
-	if (adc->id > 4)
+	if (!adc->chip_info->supports_3sps)
 		return sprintf(buf, "240 60 15\n");
 
 	return sprintf(buf, "240 60 15 3\n");
@@ -311,6 +317,54 @@ static const struct iio_chan_spec mcp3424_channels[] = {
 	MCP3422_CHAN(3),
 };
 
+static const struct mcp3422_chip_info mcp3421_chip_info = {
+	.channels = mcp3421_channels,
+	.num_channels = ARRAY_SIZE(mcp3421_channels),
+	.supports_3sps = true,
+};
+
+static const struct mcp3422_chip_info mcp3422_chip_info = {
+	.channels = mcp3422_channels,
+	.num_channels = ARRAY_SIZE(mcp3422_channels),
+	.supports_3sps = true,
+};
+
+static const struct mcp3422_chip_info mcp3423_chip_info = {
+	.channels = mcp3422_channels,
+	.num_channels = ARRAY_SIZE(mcp3422_channels),
+	.supports_3sps = true,
+};
+
+static const struct mcp3422_chip_info mcp3424_chip_info = {
+	.channels = mcp3424_channels,
+	.num_channels = ARRAY_SIZE(mcp3424_channels),
+	.supports_3sps = true,
+};
+
+static const struct mcp3422_chip_info mcp3425_chip_info = {
+	.channels = mcp3421_channels,
+	.num_channels = ARRAY_SIZE(mcp3421_channels),
+	.supports_3sps = false,
+};
+
+static const struct mcp3422_chip_info mcp3426_chip_info = {
+	.channels = mcp3422_channels,
+	.num_channels = ARRAY_SIZE(mcp3422_channels),
+	.supports_3sps = false,
+};
+
+static const struct mcp3422_chip_info mcp3427_chip_info = {
+	.channels = mcp3422_channels,
+	.num_channels = ARRAY_SIZE(mcp3422_channels),
+	.supports_3sps = false,
+};
+
+static const struct mcp3422_chip_info mcp3428_chip_info = {
+	.channels = mcp3424_channels,
+	.num_channels = ARRAY_SIZE(mcp3424_channels),
+	.supports_3sps = false,
+};
+
 static const struct iio_info mcp3422_info = {
 	.read_raw = mcp3422_read_raw,
 	.write_raw = mcp3422_write_raw,
@@ -320,7 +374,6 @@ static const struct iio_info mcp3422_info = {
 
 static int mcp3422_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct iio_dev *indio_dev;
 	struct mcp3422 *adc;
 	int err;
@@ -335,33 +388,17 @@ static int mcp3422_probe(struct i2c_client *client)
 
 	adc = iio_priv(indio_dev);
 	adc->i2c = client;
-	adc->id = (u8)(id->driver_data);
+	adc->chip_info = i2c_get_match_data(client);
+	if (!adc->chip_info)
+		return -ENODEV;
 
 	mutex_init(&adc->lock);
 
 	indio_dev->name = dev_name(&client->dev);
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &mcp3422_info;
-
-	switch (adc->id) {
-	case 1:
-	case 5:
-		indio_dev->channels = mcp3421_channels;
-		indio_dev->num_channels = ARRAY_SIZE(mcp3421_channels);
-		break;
-	case 2:
-	case 3:
-	case 6:
-	case 7:
-		indio_dev->channels = mcp3422_channels;
-		indio_dev->num_channels = ARRAY_SIZE(mcp3422_channels);
-		break;
-	case 4:
-	case 8:
-		indio_dev->channels = mcp3424_channels;
-		indio_dev->num_channels = ARRAY_SIZE(mcp3424_channels);
-		break;
-	}
+	indio_dev->channels = adc->chip_info->channels;
+	indio_dev->num_channels = adc->chip_info->num_channels;
 
 	/* meaningful default configuration */
 	config = MCP3422_CONT_SAMPLING |
@@ -382,14 +419,14 @@ static int mcp3422_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id mcp3422_id[] = {
-	{ .name = "mcp3421", .driver_data = 1 },
-	{ .name = "mcp3422", .driver_data = 2 },
-	{ .name = "mcp3423", .driver_data = 3 },
-	{ .name = "mcp3424", .driver_data = 4 },
-	{ .name = "mcp3425", .driver_data = 5 },
-	{ .name = "mcp3426", .driver_data = 6 },
-	{ .name = "mcp3427", .driver_data = 7 },
-	{ .name = "mcp3428", .driver_data = 8 },
+	{ .name = "mcp3421", .driver_data = (kernel_ulong_t)&mcp3421_chip_info },
+	{ .name = "mcp3422", .driver_data = (kernel_ulong_t)&mcp3422_chip_info },
+	{ .name = "mcp3423", .driver_data = (kernel_ulong_t)&mcp3423_chip_info },
+	{ .name = "mcp3424", .driver_data = (kernel_ulong_t)&mcp3424_chip_info },
+	{ .name = "mcp3425", .driver_data = (kernel_ulong_t)&mcp3425_chip_info },
+	{ .name = "mcp3426", .driver_data = (kernel_ulong_t)&mcp3426_chip_info },
+	{ .name = "mcp3427", .driver_data = (kernel_ulong_t)&mcp3427_chip_info },
+	{ .name = "mcp3428", .driver_data = (kernel_ulong_t)&mcp3428_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mcp3422_id);
-- 
2.43.0

