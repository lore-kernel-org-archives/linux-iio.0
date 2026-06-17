Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D663BE647
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683262; cv=none; b=ePEJYyL8kkMw7t+zpovBS3G6Hu35sOUZq/q5k+1xmZR+/6kVQeL9iSEBL2x17WGLVSteWZhxVmFl+TirjEPxwxRWGnNv1uwdcFwrD8rqF+xnI+1Sk1sfpXE5jrpiaRo9lO++4J+OqHe4SHF5Oq0uHGz3nwzKBHzV7/Xw6lVmsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683262; c=relaxed/simple;
	bh=TTELV8IpYd68DmqOR1f5rOCgz/ySoag1Ez1+u/elF8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tWD1BBWN83QtkWCwJScF5wEzC3WE6B6D/fyFsvK/SAgL6C1MdBa31pLFagDmEnw1JX3vQDYSymz8IWq2rXpWcYB/fGCZxE8Qj4rFDAOQpplkZWg1syhVX12In+ShoU8PHyxEXDMAAmsO1b2T9WhmZ3KhS9YJWiHbn6gbuDBi95o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LQ/iw4xP; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQ/iw4xP"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6957f9ca40fso307594a12.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683252; x=1782288052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XN/2fWo04yb49XoOXlEMtfv2zfwELjeaHNjw1feXliI=;
        b=LQ/iw4xPQsM6MpB8IebcysDbUOYAKgmbUbwpBtuFDwI+niiWcvKe3SGf60jNnAxBKT
         wm6reAgrEKK9arskZozrm7cr+ubbjGSktQAd0o7Bsn2Y0TL8yhJwYVAtUSg3knqStRf6
         sytWKBe92DonLcFKr5+gbfQwQpwvWsN/7bb7lH98+VHcz70o8ooUTwNAHIwM7wJRLOtf
         c3YHCpGbXFxCEeMzxaJtDsDJln6QtE6nyI0l0mBSRTOTjR7H01XFTWIn6pAcgw3Bg6A7
         tOTOZl5zL/wQjloFUn0EufhkP6X5Dv+TqCicfHPQf3i54QP7SCm8jMpfjAF03KTSt8nP
         lYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683252; x=1782288052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XN/2fWo04yb49XoOXlEMtfv2zfwELjeaHNjw1feXliI=;
        b=oDeSOyVIDLoxl5ebXh6bCDvafwCw068x0aMAQkCp8MNuiu1nGWHF/TFzZzQ9JgWEFE
         pbcXaWYyoAAl82wQIDvHR+M+2tpCJQdiCyN7GUC1grWOm2Z6NocKel491WgbeGaZQ00v
         Gzk6XjIwNek7SkbDTSvOwH/H2Puzjjbhj6PwSkJELi/YdnXDTSW41qw/pyyHbtHNbtJS
         Df32Zj9ep0sjf3sbWI3QfzkOIHTn0EJX9U6KgRj2TKMTnwdy2H0GcLbiC2tnx39VaEiS
         xrSbIGHz1ajm3F1F6kIXJQUn7dsPYIai0CH/zvbJdG71IaI8Sk4BbMzquvJBjN01upCk
         6tEw==
X-Forwarded-Encrypted: i=1; AFNElJ+kJzLt0vg4dR9+/yaL0Zo65poWf2W6boyG7Q6OkJaju1cvSbg2mDGfl06iOTcISH+mpKGdpU/Pees=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEFXL3X/NEF12sf0jliYdG8fMOKMxZYncju/pDWehklPRWtWjw
	x6fC1iSgZMjuEGs+aQdELajmG81HVEa5955ZvHHGbj632vFKKv3sjaGC
