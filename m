Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B73EDE4C
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778666857; cv=none; b=qnWWQtkq/X5mevslXhH41H0wfiNbCh+hGC1p3mKgkZNGP58r2w/amnRpZCwzmrKpQ1Z7xh8RC/oVMXDWYbnNrM+c6/SMerlq8KcHuHh2IFZgNPItLs1K/ktzWWbR7F2mhgh6L1yZyTGkt2fOvhtnVLQLWYzaVhKWQ0W2B1l3y+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778666857; c=relaxed/simple;
	bh=7FYcAtqCkDRuAhNT0ZuaWJ+ehmXvvIPTDlt5vl6NT94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PkkRvuFhZx4r+41EBrzuUuzWovyWos9toQ/GbmXGL9ppOuctn/U5fF04AjbH0MQkTmjTq3ABADR/951boyLpoorOzFe9wxRqo1OtNzrRzKI2TZ7A6xhWsm1Y0FVX7zPwMp7g9syTXpkM5curcUc9Wg8aQe1YFVoU9hR1KO9J0FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/5VuoIz; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/5VuoIz"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44b7e8b65faso595913f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 03:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778666855; x=1779271655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6OYzOoDs9BRlHknaQugKra02gfDHzOa/1dG9/aK3BrY=;
        b=Y/5VuoIzBOChQkIdEa3t2Yu6PeA3zbbHRo0nuSfAX00Rk0O5NktRP/aS4fxo4VEaYQ
         w8xnICzcYzritheKkMk2q9fM273InHFVPRRFKVLWqDLz6WzO6byCtIcV3+acqjq1wdaA
         XmbmmniojP88Fp16lXcTgYYvNxF71FmfPn/Lruf/HvqvW39I0hcSMqVdVstfARTA1eLH
         QQmsBs/xeEf0u8FtOZD5Cl2mDPNTfV87p1oaI7roIJaecw9hXnUkntcFICPJU1upbfC/
         SgKcNBJTNWOOegN66t40yXo4Rxzr/SAiMciVv6V2ORLMnLY770elqK3B0lICL5c2B8oA
         RADQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778666855; x=1779271655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OYzOoDs9BRlHknaQugKra02gfDHzOa/1dG9/aK3BrY=;
        b=bgxwyQikeIq3uH+ZDTaZd28f3U0R2CDB73wGAJu0eQ/f332wvAKWxVCsCt2Ao+RQAX
         KNyjidNEumigsp3v7Vhcjb4CJJspvp/2qzYDPI8x9jFOfIQFU+/jNo48pTQhr5+oCd4M
         l7HaS/Dcerc/Hx4qYHvp0cSG1e+vV/k/Xnyjr5c4A95gQ25ssYKPSteQVKqtfQY/vRSY
         nXiPuh0ZKhLn/36+lvjP+hgZhwC2SeqFViEWG1fY9z+XpwXB8JTCz8mGQ7RSpumYo+D9
         283P6iHgjUqI0LTjpsYSOxg678TkV7e7kjqplWKxC07EXKjK28ER7XVadtHMHKyZ542q
         njkA==
X-Forwarded-Encrypted: i=1; AFNElJ//ZsGVVRYtyQN3vLRg5hGliGC5hIRzIPxN7bdZSD0R03vVON4J8VKeXXpdha7fBYeehg0SPmFyp1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcx65W776JDv3IWtGA4gbPs7P9cJKUZdNs602JyB15xmG7XUDo
	NPostJGt7YOJayAaHjLKWjJARRNTFLrQciSv0G8OldYaAsF5u/OcbmIC
X-Gm-Gg: Acq92OGPPnMo1+ho8Jwt788vC1P4HVUI25+eWLvUwMETP1sEd37t34omJSCqBe3uWkA
	FRgzWC/i7VkTxwoQgoIo/bKaPQUWckfUOfGab2FASTTTMa27uGaZQKI30iz2GvEj0k7nPRujsY9
	np/alKOmkAlMK34joFid6N+ucDSrD5+QfsvzroH78Ql3t7B4OzOqTpTZ5dOPKM6IzIl538H6tZs
	BfcyrVQVvFJatzUykSX4ks8XBcnysG/e39IeBJB1Tr9ItJ8QBJbrB/rdVDeWZ5MgEWmNRffjUXb
	8Np7HHn08YGl6yC5fg2N46w5jIYLXetsRte2eX4PaqnUHs1NzebAdvZvxNzlSEQ+2LcHt7G5sM4
	MPWS511kJAUJzsPlTRiu5ScYjVEbv4Mp0IaO953pbr0APU18NZBN5ZBul36THDM7JcnoWDRK1nT
	sFntjGWfQgpUzQ64ly+vFr58zl5VaCyTGK7FFOM7othlV2JRee63njKDo=
X-Received: by 2002:a05:600c:3042:b0:48f:d410:605e with SMTP id 5b1f17b1804b1-48fd4106119mr1140055e9.7.1778666854778;
        Wed, 13 May 2026 03:07:34 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548ec6be40sm40978655f8f.12.2026.05.13.03.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 03:07:34 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: corbet@lwn.net
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] Documentation: iio: fix typo in triggered-buffers example
Date: Wed, 13 May 2026 15:06:57 +0500
Message-Id: <20260513100657.8498-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function call example in triggered-buffers.rst uses "polfunc"
(single 'l') while the function is defined as "pollfunc" (double
'l') on line 24 and referenced as "pollfunc" further down on
line 56. Fix the misspelling so the example is consistent.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 Documentation/driver-api/iio/triggered-buffers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/iio/triggered-buffers.rst b/Documentation/driver-api/iio/triggered-buffers.rst
index 417555dbb..23b82357e 100644
--- a/Documentation/driver-api/iio/triggered-buffers.rst
+++ b/Documentation/driver-api/iio/triggered-buffers.rst
@@ -43,7 +43,7 @@ A typical triggered buffer setup looks like this::
     }
 
     /* setup triggered buffer, usually in probe function */
-    iio_triggered_buffer_setup(indio_dev, sensor_iio_polfunc,
+    iio_triggered_buffer_setup(indio_dev, sensor_iio_pollfunc,
                                sensor_trigger_handler,
                                sensor_buffer_setup_ops);
 
-- 
2.43.0

