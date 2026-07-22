Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7D439F9B
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 16:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737388; cv=none; b=W60+JaytICS4KS3r4SJ0U3d466bNHpSMXVRipEprrnMDe/uH3LdhHgMNYZVocD/bECLx+fugtqyzr1e+wxTYH5m2bFCAWhi/5PT6/8jCO414RSlnkf0OKMie+tDTE/owC3VSsX7Y/cI7EFhdKSIEQr36s8YLjSduVqd/O866hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737388; c=relaxed/simple;
	bh=dpiqy8v3njUhl+5M8+H78HgeeoztOF42HF07K+INYGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yq+g2eccfy16fXegSDWFHxxCoNR0zGheXXY5RcN1DJWgf623xfllvh5qvnWGLlmC9hRJ4AFbdqQbnOTFEC18I2zIDbOJyCPiTyAhRerqYrrRlxGcCwVPJddVGDh3BJSbCj81ElBV8KqnwZ5VK1SR7p+IDw/z8RZXUnAST+svj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKiBQXKJ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKiBQXKJ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso7940530a12.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784737386; x=1785342186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LdG079b6jK+3Fw2UuAshVoyvrHhYqH1e6aG8pN/SHkE=;
        b=BKiBQXKJe2Lm5zfmmUiNYRShJjd8Q66d0SlvQiH6YWFXoeQ+vDUnzTkJobLJXzfHKq
         ErBtsvG04VNJ6CxvC18JRw0wl3hu3e5+Ve2WEEehcVT3HkYjStqr9MT7EReyioDMk2LG
         zASkO8u92H4P3MyRXx5CI3py7yhdZPAfhRPWnXBNmGu+RreoXSdbrFZp4/YsvioSauhC
         HL++XY04arqLkNE4c19HJjpddvl0IcU2A2dlhbZi7mxIMulI5q/j+xBgryIjg1Ooaqa6
         BTUvcuUKHi2Ym4A5Z2HD8o8VQbAVHHr1gaDIDP48TPP+YBKwma1QDzksiZ1SSfRzgllT
         MOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737386; x=1785342186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LdG079b6jK+3Fw2UuAshVoyvrHhYqH1e6aG8pN/SHkE=;
        b=EOT0RV3nKRZVfaEQqLsFPXh204TX768nDm13WWseWQpft42LBGIWtJe1pl6ln5e9HZ
         YTaXrtaxAh0tqOeSl7aQo8YpIOykbEUKua8fM0jcT+mMX4PzMdR7OmZNKHqFZ/g8KN1O
         ujioFiWzu7TlEAGVz21M95ptGrhfvM2Dd72q2Byat9VWodsgLJtJ4hgwJZlcfQiJGiF8
         ef6qj2I0uRxUVK0m09Juo3Y/8BlxKtfTq/Wq/lpVGSsCyabyI0yxIwTwoYh/dRDPWgYT
         ePj3N4jprKu7La2ARLlzTBZvYBY0gypTIMY/mXkq6W1V4R0ZUv5TIzQXgkMxWclCggz7
         h+LA==
X-Forwarded-Encrypted: i=1; AHgh+RpXnxkfEpD5yG2ZQgV9nHCmIIefF/yFVE/Te5tHO76LYT5LVNk0c3HvbjlqdslwkoaZ9NGIQxTK4UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR6sWmVCVVFAIse2mwTu0PLheFwEmuIH4XxI/gwe5cWlBHf8EY
	eU1y4W1sOPK0wxFcVk3bTToG3Zcii9rJlAG8qIWrheoe3Gz56dJbhRk=
X-Gm-Gg: AR+sD12tiXeYZQGD0GgHAyWB+UHSrRFD00527hRZa0yWUyXVNqz3oRg/e5W/KmpsK5O
	ewNoRO5tx2l+UT5IcWji0Sf/h/59qj2tWuDsSePRViHOoQI9drrIUB7ZKNyzVLfj/GkelCHkNyU
	knjp7aKEYHkCJruQVGlQXcAaVjmrFG8AzayUYFG4OdkwDe+mYzUXT4gRe3Xm6jDu4zKnQ+d/Hmd
	IZvhGB8io+JL2m8OBMWDxa/LGm2Bf3NTkhKBZiijvS+Nd+c6iXe2lqKmi6RgjqhukyNm3/Bexm0
	aRPPcQQU/dC+f68jdOm61pz5YyG/fKNKvkgPj76Hr15ubwYbSNWCUjeovyTc+LE5i7D0nmiUWvT
	GJKZxu+y0hNel8r5L/q3fhlyWAv0AuvsCNEhEZJygyI9ph9wvZr6UePGLghdHnBWmC/tQ7JViCf
	vhjN9pU7cZRMo/1nwwrgZNhZCNvlvAxPx2ldcSt2Rrxw==
X-Received: by 2002:a05:6a20:4c8:b0:3c4:1c9f:d90 with SMTP id adf61e73a8af0-3c41c9f2e30mr7154477637.39.1784737386122;
        Wed, 22 Jul 2026 09:23:06 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1e3d9sm9260471eec.5.2026.07.22.09.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:23:05 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 2/3] iio: light: gp2ap002: re-enable irq if runtime suspend fails
Date: Wed, 22 Jul 2026 21:52:46 +0530
Message-Id: <20260722162247.8229-3-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260722162247.8229-1-nikhilgtr@gmail.com>
References: <20260722162247.8229-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gp2ap002_runtime_suspend() disables the irq before writing OPMOD. If
the write fails, the callback returns an error with the irq still
disabled while the PM core marks the device active again.

re-enable the irq before returning the error so the irq state matches
the active state the PM core restores.

Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 966459994995..e8ba9c00dabb 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -649,6 +649,7 @@ static int gp2ap002_runtime_suspend(struct device *dev)
 	/* Disable chip and IRQ, everything off */
 	ret = regmap_write(gp2ap002->map, GP2AP002_OPMOD, 0x00);
 	if (ret) {
+		enable_irq(gp2ap002->irq);
 		dev_err(gp2ap002->dev, "error setting up operation mode\n");
 		return ret;
 	}
-- 
2.39.5

