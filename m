Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2DA5187DA
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 17:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790788353; cv=none; b=c7Bd5A1ISzOVUlGRKdivzSl8lCZ2VmbJEUlaixIQ+d+kckybKdF9diM3EGeROypXq6MnwKHPIExyYIihiaKBETWCN0FV/3fV5FEegQvNEnFbmPUOyZUCu3vXdqn4e1OyM5nuFvv/cL2TiBXkl3TrWV9i1JKMcyceoV+oDOba4PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790788353; c=relaxed/simple;
	bh=1G4fuu0oR2VLY2dRpac++Pn4hsuBKzHcbn8FnN5XHwg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oeo+Iw9X4KJSyqBW2O2UhmVm4nD/mJLRN6lkG7i6rl6CqRWw3klETN16rMxSrA9h7iWy/o8ulRSH6gSlnBWvMo6BiaXpyTLVG/hK0rur6Ow37s9vqsTV4dyVAvsIF8dv1zdhSMKyl/S49SqkGHXx5Nt/0gPF1iMOfKB+GHw0SeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxEB5ZhH; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxEB5ZhH"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd412cfso2225988a12.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790788352; x=1791393152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=03K6qy4mLWn83QvVAuWVm9dIpVbvpOg8pybvV7UDWXo=;
        b=AxEB5ZhHD5hpBmCkoXe5P3D9nDmzO2h1jPDjC5J4LNspe8hv5zx1zFEjKNCe0ZQ/sv
         4NwBkvgxWUFXoQ9g87cI2ig/Ny9jbFh9wSZS/GVs4LuQWZ+IOZPI9N8ZdVhmIC4NR4mS
         UJ1aPMdUvsq567hrbEmYC9ZoOSet7WJrWnmnSXQv2wcbGXEftstCmXLGR4noBFa8FcxE
         jdtzimjLsBu3TNk9sDqTlbgqtzc7cuWBqcUINbaPgouJ15mC8rfn2cnyC6QNogpbKHrH
         tYyV/S2FMtXkRnyIx0SZo4gB5lzG4A4AfY1AKAn2IeADFfo6/14Pp/vuWOu0HuyPz4nt
         CyHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790788352; x=1791393152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=03K6qy4mLWn83QvVAuWVm9dIpVbvpOg8pybvV7UDWXo=;
        b=K6BuTFZRU7tw8HIv2xLTysxUjfcKw3v9HaVN1KAoJVzTfYu4K3vTzNDdyv96Inhio/
         yNn0JfMBDcreqKPutPM7OaFggBUyc2xQPaX6RMlNEs6d5QFME4eECzeYsu56193N0SLb
         4YEONyXq/EN2CR9+Q4UnjTjNeDcGZDAHxbtWLAttb8138FfKDinGAq1Xy70k4k/htrr5
         F2bj5lnUOUmvsaxIF3CSu9V8mhuLElklZCdjnu4XiXgeOC8FU7ONX1Qp4xLUv3REGiU4
         eVZk9oltDNU3VOoVgqvKoY8+lrc0Pe6DCrY5Se3b88fiV+gxuq0w09VTUrtRxi4/iw9W
         f9WQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkL5xghV/bgo4q28lXIV9jH23kDQYA7BK+/TAlrc0sf01a6K+dGNO/3PdhW7lz6oTCY4NPKoaRC3Y=@vger.kernel.org
X-Gm-Message-State: AFuF++n3GDrmCuaSclOgQV7+k31TfGRc3t4LU3ac8Z6ZMYxVNJrkQGL/
	+9dHpHKvuvAZKzRzqjh0JFJTc4qtzZaDFzU6IeHT808gdCkb7nZsWGkU2KYRzWP3PBo=
X-Gm-Gg: AYBFou0ooYY0KHyOxMhZq57pGahPUjk/Y+spmLr6L1n30ZngWhxqLbWUyB0i7oYr3r5
	QguMKrhJZ1sywunA19ywVwUmabnTJAR5HeqqTU7yHgifKzOVVSldOks9PcViBqsmrpuSpO9BvvX
	71REgYATGsMjPNuPGMhl4LDrL62/sEvIfGuyPJRbSxfWgw8Ikdj8ia/4HwXRnNfYKf0xQ0kVb7F
	84+EGfdlcm9l4KFRaHtI98iAtpxyy7d6HddGsGhUQNTpuWBu92GRjweC5SEkN2qnfRsnecK0u6T
	imHgugUk254FrwkXU7dgFGpgyaYHiWEr1q4WX+gYcAJz6mAIBxQhtU20PM7PIAx7vN/3tRD+ufz
	PmkzH6i0RsQnn0EriYkdUSxToqQ2BWyrBnjfowjbcH3qcdBaVyIUzmFX/Gnysm3G9oOoy8HVptw
	rdKFmBZVDdPWLFBcZi/X6IRL1F7o+cggtnLZ0dk3WcSEddCn3XNeYKKEkwjZN+4LFl04niT4QyD
	QhDgMUyRZu9h2o8y0RRbP5JmT59XnMIvXciJIzTLX2iVWYVpH0=
X-Received: by 2002:a05:6a20:7344:b0:3de:51e1:e7af with SMTP id adf61e73a8af0-3de9e000a2emr1955365637.12.1790788351537;
        Wed, 30 Sep 2026 10:12:31 -0700 (PDT)
Received: from debian.ari ([152.58.182.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-887bc2bd404sm636872b3a.46.2026.09.30.10.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 10:12:31 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v5 03/10] iio: adc: ti-ads1015: return -ENODATA when match data is missing
Date: Wed, 30 Sep 2026 22:41:57 +0530
Message-Id: <20260930171204.12863-4-architanant5@gmail.com>
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

When i2c_get_match_data() returns NULL, it indicates that driver match
data is absent rather than an invalid argument being provided.

Return -ENODATA instead of -EINVAL to more accurately reflect the failure.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index ef03b74bda3e..9479f110448d 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -951,7 +951,7 @@ static int ads1015_probe(struct i2c_client *client)
 
 	chip = i2c_get_match_data(client);
 	if (!chip)
-		return dev_err_probe(&client->dev, -EINVAL, "Unknown chip\n");
+		return dev_err_probe(&client->dev, -ENODATA, "Unknown chip\n");
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
-- 
2.39.5

