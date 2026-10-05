Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3E499F1B
	for <linux-iio@vger.kernel.org>; Mon,  5 Oct 2026 14:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208973; cv=none; b=PuVjazfH6jhWiKgeZWCx++ucNkxRXmKq3wl6E07sVVjbLUjM5rvPhkOmnxBBg21TJqTL/1n/PAXEHkYoRqTFwMDFJlpB6DacXF+rELbz7H8n9PZdVQ5WMr9Tgushh4Lu7KVM+4jIT3HZEA/CW4f8VNuCZs9TpsbK/v35bHzeY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208973; c=relaxed/simple;
	bh=A51wM/dP/syJ82c8bf/z3d+V3f9T2Qh8tOLnUCyrXF0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N8F8s9OQm9uLfugDxfDCOgQPrriRpz4r2QAM5Lfqfae8/SaPlH6tD26aKZJ+PQbkeWpUGehZM5t5UNUqaFzr+kczje58xeQDV06qp2Zs5PwDY7moIhlFN72NPAPkJ7Bqa8ezjRZLq0mH7JMiZ4mJ2+SzQs3NKGb9DvGpj148mLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk; spf=pass smtp.mailfrom=thegoodpenguin.co.uk; dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b=CIhMfnnE; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thegoodpenguin.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thegoodpenguin-co-uk.20251104.gappssmtp.com header.i=@thegoodpenguin-co-uk.20251104.gappssmtp.com header.b="CIhMfnnE"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a022e9cbebso15029345e9.0
        for <linux-iio@vger.kernel.org>; Mon, 05 Oct 2026 07:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thegoodpenguin-co-uk.20251104.gappssmtp.com; s=20251104; t=1791208968; x=1791813768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H3EqlIaMp/KOmVRZWYTNY9W00Fvgmc86X6lg1sXsMws=;
        b=CIhMfnnEKCWqxg3v28t1+7gcC1U7yu4preAcTKyy1dHM8iaqaFO48GM7P0prg3lgHC
         wCCnllL8GdaXZLoRTgj/sk3MMtLiQ2M03Fy2H1rQRGlYLsI67+7SDRmeTN4t5Vu9gRgW
         GYiPSbe8FltsJgMaZwhBbEMByC8VkN/+q07kLeEIKf4hKdj6bFYwf1C2ydnSTyh4LEv+
         EDmwzWAtWoJfvj9J9LASm7xFr8Ty4GNFlA4dsGT2rPIEzpGGC82k3wcCODdB5cP0hDoF
         FY+z+qlyMXoLU62AsqvnnDYDyklUOJWHt3jM//8/tS6TcqcdKp6Nimm23I+xMR02aoW5
         KpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791208968; x=1791813768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H3EqlIaMp/KOmVRZWYTNY9W00Fvgmc86X6lg1sXsMws=;
        b=oNRMqXfrsDT7wWge/gvPlg1WzpQOtd4MHBeSr+4Nwy/GgFcwe6fh9eFPiP6BHeKzBs
         9N33lUEvrudlDrO90/tTIQvJ7ANlvLYbMZ6HSigyuxLo8mwa21QHOcsVrbCO1nPCPp5z
         dhCQzGj71DUU5fEO05dAyiqzfcKM2dQJKS9oOUmEXiren+pAelDaR3AwctaoHbJrbGTj
         4XnkHh7HGUutcxGhDyN/MRNqlCYDwLIPWwYGQLfmUit+3mhUoi/HXsnztbZ1imxpMyWJ
         rTiJOdUJk/fyEXusnv7nM5EDRU39Mr9/wLCjWDHs4BMX/vNnJjOWvLXg59tCDQg4slpH
         CLlw==
X-Forwarded-Encrypted: i=1; AKwUvBzGRJYbQTkYw7Vfu4Rmx9G0bpxYvl54j5IwOWAtWdwrW7hMsaVJIGOAiRdnWztgS3KGisULMmbkWes=@vger.kernel.org
X-Gm-Message-State: AFuF++m2Z5hMPni745h8HIQcbXrF9g1OBmP9DdBYfRhsSqrZ4CnzCm28
	dgNQ73YZQWCIUOUbeMB9mik5XqnRrNimaF+t3JTfihhUjQZl6/zMzsVkiJurCJGqRg8=
