Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0E93DB625
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327166; cv=none; b=ErL+pmp87tZXUK4VBAvyb/NI0BKwtyPL7+awgVtfnl/RNCfLkLQONWEhZ1pip1lipqKcpD3RsqdPs3AuM4yyQNXmFgLaPieXG3dG1SPW1qXk8b3zrNiNI/SyJ7xQwUXV1PvZGimXYNRIkZUaEfPu8nWBWPuJZSVNGi6LbHEWTb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327166; c=relaxed/simple;
	bh=+XJVhU2zPkpnCe5OFCObMG1j3Sj/CGVdrvJ521UPM9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jiWJND3RA4Bl6oQnjO7Uxkt600FfEeE3GuNfK9bYKfLF1Mj8vVLiGzW6eQZWha2o2/4+N0Ajax1Wz8s1jVbhQu6rwdFXg9H+x0gwNnfyFgGWZQwLMxu96pNRMQ0/LbW3o9w9YcMvYRuGZCSbAleZ+IVA8We3R6qDx/YzGlDF9OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/pp/l99; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/pp/l99"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-490a765d410so17456995e9.1
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327150; x=1780931950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeSJxuqtwsz6jGt+YVFicWB8+6LnFt3NUvnbNkDL/mA=;
        b=V/pp/l9948g7rakEOQUQ390K7N9kJ7sXVs2zB9cQnAKPZYPQ6sZ1YrD4Koy1xcdl84
         HC4gfDOvOdMpPzk/qeXJLABpNiGwsBwt5ITlcPpK3PzkE6z8hJlsRgki1V1byJy0VWld
         4SEsVODptC2xv8sv58A4/pQq4icscBd+TTnMfcbhYPLvyxdRtRqOU1C3T5cmPbSdrrXh
         azI4KW6a9DXfUyqgjRHlh15vBYBpRG+o/nGy30xa8l22ZjenhGeCEleWIyPfDLdnmklB
         Dc1T8b3lly7M0KBDW58x0yNaIBxrPdIfIIzzIOefLFzWsn17usNDYX46ATubZGo/QMMn
         pGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327150; x=1780931950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MeSJxuqtwsz6jGt+YVFicWB8+6LnFt3NUvnbNkDL/mA=;
        b=QtYrJcfC4C6TMK63ZBQTV4zqfilAqAdSTm5rtKiiQA/AKiqJUaQQ8PeLhpHk9doFU6
         yWw1Ex0/6BvnQbiaIJ8RRs7YDrxy8mrZTeXG9+jMnuwE5m3sPW2pwtlEGEHtOQSuKzvN
         GhTJ7SgEbeVSeJHkw9VoWySzpd+s7Z9+JiUZA7Vh+sJ+LxkRoTDSiwgA7jRr6TDoEyll
         phS9jLuUZfN+okk0wAcfBpAzUX/JcgBaKu+EfCIDG/JYB2Phe1b8hfULj7lD86hBSoo6
         tbtBGd5/vQs/Y3LdjCEdr1WACwcqIRmuaDBCQ6Jmf7EKS5unDyXA+WauTkD8mn6i+ui+
         FADg==
X-Forwarded-Encrypted: i=1; AFNElJ8it3AAf34EOi0WGYZKu2UcKRwstqVrE6rjbTpuM26x1IwjWjeVqbnB/DfwjYmAB8yndyd0M6Q46Uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvWt+QEk3RW3NaV6e5T8b26n9d6Plu92TnzMVsnT1tV8+j9RXy
	QoDGw6PyaN3/BYTMO0QCWsIFH4BJmvsVKK/BUE438dsDwKpNyAE7nXmc
X-Gm-Gg: Acq92OEobHHNvbJnw8Qk8/GG+XKO1cWrcZkWyf/r8Rw5K97r7F9IA7j7UGYs5iy/t00
	SzQCk6eURynJCfgyMT/N3Ek2KXrFQIyr+GGXPMn4WqPP29YBj0IQmZzhr74a2V/uKlK1s6X4NOg
	BEbc5EUVhSDPqf5pTEuFkbguM5hegBgaRCmGVTvE4cD8dWDapnmN4tBN+SBWdFsENRk5j4w+0rM
	TQ0C4iqO9nbuAdQ9Eg67YhQR2W4H5OmQ9wKbgoPtXRVWsOrq27kxLFrcKZyhNM7SF6A9uoUdiRj
	L7FNO4tXUxPHgVH73Z++2dM/Z1LuXmpokKSaJcUQqXQw+LhraTnlUGXpEKlhBbx46PAkB5VrqEf
	CGhl6ECmGRI92DnEemyuVELfkSH/tV73qvaSZd0daRlNWJspZKo8iEItX+UG+HUI7xTStNfudhg
	fBEnccjsndiMe/OfeRnMfCJ3k=
X-Received: by 2002:a05:600c:4715:b0:490:7136:ad05 with SMTP id 5b1f17b1804b1-490a29748dcmr205098165e9.31.1780327149765;
        Mon, 01 Jun 2026 08:19:09 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:09 -0700 (PDT)
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
Subject: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear sysfs logic
Date: Mon,  1 Jun 2026 18:18:28 +0300
Message-ID: <20260601151831.76350-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the sysfs logic of the linear property by switching to a macro
and a ternary operator.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index c70b8a3bb301..36e6f027613a 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -23,6 +23,7 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -136,8 +137,9 @@ static ssize_t show_linear(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
+	u8 mask = CTRLBANK_AB_BCONF_MODE(id);
 	u32 val;
-	u8 mask;
 	int linear;
 	int ret;
 
@@ -145,8 +147,6 @@ static ssize_t show_linear(struct device *dev,
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	if (val & mask)
 		linear = 1;
 	else
@@ -160,23 +160,16 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (linear)
-		val = mask;
-	else
-		val = 0;
-
 	ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, val);
+				 CTRLBANK_AB_BCONF_MODE(id),
+				 linear ? CTRLBANK_AB_BCONF_MODE(id) : 0);
 	if (ret)
 		return ret;
 
-- 
2.51.0

