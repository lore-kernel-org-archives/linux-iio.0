Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E153E5EED
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170247; cv=none; b=Ep9c7Hl+Yw6NqEZlBa0IynfXqWzwdyvoxj2YPMkIplBFt4qr/oBtzP14Cu2ti0DUX1HkemgsZtqxEnMPX9I4aRhGsnWIiySmPKM7iIeYHQGxwVeSxIX6sU176uxIkXEKJJ4JKLdH/oW8wVdYJ2nSJ7vVMztUxysezwOqn2uCuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170247; c=relaxed/simple;
	bh=xLu38bVMUys/cZ6QX8r6iNH4CMwuE0rQsWHnSsbUnzs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=afAzWkPfshq2oFSfbL8vk0gFvLavDBl0dS4mYUG5BHgEuuIPzUrhnL0vQFjaOkTv6nTlzrr0TwiNbYBES9f3ouqCH07g1oB+W6KiJdoM8xG4Hxlzg46Tt0zVeTBoxNmFrhGYJcFmCixnJz9vl80YCKo+Y3uJE/8Njl2S5Dji3yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoLyPbaK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoLyPbaK"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d75312379so1527805f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170244; x=1776775044; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DN+oBwb+Y8IFK8YL3Riuf0vPIuv++6ageqUt2vFSbSA=;
        b=XoLyPbaK87X6pV3LWAXEzDBIqzmzAjbguaPpUV/BAZbkfqQiplITz96p0zDJi+v5zE
         CLXRl6qtBIABpdrIthmDwJGyTZfNUAwf7pTrsSB2FMZu8/OZaBxXb+08L9PgzFUlYDce
         ieLwuDWmWqyXz9Cro5YbXXC3K8CjD3s2yM70Ifv7w5a0bHoPdxwVf/oGcFxVgfJ6TYMH
         k1hDWg2T7BNWvSBB/NsUmFffPESRUrgbPo7R0K52BH22p9kRtvqyJPc4wAvD6pqOLLH4
         mFNEgKFLXuq5rpGfOR0pHgbC3wycWYVIKDJ0iTrbyWTQxNAtgMj060oVgTGClbsdkjkL
         fjgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170244; x=1776775044;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DN+oBwb+Y8IFK8YL3Riuf0vPIuv++6ageqUt2vFSbSA=;
        b=d0Aj5GkftYtYrxoyQB/JatxSEu9XKCoNvO5NtprkcZSuL0GcxPoYflGr9JszjUByYK
         4MLZwvZnqNQ2KfgZWjwWipgt29UZqXGl5pPjAvYeU67ZOfokQMbjbCT1dDdBGC3NPz4p
         Oen659GmzLAdE//ONvCX7DsKyZnkGElhihL72kj+EXAt9CPZ/nNmSkWKcEM9GfP+BjQ8
         y/5PXejRL7HagNpj6lfvKQwWFi2dsSCBvbQDds1239PsS5em/hSaa0bQvWsqlff9ZSOn
         SPDAEa4+nB9QvxoENZVfhsdMFobQT6lWuZKRSjSuajzaraWUf7XVQ8Ixp//QXKSmN1CL
         XsEQ==
X-Gm-Message-State: AOJu0Yz3M0nHqnKrOEZ7q403aZPlgFNcZxIDd8/qYrfSymFWvmRuZXVZ
	xiE1oKujXt8s1kjWfVEZtlCH82OAYUxxVuE3pwMQ0MZsKb+kUD4P+N5C
X-Gm-Gg: AeBDiet+UiA5Y27XGoaTotZ/ed8r7AJkjsRwmJSYCPjaUm9U+N+tPQRAbk2gysCB2S1
	DufurrkoC5D42+ZMogXvjuiZyy8/W5PF/s9FvdAU7oT+KmZf3al6hCYF2y9JNTaaxAlecp3rtky
	CVSgVD8gKEXKWWAAwAWDoN8uRtSZlFdD7Vl3WtrtiR8oiNgLyqw/TJM+6aogj1PEeBpqd921CRa
	Kw1Xssw9UgQywrzFQSfLHyh0J/VJKDNRId0iQVxGFd9rWucLj51iIDTktATaY/Znv1JaxLGjP6f
	AzeZzLsaZzW6i0LtpK1fW5S+/65xJs/fj19XLOkB8e1BCT9pJ0c74hms+k7sgnlhkRa6QKoinvJ
	+Uy3saiUGg3foMBcxoTzG+HrBC7yQxeT9g7PyxH5PqUVGbQbakvHF+oZiUImQD7leJKeuE0Cx82
	fy2dc8thnFEyA78q2fhvwj/xR1zQm6QT6UYgN9v2v9
X-Received: by 2002:a5d:452f:0:b0:43d:729e:f23a with SMTP id ffacd0b85a97d-43d729ef530mr9716746f8f.22.1776170244081;
        Tue, 14 Apr 2026 05:37:24 -0700 (PDT)
Received: from [192.168.8.79] ([2a00:f502:260:5bd3:9217:8960:5f33:aaab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm41552729f8f.24.2026.04.14.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:37:23 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Tue, 14 Apr 2026 15:37:19 +0300
Subject: [PATCH v4 3/6] iio: light: vcnl4000: move device tree entries into
 one line
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-vcnl4000-drop-enum-v4-3-59fde2932a0f@gmail.com>
References: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
In-Reply-To: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.15.2

Make device tree entries one line each to save space and LOC.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 35 +++++++----------------------------
 1 file changed, 7 insertions(+), 28 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index cbe0a9e056ec..52f60b372d2f 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -2058,35 +2058,14 @@ static int vcnl4000_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id vcnl_4000_of_match[] = {
-	{
-		.compatible = "capella,cm36672p",
-		.data = &cm36672p_spec,
-	},
+	{ .compatible = "capella,cm36672p", .data = &cm36672p_spec },
 	/* Capella CM36686 is fully compatible with Vishay VCNL4040 */
-	{
-		.compatible = "capella,cm36686",
-		.data = &vcnl4040_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4000",
-		.data = &vcnl4000_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4010",
-		.data = &vcnl4010_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4020",
-		.data = &vcnl4010_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4040",
-		.data = &vcnl4040_spec,
-	},
-	{
-		.compatible = "vishay,vcnl4200",
-		.data = &vcnl4200_spec,
-	},
+	{ .compatible = "capella,cm36686", .data = &vcnl4040_spec },
+	{ .compatible = "vishay,vcnl4000", .data = &vcnl4000_spec },
+	{ .compatible = "vishay,vcnl4010", .data = &vcnl4010_spec },
+	{ .compatible = "vishay,vcnl4020", .data = &vcnl4010_spec },
+	{ .compatible = "vishay,vcnl4040", .data = &vcnl4040_spec },
+	{ .compatible = "vishay,vcnl4200", .data = &vcnl4200_spec },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, vcnl_4000_of_match);

-- 
2.53.0

