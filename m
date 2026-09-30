Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382951A74C
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788373; cv=none; b=PUj/Tu0+B+4/k+qVVYXzCZc4t4QNXDwUS+u5uCRXawYjraIcqmgq7CuzaWZfoCpM+1ACFjVWKAkq9YQQXv38PamRR6twq5u5ypkurAiUN7qNLjBI1n5bKKB6tDGH/XotH7YRizzUnOMJDReHsjx6SdYe809RcqC2YHFGgn7E32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788373; c=relaxed/simple;
	bh=y3S9btysFhmyj0XZ91haKB9K3DUP7qVJalcptDQPz5Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hp2lE3JaOxPTJ9jRnHb5Lch7KJKMcJXYlFCEvRcnfRfrYIzufxpc+1OwMNo0WZtpU44XyYJX/oUpf8rrbfFmnd6JKnq7HEjLGACr1WvpsKZkf3D1A9s/NvQHIjonS4SB+k/9CuS0ED1lgWZacTpvPX7N2IXwOWIHNzIUrFb5RrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dchr5MK2; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dchr5MK2"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469f204f6so2756962b3a.2
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788370; x=1791393170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RHz85aSKwRxYDyKJz8uKbf3jnYwT8k8pej0Gb0dBQc=;
        b=Dchr5MK24O4pZBFPIY5gZtmd9gGOwpJR8AYAcY5kmU30ge5ROdrdju6msRGGSCcv2p
         aSi1Br+a1dR4hqSv389F79IOxsloumJlpFIEaIVNSg3njaqJpI66jHUgW0eYv0C/Ha8+
         N2Sc8TVoOLoKuB7tAM5OgcyvnR38erXTK6gtT3MPbGXQUmnxYcUngKgHqXPVFm6ZBU0U
         qgSo+oPtOGPzJ4+fN5NolgZ7gdOlNFKunnrEcZMGXqR8tXb94FfyQBfuQJP19mUwqqNy
         dQGPxQhaps0825cQ9886bH90wvqyfWaIid8XEN/s8kL7heUG9YD2M8zbj40kFKGXww3S
         a8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788370; x=1791393170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RHz85aSKwRxYDyKJz8uKbf3jnYwT8k8pej0Gb0dBQc=;
        b=jGZV7rxDFKiQVlgjYdXCy7nHNRMOpYNbhicEaJUXz8S9C5urAjzsnpf+/jvRXBQ123
         WYrKr2U8BPscFZC/NqkAr2Qj0FC6TxYD2+QGatXwzuLEawFCZ/ruk6LQ+lLVl5VuoEeJ
         bCBj5/xlI9/2CQuXrUr2A0yPjOka/OD1L1nuu0lyPcawCKEXSjyBLEMlvxrPazchl3OD
         7PEHQcB2ojGc52uK2cvcELM7ovCnjM5HRFeCJNNEURYje5LmB/49z+1GOA90KEjvZBmd
         PujNNmWxTWTEfqy3VlqF0/qle8cld/zIfXnlNaUvUZlxRF4iGxz9YCwLv9jiQi/yLRwz
         cVdQ==
X-Forwarded-Encrypted: i=1; AKwUvByI8burRydmMzWlyjb7aDrb33KJ8GW12fBP0rNGC5EUo5ZqyS2KoK6fRio5Wh9Ln1Zf+zcKhbhxK7Y=@vger.kernel.org
X-Gm-Message-State: AFuF++kdLpTNpuTSG/CTxw9+bgFI+7fpxhhbQGYOiYJmRvifsohWXpyU
	yGX/1IMSsI399FtA55YljiHQnDAqAN3wqvlyFYIRMy759ko1wcwZxtszEhcXmrGyKLQ=
X-Gm-Gg: AYBFou2ZcyIIvrKKhHgXZ0uaH1ejTF5yWqeiSrZlOElHUvYTk+ZsgqAxJrfMQ1H6ngI
	L0d1qfTbtmgTZp2r+MlghAyiBQAdMHatawrtwooTGCNivDnIRNBqzFDXv0xBL4achgGt5b+02kz
	uSA88BwHLYZby7R8k7RzDvhDz5sj/7OO7Pnf56WHH23YpQq+podHCDn5oaih7YWMkypo5zq9cbK
	bPj3OH1werfv7u8/orgJVuvLzvbHtrjPK0d+LOieWWZu/zQt4ZsQTu3EQJqQJMGWZrenIpWHU5F
	jCQdlMaPD/Ds4WK+5N+rnOrzsZ3awOqKDGm2m0dipRT6RZVWlF90gtTKfZVZr34BY+FCvRHLo7P
	v5H1aQSNLVuUzyS32pyKkEHM4ac+ytThSljCElhS8O5Bd1enDsenqDKicCWfJNpBnfepCC28KUa
	dxT9gSHus9VOAr4GLY1IVSLZXnaW+qzUmRmuth+IUWjhVgf+/qCYffGTO20n9jPXR9fDhcrVvMU
	A5rTz6U27l+Ag6jXHQ06JJwKza8h24ObibX7codxZnRmWeeQA==
X-Received: by 2002:a05:6a00:1a03:b0:888:71e:1695 with SMTP id d2e1a72fcca58-888071e1ff0mr106338b3a.44.1790788369803;
        Wed, 30 Sep 2026 10:12:49 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:49 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 07/10] iio: adc: ti-ads1015: use devm_mutex_init()
Date: Wed, 30 Sep 2026 22:42:01 +0530
Message-Id: <20260930171204.12863-8-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930171204.12863-1-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert mutex_init() to devm_mutex_init(). This ensures that the
mutex is automatically destroyed when the device is unbound, and
simplifies error handling.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 6637c42e0506..a790f694a1a9 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -959,7 +959,9 @@ static int ads1015_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.39.5

