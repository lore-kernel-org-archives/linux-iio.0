Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793765572;
	b=bU5X5tWFosqoslnJQ1q5OkNNl9w79lxkjTOD70w7jx3mwaNREMO7tbp9uClG1nZFmzaa
	 elDMmodh48akx4WvS5n+dGukaoCUV8Pq5CjyRHdkhPk7M5NMOuFKSpF/YiEPVsjGZKIht
	 02HT44azFYjt1IS5M1RMF1mN0cf8hg5BnBjPk66UFU10KuZK1hKc0KcGGfMwLDkhrA1wC
	 oLzl2dNoKgRSGZm5ubeeHCJA3ZgwB7QpnvR4QQpY5m19I4NPfuSKBQOeDyv/m+wmZb+cM
	 jGNnYHSGlUEKPS9mMVpNtnKUIxqyn1csPnjDLKs6DxvKg22397gP+ust6uiCPwcsaFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793765572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ETxWwH+3XKdmGy3va4VsbBXcOFXJDAUa18QQihknvJY=;
	b=lML5IIzQTsJQmwSTvKlr8/Ob0qOEuObmVyGp344vX/FJLFaVHNxHg4UiTgp6nJI7omHi
	 TvP7qmL4c7XHRWt0+ClYEXN0rsa9mfK61SWY5nH7eQOdMhps77U1pZBY6JLjtynhVwamk
	 YXRhOr4q+rWdCPGDrVb4PZ1haHBd5M6d5WihZ2P8MEuAMSb6wG1XY/4rVma+e7nGzymmi
	 5gh9iVyok/OYYDoT4EHC3qO4f8m9iwSQTBJm0NoamRUHlr3nIySJKJSaBUXhdZOFNHU1F
	 OWGsOTrSxVqZtKd8Xrs858WTQ8oe8ecU2MrAO9TMxrltz0B3oY5puvNepbwJy2AfNXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMPBtEIm;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A64E606A333
	for <linux-iio@vger.kernel.org>; Wed,  4 Nov 2026 04:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A64E606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fMPBtEIm
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so1836165e9.1
        for <linux-iio@vger.kernel.org>; Tue, 03 Nov 2026 20:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793765569; x=1794370369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ETxWwH+3XKdmGy3va4VsbBXcOFXJDAUa18QQihknvJY=;
        b=fMPBtEImdLr6lzNVywHPVDC5UuCXcKQy5N3a/MO3j7fq+oA2GN9GpPhpGxS53+NKp1
         MpE8Tu3OquQp7jzudEMTfxpjWfR9J42q8slj3J6DyqluZIOeLT+jzNMoY92yizglDv03
         QCZf6IkpYyZQ1GCk+5TH+N70HBy8xyvH+8kkalO9jUmw54/9UWtVX2DRViUXMsUmb1/P
         Xop3iQwC8V+uWKZipkPXneGMAhWq2kzz4qAPrT88RErlW85ShKpn/ly+649lA0DxCuLA
         h/XWLf2peMm3HUvz7bR7V6e6gflSzLgCNWHsWXN7MDTor+L+CFeg+oK3hTwem6zj24uE
         iilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793765569; x=1794370369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ETxWwH+3XKdmGy3va4VsbBXcOFXJDAUa18QQihknvJY=;
        b=DYT8rYpkp6kY4OM/V9jwNUbk61/yPIx5b4E3pwH2xGNQsJk4KSiLBWe2CNLhI90Ijc
         S5MxqzZWPexhl+jiAIywyAxt5OoaVgFuc5yuVj4w1csrxf5Rke9ntu881SQtYRlIcNzU
         tTb+Glgblb8e0NwqRgfzVt7i6w2t9C64ngE3SjjjRkI5F0YNhoGVECGWRohdhyBnvBch
         Hi1eo3GyWgYod2YSJcYnF8IiuPlnSPbN3Ikze/IskFVic9Zgx5pi3xZOahawaqt/HbJo
         9onHHG4H0EGKfZR8+vpOz6hkCOPpe/GYC0d1PA8AAbSu9DXJYHbvhSVw3+TeW/Nnt9UG
         zFOQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1e/5KaE+uvqi8PnjrYQDvI/VBhUrtaviTurg8h/n/gcbjNJHjBh1dHL+Cl7rhJ/7pzK1CrY0XKx4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+gJUP7AhJ0IOHfxpwJVyRx+YgA1wVZX5O5+dYDpQxqB34SgoSS
	dt4QC+g0DQNRAHO5LeEdYUhIQevGbQu/bF5LDj4GX7rtZ0A2Pk4xGmYG
