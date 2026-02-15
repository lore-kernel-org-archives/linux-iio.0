Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B860261393
	for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 22:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771194248; cv=none; b=k79sruTj118oIY3dhnOXEXwPamEl74J+BymwfHP7roIMtohum5gn3BIcs1J/pOG7ZuDwHoyrX0x+5JsS2FaHQmJvjUcdWvroiHIZFszv5zAQGuP4AyD/pyb/W2GpMzlAOgiie4za6u/GUdUteTTMajr6+NF5caMNyUKGNTB98uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771194248; c=relaxed/simple;
	bh=rDzme/Q5Rl0/Ur4R6FppbNBFAQBVwz+8CH62eaR53k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lx03QkqaF+5ftM7CnJAHK2ugv3gsOTgvjchr2tyyEP5KGal/tNjBBcnVQErwFnXTb5U9DJQV7jbebTA5VsW3ZI2aKTE8zGxBY5Wpsi+oh4ZC69EvyocoVS+h0Xovq7IhVextpuOgMIVqy6Eh/2tcTkHYV9sGY9ZGWBocYLtWSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sy2HlMpK; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy2HlMpK"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4359a302794so1716773f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Feb 2026 14:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771194245; x=1771799045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=66Vmwy4Sh5Yol6CcoKobP9N7ecyBQmrCDQEcpTKoAGI=;
        b=Sy2HlMpKXKD35HWh/3dFf/GpoafnrAJgAQRWQ4H82zdxDYM5ojJtxFUmbqGZq2F9r4
         9KOO60fOmJ/FTYFMeygAZqYyi7HeScSvltkRJwppMD9BGS/HEUqjNuvrpBax98vPmH3c
         s1FybGQULcEvyRVyCxUuBJYZcBQb0dvulNa/HVAUsEKsu7i+mWgLKaMPzhgaWahtXm06
         T67oI1yuoEs/mEAdKIrppUzNmkAeMTPvSn7ckuj6g+L7AQH+klUncJZG2IS1mt8YOHHX
         3DWHo8LBJvQV56n9qIXHwcGnUU9meMswirH0YZqqiDgf3uCXjhKwlQgzHVLyOE8Li9PK
         rulA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771194245; x=1771799045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66Vmwy4Sh5Yol6CcoKobP9N7ecyBQmrCDQEcpTKoAGI=;
        b=YqeG9WXxVZbksF2J+mjtAAooMJTsS4FDQt7aowZSXmMNppkOeUAlDsV6VozjqXFQj4
         QCV/7ZPQdTNsAaPZ7OlEY+G7gwDTd32jQGaRFd2gMFF/wwlG99zu36XVTvc+ENMvsF9u
         U10ZiHhNOICll+xcmTJQrsP7PLp5U+IKGChlJ57sHSGEBysVZIyNe+fCP84DQAXv4/a2
         LBq/Fncx72eJZctxN1UK/a13/kAdQXexjsxvf/A14XMHw8zDpeCkC4Uo8YKiTZ7n6BJv
         ZVNplGkm7mxkuPaf3xzPQlDhacbLIE0bAdUxpEaqVd8HWzGA8jwBgMFtIVHGbRD7aKw8
         SKdQ==
X-Gm-Message-State: AOJu0YyUc7e9PYYo28ZRV+e4S5lRvqMC21dxF9RRIbDQe0SI1xDJ0B9F
	7VANx2J48ciqB8dpKYD+yQunZ2HAj3Zs3hifMGwkvHFRsQdYFW1TXv8p
X-Gm-Gg: AZuq6aIexM+Sea4jIYgQOsmUqFPFUjbAV6JA38Qq/ACVK1+9vBGb1Iu4BGRe8wjUH4T
	MtLeh7MEkxUImITHDF+DgWqpqfGDXFGZCNBTgErHRCsexeWm1ecez/VcjTevbRoCgoM2gNX5qMo
	mLRawGL+ArckogWHOK9zS2sxTZ7Gd2MaBPtzpvFnw9HVZHna+ZaTQaoN/5VQzwqOgO1PjvvlLym
	HDl0DEFsHZB9MX1yMMSyW4T/xTa8b6O6SHR/wVKoep4ddRRQYEKfiUM970k2qCKftkiFfXL1WUf
	QP7zGfPdh0iz83wJ29/viZBwOH3h3gjbiaA5rAD73lToruY4EfkqX3HifNruGJ5qnid3pMzKu9Y
	TbY5i1s7Vt4bgeqxmyi0wXDva3tUSMMnTUkuulTW6rl3mG+kQMpjW/QM9lpNhdfeuGLR9KzU73W
	3eUAzaDCRdKnNCQ79gGmtk9X4UIhr54Z2wFes7
X-Received: by 2002:a05:600c:5285:b0:480:1dc6:2686 with SMTP id 5b1f17b1804b1-48379b990fdmr103216285e9.13.1771194244437;
        Sun, 15 Feb 2026 14:24:04 -0800 (PST)
Received: from localhost.localdomain ([196.235.85.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483709f8812sm124548495e9.0.2026.02.15.14.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 14:24:03 -0800 (PST)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH v3] iio: trigger: use put_device() in viio_trigger_alloc() error path
Date: Sun, 15 Feb 2026 23:23:47 +0100
Message-ID: <20260215222348.186806-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once `device_initialize()` is called, the lifecycle of the trigger must be
managed by the kobject reference counting. Currently, if `kvasprintf()`
fails, the code manually calls kfree() and `irq_free_descs()`.

Switching to `put_device()` ensures that the device's release callback
(`iio_trig_release()`) is properly invoked. This simplifies the error
path by centralizing the cleanup logic (including `irq_free_descs()`)
inside the release handler, following the standard driver model pattern.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v3:
- Rewrite commit message to focus on standard design patterns.
- Remove the "Fixes" tag as the change is a cleanup/robustness improvement.
- Simplify the description of the fix as requested by the maintainer.
- Change title to better reflect the change (not a use-after-free).

Changes in v2:
- Remove the manual call to irq_free_descs() in the error path to avoid
  a double free, as this is already handled by iio_trig_release().
- Clarify the error path and the potential for memory corruption in
  the commit description.
- Remove the blank line in the tag block to comply with kernel script
  requirements.

 drivers/iio/industrialio-trigger.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 54416a384232..7f53e2a5a101 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -576,7 +576,7 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
 	if (trig->name == NULL)
-		goto free_descs;
+		goto free_trig;
 
 	INIT_LIST_HEAD(&trig->list);
 
@@ -594,10 +594,8 @@ struct iio_trigger *viio_trigger_alloc(struct device *parent,
 
 	return trig;
 
-free_descs:
-	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
 free_trig:
-	kfree(trig);
+	put_device(&trig->dev);
 	return NULL;
 }
 
-- 
2.43.0

