Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC8C3DEFF7
	for <linux-iio@vger.kernel.org>; Mon,  1 Jun 2026 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327169; cv=none; b=IxBrQaMNkwAhQLPuekpgrbugg55KpeEuE1/XwSSvJs1quhWqAHae4BlHBxfpJ2XJM7OoQsw32mwHxpQr5I+qLYjA49H+ebmANSm8woEnhb546Cb9B0Kj9yScFTIJ2jvLT8of0+UA3tFWoslvFpgnqYKPbxSoFN736ImjdRbOzFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327169; c=relaxed/simple;
	bh=Gqs7G7t00pywVX3rRhClLifko2DwPlgtzGf6OODWNOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXOwymDnKRFQT7r4mq0h2uCxJb5DEu4izGiEIXMMgShneGdXNxlLqv+aFtlqFm8rLixtWRgpFzcTBo0Ek3DCkH0XBOYp/wL3scJZVFSlN1B06tmHwqxo2BK9rLGqiBJ8c5xtdtgUy4h5MvriAfH/0zIR2dDML8K8AE4Y7ZM2aOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SlWReqmt; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlWReqmt"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso86470245e9.2
        for <linux-iio@vger.kernel.org>; Mon, 01 Jun 2026 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780327153; x=1780931953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33jV+tJR7Nm5ReUL1Jncj608Et9Ag1X54glyJfKp5cY=;
        b=SlWReqmtNBJgpuPqFBJ12rBdSTE7NTWat1EwcxNlvUeN/Q1Vmuq084pYnUVAPpNXTh
         K/7XijqDSNVP7JleW6xrVBhilYT/7pjmhsYeZF9ykncXIuFMw/AtI6IpMBZR6qIu4CtJ
         alpPerpSV5LkvxU/kBG54B0uhhRDRFWkd5FMNNar2kl+3CugOLVhYN6/sc2ugYKu+TAw
         GEE5AbOxDZlxbR00XBDHRloB4HW4NFOiKkUllyhnpOAiKzdCZtt3ofTzfdmmP4Uul2G0
         L0AR5zkgyJnyrnDlY7WwxlOVcK0V5rKis71rON1FV69F0QFYRmo/K1JgOYetuUizzmJG
         jEtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327153; x=1780931953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=33jV+tJR7Nm5ReUL1Jncj608Et9Ag1X54glyJfKp5cY=;
        b=Wc3cLFrgLbNrDtzFrv3x/7P5BpxZRvAZhygKBKZFmwNvM++ClTGIvUqW+fKwPLUd/G
         OrgsxBX0cDCpP+6DQcBCOSGCL6rD76qJvhNsTaIQku2nqmhUPbKyYvvUTXvxuTvrd4oZ
         yueW6xA0J8OxYYAdle9fEXgErEXWtNUrJ6IbTQNk1/C8vHbGCuU9At5Dq7kNc/jB9NzG
         YeV8faa4322Kr57guUuGKqoFQ8wTpqhA4MgUyb4abpRWxikXJDz8ZJumpDKLhY6PSyg4
         SfF+SmKZ/3shi+IAie9WLDPIkSvHxluyvfvdxY53MhFr7C2bZXsVG3LmSQICrDJyzURh
         LkzA==
X-Forwarded-Encrypted: i=1; AFNElJ8ttIs/HAnTlazo/tvxqNeQqTLaoLhUIp1cny4h3eYrZ1YArmrB9wZq237TPA+ryjgI1B/9pbMT2to=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0kWV89YqhT7JpUCLJ3BwoKJFnkhArWCE+o/O79qPXAWQOL/7I
	b4b2IfWu229uPJ8DjrrrsuQS9xS8bQm5afseePYSEWWwu4K86Xcu66Sz
X-Gm-Gg: Acq92OGSdyv0UET1TAMsARcMwVsxeHoy6O+zQaNnctmLCLrT9eIXgU30gYQ49ZY+5Zv
	tpstXjLd+AM6iuM9r76KpjXj7pf7b0HDGLdTWKuOzvxmGYqD/n5jjwghWCSn3hnRgJ4VAoOiinK
	QNG1A8WbE14I2W3oD1IW4T00MjK17tOn+ibuw1RtUDPc5MhrA72mLortbDnFi9WxagEiiWlLD9g
	amq6mijZFiI49x1WYr3KgZ+REjqynfqr2XxRj3bvISdgIi7mhr4GQ6BMXLmLsayQr2MAL5Vpebg
	QGVOrlWAZXlXgFWVaCGbYen1Q/h12cJjboFt9J7vtGsa6ZGJkcRtdaZVn3TzESR27K1WCCQF1O5
	JSYFBGbEhxtQyfh/AWMLt+wbfYOjrWAdcj9bleEeNdP/k/k9HTPtapS/2PnJh2sPSgbTVsrMYIo
	gt4vOyU22XHtWVyUTvhTXrqRZ4zw9rPQF/Kg==
X-Received: by 2002:a05:600c:6385:b0:490:40f1:5314 with SMTP id 5b1f17b1804b1-490a290ec08mr258749965e9.1.1780327152708;
        Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
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
Subject: [PATCH v3 10/11] video: backlight: lm3533_bl: Implement backlight_scale property
Date: Mon,  1 Jun 2026 18:18:30 +0300
Message-ID: <20260601151831.76350-11-clamor95@gmail.com>
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

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index f0d88b7bc229..945625c54fc4 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -161,6 +161,7 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	struct backlight_device *bd = bl->bd;
 	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
 	int ret;
@@ -174,6 +175,9 @@ static ssize_t store_linear(struct device *dev,
 	if (ret)
 		return ret;
 
+	bd->props.scale = linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
+
 	return len;
 }
 
@@ -309,6 +313,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.51.0

