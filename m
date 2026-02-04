Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185D610E3
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 00:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770163449; cv=none; b=iKt6/NopiA/P8EUDZzuzWhxKDTXxH4EfihJm68BfTBpOCR/k+2kpfId3d//FujRCB8kSe3NXnEg8IdOxX4Q1EhjaztPf3yPGsnnQlr8881IeH6WtnOvNnzB2/l1CKqCbjhwPZntgTYvHv/++dv9ztnhT8AEO8+t2SPp6Kxt7aSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770163449; c=relaxed/simple;
	bh=Vl1dg9WukJqYTPC06lVnpHjD0vsq/0gDvQVBNUFmJh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlekTYw/Yrc6bP/6Sk2ZLTDCo1GtdxcxOryJm1wDO47V5kmpSmpGxR5FE2J+zqA2BWQWNFMnV8SBkBLJvFvCZwct7HIELoEgd9vhQeHfVh2S62ckqU/ds4QeM5L+fTQTCPp+YFiA8HEaTc4t4Hnzpxd4jKaJPacmASUAH4yexxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cSj+L81H; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cSj+L81H"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c6aaf3cd62so680609785a.3
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 16:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770163447; x=1770768247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWP6YHUklSTvYW2OX4DByGvzjUzKq5UuPUF3ht+MFPM=;
        b=cSj+L81HkWNenfrlLNAx0acgrN5kGQZs5kyGyAwjQYbqXyCgnpWyuRsCB3dSocZLbp
         /wS1Z18lmN5k99qoE6G9o0L36oKkUFXZrX4SplJhBQHLneo8vyYV/OYIrgYQ07RnU2jT
         uLC7dlG/y3vYmnJhXd6fFXN2yK22xogseZFKMRuFMP0DEzFSFRBrgSRD/aDVQTHzMnHf
         AIYxusw8SVp16CANqbN8mMLOUcCpN0rKoIeDXhCh6wetxcE62wW810uabX2KDTq6ni+5
         7stXIFhzU1PLNMw6fRk0Hyb9qNC7t9Lu2bvGlSnERj+DkxZFTqh2ggdFmjIUzCRWOmLV
         e6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770163447; x=1770768247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWP6YHUklSTvYW2OX4DByGvzjUzKq5UuPUF3ht+MFPM=;
        b=lrrDK6N8bBGx7bRM+YRjy9l3JVCxoNS94znYLxzIg02XB6hHjfuoIXET+gbW+tDnv4
         mi96OR79vYj5RhQY2h+1ydb45FhO2JFBbG+ND4bW1Os55+1BcQSew3AQ86KOEze/fL+S
         8psy7PZ1jPN8YGD6PZ2GQ02SSmzC0god969m/42frQXuv0TpCSu/95qHfOnCHolAqZp9
         rf0lFl3lLalEH58MhpOs4jMeHs8vHp5rB9fz5bOeLXMLg4W/Y3lmPiwwInFLO1YfSHhE
         CQduhsbgbSdBTfeajtZuNvY0zHpNXmB5ktUU43hwgmx3h4hutrCsT6vpN8TUEiHWNarr
         BLvw==
X-Forwarded-Encrypted: i=1; AJvYcCUF9Z3jVHkpJxK1q5tn88vizNy+cJpS456FuEtDKxLdCHQCowL5vJdA6OMG90HFStZiALjaAp5zpW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXP/oQ8F1IWmUZPND1j/wdpv5aTKhr1KTrb5fMFciG7b5qMyzB
	j+jrZU0g0sXCMPw0X7Dg3oG7m/5n/6HJxcAOD9FpfQmZs7xR9ngS/QrL
X-Gm-Gg: AZuq6aJSH0urQsbmQbi/uDbEdzf7hbGbhzEarWvUNaTDsLYgNY78U0G9NoMke/jpzJy
	Nn1uw/93J5fnmVKH95dRHj5lHSnWS3A/p1dBfd5sT0Pm0r7gPgTCSxPgiOHoMX0ISdL+zYrBeIn
	5ALkwBbQeFAwL3qgmjGazvLtTYQ+XLvvcn+BsGfj7JjDh1xCPGnzD9XCq0ZT/Rrh7GGnqCy3XWu
	ep2wyhMYCL9QjpZ5TDyDFE4gJJ5deEwPC2HDeUvtPbmWnydVm4fGVAmVW4KSvcouYSmYoBT8dUY
	VbTcMgp5acwOk5VKExxGK3pK1B0EZhsMf9xxbq6+nlV9kBgFiG45+HUghfKiwXy0CBxACQ9l1kr
	TI6tmlmmwjrvX5XLQ6CZtejOHF4qHHYJXRC7Gzw4ld+e2AE+wlESTlMma+Trp/db3cJv4R4E8c6
	jK5+izs+VuEkeTt+nyw2MzuKhP
X-Received: by 2002:a05:620a:3193:b0:8a2:234a:17be with SMTP id af79cd13be357-8ca2f839c7amr200973585a.7.1770163446871;
        Tue, 03 Feb 2026 16:04:06 -0800 (PST)
Received: from Mac.home ([76.64.58.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89521d13461sm8518666d6.42.2026.02.03.16.04.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Feb 2026 16:04:06 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH] iio: magnetometer: bmc150_magn: Used guard() for mutex protection
Date: Tue,  3 Feb 2026 19:03:50 -0500
Message-ID: <20260204000350.25454-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replaced the manual mutex lock/unlock calls using guard() to simplify
the error handling and reduce goto statement usage.

By using RAII-style cleanup, it ensures the mutex is always released
when exiting the function, regardless of the return path taken

This was compiled test only

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6a73f6e2f1f0..73d9183a354b 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -796,29 +796,22 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret = 0;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
+
 	if (state == data->dready_trigger_on)
-		goto err_unlock;
+		return 0;
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
 				 state << BMC150_MAGN_SHIFT_DRDY_EN);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	data->dready_trigger_on = state;
 
-	if (state) {
+	if (state)
 		ret = bmc150_magn_reset_intr(data);
-		if (ret < 0)
-			goto err_unlock;
-	}
-	mutex_unlock(&data->mutex);
 
-	return 0;
-
-err_unlock:
-	mutex_unlock(&data->mutex);
 	return ret;
 }
 
-- 
2.44.0

