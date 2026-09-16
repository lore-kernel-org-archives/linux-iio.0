Received: from mail-oo2-f0.google.com (mail-oo2-f0.google.com [74.125.231.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0520D4FF
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 06:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538509; cv=none; b=qzU61uqvzXV3/eHx+XQN9qou3MUQrPtFPfhJt/cs0o6ww6Xq34Panj8VvsSV06n2b31WWwB+DPGWkN1ym8oI5dreA4Qaksic3w7Gy+5wMMacIOVChX8TSRScNq1Qtg9U7knG7sM/YUqCJMjDfCe1sVd0ZHY/C29u7llQWmRa0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538509; c=relaxed/simple;
	bh=jdjAPSPLuyxRLZ1jAdbxmzWn5IkgNSpN8s2QXS4iXI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oL8F6daYYF+E/UZf1BjfTydPmoYEvwoDO2wngh5ZHMaovUiQAMQ80iPhwTnv9UeQDOgSqfYu2F2rx8V3dvpGQdJdgcsbeB6ljabXjr0qIWwrKwOPW5+1/PLw78kC16ilXpFZWgBVedsD+fSnYU1druGonj4K6w9kJt2wDPYJD2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7ED/rEN; arc=none smtp.client-ip=74.125.231.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7ED/rEN"
Received: by mail-oo2-f0.google.com with SMTP id 006d021491bc7-6a3900cb2b5so2284564eaf.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 23:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538507; x=1790143307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlprtAOoVlPqxqtboFIENF5edZTisK8lwKsAslAoF7w=;
        b=l7ED/rENgmRd6+SwgGaIsKLlLtDGdoNOmYzCqsL3Cj0274He1L/cND0s+TXGfa/Mte
         JMrA2cxaPE2LIzxFGprgskkSquDvc5TxvDKAJG+ohWeiOghLC+Z5ndwgTZI5wVDIDQbn
         mWK51pwo112zSLVaxBgsuE0UFLXcjt2VQtO2saLeBXFxhSZEkAYDjHQAoW7oHetIZm7x
         aJIaeQTKWAJiFgbnzqXIz22kzXqyBzFWUePC+HQi9Y5qGwG9wKZNosi2shYtw3HJagDA
         Ix2umLt4dy9ekPoUGLz8z6ZC5bvMNWbhRZSNQoQttHx9uA4x3JWgvVR0OJ0yXqEShS73
         wFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538507; x=1790143307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlprtAOoVlPqxqtboFIENF5edZTisK8lwKsAslAoF7w=;
        b=TmC8+bE4Ealm8fN4562RScqJL+ESR6dZI1mnDFzWlApzinhupmDl7y6SB7xzwJ0Ulk
         68giFLQckU1MPG16DfIlSgRZEWMax7rpYS+jTUXejAhcZlzmxn47pYdWi8TjwSuqFWre
         yaYjTl7u3ZTfxbWWwwki2VB8P23Jmq7YWcsmpbDTo6fY8augcs64vaQM4SqTZnzertVI
         P33tjRxgdQIaWlwdnfXCpcOOeeskTq0VoRO6PXYpMtr8PObUmoJkC9eyNlw1e1B9C8Cd
         2iGJ0JpoJYyo3DpaMtBGZn/ZH2FXDtq2VAOHJ/KaPl1aHJOYZnKMgAWcFfdcRq4UgGb3
         165w==
X-Gm-Message-State: AFuF++kstPGZ+LEeNCpE6pT+sv9jUzTSXtTgDZU1s1bDxmBIE1EaRdbe
	o3bnlla6lF97DsSLQ/SPrrKab8IA1M9dgipsw6igHt8HGotj7w8yocn42Ry5Vrftj1c=
X-Gm-Gg: AYBFou221rduBya2HfykO73PyDG/GWCb3G5TQU3q+RIETooHi1UkxBsPRYsYCb3OKUd
	q/GCcork2OCOMrAc2JX5yMOBxr6Wy/tCVStRFi7U/bkbJ+c3fe9WzEYMXqIk33gX1ifDmIPmTJR
	bi/U2vc2ZBt7aKXac1fe7A4kqrPfLXfseUNy9qnY6NpvODB4BwK8G6lmTGaxTru5ZYp98uyJQoW
	tEDZx4ww/2R7Y2xxZYa9FkOPmD8VV2g/rZArZCsRr3fw2Aiwnqdtslnal/UxDbfbRmNPg/WlsJ0
	L/Vzt+hory6ApM+Y4sdB6JPup+YMZFOs0kpa8qEioQDshVUhWprhKQCm6Su0l9/mxAdKBItvGcZ
	3mTNSbOQurM2pKAgtlFh2jTEVlBMTFHOjOOXZhHioxAUp6Isz6Z+XjAORcqjSNpEDA5T8KiyZFG
	XAZkjYlIqxugEEarECJ9at0t2cmBdHabeW08bs6nw1glf87OIMLS3uCACcni6UZQxHVj/FCcwJn
	j5wAKED3eX0trC2EsjeaGBd6obR0A==
X-Received: by 2002:a05:6820:1c9d:b0:6b4:117e:543 with SMTP id 006d021491bc7-6c7d0eddbd4mr1579180eaf.21.1789538506965;
        Tue, 15 Sep 2026 23:01:46 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm5150929eec.14.2026.09.15.23.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:01:46 -0700 (PDT)
From: Shehryar Ahmad <shehryar.amd@gmail.com>
To: linux-iio@vger.kernel.org,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Cc: Shehryar Ahmad <shehryar.amd@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v3 2/7] iio: accel: adis16201: add SPI device ID table
Date: Wed, 16 Sep 2026 10:55:32 +0500
Message-ID: <20260916055547.15206-3-shehryar.amd@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916055547.15206-1-shehryar.amd@gmail.com>
References: <20260916055547.15206-1-shehryar.amd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add spi_device_id table for ADIS16201. Replace MODULE_ALIAS() with
MODULE_DEVICE_TABLE() which automatically generates the same module
alias.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16201.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 834714fb9..2b76a6b3d 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -288,16 +288,22 @@ static int adis16201_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct spi_device_id adis16201_ids[] = {
+	{ .name = "adis16201" },
+	{ }
+};
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

