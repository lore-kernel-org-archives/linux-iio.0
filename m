Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C79439F7E
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 16:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737392; cv=none; b=a7gfIzATTVdnVeO8yW5tO8VisyEJFObclyv3AqEMHHLsvTJfCiRRyY6Agk+Ck7UCtfzuKjtrUsXGp992FSElmDYPK+j6A8zrG6i7dorYi76FOYn5zLrVPWQM8ppurLg17aqeyp9QQJcBDApK+mWhb34dteCBe2tfrIcmdnwfgbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737392; c=relaxed/simple;
	bh=i8HPqvtfirXrkg9CRJQYHnwQufUh+A0XBBmT0sSXqHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P8B3dWZKr3BJ+DsZOeckZJpOPAsChVW0BKl5O9jmCUTwyrDOD6tPVWZYKd9SVWcfZ912/OlAgEdRdlgZNC9nZNGh08BKaoegRh26iiNWjoHw+JdR9uEttskQU+Sx4J1IsGTz0Cn5dEMDkk5YFVXoQaIcsDLe0MxkvKw5/dzrXUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVKoNCHg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVKoNCHg"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso9084657a12.3
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 09:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784737391; x=1785342191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eVAyazMl5WkniAlf75NkROON8JhWPspf9inm470FnWQ=;
        b=aVKoNCHgSBtdvfPTGMJRrjtE86jXGz5j+q/SxLV53aCQ2XtuMyyqQL/OqLSFjK9FXV
         FQ3rY40NO8uKnjht9+r4AhHUw596geoOtdvtCuPeO7pN878WZ89uVTCwLbvDGa4lg4dk
         uru4pyfgEGCOsXQ9M/by1nxE0IcReTQBzT3ayz4Nx7ZTi7NBnJ/uBo6zy/3ToQCY/Qj2
         VRu/RGCExPxyBIqv09hF8vnFYqnIhE0BqQSZk/sIone4k+I29uvYakPHO7YuKoOI1Wh6
         mjKTmJklyU4psj5Q1pUejU5XxlU67Y8a6nNGcBX0BmrvBJQtUY8IYTkNQcqXFK/e6wZd
         wNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737391; x=1785342191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eVAyazMl5WkniAlf75NkROON8JhWPspf9inm470FnWQ=;
        b=QTwF+kbcS0YPIRzpi1YHdVsEhF5hv45Fjbjnek3w+wi/+GQRWp/6PqzMc2e+M96HG4
         vHlfqY+ha8Qi2J9zJW0DXU1+/OA/fGJ4e2prj0s1TY0XRAKJivnlthoj9jSoJPCX9HSh
         ftMBdO8oxSDL4VB1gpbBrZOu4ADEYglW2aaVLiCPbU8J1zvnb0iyq4eUguT38vhdW5mJ
         kgnwxU9bonc1/EvmwBT8FoAQZA1qqPir1QhrG8RarwTUHllcCifJ+BH3q2LXz/Pmzo+2
         l1U6V4ThdUbuW3+pWMBEmDCUfzkQ4az2dVPtI5wPv4M1RU0fuWG0YpTueQGr6Re31ANn
         AcXQ==
X-Forwarded-Encrypted: i=1; AHgh+RrD+g8K0Y6qWYH5O9xfOj4dni100GKk0No9m7rHDduTirBW7Y4+QVd3ONQS5KmzitF8La6t0b4a1uw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOVGNz8jWFbZlxhKABj2EL1DwmfI6J4NjfRivLK1BL+hxY8kgn
	Zoy3aJEAQrMBGm2L/1ebagBfvuGN9DuaQAinrXQOsSD8EDoJQvz+INc=
X-Gm-Gg: AR+sD10DI7877xLDqXLg+M/g/vvkyg21dx09JfC7ijjbwQdt3qDUaey9vtS0ze6zb2N
	jhQOnBY7GwFb8Yv+jvrmkgG9hkngNS8fUjtbC3+SJ0pYVMrFMtkEzEackTQvTZPPZfcIUC3UA/I
	6weQt9M01Q0MF86p7qijHFfeDHqRzZDUOKXzEXk9xfId6H4CbIwn7erH7NoCQtodfmeNmAlBF3F
	pB4VEO30TcCIkuzAROaBPUHyQOsIOefpP3hdW/GcICUrq8b5FtkLKuMMzJeNkXROeAxmUn0VBGK
	ETPqlnO0e6Zmq+N/fwwvC6acIofliGYdJpqTRyi9Y8XXHBEyCfwyZ5XFz27tD29DbN6fiOzqBh3
	coqeZqYvz9CgLCHTnJlDvEko3FJL1DWBCRj9ugJf+TBNXE3k6s17SzZYU9GEwhm8ULBhSaCHQ1E
	TiadEW4+C0cyMznjCWMudDBBp6dQRUohfyveliqCyH3A==
X-Received: by 2002:a05:6a20:cc0b:b0:3c3:ac5d:b6de with SMTP id adf61e73a8af0-3c3ad7da25cmr27209656637.22.1784737390679;
        Wed, 22 Jul 2026 09:23:10 -0700 (PDT)
Received: from localhost.localdomain ([101.0.62.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc1e3d9sm9260471eec.5.2026.07.22.09.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 09:23:09 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 3/3] iio: light: gp2ap002: Fix regulator leaks in runtime resume error path
Date: Wed, 22 Jul 2026 21:52:47 +0530
Message-Id: <20260722162247.8229-4-nikhilgtr@gmail.com>
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

If enabling vio fails, vdd is left enabled; if re-initializing the
sensor fails, both regulators are left enabled.

unwind previously enabled regulators on failure, mirroring the error
handling already used in probe.

Fixes: 97d642e23037c ("iio: light: Add a driver for Sharp GP2AP002x00F")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/gp2ap002.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/gp2ap002.c b/drivers/iio/light/gp2ap002.c
index e8ba9c00dabb..430336b51f83 100644
--- a/drivers/iio/light/gp2ap002.c
+++ b/drivers/iio/light/gp2ap002.c
@@ -677,7 +677,7 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	ret = regulator_enable(gp2ap002->vio);
 	if (ret) {
 		dev_err(dev, "failed to enable VIO regulator in resume path\n");
-		return ret;
+		goto out_disable_vdd;
 	}
 
 	msleep(20);
@@ -685,13 +685,19 @@ static int gp2ap002_runtime_resume(struct device *dev)
 	ret = gp2ap002_init(gp2ap002);
 	if (ret) {
 		dev_err(dev, "re-initialization failed\n");
-		return ret;
+		goto out_disable_vio;
 	}
 
 	/* Re-activate the IRQ */
 	enable_irq(gp2ap002->irq);
 
 	return 0;
+
+out_disable_vio:
+	regulator_disable(gp2ap002->vio);
+out_disable_vdd:
+	regulator_disable(gp2ap002->vdd);
+	return ret;
 }
 
 static DEFINE_RUNTIME_DEV_PM_OPS(gp2ap002_dev_pm_ops, gp2ap002_runtime_suspend,
-- 
2.39.5

