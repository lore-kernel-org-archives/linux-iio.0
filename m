Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170EC39A4A0
	for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 08:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289636; cv=none; b=Ddb+HS3xNO3SDV3ovvU0ecpPjEIqg+CPZAf2VoZK2XKDSY/spKjS8zaab+OBGeM/ioc8WnOR3F8QLrYTyonpjxS6qHqwXEyBR3npXos2ogy2mWnzWUSLx50HBJmzkosrrSX62V5+FFU6DOI2zYz34+bghjpBunAGnVwAfvPAsvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289636; c=relaxed/simple;
	bh=3+cgl2lApzXM57QbowOk6GGJ+xHrzWmluYrLDPam/Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uCR7Fgre6vphKU9QNmiOvrJrk72emjfh21nUVdfUnZr6ocFMU3LWia2hh4l0o7N0ir1tI4BDeAEYSl1amMJDPg+JUJOUFDPcRFJTLMAsZOJj5vwV6SWuBRGZW3g+p3TDaVI6P7LvHniussO1L0ocBRnrTsJB534R7ZiPJWkpfII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fq5QxBpa; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fq5QxBpa"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so645026f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 13 Sep 2026 01:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789289633; x=1789894433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uOdml8t4+a2r4TluaWsnQnPMm+X8XLNBiqhXtFxxsck=;
        b=fq5QxBpahrv+jiIYVzyNveZEQBLfAo2e/h8lMGtG8BFn3flSQbTQ4FPTt+qQW3Qep3
         kTxBsXb/WD8kKvA3Axlpmsrh7ueLU/1JuHh70tvKwafSDJzkdchgXiharHlZ8gopxbPb
         ZdiBTCYCEhm52ZX5/45guzUIB4O4VyvPCvMJg8PgvpKjyGXXa2pEnFRW2u87ELPo65F+
         oyJwUEkDO00hHeMrvvE8dsfoBWGc2gay5PuS/3eqyoRKwckwFs1+qnVb/W2RBJu0RfoP
         Mw8//lqS6YfI8EQWByc62MaBmKJQPt9WYlK9heZncGg+6LktLM+MuaaDWiaHOzz2dV1r
         B02g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789289633; x=1789894433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uOdml8t4+a2r4TluaWsnQnPMm+X8XLNBiqhXtFxxsck=;
        b=gqEvQkJB0ZF07jqBQOY/kKUXJRw2HC/2E8N9MHbAp4/Hk0eLmQvtwj/V8bMbZoK0HS
         g3E1FhYT/41JaqQTl2hLBOZuwQZFooSEGSH1hZ1cKC9HZuR+M7OKtA6m5pwrFsRDGQWN
         P8xJICRwqk2MUXLa8/E2rZPVfKUuKiJAjcc6wfb4Fvgqpm9oNFDHZZO1wKird87/Nm8S
         E+3FUzALYsLaSgnjfsd4xAUhEM4kCDHGUbR1fNp5F4hZdli7QeedwARneOR1caSsi2+x
         tr5v5AHvhKlNbynl5qYCIj9GL7vT2xO5QIcBc61NkW1FIS9i8v4eXdD1Epv5iIQkszH9
         mPJA==
X-Forwarded-Encrypted: i=1; AKwUvBxXTo6poYb1FPPtQy5n0Pgzi6d+dQf51KvJyC3SjT10asVYwsIO3jBJuFLpSB/WorZgfnpWwBzpOPw=@vger.kernel.org
X-Gm-Message-State: AFuF++nVovN+GomRvw9Bxu5AeU5ipdtEL0WpLpYJwhXBgIXYUZNPQNxN
	s9cR5adk/bUhXIlaCx+FQ6c9zy7u75sd/kjoDoP8wCHfuJiJCeamItDz
X-Gm-Gg: AYBFou05zcloPBcyG6OtRPXyD+rZKlCt6jBoTjSVOL0LcL2/etjmjwfrDbmR8OsCy+u
	EjPk2I1+6nSX3oEixRf56Hkn6aXWzlWhBgnCITSBlYmVMpkPVG59Qz8iZ9bgAhBwbcdn6Fky1Z/
	ug3CZOhUQqX7RJU9jJWenaN9rPKqr8kCJzsB20e8kR2/gbTIzIuP/51SEMGlFrsFOiArSFuwL9A
	vZOzLE4j3MLzDUMVylktW77PG+PnocePq5kvKKbBsFYl4DSAXBc9lOmUUCRIbS6lc/doeKnrHen
	Tc6/a+4SXhSBOmgtSGE8KPtfljO2pS00DOwSoQEukvpZyPta15Il9uQVIZpPNdOOusW9ldoRMM7
	uopBydbJl2sk80mUhZtM2KLgLe/Si0h7dT3PVRoA6i0j6WmRAa3N+j440qWtUpf7iXW6WMAf5pY
	0LUycmEDRkBJr/gCmuDq+sTuV6MkJVMxIyk9J+VUvC2NvGLhJTwfXbJTNB8Gz2xXQYY16jqQGUb
	vNyoybejpkSEqYfEBo=
X-Received: by 2002:a05:6000:2084:b0:486:f455:403 with SMTP id ffacd0b85a97d-486f455045emr9034370f8f.57.1789289633058;
        Sun, 13 Sep 2026 01:53:53 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.145])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb32e7f5sm18228489f8f.9.2026.09.13.01.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 01:53:52 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	gregkh@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	devicetree@vger.kernel.org,
	Shehryar Ahmad <shehryar.amd@gmail.com>
Subject: [PATCH v2 1/6] iio: accel: adis16201: add SPI device ID table
Date: Sun, 13 Sep 2026 13:53:02 +0500
Message-ID: <20260913085307.13846-2-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913085307.13846-1-shehryar.amd@gmail.com>
References: <20260913085307.13846-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi_device_id table for ADIS16201. Replace MODULE_ALIAS()
with MODULE_DEVICE_TABLE() which automatically generates the same
module alias.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16201.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index ba0f97944..1e76a3560 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -288,16 +288,23 @@ static int adis16201_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct spi_device_id adis16201_ids[] = {
+	{ .name = "adis16201", 0 },
+	{ },
+};
+
+MODULE_DEVICE_TABLE(spi, adis16201_ids);
+
 static struct spi_driver adis16201_driver = {
 	.driver = {
 		.name = "adis16201",
 	},
 	.probe = adis16201_probe,
+	.id_table = adis16201_ids,
 };
 module_spi_driver(adis16201_driver);
 
 MODULE_AUTHOR("Barry Song <21cnbao@gmail.com>");
 MODULE_DESCRIPTION("Analog Devices ADIS16201 Dual-Axis Digital Inclinometer and Accelerometer");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("spi:adis16201");
 MODULE_IMPORT_NS("IIO_ADISLIB");
-- 
2.43.0

