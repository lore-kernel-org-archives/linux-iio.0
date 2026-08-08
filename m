Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C793BAD95
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179678; cv=none; b=Ra8z49E2uieTgny6TaiS0jO6ydzvAFkmc0+S16KVFO6h3sgdZocLJAUc8RyJq/4u8ChZ9JjT74yas+h3RGQSb8lUN1seFA+ZaJ4aK6GGkE4KMGwGH1ukicvygJXRleQ0vJ+Jqy2PP0fcBBHsSoTH4SVNPEq2VWeFWlJjZXZk39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179678; c=relaxed/simple;
	bh=l8Qv18UovxownEXrOfGdKkbDuZk8btA6NtUxQm/Mqi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzAotN/l8GzZHpN0cfOqejSyLOdNxXHGHHhziisZiONfq9jWXucyd2OJnYlhDyv8dySnZwPKt2JhZB+zV+PiIRGEbhkOkkGF+ACvAWsUjmsS/yT3Gcaz8CmJnr296Da2CB4cliEiSEyQBnBwRBHl0T0xaTw/ugvBAPcINNfBmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dTW8yNoi; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dTW8yNoi"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84e04df8c46so294331b3a.2
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 02:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179673; x=1786784473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhrwdZr63D/YjEj/MiL58RSc/8ReOPlilFBlib5Rh+o=;
        b=dTW8yNoizBdtqHKWdPdeIcdt6aW7krngQH/ngfLGvbWcmkoH1tgb4yvLmVpt9ASGFj
         9C53ehgg/7q2q9lEwyw/t/tdb7pVBYfRMfz8Puvii44zRYIGONkScJp7dBpvwLhj5kWM
         3LE0KKbj2aE/BvMc5gacgvenEYdKeFundVPFIl1s7qdd79du4l1X6N38PZeGS+xJd5np
         9Cwzla76u+FtT0Nakue3jzXWbISnvmLDB4HrpEVIvtzfcjFkmgUvQrQs1HSiGi9V4jgz
         HrFhNT5opfBMLbzEzZmJvkRHJkIRwUZPwlC007idHqT91LCjegziWaHi7jA/h62quPPQ
         nFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179673; x=1786784473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dhrwdZr63D/YjEj/MiL58RSc/8ReOPlilFBlib5Rh+o=;
        b=os5ouo4btUhe5IoF7NZg3pmbpm/LvoFM37icZXJaWhjbDtnxxHhi048zaFjZVY6qhg
         nJsRSvO/ceWoZpeqCbvMFpXMjNnFF+9OzMODLmIlwR3+fm9i9nyBLh620YrIugKNzPpV
         ZHUuXykbACjFR12hxHdy0QkjLqODM6KOGKvyTD2vDkYWBBAQMKwTOMmn1mWem/bF4f9+
         vYxbymiA3nrTISJVDHTCMnQHgw9FiXWzJWIDq8ysXltugzRy9GGowO/lg/VubUlgKpch
         N6CN+kOa5qLKqAWhAN1t2WvMuDyqXOQScoM9vRTsJQkMcR5AN3k+rZjusU/2q77AxNo7
         96QQ==
X-Forwarded-Encrypted: i=1; AHgh+Roszt+FVAqSshKxvFcRSezBtqepT50Tug2ZX/Ew+EJf2ckFmCIPXmezfSP8j3dSc5Txl9epTNvIcHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWlgMtZAROpciObRMFaU8AuvwFpuFJ9E1QPe73NXf84KwhI0Dl
	W3yTVCl+VbFK52sdII9eJgP1fcOI57tn0v7iZoM3bsMO769VFWmTNFdd
