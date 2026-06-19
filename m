Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F503C10AC
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884535; cv=none; b=gKvP+2gIySkLIAj4XNdepNclbxG9whvGbP+w83gTsStBZvA4ayGTjwUwS9ZDAh3QjADsmXk8431Jlu5fpfg0X6jTf/xSLrTCgI7awHn9cE0lb40INV/kK2kozYId4a6BwO+8ZFst+ZBw2mWJmK5SXEnos8YRmr6ALkkJVPpjpkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884535; c=relaxed/simple;
	bh=KOURT6hbMcRBPRPh2w9x5SoQOt4jV2T7U4LqGwnj5gE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsSO2eQgrzoDeMRzL3mDirP60NChbU+revOPyJyIUA4bu7ufq14oIjvI05C4x9/dLp1pM7+qZxH5g6WpfATrie36fNkkFdrY34G2yQcIKmH12KWeVly7m1iu4l9Yh/IsIm22cMCqgogwLv2doOZUt7Xt1uzYtb1XzJ82CTBJ6jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Fjd+mxC0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Fjd+mxC0"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so8589515e9.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884526; x=1782489326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zg+XvVR1erub0k2voL49iihmdIK8YUZ8wfaJ2L9SY2A=;
        b=Fjd+mxC0GlmNHJWnMK+paUVS335KxMD7iycObin6+JLtjBMVZaUxU6xs0Jx5wIk0MV
         /BcsEPZmie2UgosAGUSM2W+4bhA7TTADnI+AiAFsa3PmcaaPDcD6djVgIUxL8RuOIiA1
         I1zAtTWqjQzmBRTBZFTXYJYmnJSeVcUsMkVHF7nBl2oPKvgMKv0TJWKUm9U4/8MLwjKB
         WFZ42Hnc8IfvJMciIH/gUtHgl1IAuhBKXTVrl7QoH2CN4Dl7M95JgQyD35aZAO4TVMId
         DQn+hjk9Vk4ZZYahjuB/otTIXgEMcMt0BVBmQow80kZjFgzPaDaWJ0eh2InsIrJDkq4z
         z/Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884526; x=1782489326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zg+XvVR1erub0k2voL49iihmdIK8YUZ8wfaJ2L9SY2A=;
        b=L09DJXzh2XT9sM/YRm4YelTFI2QtFRcYe/fAl8WXXeF9lOe7YD5VKcfQCTPRp7vP15
         0G79gdNzMAWqiTXUGt0n5OHBa5zdnebae3a9RwePh8UbzIfNd5DWweOpgpiYws3+2Cei
         qGyP7b9V3aPGA8YC4CVPRgU/ntO5GC71lisDL0gitOngC7Yl1013zdoTf9qpl3W09pn8
         ActfohW5R9qfoUtKHpksLNW7SfAI4HmhzGORRi58PuZEfDZl77D3HY8nWstOSRfNA8DX
         pc5RZWgPO99c+moft32dtDF0p7cecX/IjKjZ1M5xNjT8Ir/NPUttg01IB8GG4bClIa9y
         2T3Q==
X-Forwarded-Encrypted: i=1; AFNElJ8oAFCjpOzoQzlO+VcYtWblmPRVEo2ahdn/BUAyH5KpNPu7Z/1hH/XyD3z9YIp0izmmDY/H3VSWfnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwExLNwuZkS7tgScIImEFrqqobopFsY3RyDDgRd4xFcCEi9uCJq
	2U7nl1RttpKe2CT96XcXLZR4DnOMMOAKiTB8SjQ6cjsba/VPxB+ieAHXKh9640jV0Wg=
X-Gm-Gg: AfdE7cnOuQ1hk9AEBtGwgnfUK+ubyoFwOsb+OHGz+G8wDuBquitaZ0jGlp758xIVTX5
	ndgSSl6CELznJyw693hZkRTI1LV62UcPRJlEq4idq8qM92r5/cTxhkrr2zb/R/hIqhnoQXv9Uje
	vrMwj+QBkfz50tlQgz8NOHazK+btOw5vbM5PTd/teSxHU+sHM694xJ3F7fj/+8PsWbhB4z2boxM
	vVxQOjb6kFYdF1sdYsC03DNCctNAVsTzh5WfEL4rCax+eVRsNujl8fYdZ4JKHO+wOOl4RssPw/l
	msyNUZsd+3wVOrR0r588nm7f6vHVbJNc6IDIZV1pPgFxTJ3VmTYfwGemuVJ/9LBpTQ9C3MnCiGh
	rzeOgRoOWOQVHzHNMauiMm3vT4QCDOy4GpoFwIzP75bx6LtpU1V268ivhl+muQMuMEXpyIedSf+
	tA57Bh8U0eVfNKunTTMY7Zz/0ZEOQYh7l/HgnW/IRsFG8YtsHxQP2xVPah3Ky0cRbSBjHca29m5
	cc=
X-Received: by 2002:a05:600c:c4b7:b0:492:3773:a230 with SMTP id 5b1f17b1804b1-49240e9cb38mr65281845e9.27.1781884526269;
        Fri, 19 Jun 2026 08:55:26 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923fd15517sm80746545e9.10.2026.06.19.08.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:25 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/13] iio: imu: adis16550: Simplify device abstraction
Date: Fri, 19 Jun 2026 17:54:35 +0200
Message-ID:  <d20edfa8ce9685c6c3d2654186e9b80625c61e24.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1461; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=KOURT6hbMcRBPRPh2w9x5SoQOt4jV2T7U4LqGwnj5gE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWZHrcoVYtOYwPwRUMLwP1iDxoquLZx7cekRe FcMF3GkZBSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmRwAKCRCPgPtYfRL+ Tp21B/9lbCrNKgc6Ayfej7VpgbMIEwgR16PIDeHoUKgHnBN2L8sL8uYyH+kA7oNn/cJZ55Ac1AF YmLX88dAJz+42RhD0v4cYeje+R7SFKCalQ27eqAOTF4NQAWfBvHkCz9ccOuvUZRRliIjswh/JNg DExENIiecDUZksJW4tvFmqFyYgGPHj6EfgCOWuXQtkMOWTToZnfJCGWWhrYQ0UVVBYRFEOevR0q MgsCCteFeAq5XT45THX8xkkIGe4l6yjw18hV3FlvGeO+8KSWZkfVZTBWF0HmyHfxFvwyBJyjfze 3khFbqbp6TkW1cLK3i3lESUJYAs1dws8Si2UzaORD1QIrdwY
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver supports a single chip variant only. Simplify the driver by
hard-coding the device properties instead of using the id_table's
abstraction for a single chip type and a lookup in a table with only one
entry.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/imu/adis16550.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 75679612052f..0fd18e16942f 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -1064,9 +1064,8 @@ static int adis16550_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st = iio_priv(indio_dev);
-	st->info = spi_get_device_match_data(spi);
-	if (!st->info)
-		return -EINVAL;
+	st->info = &adis16550_chip_info;
+
 	adis = &st->adis;
 	indio_dev->name = st->info->name;
 	indio_dev->channels = st->info->channels;
@@ -1117,13 +1116,13 @@ static int adis16550_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id adis16550_id[] = {
-	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
+	{ .name = "adis16550" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, adis16550_id);
 
 static const struct of_device_id adis16550_of_match[] = {
-	{ .compatible = "adi,adis16550", .data = &adis16550_chip_info },
+	{ .compatible = "adi,adis16550" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, adis16550_of_match);
-- 
2.47.3

