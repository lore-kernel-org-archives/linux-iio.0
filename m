Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B683D45DF
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683271; cv=none; b=K6tFhsrFLzcrDaGVy89SB5Iytc096yxgTpUBFIrGK/48RqRmVECD4sUnd+yobUvey/f4eWLixSocAjzLuEC6cBY1H2ix+uOcypfVQU1WwLikBvsraXXxmcOZwatyMONxOrojZgWwvDForgcu1e231Nsy6RwjDDBR6PmVfbN9zzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683271; c=relaxed/simple;
	bh=KKu9vuzjNh2iqUZwT5xjE/o1dLesFPk+03y2gSGMhFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADxhQ3NRFaMzNXH1VMQ+IkQ8EnZw0w2rxuLzBDUcOjIEG0zzM4JhgWJHNBtPUu7HqlxxsiVJ4SX+768E8fpMEHSbgwGMV+9HlgIHwf3tXZwCv/SbFhH108dTX6ux0irGEBKYZRebIPRHXLUfWdc65QIYH9cSeKeDyzrSPkX4clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Seuj2uvl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Seuj2uvl"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec449d0af2so661524966b.2
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683258; x=1782288058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2i1k8AoyDEf4+SEcMRPttiYCfUlkSwT7R4ZGBXCsSZk=;
        b=Seuj2uvl/9+wEOZEUExytld1ZS+46/FfLivxy3+PSQsYqdTMvu7F6JRigSUqqFDFAP
         Y7OVmlqKdgycRsE2yddzapgI+c5E/Pleyu5ALZJ/fQjqyLf3/T8cuLzI5FgmkK6wi1kG
         E/WIi+EDZfZHMhzOTYJCfhzlDYQELq3ly+gVdfr3xy0U5wlYY+lL38bpA72TAV13KwTV
         zcLq+AcHDslSWCp405e4eUG+FdrMkIXyoQORl7drXR6ao4R6Flp8EU4fEBGratJPYAbL
         cMzJCJIO9bGKDUISVufjCR17iW8CUViJadOQY0ePhKRqvoF4oMMK4uVLYpxzdoEe3/yR
         blag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683258; x=1782288058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2i1k8AoyDEf4+SEcMRPttiYCfUlkSwT7R4ZGBXCsSZk=;
        b=LPECR7JMWDego7/zUg0jq2P+y/aLngy2+1vmwevhlm5xK+sVYT7ppY1mhDk6bivTtS
         D91XLii2hcQ/B61aUK7GelvdnrGOmz21iDhBYBzgPeqQwE9YS6K0ur0bq2lSk/Fn9cua
         j9r7Cm069T+PRverJemy92Is61N7PDfXppeUkWPFJp5KApiTyoRTn6GygI1XfajJtKUD
         X1Z9w9q2q/ntSY0lQpLT3qWpREOPBoargq55nLiwIOgau1jeKyFM/aF95VSQAIRedY7K
         TJnHJ9l5aP/EgNKcM2S6kbZ0zKEX84fCvMzbLiRz0xIvzknntHzO6BDQuryT5FaNtp+Q
         J0QA==
X-Forwarded-Encrypted: i=1; AFNElJ+qgfOWS9b4VQD65WvOdus/cMowlAqITk7ojbot7PhpeN5L4S/c1W6J6XkbDZ7ToUmk9qf/w483Izg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymOToZwSkxom0k5o0n8pk+Z1pQdHTVaKuTzuJf4E8ayjNgS/FU
	MpVH05/vXNJTS6a+jLStm+7naNz8bynwS4x3oGg5EYDl/obhOkv2e+nU
X-Gm-Gg: Acq92OEM7d1h1trLFvU/Dwwcu2afiXs4YfCiZgw+YDu/QGMV5O3CgRAjhX6/3NpaL9H
	1MNddMQH2r+4l5FrgxeRNRearF0Vfo6Hme53k4sO3/FPNKcXOw2dFDlD+ixw5yIfPlomnnqVIvh
	wzLYZ3sHFdb2TOd0/QOKzb0ATMJ4/JGslDOP8TRnZAlyXTWQ1UqSOctCg9Cd81oZh1AP3RBUeHI
	rSghdTD/nY0+UBWdQ1eJ7MLneiXJTm567Y1ihtYauiAEd1irNFnvAWhT1o7H5E90MvIxYjEsyig
	vI0dAJYrlzB8RrOnsQH3kBCpnXbqPigzi9qiYBTW5d+9xhrdChGZ5gCNgx9fMg4DFZW0IKMYC1d
	U6NYMeTrNRLYAjysL0MFGc+YaNHWNRdxV8pQV/GE4ZTxhAwozW45tSpe7M7QNUF7wwMO4kU5seW
	ezSA==
X-Received: by 2002:a17:907:9305:b0:bfe:ed06:5a1f with SMTP id a640c23a62f3a-c05a83a199dmr195494666b.52.1781683257844;
        Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
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
Subject: [PATCH v5 11/14] video: backlight: lm3533_bl: Improve logic of sysfs functions
Date: Wed, 17 Jun 2026 11:00:28 +0300
Message-ID: <20260617080031.99156-12-clamor95@gmail.com>
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

Simplify the sysfs logic of properties by switching to macros and proper
regmap helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 62 ++++++++++-------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 2c24647fc17a..9eb0db640948 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -23,6 +23,8 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -85,88 +87,68 @@ static ssize_t show_als_channel(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
 }
 
-static ssize_t show_als_en(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_als_en(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	u32 val;
-	u8 mask;
-	bool enable;
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
+	if (ret < 0)
 		return ret;
 
-	mask = 1 << (2 * ctrlbank);
-	enable = val & mask;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-static ssize_t store_als_en(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_als_en(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int enable;
-	u8 mask;
 	int ret;
 
 	if (kstrtoint(buf, 0, &enable))
 		return -EINVAL;
 
-	mask = 1 << (2 * ctrlbank);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, enable);
+				 CTRLBANK_AB_BCONF_ALS(ctrlbank), enable);
 	if (ret)
 		return ret;
 
 	return len;
 }
 
-static ssize_t show_linear(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_linear(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u32 val;
-	u8 mask;
-	int linear;
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
+	if (ret < 0)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (val & mask)
-		linear = 1;
-	else
-		linear = 0;
-
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return scnprintf(buf, PAGE_SIZE, "%x\n", ret);
 }
 
-static ssize_t store_linear(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, linear);
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), linear);
 	if (ret)
 		return ret;
 
-- 
2.53.0