X-Gm-Gg: AR+sD13L+Eoxxx9L7uFScFr9sohb8G5NGfb7iaIpnoueSASi4HpQeHN4GsDZbkOHFPb
	W4okpOI4frbIyoPVtKJxgKbFi2KTLd40ZTwY1ZD6QMUVTjKZ8NxK1YnddFH259b+gRdnyByjLqF
	cEcnwPxxCJ3dg36Wmk0wYXqDIjmL5xuxNK3rl4dhew3K7XCKgtLNp5DHsmkRJhSH0hWrtGFNp9P
	2I3U5UEjLSCYqsVdEQJfJYrxBAC5q8FBy594CWlwygv+3rP31wH39jKIwfhwQ7xlS5uScOpS1mn
	H1Z9wfLkA9cFdm1XUgvz7NooB1XVTCaXZEJeukjC0ZcAMD2UM5XWSQJwfl9wyL6kHDI//wMbb8t
	JF35r48qUMwFl0SuMAY690xl4wRSUIIOE9q01nyi8VioZ8roJ7yrd7SgVVRDe0Kutehg5CMZwik
	O47obMJuqURn3H9Zf9aP7CimwjSA1VndAXlu/FprZ5wKguQGAijEOUORQed4WsUilg6fQGSErws
	iGhFoHignybH+2SHcN7Ij0rXnThN4tmBeXLYW1mxfgKpPjPAmHhOlqiCA62/w==
X-Received: by 2002:a05:6a00:f03:b0:848:56d4:3288 with SMTP id d2e1a72fcca58-84f5df36ec9mr11268071b3a.4.1786179672941;
        Sat, 08 Aug 2026 02:01:12 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a51e9f0sm1973871b3a.28.2026.08.08.02.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:01:12 -0700 (PDT)
From: Adi Nata <adinata.softwareengineer@gmail.com>
To: lorenzo@kernel.org,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linux.dev,
	Adi Nata <adinata.softwareengineer@gmail.com>
Subject: [PATCH 4/5] iio: humidity: hts221: use dev_err_probe() in probe paths
Date: Sat,  8 Aug 2026 17:00:25 +0800
Message-ID: <20260808090026.34187-5-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
References: <20260808090026.34187-1-adinata.softwareengineer@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert remaining probe-time error logs to dev_err_probe() so the
errno is included and deferred probe failures stay quiet.

Signed-off-by: Adi Nata <adinata.softwareengineer@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 30 ++++++++++++------------------
 drivers/iio/humidity/hts221_i2c.c  |  8 +++-----
 drivers/iio/humidity/hts221_spi.c  |  8 +++-----
 3 files changed, 18 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index da773d2edc80..313c80df3f6e 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -579,33 +579,27 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 
 	/* configure humidity sensor */
 	err = hts221_parse_rh_caldata(hw);
-	if (err < 0) {
-		dev_err(hw->dev, "failed to get rh calibration data\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(hw->dev, err,
+				     "failed to get rh calibration data\n");
 
 	data = hts221_avg_list[HTS221_SENSOR_H].avg_avl[3];
 	err = hts221_update_avg(hw, HTS221_SENSOR_H, data);
-	if (err < 0) {
-		dev_err(hw->dev, "failed to set rh oversampling ratio\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(hw->dev, err,
+				     "failed to set rh oversampling ratio\n");
 
 	/* configure temperature sensor */
 	err = hts221_parse_temp_caldata(hw);
-	if (err < 0) {
-		dev_err(hw->dev,
-			"failed to get temperature calibration data\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(hw->dev, err,
+				     "failed to get temperature calibration data\n");
 
 	data = hts221_avg_list[HTS221_SENSOR_T].avg_avl[3];
 	err = hts221_update_avg(hw, HTS221_SENSOR_T, data);
-	if (err < 0) {
-		dev_err(hw->dev,
-			"failed to set temperature oversampling ratio\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(hw->dev, err,
+				     "failed to set temperature oversampling ratio\n");
 
 	if (hw->irq > 0) {
 		err = hts221_allocate_buffers(iio_dev);
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 40276abc5d2e..8f5fa7d3eaf5 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -29,11 +29,9 @@ static int hts221_i2c_probe(struct i2c_client *client)
 	struct regmap *regmap;
 
 	regmap = devm_regmap_init_i2c(client, &hts221_i2c_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&client->dev, PTR_ERR(regmap),
+				     "Failed to register i2c regmap\n");
 
 	return hts221_probe(&client->dev, client->irq,
 			    client->name, regmap);
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index e6fef2acd523..916fe8481c4a 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -30,11 +30,9 @@ static int hts221_spi_probe(struct spi_device *spi)
 	struct regmap *regmap;
 
 	regmap = devm_regmap_init_spi(spi, &hts221_spi_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "Failed to register spi regmap\n");
 
 	return hts221_probe(&spi->dev, spi->irq,
 			    spi->modalias, regmap);
-- 
2.47.3

