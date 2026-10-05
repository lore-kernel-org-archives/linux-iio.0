Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FDB499F0E
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208970; cv=none; b=gQDcIOfB5hkqLMEhkQYAekuremtOPqZJmjwOW05anAQ2RNd902XuXVIL9aE5C6pE2J+jUiwRDnrh79xbqfuDYxV+xwINzrtSPuaUAYisdDoVsIPfsarje8S3rKZU6w5Nw6PmUEylgrlZ30HREe69quh+MrswkPS6C07i3HpQ0x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208970; c=relaxed/simple;
	bh=xSpP4cJ4lXmtalES6iPeGHIxhLR61DTDlBLhfPYhxik=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AifsuXW6jZc9EeleE1VuavdOBISk/QqnH3HF1Q0GNmvCJtEuBljqwLAcOuEHkgpSFdQ2760J4ejfH5cs8WCmxlb5Ave741EkcFzUOZG8QPxLEhl6h01V95ZJlz6FPB/+t4UbXOEAe30i3F3T5BEaE/eGm2ni3UfNNaLcJNMN9QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=pXQ/UgGK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="pXQ/UgGK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso15491505e9.3
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208964; x=1791813764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nbQtirZnYeKfajVchc5hVee9ka7n8Bg+JlW3DdQnaJs=;
        b=pXQ/UgGKEWnxCQtgSgcJMioAiurE+0vzLAMxphvpp7+xeweReOSF3bn0SYK3byRYvi
         PiBYUmgzA22w/bTj633wcZYUu+SUltvk4LNDvvUpLx/vsWmWYKOOdezeM+wz6PuRHq29
         HT8Q5cICBHIO1TBABfoi7kw9QpoT0G9bFDtilagj1rr8Vl8UrEe2lhPYxwjWxEPxoz11
         bTL4Tq55iQROPU7oK5fXkYyr32oUtEWz0EWgL8UtnWRMH+9X7m6U1u2AekEVYsmFiyjJ
         HXcwD72MB6XZt0OOy1Nv6RcK/OQawi6tOqt+M/49/zDvDnCIL5E6G4ErYJoZzIsGyIct
         jFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208964; x=1791813764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nbQtirZnYeKfajVchc5hVee9ka7n8Bg+JlW3DdQnaJs=;
        b=gljmU/onCu9muqEYn0yOd7bpBisjGp9W9AqSKORjp31AHDqSVoZs5lnaMf1u2M4q52
         C4pMm4vabK7ZLHEJ/Xc7w4XPsJGbLn/2dnpzDn65b2MWe+uN/aozpNSUEGKhDuex3KJy
         fC4pFKd5S347u0IAv7N4ooVDhkXesbX1M4oVmdR4hHJl77+MDWOEuyBwfhLuprW9lq1f
         fcJ+4Uf34RY2QOqixzQGsDubsoGXm9GRNVvM8wzqQr+uXgcTl55nFpSrgqxnVZalt8Ww
         Fy1GAXdRLsr75BCKRg1kyiSle3VNCQ/SCsXb+kaBoXAPjFKqvQboUCYMBOjP+pHzwjsP
         DwIA==
X-Forwarded-Encrypted: i=1; AKwUvBzEeyshdRiD7rq3TvFSzfh326xd0Se09+PYzvt0j6GeUrXFzETbEs7vEux+ZX7zG6fzUphCWjxK0Dw=@vger.kernel.org
X-Gm-Message-State: AFuF++n9bf4r8m0wFuw0GQtF1PZE6/w6b6TV5RXnuDVtVMGeEmYTWWmW
	hsZtB09XMJkT6L2QdxfeS/dhuIdVvX3q3bIJDLjMx2Oz/YKpTGXR0uaZQjK54UtSW98=
X-Gm-Gg: AYBFou2EuvDlpqpu5MikZ8GcQczv4MRMTpaRbBqd539ooT28GpU8HuI6lEP5SURx30c
	wqpyfBKFJQOKT8uVmUnqQnbm4+JtiH9nzvvce6EcCv181Y8fbjublEOcTYOGj1GLb984Qy6Duf1
	Ti2sF3p67jUDXwyf1hVXbE02JPEkGTgZrtp9PUsItFonHCVxEohHt0/16jra6McfbZpG6vIcQKf
	HceCs09+UDka9Bf2hrwnYyu7E9KoTYfoYAFkjFJ7CQGr/NwNSRgORm4eBHYuAybJfCdgUjHSGcg
	UqieaOxC2HO2MkE6pxlKOQxLnWmVwjl9Qfb99RXbzXdx3h5IM0yDTQHfIbNPS7MF9uru1hFGaAX
	mBZjWTxxjt/Vp/WhzVMkbn26t7C1cvSVd52v/v/oIasrpXOJQ+aArW1zGYswl6q7IEhju/D7W8V
	nPpbFirFcwTvjR39MxgW/FwnYONq2FEDHLoOA0D4w3w+rfVd1bTAFqRXaFccsaVZisTCmhsTExc
	yg+v8wzt74h5Q==