X-Gm-Gg: AfdE7cmg1OkCKkVyheSnus4TNmdqoh1NFt95eAUBPVmjWriS4YAniCf1gjPsuJBAtiU
	rpYDaquRoLrr/g+SiB2/6sUbQo2noQgbEtprIXoS8nIFYjBwqLDOkbWyZubdqJPHlHXQ+9UmWEs
	nynZ/sw3y4Qxr/Uag9rbE99r48FWWob/NTUaarZb/BYe2gMUXomN6lpK3lLS1mZMTAuPpiLlS8H
	fvdK0aC5T2E36EqkFCR8q/RTuwm0kZFKleFnNe6xrd/9L6rpyN9iVHMqhjZTsnU/H7G5OcCyYuS
	OTUIv4XTwyPkt6Sn8S9w4qfyaYX2O+QaHcg5RYUm07qle2Fk/P3ljTZ0XhBGWI+XcYtoIPwnKo0
	RuX3fvHTpCR/nfWiw6ZjBo/riPxOeR6LfICakNVdu+EysRJ+LzKhy+NEl+Td0e9EJCymuehsrTe
	gf2erUKwSdizzC
X-Received: by 2002:a17:907:d78a:b0:bed:275:5e5b with SMTP id a640c23a62f3a-c05a77cb897mr178021366b.42.1781683252049;
        Wed, 17 Jun 2026 01:00:52 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v5 07/14] mfd: lm3533: Use dev_groups in struct device_driver
Date: Wed, 17 Jun 2026 11:00:24 +0300
Message-ID: <20260617080031.99156-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of creating and removing the device sysfs attributes directly
during probe and remove of the driver, respectively, use dev_groups in
struct device_driver to point to the attribute definitions and let the
core take care of creating and removing them.

No intentional functional impact.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c           | 16 ++++++----------
 drivers/video/backlight/lm3533_bl.c | 22 ++++++++--------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 45e7f7481aa0..b03a3ae96c10 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -296,6 +296,11 @@ static struct attribute_group lm3533_attribute_group = {
 	.attrs		= lm3533_attributes
 };
 
+static const struct attribute_group *lm3533_attribute_groups[] = {
+	&lm3533_attribute_group,
+	NULL,
+};
+
 static int lm3533_device_als_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -416,16 +421,8 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	lm3533_device_bl_init(lm3533);
 	lm3533_device_led_init(lm3533);
 
-	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-	if (ret < 0) {
-		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
-		goto err_unregister;
-	}
-
 	return 0;
 
-err_unregister:
-	mfd_remove_devices(lm3533->dev);
 err_disable:
 	lm3533_disable(lm3533);
 
@@ -436,8 +433,6 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-
 	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
 }
@@ -532,6 +527,7 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
 static struct i2c_driver lm3533_i2c_driver = {
 	.driver = {
 		   .name = "lm3533",
+		   .dev_groups = lm3533_attribute_groups,
 	},
 	.id_table	= lm3533_i2c_ids,
 	.probe		= lm3533_i2c_probe,
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 4d6f68033480..9ef171d3aaea 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -237,6 +237,11 @@ static struct attribute_group lm3533_bl_attribute_group = {
 	.attrs		= lm3533_bl_attributes
 };
 
+static const struct attribute_group *lm3533_bl_attribute_groups[] = {
+	&lm3533_bl_attribute_group,
+	NULL,
+};
+
 static int lm3533_bl_setup(struct lm3533_bl *bl,
 					struct lm3533_bl_platform_data *pdata)
 {
@@ -304,28 +309,17 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
-
 	backlight_update_status(bd);
 
 	ret = lm3533_bl_setup(bl, pdata);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	ret = lm3533_ctrlbank_enable(&bl->cb);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	return 0;
-
-err_sysfs_remove:
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-
-	return ret;
 }
 
 static void lm3533_bl_remove(struct platform_device *pdev)
@@ -339,7 +333,6 @@ static void lm3533_bl_remove(struct platform_device *pdev)
 	bd->props.brightness = 0;
 
 	lm3533_ctrlbank_disable(&bl->cb);
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -377,6 +370,7 @@ static struct platform_driver lm3533_bl_driver = {
 	.driver = {
 		.name	= "lm3533-backlight",
 		.pm	= &lm3533_bl_pm_ops,
+		.dev_groups = lm3533_bl_attribute_groups,
 	},
 	.probe		= lm3533_bl_probe,
 	.remove		= lm3533_bl_remove,
-- 
2.53.0

