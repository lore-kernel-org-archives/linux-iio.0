Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A191444682E
	for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 11:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385429; cv=none; b=hgspqFyvHBlQ9zoefKRhcnixgf4ch+//RNN4Om6/9NVUebR/a3jLvAgdeh4IgmfG/0paUq1SeqODcx+Fv5x2dHnvKSGG7xYkNIutsMDce+uk4av8Qg7j/OUVxb0Aqqwbn42w5/kbOHRRU4/aZexUBEZ3Iq7F3Ea7zyiMDyPX3+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385429; c=relaxed/simple;
	bh=TU4JVaasjIZd7t0vMZCemM1pDk02dJBmznDPukWE0yI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YfQR27IXCB37v/UykAK8ZUXYlGJi6YP9x+sT8EiErN1LN6zYmRcRPNI5eVioApPbfoG8ouB820uBU9lpcWH+Nkxr/FBhFjANI0K/9n4PKBa8j0QqhvB0trTLdmSsZCzI8CTP+6TCgVt0jS+RftHXYSo4L/QU2lYTIScrpm40Sg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kS+J8FA3; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS+J8FA3"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so2002275a91.0
        for <linux-iio@vger.kernel.org>; Mon, 14 Sep 2026 04:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789385427; x=1789990227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sGBFxtH4+r2rt8dp4hP7icwkPNITskDS+AT0z1/Kycg=;
        b=kS+J8FA3sUzINznR+8mcJ+oSicZQ/HpXqAY9Aty9xANNw+Ep3USg8Ys0H2RkVbotPp
         7VLpfqcR4aEpH0KrD1PBgZCv/LMR8ABEb3tZeWlOu4BcUE0QYqQSMdxEhJsiQ+l+W4ff
         peUrRZnhqIp2u/tKJeqMm57pfX1TzZR7mqUElqAyPKaO5TBaaIdWyCb6vreuI1kk/9yR
         JPn4lTe1iB0T0T2JWydjhPSDastJ0FgNKy7jRUZtLF78wFSvKLae3o/W0WLIdjAV3PCi
         +b8xAqqYNq8qycYrQc3A/FUKer9rGpJPAOfWe2eYBa6YCfEw1icKckeeue+OhEVHsK1c
         GsaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789385427; x=1789990227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sGBFxtH4+r2rt8dp4hP7icwkPNITskDS+AT0z1/Kycg=;
        b=sHsnDyKHUYDsQDSPj8YuL2DnYU6/YD1Bjf6R/vXsZ0VWm6fYDTnnwcNe6kVIeVErM+
         qzqOd797T8xck5N54EWTD0DB2e5p8coxU2ymz0EVsN9tfqPLRKyfHr7k8fgLiuAwLPPI
         e2GZyA78JvJE5BRqLyFnRipiLLFoMfZvUcqiSzzQakjFIUbWlArcSFWRj6J+aAAifUF3
         0Ag9X2NgdYMQoE8/hbPch6GN9C19PR+b/+Uk6DlOisbV//LOQ4w7ae8sAMEpAefa4+T0
         2ZvcCTld/4cdQ4SXVY4KOUGu7f4XSBvvtG7iSaewTZZ6Y5uhdf5n7iVOPAs0UcupmlwY
         KVgg==
X-Forwarded-Encrypted: i=1; AKwUvBziEXLvS0EebnFtDwN4XATbd9Re21q3M6Ygezd4pxB1IHCtm2fIj7YFtyouh01EPSFtTiV4dBB9pEg=@vger.kernel.org
X-Gm-Message-State: AFuF++k9N/OzTr4fejmmpHdY1wl86JSi38WS3aa1pnMa+4SlcJuLdSjl
	HyoYvwC7zbv2EK7RBtL9AZvS4k74XWFVBna4u1W4K0C3b2LmJtWFZcB1
X-Gm-Gg: AYBFou2Mus0bIDHK3U8v+BdzgxqGeZZWqcNEEHgYzBes2kx9muyTgF2dzRbHZCHaOIT
	TEEc6jp02iliag+U0tNZrNTVnqy3EqK2XqVotU/i9u6Z+qwrKF9J7jQ2mkRr1yr5NWFpL7emm8S
	pNeY0EIgvV79tf+hc+7QDpZD8a9amoZsGUiHjt6vZpvI6VAudw9OavqMDjfnxq4O43y0sGx+PwX
	Sfion7OmMWS5iYffEC8+AX4tXGxed/Kc4nM8JQ8bq+QmbnLKUD+bbeejm+KGBVvSWOJcCqX3gB6
	NuHeI0tNdshCYjAqApZiB7m8VBzMAEYQAkxcEBhFvF0D08WdwTSua8NK+ZorYlP0hhBwQeBecMS
	+Z/ekE8xYSZFCDNl5uvN2FjrsnXfcaznQtT359ndzhjYxI73c30L4ZN55v/HWE2UYcjMD4Hjtog
	AEOrjqtLmvsZZgogL6+gJWkSv986A64ixu0ormuxtN1wjI9+ddBjEfHJ92KBu4+g68UA==
X-Received: by 2002:a17:90b:3ec8:b0:39d:e43c:5a0f with SMTP id 98e67ed59e1d1-39dec059046mr4410018a91.14.1789385426686;
        Mon, 14 Sep 2026 04:30:26 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39db996bde4sm14562532a91.7.2026.09.14.04.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 04:30:25 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] iio: accel: mma9553: disable autosuspend on remove
Date: Mon, 14 Sep 2026 19:30:12 +0800
Message-ID: <20260914113012.1688043-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mma9553_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
set therefore leaves the runtime PM state incompletely cleaned up after
the driver is unbound.

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: 40cb761306d6 ("iio: add driver for Freescale MMA9553")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/iio/accel/mma9553.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
index 8e7aaac89d47..5a36d415a837 100644
--- a/drivers/iio/accel/mma9553.c
+++ b/drivers/iio/accel/mma9553.c
@@ -1136,6 +1136,7 @@ static void mma9553_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
+	pm_runtime_dont_use_autosuspend(&client->dev);
 	pm_runtime_disable(&client->dev);
 	pm_runtime_set_suspended(&client->dev);
 
-- 
2.43.0

