Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BFD3FBEAA
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 14:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508430; cv=none; b=ou1rtdRyZGPp8eS8TENYnS5RiiPRxbmfZ0njZTomvnakiHGGeHMa1zcBX5QlI11p0Djwf8zrHHi9R7kv0zWz9iXfHiNhNQYvMHOov6HzFf1xfQKZ0zdzemYoNdC5MK8nOsoVsSprlJ0DjYBpJGQpINNqR4g/zl+z2uSDKE1ckk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508430; c=relaxed/simple;
	bh=/gZeyJV8x7Aeejwh7qyX5OSj6X3GN6xwf1eZzzNee6o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=vDzg3UK883FoFc7T8kMt1CUn6WlRYRUmFQLPeE4eLN/SLkhJr37Or7Du/Zyo6rpTYcNx9z+lmOw2nEqooHRPlkUUx8tYVPlF2WPFeQ+E49FsjA4Ny+Lil+6l+WMZoQpdj9wLLl2ZsHo/XfSIbMBIzmJ19HSnU4RGcA7qFHdjbIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o4yWk7Rt; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o4yWk7Rt"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12c88e5f4aeso2563337c88.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 07:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778508428; x=1779113228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkQ5/goWHs+AMVv0uCTHxRAt4oXWP81t+SslhUkMMnQ=;
        b=o4yWk7RtLa7iPcPgMHZ4CA+vFEIPy8sd9SU4zkzWcBeJ5T5HkpbqG0+lSLe1gHinUS
         Pt3hUzVZkQWaPrSLvbkH/PzQl2XjiDCVjleTZ+o8Hp8NT1GcFsmaCquB+bwZWJRpr+ij
         4CI1E/e346uVchU/vaYZ0R6whn+lx6oVlTVllXdroc8DbU0lov7/zS8rfpjoyDfweThT
         PggUAE4BT3h2nRdHkKsQlpvF/V6RGnjxH0LEtALuJGtRIg85CgWvZc3lDY8fXM+Fvhs7
         rCjifrWtT/ajbF3lLWmmE9DkGjAbsgUFwhlNNCFZLTIBhYCpFOTU6eyTSJMo59yy88LT
         asaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778508428; x=1779113228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkQ5/goWHs+AMVv0uCTHxRAt4oXWP81t+SslhUkMMnQ=;
        b=W/WKDrEpiCDtTLHGBgzRiJQgCs5pXvYJ2UxS3HQxh4P2hVyoudCx4TEpt4D1IR8rXG
         q6zX962EMhR7C2x6JUOJWNhfVIxWRarWsHJ6dUzIobSpneFwuqA3Xzc+l3CAwk5iHAvi
         eSoIYgL3AAWAZm+Z1l0abfsHjRg9jidRs4dA65uPG7/FhjJeSeEujXKY3kzKW6ojFupn
         VE0W+7yucUhBRM0IekcsbsMrBP76/UrAhItLF/zAHs2F0wAHJloNJs7pdjZycpJ6Jhq6
         twxlPS0D50do9Avz4+pn1M/dxOjXiIuKODRuMx7t0AK2i/DcnlnmgrbDWNB35zOnywmc
         0/aQ==
X-Forwarded-Encrypted: i=1; AFNElJ9y/jBR5lvgHgtrNDHmlfSC23L/2N3X8Wuy7FPVDzS2xiy5byja+8pTr+saRdN3Z1zEtx56kJBST2w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MXUp5wSkFST/kE8T0RY3C2x942eITYUfcREWXBuuQyRj34UX
	D0r5svPqcoG3zz1nyu6dPsb1LxwXXLE+eB5klgt0YrimKsTa1FPW+TRC
X-Gm-Gg: Acq92OF+zxTc2JLzaI+8nE+p76LG3q6hL0mMAx73S93AMmVYJfbqnX67FA6rjvXg/Z+
	AtRPb+rMnIIGACnYqbVTET8EJLg9YNuk7c5JgJhnis6uPg4EH5w9wpu699odkPUEza6BYWNNbUW
	rJ8tfFK8M8FZACcEnJE2cvOiK35Oqzk3D3Retis2jnmA7qwmQwWI1W0WeQzrAAUhyLJ1VGEuxFz
	Az1LWMyVIG7ZumDSnoeZeeD0e8Ux4uC43bGc9ldWODJBUXJnLz5hGDTcOx8Dt6w4wZM5MLm7bUH
	JDzjZuR4I9dO6zE9oi9lscGasEup+LGWN1a/pKI5q0xUSZZDoILUQXVJlJhtbASv0nKUVmajlOX
	voMiBHwVANTIDYI2HZ9FPhvXi9MYmt1KPSMaWhlLUqwHr+EE3dGWWehTuG8Q4H9njAH4Sf8h0md
	Z7OeLbHN0deLE0Z+yAAMwrDQXe/BTE4l0NLSoG2co3/5jlwcixMDl8hGogfUUlWe9GaA==
X-Received: by 2002:a05:7022:6187:b0:12c:15ce:a71b with SMTP id a92af1059eb24-1323b1bd713mr8099105c88.25.1778508427507;
        Mon, 11 May 2026 07:07:07 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88847504dsm13699258eec.15.2026.05.11.07.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 07:07:06 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	m32285159@gmail.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v4] staging: iio: addac: adt7316: document SPI interface switching sequence
Date: Mon, 11 May 2026 14:06:41 +0000
Message-Id: <20260511140641.86389-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The device powers up in I2C mode. Switching to SPI mode
requires sending a sequence of SPI writes as described in
the datasheet.

During this sequence, the device may still be in I2C mode,
so SPI transactions may not be recognized and can fail.
Such errors are therefore ignored.

Add a comment to clarify this behavior.

Datasheet: https://www.analog.com/en/products/adt7316.html
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
Changes in v4:
- Restore section title in datasheet reference
- Adjust wording per Jonathan's suggestion
- Add Reviewed-by tags

Changes in v3:
- Add Datasheet tag
- Use datasheet name in code comment

Changes in v2:
- Add datasheet reference
- Add TL;DR note

 drivers/staging/iio/addac/adt7316-spi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index f91325d11394..1debcc36c1af 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -106,7 +106,18 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
-	/* switch from default I2C protocol to SPI protocol */
+	/*
+	 * The device powers up in I2C mode. Switching to SPI mode
+	 * requires sending a sequence of SPI writes as described in
+	 * the datasheet "ADT7316/ADT7317/ADT7318", Rev. B,
+	 * in the "Serial Interface Selection" section.
+	 *
+	 * During this sequence, the device may still be in I2C mode,
+	 * so SPI transactions may not be recognized and can fail.
+	 * Such errors are therefore ignored.
+	 *
+	 * TL;DR: Do not change this!
+	 */
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
-- 
2.34.1

