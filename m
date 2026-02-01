Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58716288513
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 18:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769970833; cv=none; b=jLt26ohqh6sdr3m0zryl9jmCwjl/EmGrBRKz7WZe01InpPgLsLWrzpzMnbGHbeAUovAVnd8QHrg9s70PTGJBu/G1Tq0DIOGnweRByPenNBbCfFYv25xDUtRR+20Dq5Uc7NIvlfvgGLdqulqEcIyCnnRUB9hZNmsZpzkoaXD8t2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769970833; c=relaxed/simple;
	bh=IUjmltrTFO4YbZQalOEcuCS0vZJiq0YFeUYJfges9VM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv08P9sxsSrOut16kUtXJqZyvaEKwSypOIaWMaGeCt055oXnkduMDrM5B1eAtrPNxjjbNauJxW9qjGisiE0EG0xPRQbu/x9X60fyh9cejWOuuX7zpYcGoSaFrX27rjWHHFpfLqdWIEcNnwdOmb4xmkR7OpMsZTxqvmNGSVXVitk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD9CQpIF; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD9CQpIF"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-435a11957f6so3004090f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769970830; x=1770575630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8B3KYHW7oN1cE0ooieHtgCbkDaH2P1LrwaeA4680tA=;
        b=VD9CQpIFSUADbBs2JiiTlI141An8Tyr5zbxeu4fuQkGHoNcITQFfo59yeUT1waKb5Z
         c4GgeN7ogPx7S9iEVcBtlIgHeYX/3D95w5SAzipQLwBAoizsiWUuFGFqouSm9C6YjeRU
         pvgeF4U1w5atwGleDQDJUKF24ID07z7RCjUAJBkPlz+ZuHZi3nZo5IBGH58G34tHkmy8
         nUILFE5i70sUYaXXpRetO7EvojTA/Y9NkV7srXx1fkLLnUaDD8etRJK2tuMaUpuPINEZ
         2KurmRnGZklOsqW4y+jZ8N3C3eNbDorNv/Bn/PrftXt1fjGd++2kKwsRxzeXukXCgbb5
         zpVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769970830; x=1770575630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I8B3KYHW7oN1cE0ooieHtgCbkDaH2P1LrwaeA4680tA=;
        b=pLXu70YRduopuaAiMIXSPmjWl0ebZ9WZzjH0K4X/kFZyFNbClKqlRdmB/XZRnJLIBp
         dlSeeAlwoE079o0qJZ9IJ9eeMxEb4wvrC72arfwk5wKkak4e/1yul3hpuT8Mkwr8SMfw
         l03npTDNmQH8SYnl9K7whIl0A/H9QCjFNm57YEPXO49G/7RM8w7GzBi90k2IMyCJlIfH
         VajMHI29Qyr9oJb0dbZfhjzl6HZsEeQM3tYVlyfyROs5YNwL4neHgtIuooEZQES5L9/9
         9RpujLT2dwQutbASdkdU1hTLxD1tW9LKSVrHTB5oWNU31zhjBG3Y7brFzYdJbydhucqq
         ACmQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/5b5kZeTkQCq8REwGlVX4hqbGvIxwkpXFAbnnq0sDDYhFPB/sxkYEfwan1IhfV/ZAOll+N7ZG2fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgLhDbO0Le71sLedUAmDlmqrMz0TB50TRhO1QTzaQ45Dav45fa
	Pw1igHlr20Za+egZeE8ySvJ4u/DTFltPZpQxL3FqfPWH5fLiRQOgLDaEI9ygPQ==
