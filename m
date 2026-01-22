Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC23F43B1
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 16:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769099030; cv=none; b=RwEsZ0rc6qQOkzfLH2A2t8MVMcQWFx3vnpbqsOCie0Cu/BmeEa0eS/5DL1dumq822rnXikcZlawY/FFC+HRE6b4CgG9Ee/soq8aIK+A3hOOeku3Fia15BY64tT6AltM5c5waPDByhA5UnyBFTQXApk2PN8GYZbuI7/igBoqy6qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769099030; c=relaxed/simple;
	bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=haJQ3v7YImbkBV9tcq0xxN1JVUznNK98fEHbj2P8ChwVViKfdK50s+34fIIvFYt3Udxr9s3Jbu7duWQWkUzwqwXgwU7bU9tJhr8TCukTSENEFdjPLUQvX5r4IfbvF1GqSgY7y8AHdtVRPFIQhTDFFU2gZCLhxIoHiC/2rrMe1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IUG3Q656; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IUG3Q656"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47ee3da7447so9164265e9.0
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 08:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769099018; x=1769703818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=IUG3Q656veh+UXfthgUGURtOGgp6z0ehMvilOiE1FlHD/gvJ1rlNPOPUHOKGk6gGfc
         iKT68DvxQIbUo4X6fHspBF3pxrxweDsuxMfUlKGUJVXPbNCJ3AiLduTizVv4MHQtj4cF
         o01yLKchpokxQkcnVSjWSEyelw9y+ymDDSMH6Jxu3tic8VlyX9Eyd58k/zpcpGfFmHZG
         9ZgqZrf2HP9U1vvlHjcjQlhkqGv03o8qCi9MddCC+zcP9HM/g+DOy16xbJr9ngE7hlNf
         VqgHec8Y8Y13N+dEmpVJSTnLSLMgvQ1c5JUukFPpjoslGS1o/DDIAtYFcQQE8CfH/hH5
         visw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769099018; x=1769703818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=PBeXvy+tuQtuaLRclMVBz6NgKiMEwNMdgR5m2sQzvWU7fNF3g6boS5+fi+gqxHbMGC
         A2MlmxfZv9wZkZAbQ5fakUZ2kRRe32eZUgrnQRmdoVBa6pUYHZYIYZc1lB4150ZDR5ee
         08d7J0hr9OKpVCtlQubVxkRAB0365OYCyq3tb80bULz/tshW4LlxjhJL/XYRPlIJ/WxG
         469wr7tofMszwH12hFZsvE4/L4pvFzhcdNx/61dolCmL2/V3rFUJ5Q+Wabj/JwMbLw/x
         eUnxlyVTdQac6Llb42aGYwAS1+e6pseM7GF9RQoX6Au1e1WD2aK2Y62BctYg+nlRKEmr
         Hu/A==
X-Forwarded-Encrypted: i=1; AJvYcCUh/w8xwrM1PrLzjdys2iG7VD/wd+iaX3s2l+j91hIFfvLcR+tHYI5E/ue6va8PGEqY3+blEuCsUv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPExLZ2Y58FU22SzBTLUtP/ordri3XC5mhTW/KVD2TPOfRiMfi
	FZkJ9v+ESrnCM243HBSLEaAGo44JHNyzvr6OaM0058wsTUQl0eZjITtmSuGsQTEcxrM=
X-Gm-Gg: AZuq6aIokz32KEvsBpiBI7rDSn8GXyZDiEo8+Qm8DtEreWz7frWk0cd3yBaZG1ZWc7R
	Rix8bsie1r0OZF8kOqEBvpFHsYLLjW7mgn9VPn1pOe2M4KdQaki/Zs+PZRv6TGB/8HsVz/QxQhj
	yzwOKc5u7B5TrGxlwC7wSotHlGkBfgQDu1dsL/QoQzRQkM2H2j1s/4ClFBRGslrKaox4z7xPlCO
	1Q9PNLYqigMCLjwLSie8PNRV0OHqwE8lhiP84awuxvRn2jEwc40rPrAS82oD+9nTIMZmA3YnDqO
	64cQxm1/nVxsOEDBBNP4IA1Jv1tHuJqbsLpVPwhe8x1kQvi2MBO2JvzxJsYSE8pq4YGhRsePOPj
	0utC396P6nZNzZKIgo3OogbPJuqKejXhmURCNMSUcW44b0QrSxBYdRGoUEQ==
X-Received: by 2002:a05:600c:8285:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-4804c8f29f1mr4045955e9.0.1769099017865;
        Thu, 22 Jan 2026 08:23:37 -0800 (PST)
Received: from localhost ([151.57.192.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804706f14fsm78889845e9.13.2026.01.22.08.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:23:37 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only
Date: Thu, 22 Jan 2026 17:23:32 +0100
Message-Id: <20260122162335.2020006-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260122162335.2020006-1-flavra@baylibre.com>
References: <20260122162335.2020006-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=flavra@baylibre.com; h=from:subject; bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpck7oKHlBS2+YWZdjOWGvX/xqPbpahixKnyHdW ADRDgnr6CSJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXJO6AAKCRDt8TtzzpQ2 XyJfDACg8mGeBAgcwaglN2TERZ6vbyZu9tlJLV7qdJo0WDYHYQhkwu9JvY7xW2rg/lUITTNTGBe PjBUCQp3CDwVk8PB5cC1pR5C0NSdgEpIE0yVbgLtQ4eBNEJKeAcwWp2MoJHTV1BDQSA4c0cjqcO 5Dbvr7bgbE2gVlZWcBFVeYZra9bH8CcrpkgRc7rjYTf7uKmiESIv6jb9AZSNEzShN9ZR+z0htXq DKbOI042A05tUe0yWsLyq1SyxqhjE3xMCCpx/aMQGiM4/4qZaH41MV9DrNsv54ZdT5odLW5JDMY 7PJbt2S0lcGmF2thgMNZrZpDrT9HNh0igeuGL5xikHb2uG2Ue8xYuhOpDaO3gw5fO0apiWQe2uZ /pgH4jtVFPou0KN36Lq4iOYkDj1JBRPcbErWB+PxIaVOvJiDAO0qD1CMydvlQoFuTD89NQ4LJgk ROVJJBHtOHv/xnGSLMeY4YoX0x/ja5hzuPGrxusJKXS1+JmgtimhgJHkfRjTKH5vhJwu0=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
disabling the hardware FIFO, checks the contents of the hw->settings->batch
array at index sensor->id, and then sets the current ODR value in sensor
registers that depend on whether the register address is set in the above
array element. This logic is valid for internal sensors only, i.e. the
accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: imu:
st_lsm6dsx: add i2c embedded controller support"), this function is called
also when configuring the hardware FIFO for external sensors (i.e. sensors
accessed through the sensor hub functionality), which can result in
unrelated device registers being written.

Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
not touch any registers unless it is called for internal sensors.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 55d877745575..1ee2fc5f5f1f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	const struct st_lsm6dsx_reg *batch_reg;
 	u8 data;
 
+	/* Only internal sensors have a FIFO ODR configuration register. */
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+		return 0;
+
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
 		int val;
-- 
2.39.5

