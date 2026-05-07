Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DA3128BE
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145729; cv=none; b=bdtt24aNI6GXQSug1H09nuWZ06t3DwnqEjc4BTPWSvSQzFhjHOciW78t1OLxpnOLGzsve4AgoebKRT/A9ykbBguEuwlrrswzbq4T3uk+tz32jXsBJaNhv2krGA1ixk+pQ6cX0EbsREbH3YqTJSJLpeXLRZY7dI1XaUVdo3kpAy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145729; c=relaxed/simple;
	bh=l95NplvxAjRLCRg7ObjYoTtUO9SuMMlSFZQmdhBcyAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8fscseEyi0Jtlqnalh8FrV/QsPwwjL2FmAUnH82QGlacOrJjr1knuNwO4HHmxyD9M0WKyuUFVPekOfKSl1JCkM9XGnU2wcNpH4yoyNhOEt9TPhqBgHgdqWMxYO2aUUBnX8rVIIVsMWNRTR4YxlL8GCWOouFoZuUmluY52ANdB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgO7t9Di; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgO7t9Di"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d77f6092eso396697f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778145721; x=1778750521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6PYVMMAUvdqPUsNxyIec24Q2Cm7bDFnW2WKRqfA0TRY=;
        b=PgO7t9DisebRVg1iFmS/a7PjtJr7VVI6yt0MzH8UZ3DGwZ7TKfFujfVn5ZHEYNW90y
         JVL17H2K4mgOaT5oqUJtuEiVOBYlmofu76swsmZ+K5dGaMhiwwWUhZX1PYMPvhdWWCS+
         wc1XGUzfFEL3gmXGNE8JrzfVPlvYWaBqdzMr4d8d7LUO3O8Z9Bqs0glQMQkD1yAqofWZ
         OJAHtG+8X3FvN/PmzUWtgcSyMdcKLN8dISmIpnc7Po2W0R3feNQ8q5rqTF6u6JvMd63e
         RpZ/kiSDpeahRcKy8IhpDVhVYNCRZJpDoxdfskh4wGLHU/Cd8qLiN4xyE1pEKgJ0wyQP
         Ytog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778145721; x=1778750521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PYVMMAUvdqPUsNxyIec24Q2Cm7bDFnW2WKRqfA0TRY=;
        b=WnK469wlvXDLDDfWKxlHJ0NpYQIrFerYZPfHnNmit4zEwZGem3fRGn1o+OC+gbTwh4
         /2YlxiD9t1EbO9u42+enbg8T3ZQnKWdFwpHB8mMpSXh2MxFb9FK1dAanbesPoubgkqcq
         TkcztEcZ3/0WVpjD+1sRl65EQR2NLUzYF2PS+j3CjwO7r6ACN9F8OXlAAyvz9VMoDi5h
         BLjyQc2DEs/B/v/9ST7n0usYuzo0Fq8f0gYChX6z0WHnvm1/Qwc0g44i0vlnycMcukxn
         hwBHnxw7QgfIbFVDNos4uXYvrMLCN5VkCuPYSn484Q3D32XIt2XCrECmTnxhLGFN27RD
         dE5g==
X-Gm-Message-State: AOJu0YwmJqdRqbMIKKzZc0zhHi8kdQxhl8cJnjHQKWXXnr24jMzLnR5Z
	CwqgwvQkF9MQkpWpIOcCLTzw6YlERmdVlLumY/7KhABteFvT4gciGY8h
X-Gm-Gg: AeBDieuErVg1Zacl3sdx2baeZHNUxtNDgE5PUTIl44C+HZuf5c20yKWm0xzUMZ+0lX7
	VJ/aTtz1sdcZlBuBJxCKtQ1muR7H/HkECDSXLxTyGzqmZiD4q1zkiGVIGh1Lu5kaJU4Gb+h98zO
	AV5iun5SrNTuXPa0bEd1gIz4Z0tU5iaPHyk+TeWXVDeJk/FRgGPQpCQDsOmRW1g0R5L6sKr/a17
	4ufofEnr+YpfJ4T6k2E6wk5Q+ISgkr0nn1Z7/3t99yJRNFjDnu4v7dPjhfViovKdNQYDb7cZ44L
	QBtcYie5KKGo8jZ6vaesrBDV5TbiS9MsA5rBPWw1bJScw7JCM8CAP6HwD8BJ7Cv4MfYCwN2CiF1
	yG7/OMVqN9XN0ScXpaQ1uQDbFqg5init4hWZK2QJQJNa2ttvnD9jFMdsRI5eqfCGTVTc5YTfTiR
	D4MGOxaagwFi3zK8FM4T3zUrZ+YSE6W8Jfyk3jO6RoQfLTtpJOxkl4dOLtZYLb
X-Received: by 2002:a5d:5d10:0:b0:43d:7403:4b65 with SMTP id ffacd0b85a97d-4515a6c29ebmr11520027f8f.6.1778145720232;
        Thu, 07 May 2026 02:22:00 -0700 (PDT)
Received: from localhost.localdomain ([196.235.181.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4505238e174sm19380331f8f.1.2026.05.07.02.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 02:21:59 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v6] iio: humidity: ens210: Simplify I2C functionality check
Date: Thu,  7 May 2026 10:21:33 +0100
Message-ID: <20260507092133.8810-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the I2C functionality check by checking for I2C_FUNC_SMBUS_EMUL,
which encompasses the SMBus operations required by the driver.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes since v5:
- Changed patch title from "Fix missing I2C functionality checks" to
  "Simplify I2C functionality check" to reflect the new approach.
- Dropped the Fixes tag as the change is now considered hardening rather 
  than a bug fix.
- Replaced individual functionality checks with a single check for 
  I2C_FUNC_SMBUS_EMUL as suggested by Jonathan Cameron.

Changes since v4:
- Fixed the alignment and indentation of the I2C functionality check
  per Andy's review.

Changes since v3:
- Fixed the alignment and indentation of the I2C functionality check
  per Andy's review.

Changes since v2:
- Fixed the alignment and indentation of the I2C functionality check
  per Maxime's review.

Changes since v1:
- Updated the I2C functionality test to check for both required native
  operations and SMBus emulation (`I2C_FUNC_SMBUS_EMUL`) 

 drivers/iio/humidity/ens210.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/ens210.c b/drivers/iio/humidity/ens210.c
index 77418d97f30d..91c2f69fb6bf 100644
--- a/drivers/iio/humidity/ens210.c
+++ b/drivers/iio/humidity/ens210.c
@@ -201,10 +201,7 @@ static int ens210_probe(struct i2c_client *client)
 	uint16_t part_id;
 	int ret;
 
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA |
-				     I2C_FUNC_SMBUS_WRITE_BYTE |
-				     I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_EMUL)) {
 		return dev_err_probe(&client->dev, -EOPNOTSUPP,
 			"adapter does not support some i2c transactions\n");
 	}
-- 
2.43.0

