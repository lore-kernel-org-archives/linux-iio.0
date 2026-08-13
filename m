Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CF48CD48
	for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635126; cv=none; b=Mo6nye/DvoXyZTkFdDiRNQkd1azTVMqh3StYJxRZVX/zbXpZza0jvPhMO6A1FthHmGlCQC5RE9STCgNHy3U30DirvAQC82/GZrO1UjMVcuPlRVyFqw9/0B1fJcwgK2U0PB6+VO5m9dUJ5pc/J1NzF2LABv/CYxZU6EvL3bRBgUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635126; c=relaxed/simple;
	bh=0weGnRdWwgswxJ4W5rEhhfCRwov11YGiMGfnVZ1X3gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gu+YNIokOQpjtpQm/GlE6ETJjaevVqyz8dVgVr4THiM/km5cXemyqcAzJH5yC2fM4w51Q5iLxKvkiwoKc3m7rLj5Ir09xfGTSnJD7N2VeKpx+5/CKclv1ceCIXiyLbgLp+rsy0/RWIaDNmOUQeO7OfGONDG/MbE/v/sX0g4BvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddcbPk+O; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddcbPk+O"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca80d708489so788853a12.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Aug 2026 08:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786635122; x=1787239922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRBl9QkRiwpLHI9/rNlYzWl0ldnHScwdP87IIdtHCSI=;
        b=ddcbPk+OhMbHiK7yRLk8Pe4BvQ8jX6Xsz8BOHDFdC0qpG/4IWjimNNZtSDOOSfp6IA
         FjZeXWJpD7APNgvYWMGIciE7EC3DWVWAiyHZalCgJWMQALCePVgmDhq+Vdif6GP+5/cl
         uMPanpV+k35mWVOqzYDiLFaynLSbbDr6I904vT4G59YMSoLGVoSwHXaqvcYxnmLWyDRF
         7rJVWYlWbl3cVUSKzo8izKJS5ekyuguQcVPGHLqOwpMNRzxNlxB1i9Mr0F+tyaLeZurQ
         IPjMeJ+63sHvcZfG/BPbj1NzV4LUoi5aRh1xM7L4w/ghsSpugPz1Ldj9MymySZ1/0uzI
         OkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786635122; x=1787239922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jRBl9QkRiwpLHI9/rNlYzWl0ldnHScwdP87IIdtHCSI=;
        b=R+XAPfpjNea5iIxlGK8tLs3qsahYnNArmJ5Jr9+bFP/GuupdRSF9nnwEeghkyZK+Jo
         7JUb6kPLX+2KswAEy/TGEsUIJwvGqhs2ZKFyu2mCXzWQh5Qd63Bj1R8R5pdPw3K6opG8
         InFDNshfGCmSxDPwXi2OSJcfQr4gY5zPYJXXFKZ/YHIkuJWI9LRD1ap87TMnzBms7zzI
         N2IysK8e1/RTGHj3VL/U//jFRIkIs1oA8ZaC496v3jM0dDySSbcm9N6Pygh1J6hG7qQd
         X7OOdojnjNPrPiHBJn8dZFChtkI8082Na+0yfvXldao2GZjMQUYanM1dQoDmjbgVi8Xd
         GlEw==
X-Forwarded-Encrypted: i=1; AHgh+Rrqgq/JStne8qxlVnZNXT8JvMikj1LY+/vFnQcGS6Y+F3UPuanL2IESA2LMKEyLSYg6ZiKetLVW8lY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsIPPtIfbDJPWVvg2l5Nlt7JDjn1kZvngKcdy+dKm9HEwlgD+g
	ifvT6EMIK1RJFWjGgVZKn7VSArGXuREHn1JoKFzBZO2ZtLKdAXdhf3mP
X-Gm-Gg: AR+sD13IdgparuBsgwcclfUBfPiPHlmVej3ilmGeDSFvkRxAs8MsfceeyA+MFAIT2Qi
	WRFxmI1LYg4pkzpF/2ddxvBFInV/3THMOhkAhDKeoF2iVMmcAIiPmMiZ2pGLu2iSUhdVmJ49ey7
	/cjQL8vW8cUSfMUBaUJobWc3aPtryN6JPup9SfGcFftGOQr8c7M9BcMuM8pkwBUq1TUubnxX0nJ
	M7AEcfcfFF/b8TyCFHfiaMU0XMqwHKIlDUkUFV6mQw0usywDyOr4Slsastbxy1KVL2RVRKUSnIu
	AN+RcjpjKIkrAxDMIdnd4yzldz1nQfzVqnqGRAEkh23/RteQ0En+nmgyynOppTYb7EG2Z/c8R+R
	ydPhNZHpaFKLZsveAt0aAr3WusSc2hZNs6if/VGvLbHGylhc3Yn+t05Q5Nej9np9Y9H1uhXUQec
	A3LtXPsPmyUo65QBcsUAb0hIESPhh7zktFIr6XfEcI3I+ypP6lVXaqk8+RmmjaV+QkF5yZMc3AF
	/SXrH3onYe9CLD2gDLEKY8KfaCSd9jPqunn6xF6Bv8NXNxRyFHNFH8JVjJxrw==
