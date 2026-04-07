Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7425A391E6C
	for <linux-iio@vger.kernel.org>; Tue,  7 Apr 2026 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775545276; cv=none; b=OD+NFtgJDFK2Y5192eP/BZ3nenwNYNC84LoRC5xSO1K5r4uY5MRBEmSiGiQFI0HeDbxzlqFGAOw/dIYpqnEyYD7dlAOaCbcI8HNA9Mw9ANmzdkjwVNOsKmBqbk+tNhZnpzP+NWB6XsUMZIfJLfQzZYYyj5tYFkOf8e9H8yEYRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775545276; c=relaxed/simple;
	bh=iwbsvmn3sjRQhDJhAvMknBCPz/j6ukdKjlnQ+9EnffU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWjC7v0E5mjTSlTWDUabvYkJ0aMXKo9Abv+zzgwDr5Np9yKgANZqAEwaD5cLTO2V0J9wR7kL9KkONB2razlmkcOiT0tpI+cG8cD0mTDzwdHYIBqSJdwv8VKLlXuT5wV2ePwpecd3RRbgI9gAmjdkl0lKcHMVsxYetRMWwXF0f5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kySZzEWu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kySZzEWu"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso4894381f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 07 Apr 2026 00:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775545274; x=1776150074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pbshjy6ArGT5S+r1Sisv2NuM+Q/whiMd15xYasDn+5I=;
        b=kySZzEWuOpWN7lx6loaW/LiFTz0WsTWZg7Va8olfykOQMJuOgpIQ/cdvRuPSCtglm2
         Yac+lVX2qs01f2Lbjv5kMJgY8hoE3YjTaOkV72aLdEgi/asCT791x1v35Pu32+080HCT
         0lK67TmwwD2QP3Nz1gf3XzFNxLtWRMatDo/oTQcy17RJSuiDjMF6c6/aFqTQHzaBCk/y
         /Pi23mh17IGyt6LHD5dvIj85LvW76Ms9o+t6gTfx8B31S2T3kqpo5wb04BkIHakSqfSd
         WOXLs3djoHwPnWOYUpQtISJQURH8TzOvvkJheqoPgqybHH8TdCaPpPDFzn+eTl+akdIk
         FcnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775545274; x=1776150074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pbshjy6ArGT5S+r1Sisv2NuM+Q/whiMd15xYasDn+5I=;
        b=NdXp1U0gFH8VQeBk+c9pdZ5aw+NIMKybbN0NMAyEk42xY79PDxCuL4505GqEHFX8L+
         elVSkeu+0JAqHK/iIEo0j9p+JUWtxIa416yIdhiEcoVV7l70F0TZMzVUp0DZjqZ0mpHg
         3ZoFB7/XcW4n7pXAW4AgXfDbg03A0C6ILQYnnLkTCl5ACCWkmfOGIBzR/xI8DCARemc8
         bDkEpw0xX7l+ANltLZiXshkT4fzbEH5u8enwIRINmL97cDoXpp2igM4Bxdh4w3EyP1uk
         2HdwKu6QaxPXNdj8hYncKTdvmCNSjpdOgmB9va3tjiWcx2RIV3Gln9FCN35FjXOZX8yd
         Ey+w==
X-Forwarded-Encrypted: i=1; AJvYcCWHnDGWBrlQeY/vrOEWphSE28YXI1s2aK4H2fI3BAyNe8sgeVib9jhg3ItP7EK4CutfDxTrPJBHL6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwawQpTPd1UxUYfZormTicZNX1xXo3Fvd+Fscjf9HjbdjbwvGit
	YLLXV0d26p32uQansrppfMZ/ReBOZx9xWz4t7n4UTg4mcKr+pqtLY/Yy
X-Gm-Gg: AeBDieu9Eh7goGTqJqKmdU7WGBmWxUEybtC2ctJWL3z+G12T1okOtMkS0YynT/iCKt2
	YRskk4L6Zbwhx04ukfULx0ihhz+8LgtsUXY8WZzZLmKpHJqgekYMFIuwnmMN9ZkVia+jlDqWbjb
	Tlc3SLtnjyOF/p8bwoXn1zIxxphkJQaF1HnJRI0kGyrts15HBoZU9nDkt8+s3jhQ96LD++7F2Hw
	j1/YNZUyC4ivsvj6tN7A4l8nBGosG+gOBMPaeBJWILEjkhqFoftYeEI9j+yV2uu23OBJ5+781pg
	DWx+ySOOeUhrbiTee3oRrHJ3bpKk/D6iraGfaYKChoevOLPiu5BHqqOzwzEQYKtO0/65CyS5m4A
	8pyx499tpLaOmwTod40Md7P5/EeqysohNU63LBWbF9FBr1Fcac3Tw1mSpykPOUNkGi2lfI9iXve
	qPeHS0muIt8cf072plBUSbGTNgv/OGQIOCbrGN5ODq4X4EJIHUdMmS976M0Urk5Q0=
X-Received: by 2002:adf:fc4d:0:b0:43d:3083:4ea0 with SMTP id ffacd0b85a97d-43d30834f01mr11736517f8f.8.1775545273582;
        Tue, 07 Apr 2026 00:01:13 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm42167576f8f.9.2026.04.07.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 00:01:13 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: ktsai@capellamicro.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	daniel.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 2/2] iio: light: cm3323: use dev_err_probe() in probe path
Date: Tue,  7 Apr 2026 09:00:53 +0200
Message-ID: <20260407070053.9359-3-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407070053.9359-1-aldocontelk@gmail.com>
References: <20260407070053.9359-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace dev_err() calls with dev_err_probe() in cm3323_init() and
cm3323_probe(). cm3323_init() is called by cm3323_probe(),  so using
dev_err_probe() ensures that deferred probing is handled
correctly and simplifies error paths.

Remove the redundant error message in cm3323_probe().

Tested on a Raspberry Pi 3B using i2c-stub. The driver probes
successfully and successfully read integration_time after this change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
Changes in v3:
- Remove extra blank line after cm3323_init() error path
  in cm3323_probe()
  
Changes in v2:
- Add struct device *dev local variable to shorten dev_err_probe()
  calls to one-liners (suggested by Andy Shevchenko)
  
 drivers/iio/light/cm3323.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 0fe61b8a7029..c8112685e415 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -80,22 +80,19 @@ static int cm3323_init(struct iio_dev *indio_dev)
 {
 	int ret;
 	struct cm3323_data *data = iio_priv(indio_dev);
+	struct device *dev = &data->client->dev;
 
 	ret = i2c_smbus_read_word_data(data->client, CM3323_CMD_CONF);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_conf\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error reading reg_conf\n");
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
 	data->reg_conf = ret;
 
 	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
-	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_conf\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Error writing reg_conf\n");
 
 	return 0;
 }
@@ -236,10 +233,8 @@ static int cm3323_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	ret = cm3323_init(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "cm3323 chip init failed\n");
+	if (ret < 0)
 		return ret;
-	}
 
 	ret = devm_add_action_or_reset(&client->dev, cm3323_disable, indio_dev);
 	if (ret < 0)
-- 
2.53.0

