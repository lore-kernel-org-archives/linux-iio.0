Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDB38C2C3
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453265; cv=none; b=lnMsBJUHEksLBVpAJNSRqjDaqSPSdbo4TvUokFpquJUwiYFUbcTa9dcfbE813KjfZkZJ9WNdoSFn2BDvGPhZwxMwNvxJu7AoBe+4NzogXsJpciMoZOy+5vKAIXZRFYcFHTzKo1afAEERMFqNPOWw5Hi0A3OeV7sXDt0pMij0+cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453265; c=relaxed/simple;
	bh=upzag8qhKi6aKvj4oazaakxR+C2DYD1uVCnLUQ1r2A0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqVN7kanURQzyMe4YzpKcAKoXw2Psd3Rcbkgk/oVKvsgSIDW4cfxB3oUsK1X62BVim1Pw7AjEcKWIQEG1D5/iMUaO0G69ZxXhfh3Ha5jZ4yoLVA07Tr7yK0VoPj0BkmjQUQHm1x2d6fqJp/Ox5kCQe0R8UhBdAklxNAoYs8nVq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+6pZCds; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+6pZCds"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49041e84237so6929625e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453263; x=1780058063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YX8b4V19qziyTb596TiLv9FQnlA5Iy1jj595uzVils=;
        b=D+6pZCdsXOS0cpj6yowI3HnZjIccV8iJFxOXzYtbzP8h5ZZQgQsRq2xpoi0P379KcT
         gPlM0Dv6bYsRQT5v4eGG76FqAZQtHLYLH4gTkIlKxID9GWS6dh+y1MauLd+2augTsdga
         trF5jlM7Ctn3gC1FMT4MO37AobNuMNCYwrWqPaItrnrurZScHp9T7rU3gWZl6JfQWmKg
         Xstok02zfIHDBFLehM7Z4FAYABqJip3higQ7Hh/36wYNyTSmrC69NOU4KZDbo0+ADmhe
         2TGR9D5+LwIlPNotxAj+xyqnhGM27HxxlAid8JgxpMwJZytQgzp2j4DjOtDVf1IJgxFp
         2Ogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453263; x=1780058063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2YX8b4V19qziyTb596TiLv9FQnlA5Iy1jj595uzVils=;
        b=f9+BCDHuL131njyt4PenegtcYSOYfQAneP7DrQorUyD7TrYgMCtiSqO7ZBcaqHUSBW
         W3pYnmVLtdm4G1Aw8f6nfyscaYS9D6aPleirauMZgSWwFJ9kqNoFlqljbUXcvQrI0iIm
         THHOjMWQyjsej4f4zMqjyBGGV0St/Y9HpzynLjQ2PE2VFOl3qUHAZK5vGPIktNiyslGd
         0ypzZW+CCOSk9tZUvgizoUyVCAjZuP/us3IYJGNmDKJ6oFZsSGeMy01OGDRztwvBjSj/
         WM64yOK3JUUyyn999860EdhSILoEuIYnaqadiDxAtLeYc6hw/p1ZagC24829/axOaVuU
         5n4A==
X-Forwarded-Encrypted: i=1; AFNElJ8qRU2Z8PrDNkit5dVkuABW28oThq9AO/g9MtLO30nk+vuvWvsZEl7QT8i3nJpEiv60Y4DDbHzGIyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUgj/g8zaVaGF6Xb71nU6g96w6KG+4Wx+ZckDg6+4kFPR695KA
	k1Dtt2m75Zy2VPFzlXbZAonGht5/55l71uayNnICAiMK5m4A5BhCuG0b
X-Gm-Gg: Acq92OHxYZkbUljRPMVimYaN9LIVtjJaf/4tPs5c1QDMNTkySPBctR2tvSdE1uPHofB
	BmNKZq9EkL3cLInr6AvvoCWJxamdL8yLXkkkO85Q0VQCDiO33ktDc6RwdbQwmNfQvrUfpwncLYl
	hfgdwbaGi+n+IdmDpNCJEl5AwcAN2P6k0KWYKv44oYfVK6KUxhtexbD6bufz5aOhezB6g9v06Qm
	GotBrlJTBKm21btxE08jHIzL64zEqPWaj0bdUo5f+ctkZMMM29rp0iSV4IHRS0hEVy2J03IkIYJ
	CPBwtvgOFMIzUGsXz5/xA659kSA28IL7Yh5/QurYR/z74Ir9CcOmMB7lYGR+FN7CWWClLbkWS0s
	8XIckmmdRiPDrXU/ffe4riEcqzKO6RokBmGefNG0OjHZXyYDBn8KdLSvzgS0/RTU612q10ey7q9
	IMhJDgQ7uuSD0q662b95Sgro3SJBAT1Gk7p4usbYeGe9cUfT9k21yY
X-Received: by 2002:a05:600c:8b85:b0:48a:534a:eed8 with SMTP id 5b1f17b1804b1-49042260287mr39772245e9.1.1779453262348;
        Fri, 22 May 2026 05:34:22 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:22 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 1/8] iio: tcs3472: power down chip on probe failure
Date: Fri, 22 May 2026 14:34:12 +0200
Message-ID: <20260522123420.45495-2-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If tcs3472_probe() fails after enabling the chip (by writing PON | AEN
to the ENABLE register), the error paths return without powering down
the device.

Add an 'error_powerdown' label at the end of the cleanup chain that
calls tcs3472_powerdown() to power down the chip. The existing label
cascade is rerouted to fall through to the new label.

Move tcs3472_powerdown() above tcs3472_probe() so the probe can call
it without a forward declaration.

Found by code inspection while reviewing the probe error paths in
preparation for the devm_ conversion.

Fixes: eb869ade30a6 ("iio: Add tcs3472 color light sensor driver")
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- New patch: extracted bug fix from devm conversion.

 drivers/iio/light/tcs3472.c | 38 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 12429a3261b3..849ca7885d71 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -440,6 +440,23 @@ static const struct iio_info tcs3472_info = {
 	.attrs = &tcs3472_attribute_group,
 };
 
+static int tcs3472_powerdown(struct tcs3472_data *data)
+{
+	int ret;
+	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
+
+	mutex_lock(&data->lock);
+
+	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
+					data->enable & ~enable_mask);
+	if (!ret)
+		data->enable &= ~enable_mask;
+
+	mutex_unlock(&data->lock);
+
+	return ret;
+}
+
 static int tcs3472_probe(struct i2c_client *client)
 {
 	struct tcs3472_data *data;
@@ -513,7 +530,7 @@ static int tcs3472_probe(struct i2c_client *client)
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
 		tcs3472_trigger_handler, NULL);
 	if (ret < 0)
-		return ret;
+		goto error_powerdown;
 
 	if (client->irq) {
 		ret = request_threaded_irq(client->irq, NULL,
@@ -536,23 +553,8 @@ static int tcs3472_probe(struct i2c_client *client)
 		free_irq(client->irq, indio_dev);
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
-	return ret;
-}
-
-static int tcs3472_powerdown(struct tcs3472_data *data)
-{
-	int ret;
-	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
-
-	mutex_lock(&data->lock);
-
-	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
-		data->enable & ~enable_mask);
-	if (!ret)
-		data->enable &= ~enable_mask;
-
-	mutex_unlock(&data->lock);
-
+error_powerdown:
+	tcs3472_powerdown(data);
 	return ret;
 }
 
-- 
2.54.0