X-Gm-Gg: AZuq6aKihiZqNpwibEjZ8msHaEYW+I46VT7zX5zOjHJRjfzqHlSHInvNBXp+8KNWila
	63uQXxuXmaDWvuG3rQK5mrYuERQ6GuxpZRPT1S4o+a3Ljh2nF/m7qK7YupQ3K4jYhiazsWa/YZ+
	ao+Zj8qMcQ2+DfmyfH2rA2JB5dkZ/Z2Xr6w9cGKNMV5PW/34DYKt6FIz3G3dsSG+e0jvBKhzy53
	cTT3mNBZlVr//dktglfdwXs0sVpJ2hO7AaBipdoPHFM/Z1+a02M30DbQWGUZUu1K3YbcUPzpn2H
	UQ2mfo55r6g97HyFyK94Aoy8P8LP+5cNLOSXnmss+oMhyuyMdKdKacuRI9FIqGFfpmSVAMxbqf8
	S6G7LezoZFM33Z4cGsLLc9mQfN3aTsw6i5zpAfZ34FxBzPeom2r0U6iSHjpuuHUq2Ox/Jnjym8w
	08ykeAkI5Mmt4ReU0/tEuz7hi2Z72IKFummB/BBQyVzq5CzA==
X-Received: by 2002:a05:6000:4381:b0:435:8ff3:cd5d with SMTP id ffacd0b85a97d-435f3aaa753mr12566531f8f.32.1769970829536;
        Sun, 01 Feb 2026 10:33:49 -0800 (PST)
Received: from DB-VM.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10edf62sm41400084f8f.13.2026.02.01.10.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 10:33:49 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org
Cc: me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	rdunlap@infradead.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v2 3/4] iio: accel: adxl345: Implement event scaling for ABI compliance
Date: Sun,  1 Feb 2026 13:33:12 -0500
Message-ID: <20260201183320.27023-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201183320.27023-1-0rayn.dev@gmail.com>
References: <20260201183320.27023-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
event-related registers. Previously, the driver reported raw
values without a scale factor.

Implement IIO_EV_INFO_SCALE for all event types to provide the
conversion factor (0.612915 m/s^2) as required by the IIO ABI.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 78e3f799ecc1..dfe3169ffc5f 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -212,7 +212,8 @@ static const struct iio_event_spec adxl345_events[] = {
 		.type = IIO_EV_TYPE_MAG,
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
-			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_ENABLE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_VALUE),
 	},
 	{
@@ -221,6 +222,7 @@ static const struct iio_event_spec adxl345_events[] = {
 		.dir = IIO_EV_DIR_RISING,
 		.mask_shared_by_type =
 			BIT(IIO_EV_INFO_ENABLE) |
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_VALUE),
 	},
 	{
@@ -228,15 +230,19 @@ static const struct iio_event_spec adxl345_events[] = {
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_SINGLETAP,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
-		.mask_shared_by_type = BIT(IIO_EV_INFO_VALUE) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_TIMEOUT),
 	},
 	{
 		/* double tap */
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_DOUBLETAP,
-		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
-			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_ENABLE)		|
+			BIT(IIO_EV_INFO_RESET_TIMEOUT)	|
+			BIT(IIO_EV_INFO_SCALE)		|
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
 	},
 };
@@ -274,7 +280,8 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
-			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_PERIOD),
 	},
 	{
@@ -283,7 +290,8 @@ static const struct iio_event_spec adxl345_fake_chan_events[] = {
 		.dir = IIO_EV_DIR_FALLING,
 		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
 		.mask_shared_by_type =
-			BIT(IIO_EV_INFO_VALUE) |
+			BIT(IIO_EV_INFO_VALUE)	|
+			BIT(IIO_EV_INFO_SCALE)	|
 			BIT(IIO_EV_INFO_PERIOD),
 	},
 };
@@ -1367,6 +1375,14 @@ static int adxl345_read_event_value(struct iio_dev *indio_dev,
 				return ret;
 			*val = sign_extend32(tap_threshold, 7);
 			return IIO_VAL_INT;
+		case IIO_EV_INFO_SCALE:
+			/*
+			 * The event threshold LSB is fixed at 62.5 mg/LSB
+			 * 0.0625 * 9.80665 = 0.612915625 m/s^2
+			 */
+			*val = 0;
+			*val2 = 612915;
+			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_EV_INFO_TIMEOUT:
 			*val = st->tap_duration_us;
 			*val2 = MICRO;
-- 
2.47.3

