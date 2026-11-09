Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243217;
	b=A+4HR4/geRKcS85hqSmEwdf3WAm9g2XIZILhGDnSO0IqPgM8cL+gvmoQvRwnQcuV+pUD
	 DT2eDKAKagZrRsheLoxPuP0/stb4DaBGq7lBvZZOX8rK8Odks767A6u2xzPgnldfSNZiB
	 SYzEQpeQ69xC5JWk3G3HQqHbykyRQEPETqPXxKKkbemsq/EpahzbuuvU0wHuXoH3PgsCo
	 cIPA766HbWBeMbH9z2T9a0yFGN79xwGUgMIwCwXXe+DcLFSLC15vKExG/IrZ03buaS2gS
	 gJHKbZ5eMrKKE/CwyVBOxh0E8i2qpOSNMVtoJYeg9TL5OQiERZ59MczB4keWtcKq8Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243217;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=44v6KtyQHlKDjxBRLz0JvUcVR/HFDHmdgJx8X70B37M=;
	b=uHIeHpdh4gMHyK0Fnmf1cgnJO+Yln8eMsseEbyqoTtdnpEBvSQQi4A+zJjiit2rxKtnk
	 I7aX5XepbYQHC5ZTBaa4wjZVhf5CDNm01psQ7hDmGEmpS+84fK9Th7kghj6yc+ZYdPoUz
	 Pu0hhqLdtTPN5aBVfqkU7n5zBlMfb5fCRYY1P1Gah8wdfrQNdxY/j0MeDU9So09FqTT5o
	 r+Wuw+6xdblm9w7HQ/z4EaDPZuoTpgqUFFXulSadzVs7xgX/Ew0t2fBKyyMN0A7CBxAaW
	 9S3Fhf/GRZGsxlZyxvxET+/ze46qljePXV9HFAiSh/5PbcpyoYnM71KNSpKE9OuFZZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2VyakrY;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0085D606EE80
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:53:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0085D606EE80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h2VyakrY
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso554435a91.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243216; x=1794848016; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=44v6KtyQHlKDjxBRLz0JvUcVR/HFDHmdgJx8X70B37M=;
        b=h2VyakrY6Q86h0CPS7bV18MQ0sFP1t1kVU4cl4jyCkjP3WFSB77At3DuhrYg9Z7zam
         58GIOXGcmTafcyfX0mcEVK3eE5rV88pYr1RLirXGN7oLMlBdpvsLgA5mpyljlIl/1RuP
         obtLufU2TWYYO4Q8BCqLQvfa1UnWHaemPxOy5e+VFx3JsjI0su7AVtDehT2he7tOG0xI
         cG2S/PDW1tPDavoyY8hzYHc40XNuzk3j1/y+rq4sq6X8BYy2CV8UNXtFdC/uizHoKf9S
         vD0IjY6uInsP4ODO503yCjq1woUkXT+zQP48gVhvTc9tzXw9g4OuPQI1556oHc0AdUoh
         zLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243216; x=1794848016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=44v6KtyQHlKDjxBRLz0JvUcVR/HFDHmdgJx8X70B37M=;
        b=S0DqmC4/yHu2WXIq+OE42tDKPyaf2iCeHAgTpvAZiyh0ZTYqv2ZWfSOVg/Jw88SwkD
         yZX7dJJ1PgPbtP9c9FaSfboMJ2JYGi5pShiQHB0mYMIMHpqD4QPet8yQAHzZQIroicHs
         Hor3fbN3rlSmOJ6D8GzAD1Ji2AxQFUhVYiYBGrY2PQxtDqIUvdZelvkYBqtXn5mtHbS0
         XBnyvmCAbzvryyXcH4opXVotrQGV3JgxBbLhqa6lVgm76T7cENHuaZGHx1JIILLx5hqp
         dOuG0ZTbndNt0tCaYzwpYbRWwpFxYXrdWMkVDsO17p1LusQWglmmwz2sff5BkE6vri7J
         80NQ==
X-Forwarded-Encrypted: i=1; AL+hErGCWqnbjYLzf8O9czr0oSqeSLDB39Ikf8OMYrOgfrcCsKjuN9fG3leS7t5lQbwRSsjU3KMV62kg04I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WCOf5sXF2Aw3f2hvkkUJ9nNHecyfhnc5SSDS0dB44Q3Lh+/lQ
	+YXyDxXXfAkpRj7Lf7xc7qN7f1Ao0o04S1t3zPyalrgN1PdCq+Y4VH1t
