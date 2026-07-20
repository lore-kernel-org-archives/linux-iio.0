Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79BF442FDC
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 19:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784576365; cv=none; b=YtHmFHwuvOksnMzebeHOgZ0hZEzPpFtHJReHEG0qh6KPaXhLVPBKFll9vCBKmM3MUhXCeUOIDzN1YZ91DKYcx5F4bsgUxe3FoaRPybYXvP6b0dYekJ1Mxe9cWiYrwn7yc+iULngYjqPATRaXcDlwqEn2yLddda2hu/E9jXkx3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784576365; c=relaxed/simple;
	bh=jzT/6FpjIwHOnd/Ocwox01XayWSBEHvjkvcK93wVLdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/gs16WWL7sy1CW/B3uH+PvlTod1FAgv1BILSu+f0PCdUXq2Q/PYDs7nUMyYEeB1c4/CCOC8JTbig/0Is/MkFHOWMx9qbhxKsk/38QH0AgZYdfN1H/IVocy2NC6J0kOCHf7POUPrNef1sckeC7Kl2LYM8ZuhUKLDt/3c6LFwd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIzJh9Ux; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIzJh9Ux"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso2673851a12.0
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 12:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784576363; x=1785181163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTUe4BSLEWJRqj/YoC7td2ZN8zxIRbPJjN8t5iaBH1w=;
        b=hIzJh9Uxa4OWq7imQ8VRoylaZGjwzo2HlGtmVMYL2SiDOw6hyTPgqJhGZjiXBmeXi7
         wzVl8lCA9vShK41DLuUK3JBaNBVQxjn/btEKtK+dSphc9MNcD5pM1TGkZ8GsS49S5Vrm
         +DkDesb6xhs2xdGMBtBN8UPBX87H+oW6+/BzZUBJk+t6cp92zcqZRGdsEdjGKPlApl81
         a2So04xtGoSV0HrGtpWDN0uNiIWqzgfNn7tvL3NbRxT3ujWrYJ02BGwjh+hN1TkINYqe
         SFOXTvssiE8I/JnT2mBPtThl/+IaJ7kNwwa5dXQ0SXHmGWp3knfnDMNmwUMsHIQw8Bvu
         hbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784576363; x=1785181163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTUe4BSLEWJRqj/YoC7td2ZN8zxIRbPJjN8t5iaBH1w=;
        b=f8LXKiHZS0uuaK4ej9+przmRx775RUOiAbgtlWtBQaHF0AhSh/w82wZO09FweZfC7Y
         3y1mVo0BeLfR4HeGeFVi7//4TqAJJzrVQdmcX3Kn+ZPhgm6nu8GefCuw8+W+U2X6GHDP
         YxOK2GNbXwvPghqmzPYDTgu5RBGb91dC+CbtK4bzWj789+6MsMLc3hctn7NBCufOwWox
         r3E7su9VWUCoqO3eUrEmfXSXoGgRYez9+sbMRMtXmXC3U5lzrVYNav2XewzZqZ1BnYzu
         iaQido54dB6eLgH09xjL6EtLzkabulinzZk0wf67PwjVSiDVDE73WkgJ9IyAPttc0wp/
         FYcA==
X-Forwarded-Encrypted: i=1; AHgh+RpHDxkRJQ4c3Mom1Zr7jZfObNj/zDXKCTvOevinMGd6tqRsb2VFFs8dZM31nHh1i9obTaRH7InozQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRG8zw/n55yg2W3I8FxEjkyaH49o6Fqp3Myoc/4m1/UFkjUR36
	a8V2/eBjUcxoCG1nxM9xL7NQp2rS53NMTsIAH5Z1R8J4HnLuPG3d49c=
X-Gm-Gg: AfdE7cmNuDdNHDSohGiGKHYcHBpKqAjSL0fYSv+7GDftwrgFXNkncNYdMfKfOFJ+CFS
	LqBDcf1s7Ix2aJ64xOnTteYLeCq6ioEoIm6zBV5CezM5oVCfWVmmCEDKnbrraLVWK8wl4Eio29P
	Rg8TPn8zLh3hasyeMGNASBwNoeH+G5WRXpmwmweL7vjLT9skitJfjW1xWLLvEXXqMdvW1+R/EvL
	SC67V9onph1hGvhNwZEkGEt/joeB20cnsLhU2LjiGtfSyx1qjLRKUoq7gpJgztxdeJEGS7sypzX
	/c1eGr7bqm1IFDH+VrcaMiBtbfJRwnW1N9vr6tpCyYyl5WFSbRmajDMcB9HC9pIFX7XWUNLl7qG
	IvIukzw9Y+4kqQfKuvDwydYEo8WKFUhFtKfHJM8lbZu6EYV1keFYpFZaT2v0iU3wz1L7WapTkv1
	WnxYhQCjsSOMSZ21qUSsOg+vwHlOvhHRXZBsIg6RgU
X-Received: by 2002:a05:6a20:da08:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3c38d8c9c03mr21850768637.2.1784576362961;
        Mon, 20 Jul 2026 12:39:22 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.64])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce29ffb13sm33935340c88.6.2026.07.20.12.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 12:39:22 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v1 1/3] iio: light: gp2ap002: Fix unbalanced runtime PM on repeated event writes
Date: Tue, 21 Jul 2026 01:09:09 +0530
Message-Id: <20260720193911.74919-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260720193911.74919-1-nikhilgtr@gmail.com>
References: <20260720193911.74919-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IIO core does not filter duplicate writes to the event enable
attribute, so writing the same value twice invokes
write_event_config() twice. Enabling twice leaks a runtime PM
reference, preventing the device from ever suspending again;
disabling twice underflows the usage count and triggers a
"Runtime PM usage count underflow" warning.

Bail out early when the requested state matches the current state.
While at it, switch to pm_runtime_resume_and_get() so a failed
resume is propagated to userspace instead of silently marking the
event enabled.

Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index 42859e5b1089..ea971fec0b56 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -343,6 +343,10 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
 				       bool state)
 {
 	struct gp2ap002 *gp2ap002 = iio_priv(indio_dev);
+	int ret;
+
+	if (state == gp2ap002->enabled)
+		return 0;
 
 	if (state) {
 		/*
@@ -350,14 +354,16 @@ static int gp2ap002_write_event_config(struct iio_dev *indio_dev,
 		 * already) and reintialize the sensor by using runtime_pm
 		 * callbacks.
 		 */
-		pm_runtime_get_sync(gp2ap002->dev);
-		gp2ap002->enabled = true;
+
+		ret = pm_runtime_resume_and_get(gp2ap002->dev);
+		if (ret)
+			return ret;
 	} else {
 		pm_runtime_mark_last_busy(gp2ap002->dev);
 		pm_runtime_put_autosuspend(gp2ap002->dev);
-		gp2ap002->enabled = false;
 	}
 
+	gp2ap002->enabled = state;
 	return 0;
 }
 
-- 
2.39.5