X-Received: by 2002:a05:600c:630a:b0:4a1:6425:be69 with SMTP id 5b1f17b1804b1-4a1680e5fb5mr134722385e9.17.1791208963644;
        Mon, 05 Oct 2026 07:02:43 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:43 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:01:58 +0100
Subject: [PATCH 02/12] iio: adc: use named initializers for acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-2-2796f713945a@thegoodpenguin.co.uk>
References: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
In-Reply-To: <20261005-acpi-iio-v1-0-2796f713945a@thegoodpenguin.co.uk>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Petre Rodan <petre.rodan@subdimension.ro>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Marius Cristea <marius.cristea@microchip.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Alex Lanzano <lanzano.alex@gmail.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, Eddie James <eajames@linux.ibm.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=3830;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=xSpP4cJ4lXmtalES6iPeGHIxhLR61DTDlBLhfPYhxik=;
 b=l0+n2mxE225t+KjSEH8GprFBywSDtn+pK2JWX8G5FRpYBW9hCGwBDiiR5gHNpU/NvskpLcwXD
 HitLcKb2QVICPahMQzGG4E9nngiMuqrhV0viB5+ZGCOerb9l79F/wY+
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/adc/ad7298.c        | 2 +-
 drivers/iio/adc/pac1921.c       | 2 +-
 drivers/iio/adc/pac1934.c       | 2 +-
 drivers/iio/adc/ti-adc081c.c    | 2 +-
 drivers/iio/adc/ti-adc108s102.c | 2 +-
 drivers/iio/adc/ti-adc128s052.c | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
index c669022b5dec..66b8ca4e3132 100644
--- a/drivers/iio/adc/ad7298.c
+++ b/drivers/iio/adc/ad7298.c
@@ -347,7 +347,7 @@ static int ad7298_probe(struct spi_device *spi)
 }
 
 static const struct acpi_device_id ad7298_acpi_ids[] = {
-	{ "INT3494", 0 },
+	{ .id = "INT3494" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, ad7298_acpi_ids);
diff --git a/drivers/iio/adc/pac1921.c b/drivers/iio/adc/pac1921.c
index f0bab94462f4..730416ba147b 100644
--- a/drivers/iio/adc/pac1921.c
+++ b/drivers/iio/adc/pac1921.c
@@ -1322,7 +1322,7 @@ static const struct of_device_id pac1921_of_match[] = {
 MODULE_DEVICE_TABLE(of, pac1921_of_match);
 
 static const struct acpi_device_id pac1921_acpi_match[] = {
-	{ "MCHP1921" },
+	{ .id = "MCHP1921" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, pac1921_acpi_match);
diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
index de59dc27c440..7e18a8728bd8 100644
--- a/drivers/iio/adc/pac1934.c
+++ b/drivers/iio/adc/pac1934.c
@@ -1612,7 +1612,7 @@ MODULE_DEVICE_TABLE(of, pac1934_of_match);
  * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ApplicationNotes/ApplicationNotes/PAC1934-Integration-Notes-for-Microsoft-Windows-10-and-Windows-11-Driver-Support-DS00002534.pdf
  */
 static const struct acpi_device_id pac1934_acpi_match[] = {
-	{ "MCHP1930", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
+	{ .id = "MCHP1930", .driver_data = (kernel_ulong_t)&pac1934_chip_config[PAC1934] },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, pac1934_acpi_match);
diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index 2df8f1c21c2a..d222c5637a71 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -205,7 +205,7 @@ MODULE_DEVICE_TABLE(i2c, adc081c_id);
 
 static const struct acpi_device_id adc081c_acpi_match[] = {
 	/* Used on some AAEON boards */
-	{ "ADC081C", (kernel_ulong_t)&adc081c_model },
+	{ .id = "ADC081C", .driver_data = (kernel_ulong_t)&adc081c_model },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc081c_acpi_match);
diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
index 10959e835cb8..316d2eb16991 100644
--- a/drivers/iio/adc/ti-adc108s102.c
+++ b/drivers/iio/adc/ti-adc108s102.c
@@ -270,7 +270,7 @@ static const struct of_device_id adc108s102_of_match[] = {
 MODULE_DEVICE_TABLE(of, adc108s102_of_match);
 
 static const struct acpi_device_id adc108s102_acpi_ids[] = {
-	{ "INT3495", 0 },
+	{ .id = "INT3495" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc108s102_acpi_ids);
diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index 1899813c1aee..381e2121a2b7 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -264,7 +264,7 @@ static const struct spi_device_id adc128_id[] = {
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
 static const struct acpi_device_id adc128_acpi_match[] = {
-	{ "AANT1280", (kernel_ulong_t)&adc124s_config },
+	{ .id = "AANT1280", .driver_data = (kernel_ulong_t)&adc124s_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);

-- 
2.53.0

