Received: from mail-oa2-f10.google.com (mail-oa2-f10.google.com [74.125.231.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087BB36A361
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 06:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789538518; cv=none; b=Jh8H42s4xr+/sXyGV5T520nVO3NlG6CYzXXceYfNm7oGwzrhOx4FrczNpCPWYrh3QpSTDfaxWjJk6JpYzADSELC9P+XkQGr7VXD3ZcRukscClh1b90VMyF5i64Q0kLnyvSz7OvesLl/kN/+Uul0ITBmnM8Vx4SG/qLzduceC3aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789538518; c=relaxed/simple;
	bh=bMlyefeZy1oYp1vQJXlNNt86+odm9DEd0tpgl/S9jjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftPG8R/cFZ6h4x8Ip+NscAZW8IpCWvA/TFCHlvtrYTEMn/FFwwFIsI5ir+kyE4w1Z/WeikouX1XfVQpLxtNQ1xDBnO+IrhcilSwGm2tMRClNgV2FXHLmIqmQo1Wv+ESf9Vv6XzxcCMsgunmyQmXl9wymc9V390Cm9TOn9FHOG68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTnn0pID; arc=none smtp.client-ip=74.125.231.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTnn0pID"
Received: by mail-oa2-f10.google.com with SMTP id 586e51a60fabf-46ae9734a12so1416798fac.0
        for <linux-iio@vger.kernel.org>; Tue, 15 Sep 2026 23:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789538516; x=1790143316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f0l0dOxlq9FIh83bio/Qt5t25oXlLyhJQqJEQz9jJzI=;
        b=JTnn0pIDeRzQ7R2pCNHq5Io2Jkuk4nJpHpgBWYbVlAe4+5Tijjt8tf5/Ve1w/WRoim
         KfNH2k5WR0j50pqgfy4HBodc2RUzjpU0KnbN7Yah6bQpBYqkhfnLnk9gmnsnzJ+vI57R
         LXPjc5W/AUTid3xwP/KcyqVx99htkrqYfrXHKaMfw3NUU4YgDnJdh6nKl1GMiijsz5Pe
         qRDEfd8FKoZZ5ObBdbeLxMf5hp2qFHSUSTREjZKIPhk3ST8L4xmCYqUAcE80GkcApmpD
         8k+bfVCJ2B974tlPgUDlzlaGuDBsmGqJeCUYLD3RtdOkU1gDFDo2gcZY4tKGd48Xwqu/
         xSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789538516; x=1790143316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f0l0dOxlq9FIh83bio/Qt5t25oXlLyhJQqJEQz9jJzI=;
        b=znAkMOdfC0o1+drJd0sxKlmwYfa7yEnPvKP1nahHefibv5Bl1K7eFHrdJmFq/j3DVS
         S6HW3hHRC+pOnvy7Ea1gnu2kRLRrEFkY58N5+wOqsL7BRxtDjK+OvzCnB0Bchi6t4iYG
         VhQBPlhMDp+X20ncLVEtwIF1V+7kmInGIcUvpD+uq4Ot9ey6sV+MiAWQu19ukJajljJQ
         FNFPEArU4TKvrba/yGRcQ+CCSFnOmkHBUU4fpScZuJygBUG71gRgO250Rdp+CFxmdocn
         g6bdlvqgf9brmYUnAJuPaFgjm1AzRaEcoo7qURz1KeXVvtjVzSH5aS5wyCGghqvBG8o6
         xq0Q==
X-Gm-Message-State: AFuF++l1w3vjQ5zILPMOJ4QZg+X8LDM9/0hQUrawmcfAkz8ZDfCKKSCM
	UkE94ZKyvbTgxx4Afb+RkG1V4KQngILilHPYNHNtpjy++pbv477lAahYPt0GEB0PZe8=
X-Gm-Gg: AYBFou3Za3Yfn+niKDQ+WffC09JV1655a5sdD9x/NrIcYgIlmvB+4WREgbi5ONZruWM
	mjzpUsZ5slKBkBMMkD19+58aHu5RIfsI11Y9KzhYAUWixCg6ZfeUJv8DvykbeAr3tDtr6GPhKhi
	J0Gf3rRQgKXmKS1rZovuKvNJP4AULv7PrfvqVOdFX3YiiQ62yt8tnx+WZfPTJ0shfeQprvCm720
	FxyrpfHBu3SNs3X0iy5+6r/YcPAL8HiwEVJ+ztHtRO2S6OQcg/euGHEtfseBiMpMncIN6NHWyMs
	gvSbMySHtuOl6XxDCt2Wo83YgTzevIv0oRr0mfk4AfV1UNGJyP9x98jnFEoeM0m61U9QWKz6xRE
	mmhomaeMEmLxORmG4FaC7RsmwVP8BajCEXrox7t8vE9bky8I1k0qcsHnQ7o2NIQlKYEEHuzBPgv
	Zdty7WGFZyFS7RjMT2BhoR5yfEpEJR1CYZD8kOHCxmLTAANcMePmTySAbRFmdDnvMCfhmouJ2t8
	efJ3I4EzxociWRmahiVllHRJElkHA==
X-Received: by 2002:a4a:ee0c:0:b0:6b7:8415:d78b with SMTP id 006d021491bc7-6c7d3206a47mr1566149eaf.54.1789538515822;
        Tue, 15 Sep 2026 23:01:55 -0700 (PDT)
Received: from DESKTOP-M0MLFVC.localdomain ([165.99.41.153])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5aa1194sm5150929eec.14.2026.09.15.23.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:01:55 -0700 (PDT)
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
Subject: [PATCH v3 3/7] iio: accel: adis16201: add OF device ID table
Date: Wed, 16 Sep 2026 10:55:33 +0500
Message-ID: <20260916055547.15206-4-shehryar.amd@gmail.com>
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

Add of_device_id table for adis16201 and register it with
MODULE_DEVICE_TABLE() to enable device tree based matching.

Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
---
 drivers/iio/accel/adis16201.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 2b76a6b3d..cbac23d4d 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -288,6 +288,12 @@ static int adis16201_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct of_device_id adis16201_of_match[] = {
+	{ .compatible = "adi,adis16201" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, adis16201_of_match);
+
 static const struct spi_device_id adis16201_ids[] = {
 	{ .name = "adis16201" },
 	{ }
@@ -297,6 +303,7 @@ MODULE_DEVICE_TABLE(spi, adis16201_ids);
 static struct spi_driver adis16201_driver = {
 	.driver = {
 		.name = "adis16201",
+		.of_match_table = adis16201_of_match,
 	},
 	.probe = adis16201_probe,
 	.id_table = adis16201_ids,
-- 
2.43.0