X-Gm-Gg: AYBFou3NQAqESOyoF47Lxnn+bDEmSpFV5pG2lZxL4wxyDEDyluPOWHc8z+1+SgYOyDr
	ZHzxzjb0uo56lbQDG+sws2OsdFF4iYT42IocANgvl43aN1AYNamFZkezsHWK9PRj1wCUcwa9fU7
	23CjWIZLr/kRRvlt70NZSi1bkpmyPzk8iUwrARbqx+5ofjOZzQ5EArQVFeNuapEgGLbG9LoIKpR
	hPQfECihWD4etLW0M8OYr04cwy9r6YWJ/zqd+6J5a48oJ5eKIf8GNb+GxuG8W8arfzbNTX4QH3q
	QVrxl4XWx1DHdGIINgW4B1Q+CB6WgwAda21LvEPOROs4sOZyU65y5WQHJzgFn73K/ryQXzhF4rA
	dGqq2ORgqOxSoF9u4U4a0Poir78NUP5vukItwbxtCtzjghnGqbLOqViWondfGLoZia3fp4T5X+3
	i6bsP+vc4R3fpnBpWxNrvlQhL/DpoNF+vNlMZDn7mjMpfl6+m0qr38QmVL/Yb6boP3SlYG5wQ5r
	GgF/N43k7+bUQ==
X-Received: by 2002:a05:600c:83c3:b0:4a1:6f78:8419 with SMTP id 5b1f17b1804b1-4a173633d2cmr38912895e9.0.1791208967680;
        Mon, 05 Oct 2026 07:02:47 -0700 (PDT)
Received: from [10.42.0.1] ([2a00:23c7:1d1a:9c01:9c1b:24c4:d43:125f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a162e867e8sm324052715e9.15.2026.10.05.07.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 07:02:47 -0700 (PDT)
From: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Date: Mon, 05 Oct 2026 15:02:01 +0100
Subject: [PATCH 05/12] iio: humidity: use named initializers for
 acpi_device_id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acpi-iio-v1-5-2796f713945a@thegoodpenguin.co.uk>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791208959; l=1405;
 i=pzalewski@thegoodpenguin.co.uk; s=20260430; h=from:subject:message-id;
 bh=A51wM/dP/syJ82c8bf/z3d+V3f9T2Qh8tOLnUCyrXF0=;
 b=1ie1zuvKWIZWgp8aBP7W9F5VSoNqkLIM4Vc51mi56/GtfjSg/zjQLZC8wGkz5pBoc4LHQ7dip
 buitnoUxlcNBAsBNreq4q12iQh+6yNacbR3xTgsu+quBo5DvDUEVYPI
X-Developer-Key: i=pzalewski@thegoodpenguin.co.uk; a=ed25519;
 pk=vHq4n9IonORH2GTzLv8r6CWAFHzgfBuNkQPXA8NSly0=

Use a designated initializer for the acpi_device_id fields which makes the
code more readable and consistent with how lists are initialized in the
rest of the kernel code base. Also drop explicitly setting fields to 0
where it is redundant.

Signed-off-by: Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
---
 drivers/iio/humidity/hdc100x.c    | 2 +-
 drivers/iio/humidity/hts221_i2c.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index bc452cc8fbcf..9f07101d37f7 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -400,7 +400,7 @@ static const struct of_device_id hdc100x_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, hdc100x_dt_ids);
 
 static const struct acpi_device_id hdc100x_acpi_match[] = {
-	{ "TXNW1010" },
+	{ .id = "TXNW1010" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, hdc100x_acpi_match);
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 40276abc5d2e..23fc1d820abd 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -40,7 +40,7 @@ static int hts221_i2c_probe(struct i2c_client *client)
 }
 
 static const struct acpi_device_id hts221_acpi_match[] = {
-	{"SMO9100", 0},
+	{ .id = "SMO9100" },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, hts221_acpi_match);

-- 
2.53.0