X-Received: by 2002:a05:6a20:3c8f:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3cc5769db39mr7615107637.15.1786635122196;
        Thu, 13 Aug 2026 08:32:02 -0700 (PDT)
Received: from debian13.localdomain (bb219-75-96-14.singnet.com.sg. [219.75.96.14])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ec082943fsm7960604eec.29.2026.08.13.08.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:32:01 -0700 (PDT)
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
Subject: [PATCH v2 4/5] iio: humidity: hts221: use dev_err_probe() in probe paths
Date: Thu, 13 Aug 2026 23:31:28 +0800
Message-ID: <20260813153129.12423-5-adinata.softwareengineer@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
References: <20260813153129.12423-1-adinata.softwareengineer@gmail.com>
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
 drivers/iio/humidity/hts221_core.c | 26 ++++++++------------------
 drivers/iio/humidity/hts221_i2c.c  | 11 ++++-------
 drivers/iio/humidity/hts221_spi.c  | 11 ++++-------
 3 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index b73c26aae9ec..fda38dfc6742 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -578,33 +578,23 @@ int hts221_probe(struct device *dev, int irq, const char *name,
 
 	/* configure humidity sensor */
 	err = hts221_parse_rh_caldata(hw);
-	if (err < 0) {
-		dev_err(hw->dev, "failed to get rh calibration data\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to get rh calibration data\n");
 
 	data = hts221_avg_list[HTS221_SENSOR_H].avg_avl[3];
 	err = hts221_update_avg(hw, HTS221_SENSOR_H, data);
-	if (err < 0) {
-		dev_err(hw->dev, "failed to set rh oversampling ratio\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to set rh oversampling ratio\n");
 
 	/* configure temperature sensor */
 	err = hts221_parse_temp_caldata(hw);
-	if (err < 0) {
-		dev_err(hw->dev,
-			"failed to get temperature calibration data\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to get temperature calibration data\n");
 
 	data = hts221_avg_list[HTS221_SENSOR_T].avg_avl[3];
 	err = hts221_update_avg(hw, HTS221_SENSOR_T, data);
-	if (err < 0) {
-		dev_err(hw->dev,
-			"failed to set temperature oversampling ratio\n");
-		return err;
-	}
+	if (err < 0)
+		return dev_err_probe(dev, err, "failed to set temperature oversampling ratio\n");
 
 	if (hw->irq > 0) {
 		err = hts221_allocate_buffers(iio_dev);
diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index 40276abc5d2e..e6dc9532cfbd 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -26,17 +26,14 @@ static const struct regmap_config hts221_i2c_regmap_config = {
 
 static int hts221_i2c_probe(struct i2c_client *client)
 {
+	struct device *dev = &client->dev;
 	struct regmap *regmap;
 
 	regmap = devm_regmap_init_i2c(client, &hts221_i2c_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to register i2c regmap\n");
 
-	return hts221_probe(&client->dev, client->irq,
-			    client->name, regmap);
+	return hts221_probe(dev, client->irq, client->name, regmap);
 }
 
 static const struct acpi_device_id hts221_acpi_match[] = {
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index e6fef2acd523..8bcc1b5d150e 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -27,17 +27,14 @@ static const struct regmap_config hts221_spi_regmap_config = {
 
 static int hts221_spi_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct regmap *regmap;
 
 	regmap = devm_regmap_init_spi(spi, &hts221_spi_regmap_config);
-	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
-			PTR_ERR(regmap));
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap), "Failed to register spi regmap\n");
 
-	return hts221_probe(&spi->dev, spi->irq,
-			    spi->modalias, regmap);
+	return hts221_probe(dev, spi->irq, spi->modalias, regmap);
 }
 
 static const struct of_device_id hts221_spi_of_match[] = {
-- 
2.47.3