X-Gm-Gg: AYBFou1+BR2DCPYajoTBzba4q6jaM9++j5BsYJtrjcxl0V+xH+GsFSSTSJsOWu60uYm
	pGFWVXuLQBOjegfwc2g5bIWrw6oHGI5Z8Fk+8/pp4TV7HetG3Is599m73jzSE5rtH7rWECdA1SC
	nPwvr/MPECFJ/bdTk9H3r/kVGTGZ3oMZTO+JVoPq4fgzWvtTLvzwq1Nwn6x/WzaMVxGKZNuqhAO
	zCPDrA5FZWMRjFgoYOG8Y5oMXFoR7I7CAKDWvpkknQ/PMhGaPm3Dh7/NMvaxPdo3vSaQcPtoa0E
	XLoHwuUu6f3jWjJIwZNjRCc65HTWwsRgOBvewF6HVV4/MRSVxdqR9zhviP/NfjKKCUkKeAsC8v0
	OnMt9WI/2XzAht71hkCxSDDGPq+KOADMv1U8tFtzIISKE53dMn9PaAsNSGMy3JCWrXDiEniUh+p
	9RZrCHmaEnPW94D1XrUYgOO5T+HNsZyryWtpd+vHpYcStXB+TATNMV3iOcvapWhzirpGAKkVPTZ
	/CFkG05QT9qVNfMubiYrGgbP4Grm0u2DOygh6yJ4/enXb90OkunvMStZoF0NGjDkMj4Zmr27+Un
	stQorNBBYyWaGevCAKsG3rLFNf+d3SioRd87XKJLi6KAjy13Lsn9iO4GZKUzmU3mQiYUzZDTGpe
	zOMGB5A==
X-Received: by 2002:a17:90b:5101:b0:3b0:934c:5e41 with SMTP id 98e67ed59e1d1-3b166caf0d6mr242689a91.29.1794243216288;
        Mon, 09 Nov 2026 08:53:36 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm6455688a91.4.2026.11.09.08.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:53:35 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 05/11] iio: adc: ti-ads1015: use dev_err_probe() for error handling
Date: Mon,  9 Nov 2026 22:21:33 +0530
Message-Id: <20261109165139.30803-6-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165139.30803-1-architanant5@gmail.com>
References: <20261109165139.30803-1-architanant5@gmail.com>
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

Simplify the error handling paths in ads1015_probe() and
ads1015_client_get_channels_config() by converting dev_err()
calls that are immediately followed by a return statement
over to the modern dev_err_probe() helper.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index d18a2ac1205ff..9fd07ee21ede8 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -896,18 +896,16 @@ static int ads1015_client_get_channels_config(struct i2c_client *client)
 
 		if (!fwnode_property_read_u32(node, "ti,gain", &pval)) {
 			pga = pval;
-			if (pga > 5) {
-				dev_err(dev, "invalid gain on %pfw\n", node);
-				return -EINVAL;
-			}
+			if (pga > 5)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid gain on %pfw\n", node);
 		}
 
 		if (!fwnode_property_read_u32(node, "ti,datarate", &pval)) {
 			data_rate = pval;
-			if (data_rate > 7) {
-				dev_err(dev, "invalid data_rate on %pfw\n", node);
-				return -EINVAL;
-			}
+			if (data_rate > 7)
+				return dev_err_probe(dev, -EINVAL,
+						     "invalid data_rate on %pfw\n", node);
 		}
 
 		if (fwnode_property_present(node, "label")) {
@@ -1018,18 +1016,16 @@ static int ads1015_probe(struct i2c_client *client)
 	data->regmap = devm_regmap_init_i2c(client, chip->has_comparator ?
 					    &ads1015_regmap_config :
 					    &tla2024_regmap_config);
-	if (IS_ERR(data->regmap)) {
-		dev_err(&client->dev, "Failed to allocate register map\n");
-		return PTR_ERR(data->regmap);
-	}
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap),
+				     "Failed to allocate register map\n");
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ads1015_trigger_handler,
 					      &ads1015_buffer_setup_ops);
-	if (ret < 0) {
-		dev_err(&client->dev, "iio triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "iio triggered buffer setup failed\n");
 
 	if (client->irq && chip->has_comparator) {
 		unsigned long irq_trig = irq_get_trigger_type(client->irq);
-- 
2.39.5

