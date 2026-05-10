Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD863659FB
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778398183; cv=none; b=NIuT3Il0mIKOWU+E1igpk2aF6fQGh3ZR81sLR/OO6s/HQRWcmtKroW2fNbXBAt9HhkX1CKwnwBJtFAvPy6SbRGV4/Cs1fy7Ltp6tVC65gzMYwYEzT/1uw71Nu2LBxPE17VLaxWfAaBFYCNESLNn6NFpF5/E5gnq2o6D40+uLQ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778398183; c=relaxed/simple;
	bh=qWCmPhOrDnUxqUKogWTLDFIt9grLd2AwEu1Rc3nJqfw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RA2TdqGDTp3LEPXu/MsWDwNe6oBcyI5DjoxOK1zFHyDvx/LQIjcNpwJSN/Sb+EQSEFkMQSXjmMeEz8tiEKjUL+hcSRlSAs22mzFXl8IIC0mW2EePm5prxibTbWRiyCnAWclIMdGBQhpMOaBMZoXq8C8lsd+uI2xVBDsTLZV/uic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtWpE/2h; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtWpE/2h"
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-12c1a170a50so4482018c88.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 00:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778398182; x=1779002982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hAJj9gR9YqXW3Aa8yL22LCa/R0RncrwiTc1yi2jGMAM=;
        b=EtWpE/2hzHH7TmDXEoL/UblqPWLEuoboSleiqC3O05tG+8FXdrHHhlCPNEI/sB8bRi
         m/IGBEaOtCmv9CvLzsQjI8gRT9YdVTFzY4afxJy2K5QA6rCAFhU/McN4pGRB9B91X9Q7
         7GKIqVKFwn3W1sae10rFgDl8vamRm+qU22PT9auhtXrREw0vBrZ0nOZfPc6olbS1IXBa
         LUnm2UXRzpxa+XKZo65hjNGQPbSraC5v7XygQCwl8jikzN3duFP4d5z65VUBaI2fxmem
         agw0QEqmt1RGNTHRzsqZ9grio+VxKS2l7KTpMsWyjHIcchLJTZHAG4gIjXN+RNKkW3Bw
         LRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778398182; x=1779002982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAJj9gR9YqXW3Aa8yL22LCa/R0RncrwiTc1yi2jGMAM=;
        b=sr/8PGhUXKQ/8FriBocNVnAUrK+HVCb/CIfcYbcHhAxbcnzE4ocj806cBjM3tqONPU
         monzIrOkXqXgZd45JwYDS5UQ67mCRGYgbdiMtxZBMVDJui/9B331Iq3R8XEfRkqgYnOa
         g74pMI9QL8OUTD/jdiTTS+1pPhlmF+U4+yDAwy4GrBRiohenhaqiJbPs4p19CaLuEqrm
         L8dvHUWs5q9LPi++0QFt4UNfksQLQZGFw/K0/Uf+F3QOYhGEXazbaEXiLiwQEAPOM9ki
         QrLWBz1kKu6sNJpVDwIlFUHJuzQUCkIcccUeOsLPb5Lkk9NX0COP/80ftRyUVL2ZBpOq
         nMrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ok7NdgRjO5+ZwQT5d1Uc3bspXKfrRutlmeCRx5IMTvRRVFQHk2P8DBHWv+P1Z8zIrDlowdtCbWfc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTQFXkGe3dGNo8muLK1BNylbMGKqFjFdQWqssVEBirD4NPhde
	woyymWJmIrpjvxX0/8QlOTREQKq1fmAxcxQ5SB4Prx4SNkqUDNfNlHCy
X-Gm-Gg: Acq92OF5ZO55QBNUBot0ca0AsuQs8tiXmI9bgagesXUuhrk5YqIxw9VxmzA5Y/5BW31
	BvF4eu4Lrgiyh3ulS9Ifscho007tIzydx1+DlviFWtsn8Q/YGIj0K7WROKNUrWKb74kyhn8SXVq
	/t+0qcEJDfD0lwebc8BHP/3gRz5VYPMgRx6bbJoDw6nYCfxhOHIWuBrpJNNXOu7BQKJLNWkAt4t
	DP39Cs0CVgM7i+dqNbanvFa/qqvCFoAGEdDd9PhcX7AWEoD7aSWS8PzqvRgWNRyIbqurTfovZOb
	WsjuF1ANaDS6zppCSnOl0bZNWpizXJmkQ6zuMgqLeqamhcKDS+aDt+msalaqQTeS+v1aRzxZXbl
	iY4an91Jd239YFF60TfDorb5h0uib8ijyHPN8KS889kukmDMElt3JyLe8wnMilUXSADzu+ENuHZ
	Szo6KTZZswlu/HxfbGIPY+g0X4Zi9L+LHpPXUcg1kBLf0hoThd8jGsUM0=
X-Received: by 2002:a05:7022:688c:b0:130:c9dc:bc55 with SMTP id a92af1059eb24-1319cf5d736mr10234387c88.28.1778398181601;
        Sun, 10 May 2026 00:29:41 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13277bb2b14sm11920107c88.0.2026.05.10.00.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 00:29:41 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] staging: iio: addac: adt7316: document SPI interface switching sequence
Date: Sun, 10 May 2026 07:29:18 +0000
Message-Id: <20260510072918.85734-1-dennylin0707@gmail.com>
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
Such errors are expected and are ignored.

Add a comment to clarify this behavior.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/iio/addac/adt7316-spi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index f91325d11394..6d710e1d4aaa 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -106,7 +106,15 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 		return -EINVAL;
 	}
 
-	/* switch from default I2C protocol to SPI protocol */
+	/*
+	 * The device powers up in I2C mode. Switching to SPI mode
+	 * requires sending a sequence of SPI writes as described in
+	 * the datasheet.
+	 *
+	 * During this sequence, the device may still be in I2C mode,
+	 * so SPI transactions may not be recognized and can fail.
+	 * Such errors are expected and are ignored.
+	 */
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
 	adt7316_spi_write(spi_dev, 0, 0);
-- 
2.34.1

