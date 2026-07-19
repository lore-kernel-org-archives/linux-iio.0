Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3193279DA
	for <linux-iio@vger.kernel.org>; Sun, 19 Jul 2026 00:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784419739; cv=none; b=IwcY6ayOK87oVcYRg7t/zVc11bnXu8QyF44Pg8pk1vSFFYVah96vO5bJmUTtoygriAcYcN9kXYBjlQtcJZ4/5ReJILhB2zdeyk9VPiYwcQe7x4xv2hOQlJJYjOP/xcOUJhHqPMvg1Iwu4fAoaut+qzRquBV5a6IgScNthpyx+WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784419739; c=relaxed/simple;
	bh=7D8/SUNsLqJeWmAc6/7M650HPOnCtrqgAwDdxP/Awdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DYdWKSJZ2qJLxeIl6BjnX4FNJ64IzEcWXRH6Z0ijMhmiasJdEjBMM6Rw0n56aNKpE6yDtOerEDoG37dMiWVaFrQwuMO8QnDnJC6Vfdj4ObYGOMQSszOFkRhJx3V4MD2drAomA81MrSlwyud+aftOwEZMc0juFQdxqtL7mg0Gm30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAev/fB0; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAev/fB0"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so3443051e87.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Jul 2026 17:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784419735; x=1785024535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V3noO0sro3v6wdXAQL9ZZ57Lcl83tArU5b36o7WZkR8=;
        b=HAev/fB0kBpxx5GaHOp3B9ae33qHPRuRa84ShYV1ZHuA7nxmbzxQZq6EY1Z1Z1hLrg
         dI4xxNsX4E1VsPYmOBM0RM8Gj8nswZ45qWaZBlYakDRuR34kop39dfagaXu+RU2s/DdA
         9TazQQsswYgNAN04ApAD7DN7uI7qIKubJugSdkv/S3gJlxvcU3MHcqF4nB6Cos1Lq3oc
         JHl+OPTGlwKqc3Es6hQG5pUxGs8SWP+Est+3d4yIPN0VncIqTpYtjITY9+3GI07cOIHI
         iv46o2qAvONIbz2vGX1quoLre+dS3McElK9iDPHjYYK4zyerpn+1EEkXY2Os4cFF/K02
         RqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784419735; x=1785024535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V3noO0sro3v6wdXAQL9ZZ57Lcl83tArU5b36o7WZkR8=;
        b=fZ66LNRisuSSK6NNtZtWir+GdOCco4eVl4Xt8PWw7kAF4Wt6038EJJ7DNrMZnAjw6z
         xn75pWhjD/xTOe//A5roHkSMKOaBwBJIj59kB09lcp2fTSZzUXc72tjtvEVe+FhPJDzp
         Vdb+jCLt9E9ir6PXIGTdWURDCWA5xsU/O5SXu1c8wQgitAc4hKYB5sGEsrHpm1aPZufo
         ilKrWV+4l1d+pPYe9+z2l8kn4yTxI3s+gEIwN16WjhQlieG5lmO2lTUTFbisT79gtBn9
         fAIuRXmd6uD7xOfjACgVFRl3L8rO3OkKumLHrFlQKab1Z6H4yViY5pvQq0isudHGH69Y
         rkzg==
X-Forwarded-Encrypted: i=1; AHgh+RoQp2EoEX70F3a7ipIPv3Z+Izqfq5fDLHbm51Ilvu163OFMeTqRpLxJQL+OJsAKVIt73HtRQYzI39k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoYLj6KsGaMoOiw0dZFzLR5cDhd0UnuKOejgHqhSkp/2jUnAn
	h9xZTIQLDyUTLa6TUCV4c4TE0oL+gmj5c82LLzyXv65ni6xo4vMwgcocNDdfiyL0
X-Gm-Gg: AfdE7clNJWFLeGPUbHHAopgEgtkUDimqV+4ZZebZGMhLP/glN8AXXPtsYTSUqvPlNnu
	eIc0BH9ejuogZrLFrKV9er9WXZVWL/MtTe5y/kv4epXgedQWY2ZP8Ds9fvIjMQa0diEJMu2WgrG
	pZ+7Rzq6I7I6MLq3iFXnSE0JZyMONMG3NgQLqlG1zUCx/ShbDVei8ks7HCwikqsv1/yFs4R/I6T
	ZFE1RHj7vLXQ9i7M1O1US52klx/vDGoCe6hdxmXdG6GLP4Oljtz7xdzzYw1JlKCiI7yBpyWC6bk
	vYupzewRu7knKxdl0FyxWvoTmKwywZHjTlkKbWX+1KoBmEWricKRJpKJ80ZT04f2UcMCyEadnoj
	CJcQSMna2i1EAUbcpNXm2COp5II04ZFPwC5WGaI60TeItC4N5ei7YV9aJ6vQmdtWWJxwKAQr0ff
	wdaOpJ8XAYZhnpqO6ci5hhNLER+Aw8lu4ld7wql/d6ScWi+5xGzESMORGXxQUT2JRO1w8ulHjcc
	Q==
X-Received: by 2002:a05:6512:15a7:b0:5b0:215b:5de8 with SMTP id 2adb3069b0e04-5b28fabd8f0mr1772058e87.64.1784419734986;
        Sat, 18 Jul 2026 17:08:54 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291e0eaccsm1324841e87.38.2026.07.18.17.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 17:08:53 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on ACPI probe
Date: Sun, 19 Jul 2026 03:07:52 +0300
Message-ID: <20260719000752.75936-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the device is enumerated through its ACPI HID (IFX3100),
i2c_client_get_device_id() returns NULL: the ACPI-derived client name
does not match the driver's i2c_device_id table. dps310_probe() then
dereferences that NULL pointer in "iio->name = id->name" and crashes the
kernel during probe.

The IIO device name is always "dps310", so set it directly and drop the
now-unused device-id lookup.

Fixes: 72ff282819d0 ("iio: pressure: dps310: Add ACPI HID table")
Cc: stable@vger.kernel.org
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f45af72a0554..45bdb8c7670f 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -845,7 +845,6 @@ static const struct iio_info dps310_info = {
 
 static int dps310_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct dps310_data *data;
 	struct iio_dev *iio;
 	int rc;
@@ -858,7 +857,7 @@ static int dps310_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	iio->name = id->name;
+	iio->name = DPS310_DEV_NAME;
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;
-- 
2.43.0

