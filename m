Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05013E0C46
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 08:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178424; cv=none; b=QmmEgc+mZgSNq1KPldTNH2ZjlK3uCXehaX2CBrv5mUq6KFY8f4LOFYro8IrgvOVJBccW6e9C5zwfAapjqz0xpsV2q7wrwS4CNZaQhhugzR5cPm0MLQQHPxf17y/NU02izA5pM+R2huQojKeiQ9MzUTXfZ5Yfdk95FxYpce4geKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178424; c=relaxed/simple;
	bh=GTjiSaXBWRHQVNgyhtbnVY1dqwa+QlU2g9/nY75c4kM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EG7PPxOhQ/Nqgv2pVa9lsk8wSvVVo0JrNewkdq7EjS2G0II18kRaKkNgcTwot4mLm1MhragCcH2AlbHf+TlDQwgxMNzwPB+/6PR5+qrwndLcVk7gZoXekNNkXuOadFduVhBbga07kf7Y5XsYWY4QkQw+A0UTey/CAb5rZqHbtX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=W3mdcK2E; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="W3mdcK2E"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48e82c23840so25080565e9.3
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 01:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779178421; x=1779783221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gjB8BJUdE0f5o7s5s8/U32odGzbYP7pjEnkn5QVT1gw=;
        b=W3mdcK2EMYSl9cEGQsHOk4bDBYRu+JVPYrJ2jgdDcmtSJpyo0ZbeKm6PtEItjNTusE
         /arYAqp3ndcjk5dMRlpTOhY2whqQ8Lr4hs8UcXL0NhvnUBla6L5H6Yd6v5By30p7zjHB
         LVfGd2J4Kyhz240AKMc9kFrRs3RINlhqH2yyyTSAehzjh2wcySM5QxaZjk6GgHamg927
         ceIqm0bn0C/Bz+Cs1sJ2s1fWc71rnFn2z4YjlPV444E73evNjeyUJeyCxlAhcI87jJxg
         tz9uMoVNrim+ra3t2cBMYGZiRyjMfNd+5ZTqF78oAAx0fj5FPNmPH3/JRZou6+sikPN/
         skbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178421; x=1779783221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjB8BJUdE0f5o7s5s8/U32odGzbYP7pjEnkn5QVT1gw=;
        b=pJA7Nj7fWyyR79Ri6MtxCvhaRjPCadsrp6/ThKZ1lDpIwujLGDxGsN1xj+OrPbdGlc
         gKQSN/HZKZSvqFiZ5p8YcpV56EXdrAo0vQcIH51KEXPhyGvByiy3cB+dTJ2WCaxjsTTe
         EzgkU30jHby3FG9M7rf48e7QBmmxbn7y/q0x4lVVD1NlVWIV6VibeXn5Ym5CwGDB1DnR
         k7U+xW6tkjBeqoKzW3vf7eAIMEFu07BE4a/NuOPtQhJemXb/XTlDrQ8VqMz1w7SbUDbf
         4fEDq80eqICUjW88wn0CKiw/d62VI904rR9z8Gd0tNRKVa4OiJiHK9IIPCyErq5V4YM/
         Dkmw==
X-Forwarded-Encrypted: i=1; AFNElJ/ybKcVUNHdmnXsKQleRJopFfscEHYXuVQojjVTz6nC4kAgU2b/99n/9xJ6h/GGhJtCUW0UVx565gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPqsx/2EWInS6rzpS4uD1nhcx7w/uxCGBo7G7SCjGw98kpPYpx
	PNO8z0yMIE0y/xwBY5OyohspMFUf626UNB+3IklEYOc7RBV+vbPCeuxBz63YxLU+afIdYvOh7BD
	F8HhRZuw=
