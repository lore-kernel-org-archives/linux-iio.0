Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA554BC02C
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650628; cv=none; b=gkLcDjJKFFuuSJgp5Xmw2nPDW/PKiQFV5nuWTvPrcGHUyY7RJPiGgtudCHvNAGHYqYZvUgkfzPLeZa+OvEwhOrsuZYWDgIpG0VWg19HQBSqPYsBMED/Vr0EJd3QKGpWIWOAnJqtaVyAm7T26F8mEFs2yi9XaPsFvQlrOcdeDQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650628; c=relaxed/simple;
	bh=cQOCyWEIALkdoLR3TrYUhtEyJOAoHDyTYq9GcxdQAAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgecZrceClGt07Wxxy3cUD6k8agqw6PIP1QVHxFzPbQw129MeNpGJBZwAbSrytb6VdH4NJcCcjPBdJPteMJnurG3cWVYFwh7wMiSbIrNNn34TRPVZYFl3KqFFq5E0CrTvv219egNwuNUZA7vRunh4jJzEzgTtijexeFXjxKecVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuAmDL/N; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuAmDL/N"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa7a7ad4d3so1370329e87.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 02:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780650626; x=1781255426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=awNPDfMBLScbqNNAfmJZbvI6wRRhBZ6Yy/Wt1gz41bE=;
        b=HuAmDL/Ng3heZ0WZ1Re4JxpincnKp0EIFGD2wRz+K5BCF6eMofxxyrKV2aAf4NWGLY
         7VCZ+vgu/REuenqOokTHZ7Uj4AgxDtcVHUrqaiKr3juOvXp92LM+7rAn16RH1Zb5v+f/
         H8UiHQKW4iiDZYYr25q4ao+PfNEk8pJIw3NccGc8nnuknSXsKmt0aOE/CRICLC2vOxrG
         IAHbh/oV0al8wJTuFRQJOMzxBcj9APAV+kBT6qMaFRoKciBIL4+Sb7RVXAXVqOpbK/N7
         UWrHCGNORC2Iqgn9snseqgMPJDKgMRAnyGWFIix5XtqCfXzgkF1cxaWFVGpq0HUkfZ7Q
         a0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780650626; x=1781255426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=awNPDfMBLScbqNNAfmJZbvI6wRRhBZ6Yy/Wt1gz41bE=;
        b=GYtgBU100ERv5RsbFL1bXhIGx6Ley9IuJTRTuH21orbMHP3n4zcm55uwBi5Ro87Bs4
         lrvGqj4JHNoEL3vThyMIybqOGlBGI12bYHYEeY6UfKYkod7Qrv3CfDcM2jV0OAMS0jBf
         Z9isaXFHpp93ScXwPeDIqsr2aVQV6gbD22oeAQ6WUEHK9FSTQsmQQ4oug7DIBmlxvKnM
         1JxiWwH7bP0uTFM83cmoD0gr3zq8QssM9MSOr9kvWxpwnqxAKnlz5kq7IPTBP+BC9alQ
         sTnRZPugNIFKXjeMwYFd3ikmg5RFmJmAgA+eglyhQiOM86XdYCvKuR0l38/w8XkhCYb0
         yllg==
X-Forwarded-Encrypted: i=1; AFNElJ8d4anXiToA9fdYQCpnmRnyrkA9WShtVtfyYQGsr345pW2i+WlhBTNqVzB65coAFjKt0Opa6s1nksA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcrM7EkJFvSSjiFq1H6m+v/9pf54FunevAZpBNKlfKrJdCo8a0
	21xvp29KzGp1aGSSEo3D/BfnGz25f/kozPy85MP3bjnJGLiYSotxKHJO
X-Gm-Gg: Acq92OGo9veCh9ei2U7ZYdrxw9AJbZfqfNKu8Ioi4TbmMPyVabqJTxVXZa3A55pVbEs
	hoZz0YzlGohWRy/gkz/nG+RbA04hhmpXd4CEaX2MfDRq8YeFTzakzPX3tSZjvgR5UXOBDpSiQbN
	3sRvYYg+nUTE9VFbBYyO5b1ei4cCUGzNOerJQ1p9H3PGKyCwhRtNOqA6NLpPcDgWOGPkb3V6BbP
	Lmn7Kii368bW36x+PsZ3K+PTrQlUIUdDetne/1o89LP/4gEW8d6n5tpV3d4kun0CLu3hVT6xkE8
	XqnWyqLJDH/a0NjgJlfA34xA1qyFBRztXhxQuOHOMx5H+Nb6paVT7FvXxPUA0S0W1oEFP6dX+5O
	c4sKFW4K53EMxWKIJEtIbcNVhfQYgyM/HUdyqSydxI1lcPei1rHBi8anmlETzO7UQvHgagI2xaa
	VtsoFAh3nsTPce+hT++1lTLypGNqcj9cpp62QrPn+s26k=
X-Received: by 2002:a05:6512:ad6:b0:5aa:671d:9966 with SMTP id 2adb3069b0e04-5aa87b40683mr814399e87.6.1780650625403;
        Fri, 05 Jun 2026 02:10:25 -0700 (PDT)
Received: from new-nest ([2a05:3580:f312:6c00:1b49:dfce:283c:7307])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b9903e9sm1705914e87.69.2026.06.05.02.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 02:10:24 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>,
	Rob Herring <robh@kernel.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v4 2/3] iio: imu: inv_mpu6050: use devres-enabled version of pm_runtime_enable()
Date: Fri,  5 Jun 2026 12:09:39 +0300
Message-ID: <20260605090940.1103750-3-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
References: <20260605090940.1103750-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Usage of devm_pm_runtime_enable() allows to remove driver-specific
action, that does the same as default action.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---

Changes in v4:
 - update commit message to address Andy's comment
   about functions, callbacks and runtime PM names

Changes in v3:
 - remove extra blank lines in "use devres-enabled version of pm_runtime_enable"

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 8c8b4f9a8ff63..6fd35ea5daabb 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1874,13 +1874,6 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
 		inv_mpu_core_disable_regulator_vddio(st);
 }
 
-static void inv_mpu_pm_disable(void *data)
-{
-	struct device *dev = data;
-
-	pm_runtime_disable(dev);
-}
-
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
 {
@@ -2023,13 +2016,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 
 	/* chip init is done, turning on runtime power management */
 	pm_runtime_get_noresume(dev);
-	pm_runtime_enable(dev);
+	result = devm_pm_runtime_enable(dev);
+	if (result)
+		return result;
 	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
-	result = devm_add_action_or_reset(dev, inv_mpu_pm_disable, dev);
-	if (result)
-		return result;
 
 	switch (chip_type) {
 	case INV_MPU6000:
-- 
2.53.0

