Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6553D9C8
	for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991387; cv=none; b=HEbyp3jSz+9U9v1J9WdlTz9HEibS9iKNaH28SgKDQk2RPbtuRCTd/sHNIdJmFARJBL6BaPqpjB6gFSOntI8o+5O4/e3WrDC8ktdkrLY81AOU0ljDEraKe1q14Kur5K8HFOgpmP+8CofjDuGdFwnAqFPxD0VIbHb0EgNwQSnGNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991387; c=relaxed/simple;
	bh=kkNXuswEgK1DVfRXX9IU7JdGeJEjQz2f1JKMtY1WmhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nN3stxUDauImC87e322qlAW8ubUPOG1jxXiYpWao3ZU0RBsVoaP9MdaWEHQufzmmDz5ig/Aiy11TzKHFqS+nrR9V1ufb35/WPIlt/kFC+j80Mjne9nSzFgn3/0T100UIOys2UBrNvTMlqe0UJEYdQ+78KlfdTjq59s6TuQllm9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JeK1VyoG; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JeK1VyoG"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-141395927feso8121523c88.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2026 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791991385; x=1792596185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2sw4OGnnm2bLKh/dUSLfjPCbohHEUNyHByvYgBWXWv4=;
        b=JeK1VyoGXYT1BYiM5ZjSso6rI33ESgViFAMbSIICUVLfGhJD/RlNmRaB49DZysKSWi
         MUX+Lg8riJ10gKJo08koP9ZmeP3OXGjl7Tb965/Eb+f0FodINXC/oLusiJXaWHvRzcpm
         qXG3FJbtR/otvvZrzzyYbFWxAjTICk+NfxK8/5B5cWrI6v6bs1HTsvsuZwjDwDhsFUkB
         0DdHEQb1M2hzYaBn3jmb8SEDJVOSEE3nNo0vW6wN+hqe25dMobUKL7jUnWlPdS8PjdEI
         xmXO1nR+z5kE9v7cOCeexRLNkoEAV0eRThnlYlYMgYyLPdHHxlhLcRLLuMKkkprOuppm
         yGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991385; x=1792596185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2sw4OGnnm2bLKh/dUSLfjPCbohHEUNyHByvYgBWXWv4=;
        b=Q14eb2P189vDLd/B7DJNyRs/EqN5tZwZ5L7EPVbnN8jQl5/1ZpTBgIMz/7ZtFB/g4k
         8PgdyUu8ftPfGF+Nzq3wlpQq0vomOE5HD+SdxhUlUFab3UrJl7H5QM/BstkKo2RpDFdL
         U12Fe9T28hF3IjQoKpQjNqUJAP/4eZii6aMKaJsfwfJhZi7Nthm4DOhV6uAqMNs9KoIQ
         y4GKlT52LlWBu8nlIbFEyUD9YGTJX/fvzQXC5mBJZ3ZSo/LEqrKUTtOQ4wOEgatFAQyI
         E4du2ApYrM2fTn4zu9P7EFvOiw1HruKZOIyF7jrcJJLtuwGkgG4SQTka1RwnSkQyebM7
         TSjA==
X-Gm-Message-State: AFq9FYLI0MPn9Wv9UqOzhxO1UsyO8PgBOGiKkg0XXw1QlI7ziSfuGWDO
	bogRDnnTbCndf3mrzviyQBq/Q/eizWN4yp2xACygFrDIMAfvnPBIHN2/VJvpEI5rlQ==
X-Gm-Gg: AYBFou2XAkOtrCVaGC16fsczWwsO4se4m+bLuJh0+jQZHkAHgfjKBKwlgHJ1ailcZmZ
	+bFoXgxgASdsP0VFL6nJ9J7MzQxhMkR71J8thZrV8Kun99/aEQVkrszl6jy030b/sc1X1l9wwyS
	VcA5mZ8DF4Xg50Uwe0dVoTlAQdsrqjv8Q3YQA9848Gnqb+7XDtTAJUEPDymN1fkZOq9hBJ2p6i1
	hlPbp1ZhboA9+ahcWMIMZO4/4G9D3IMj2GR1GE30AhsvuMWtPHNIyumiORF8WsWcvUJMM8wWfE3
	wTdpLVEnNuWuG2TCm7kaZivv5xf+G0IhYc3B99EEcC2s8rN84Nuixe7H8xjyLexBSd93oxQs+cb
	8srQ+Ox/bTedpXCfxXZKPYH8gXQ1KRkBOkiMtlaTuEExzxw3sGMagFrN+E/uh/Evl5TUT/ysmcP
	sYXDC2ITBF98sHXGU0p4T7GNwnAJkuaK3u9WWQZnMooQG5UKvudrCZ1ZzzUFc6VsOxdzib3zBx+
	hJePqlLvrm5ATbHZDRbFmu3TzFH2hzt/RCT3U4=
X-Received: by 2002:a05:7022:ea56:20b0:176:a225:e364 with SMTP id a92af1059eb24-176a225f2a2mr10716902c88.35.1791991384919;
        Wed, 14 Oct 2026 08:23:04 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.171])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a3f6186fsm50742326c88.14.2026.10.14.08.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:23:02 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH] iio: ccs811: Deassert WAKE GPIO on error paths
Date: Wed, 14 Oct 2026 20:52:50 +0530
Message-Id: <20261014152250.8324-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure the WAKE GPIO is deasserted when status polling fails or
the data-ready timeout expires. Early returns could leave WAKE asserted,
preventing the sensor from returning to its low-power state and
potentially disrupting subsequent I2C transactions.

Route error paths through a common cleanup label to ensure WAKE is
deasserted before returning.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/chemical/ccs811.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/ccs811.c b/drivers/iio/chemical/ccs811.c
index 998c9239c4c7..94c83937d1d7 100644
--- a/drivers/iio/chemical/ccs811.c
+++ b/drivers/iio/chemical/ccs811.c
@@ -198,20 +198,22 @@ static int ccs811_get_measurement(struct ccs811_data *data)
 	while (tries-- > 0) {
 		ret = i2c_smbus_read_byte_data(data->client, CCS811_STATUS);
 		if (ret < 0)
-			return ret;
+			goto out;
 
 		if ((ret & CCS811_STATUS_DATA_READY) || tries == 0)
 			break;
 		msleep(100);
 	}
-	if (!(ret & CCS811_STATUS_DATA_READY))
-		return -EIO;
+	if (!(ret & CCS811_STATUS_DATA_READY)) {
+		ret = -EIO;
+		goto out;
+	}
 
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					    CCS811_ALG_RESULT_DATA, 8,
 					    (char *)&data->buffer);
+out:
 	ccs811_set_wakeup(data, false);
-
 	return ret;
 }
 
-- 
2.39.5