X-Gm-Gg: Acq92OETPWKpNr+U2iTibW3QgL6Ccl7MdXFj+3rNhpRbXSK+V0JmxgguhjmlbkXS63V
	xcaBPoy2dJ3WLU1wSYlF5qYAHF/QJQQHCCdWTd6HAh0x5MECMjvsiG2H/QmxTJDqIOy/b8Uc/cp
	J/dnwR9nv9pIBQrQ6f5x3yYPLz7xEoqiv4wLH6kEDJWZ7qvF48yAeKFFDWegx9M8yXvNFrJS4Dj
	5xxPkhKDei16GtstSC6PNEfSnzUT/4d7IIJBQvYbcXLLLwC8QVMQStmhh7bd3ddU6bZLaNrjq28
	7PbYQdKmNfBm8hJgZulMdy+c1auAl/8O4cm4NVjSO1NGUBeLFBwJwRiOE8QdNYeEVgq/hYu0ud0
	JR3mBap6chJCDt8BEYzpLKZhPW/hZpzhMhc4ICYg19VlU/ArKkf1ltg6MVfysxSqlsML2dISqdb
	JzVufN4Jb3Mo53yCweZ9SGuNaadTl49OLaDuvqCuvAes8VOnpYFCL2gempw4BdAtAYzp+wsJDTA
	EgdqYyIusjalDN7NwAyAx4hZw==
X-Received: by 2002:a05:600c:4e47:b0:48e:8345:6f8f with SMTP id 5b1f17b1804b1-48fe632361fmr297861925e9.18.1779178421007;
        Tue, 19 May 2026 01:13:41 -0700 (PDT)
Received: from localhost (p200300f65f47db0428dec7b135f55767.dip0.t-ipconnect.de. [2003:f6:5f47:db04:28de:c7b1:35f5:5767])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-48fe53767ecsm280540595e9.10.2026.05.19.01.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:40 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/7] iio: adc: ad7091r5: Simplify driver_data handling
Date: Tue, 19 May 2026 10:13:05 +0200
Message-ID:  <2464690a0a70aa65880c5c61602b52fc9ed9d69d.1779136001.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
References: <cover.1779136001.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1444; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=GTjiSaXBWRHQVNgyhtbnVY1dqwa+QlU2g9/nY75c4kM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqDBugex+Le0NCqtuZ7rmhHUdahzpHaAsaAOlaa H/Wtq9+Kj+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagwboAAKCRCPgPtYfRL+ TisKB/98g336T8UX15O/1sT4Qryr2GUn6OU/ZqZDBiGu+y33EWDpk5SjZ9QZeM/O5syio4/UBVV 20kkBbT0PB+wQm0Oew92WlFILUs7EeuDDW6PCmqf1tQBerlS2RmEAMKZ3ye+XtYm0u3FPX1987p Fzn7fYtlJYxGwUKRY1UZrBiMgqe6V4yNfl9WfxI2znachjdn/tKwWS4BjWpfwoA5wKdNxTH16a/ EQwT1K0/KJbRt2TEY2VjxNeqwsk8+FvOoFXBAaFKveoPngyAHDKOhz9JQALenIOuatCFeYG359U X6RbTeZ2EiFRF8P2Up3STEHk0a+4woOj/ohn8T9yB7iNB1/q
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver only supports a single device type. So the return value of
i2c_get_match_data() is already known and can just be hardcoded without
type casting. While at it also remove the unused .data of the
single of_device_id entry.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/ad7091r5.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad7091r5.c b/drivers/iio/adc/ad7091r5.c
index bd4877268689..7bf7d538abd9 100644
--- a/drivers/iio/adc/ad7091r5.c
+++ b/drivers/iio/adc/ad7091r5.c
@@ -101,23 +101,17 @@ static const struct ad7091r_init_info ad7091r5_init_info = {
 
 static int ad7091r5_i2c_probe(struct i2c_client *i2c)
 {
-	const struct ad7091r_init_info *init_info;
-
-	init_info = i2c_get_match_data(i2c);
-	if (!init_info)
-		return -EINVAL;
-
-	return ad7091r_probe(&i2c->dev, init_info, i2c->irq);
+	return ad7091r_probe(&i2c->dev, &ad7091r5_init_info, i2c->irq);
 }
 
 static const struct of_device_id ad7091r5_dt_ids[] = {
-	{ .compatible = "adi,ad7091r5", .data = &ad7091r5_init_info },
+	{ .compatible = "adi,ad7091r5" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7091r5_dt_ids);
 
 static const struct i2c_device_id ad7091r5_i2c_ids[] = {
-	{ "ad7091r5", (kernel_ulong_t)&ad7091r5_init_info },
+	{ .name = "ad7091r5" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad7091r5_i2c_ids);
-- 
2.47.3