X-Gm-Gg: AYBFou3I1dnrvDQKw0Bv/EsxK8VNzwZldO0JkKd3mOkZUiT9Kf+g02iqjNXCnNAMkRc
	wcIqulGVhuQB2YTp6hj9BxzqDQEA0a3yuVDNHnDvddM7ELJKFiW29aNWjxDbXkyLhsRf9+SXCbD
	KfrCKlSiYa6tC5HzTQ7EYSSf68HSNv2kgFkP5VG0eB9d8Mgc/H4hdsi+90rXzc8MR5WdI0Pffey
	pZ6G4qNtXQoLoSn5eLh7WKCgzGyr2NAUiI3iQbkPb2ItVy+HS8DQYSpJ7l5kahO+PeJywzlFg9P
	CDkd4o6uTeZ7EKDxYQ+lR/m4qrVjw5/bE+z0eVsXXKlAFr+Jg7m38X2uKhHAnhKEL3b/fvBROj+
	KjFwGYofLQDskXpb9KYU7ODwvnQLBku3rOfbJZyj28ahz6rUTDfnrBRhDoGJ3m2FPUzMv58nSoo
	Aqui+sKXH4v0QGMbN0XlXg5O11tf1JES7LPxUZ7bcsR5nzFQR9DruskQbhyg8NoTSYmxdEzxiSB
	o5Q1AqkpLqYAjwMc9dTI2pVBhi3suD/Eqw8OY0jPtsjgjuDa2z/QhSz2ypPWOliJ7XFpGVknr0u
	F1eGtDgrX1AV+jiTy6WrYPpRGAfMW+0E/3/bkf0XSAvIntcWisEfNmqPoD2PQcCEg7nCJYWpD+6
	jRMNoCZ1RQr4a4Nch6bNSzbAboJkLPCPARSRHg3yOC1wgWPDPZyaWCylPKFv5w9SxM119KumU3G
	5Vo27l7kPgleBe
X-Received: by 2002:a05:600c:46d1:b0:4a1:df52:3e36 with SMTP id 5b1f17b1804b1-4ac17b2cdc2mr344273165e9.27.1793765569288;
        Tue, 03 Nov 2026 20:12:49 -0800 (PST)
Received: from maria-VMware-Virtual-Platform ([154.80.94.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b437864e3fsm21212225e9.0.2026.11.03.20.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 20:12:48 -0800 (PST)
From: Maria Sheikh <mariasheikh812@gmail.com>
To: outreachy@lists.linux.dev,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Maria Sheikh <mariasheikh812@gmail.com>
Subject: [PATCH] staging: iio: addac: adt7316: return 0 in _adt7316_store_enabled
Date: Wed,  4 Nov 2026 09:10:45 +0500
Message-ID: <20261104041237.7978-1-mariasheikh812@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_adt7316_store_enabled() writes the config register and returns -EIO if
the write fails. When execution reaches the final "return ret;", the
write has succeeded, so ret is always 0. Return 0 directly to make the
success path obvious.

Found with cppcheck (identicalConditionAfterEarlyExit). All callers
either check for a negative return value or pass it through, so
behavior does not change.

Compile-tested with W=1. The disassembly of adt7316.o is identical
before and after this change.

Signed-off-by: Maria Sheikh <mariasheikh812@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..4cb03e7808ab 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -236,7 +236,7 @@ static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
 
 	chip->config1 = config1;
 
-	return ret;
+	return 0;
 }
 
 static ssize_t adt7316_store_enabled(struct device *dev,
-- 
2.53.0

