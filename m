Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6AC3164BB
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439263; cv=none; b=l559g/mNiRiUQIJHX7STcLetqd8Tfwic6S6HErXrgJRtVuLkhQlsTiUZ8OWywFVFb7Vny4eUMYfPU2041sgfOqSrwB3oUMXFYEEOodsgiGGzW6FrX54MRfrTpTlJiDLh6RbWIdIdgUliVB+m5y3DszrXS/CKlPeOktDbIKIqJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439263; c=relaxed/simple;
	bh=oXfJFWjieL36YEnI2T2wUmSdgBSEBaqGLcUU3ljZGGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HQckhyLpXwH6didHp1HsMS8xF2dLC+h668DCnW3z/xmLNNdGs3QjKeF+UuJZxE5VEL6YDP9ze+SxATxOjJ97SsNzJulKgwrD2gnD3fcHlhQ03jSoAOU3u1G40OcCvcu1wJsIMvaVsMyYOYwOBcqYIT1QXzFV/z/QqSe8KxFZYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j05YPb8B; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j05YPb8B"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4836d9d54f6so4437565e9.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 11:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778439261; x=1779044061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nc72XHx0FU09ZOZXUXlMusr4uoZVxWVHm1h73tUslY0=;
        b=j05YPb8BW1WxqGaff4LO8Tb6lmXPTmICDZ6i3SEYgEN4D/ZJeQ6v3pGYRqNsnRvM4G
         dofSipzq0arOKc4NQ/oqsuk87Ragjou06li0WLChGb4Z0+cxJDiiGFwuqNhCUlNje0Hi
         9viMdbRjlZLhcn/vnXBHppFHZlclmukEcxsd6UhPYAylD9TKxsa7RNZTLJ4bN2lDrK0A
         2tNk8ugN2/J3HI4jo3QAuBEtn8jAMoUVIfOAAyqHObUxJ4b0NqoieSQ36F41wt1nQqai
         2J7lVUukjiSESObATEO1pDAT94IqLLa2Su8Gt78YsPP+sHCPAXzj4JwSLP8343awxKmO
         XLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778439261; x=1779044061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nc72XHx0FU09ZOZXUXlMusr4uoZVxWVHm1h73tUslY0=;
        b=T3sVrZQfhigg0YYv+YHo5hDl+uSwKMlGzvdAceKXtsrYDeff+5iNDFtAP8osz7fRcX
         oHWLJGm1T0m4ZFet4T7Dhwkf7fyL1zGmSNzNyuMGyjQp5BsaTovNGd0MF4EbASqH+qam
         pCBNi1eVlgGY5k1Z/q3bUIXAjUa/5mSz68JVppiyrSSpB8Irs2IFoNPyprvd9zRvcoTM
         D9974j0BPPsU4FVTn1jHF8x5C5q4c/ch0y+qUKeNfqygeQ5W5dO4uAo8q1hL4s3ngEEM
         LEUMPFiygtCWl+WyunNFg0PxvhCrdYi//JCukss8+CKDHDwRvg3ZpcmhMrmyDGCADBit
         XvVw==
X-Forwarded-Encrypted: i=1; AFNElJ8k/YZuh21UmBkt110CZg1UU9U5+JJS0s2Y5tM6Z/B2cmpM6wzTpHKfxgI/Zvdf+Eeti+8wCgdgZVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq/n94g7LyHCQdHRKDKkhTitD9G+Omy9cPFoaqtzo8CpY5oo5I
	D05WcMaRgGRgl07EIZvM3qUokXsYnTpaoL2aBVkCo312sDx6Nj9ioTnD
X-Gm-Gg: Acq92OGfVT2uLLFafz/NRt782KMFvo1rdesGSgNvwvt6P+d0XUWzR0FUwk05kG4sqW7
	O8ciKgKMxX1rKBk1vq/40tWi/D6E+hzBIfJ6BapfnZNRKS2X6KCw6QJqdSOCPMnkSd16eiuCftI
	ashpE+k3Ojld6lT4BTLulE/JxPyj1uEEO0bkRr4+KthW0wHY/bbnSQmZYQo77abGYKZ9i8VUQdZ
	GhqJVHM3cUs2/N00Fd6MZIfV2xF3JyKkWpLa4KzufrXKSRgzcA/7JtN4FmEjEvYDjmLy5VTdE05
	nTIsMJd4zWTdI1G7RkCCVhMVECx4snc1isppykaqlm3lnvaB9LHJu8WKhx7yfaZtmrkx2mJPwf2
	+R2b/JhU4rRthozEM5+ljHJsdU7r3mz2UaZf53iUdocPQbMNaSNN3c7Y3Ul2RlNon1A7izdkZjT
	7vkZAes4djzZVqrJUiEPPtB+KNhB1YzOd/wu14abOjyg9T
X-Received: by 2002:a05:600c:198c:b0:48a:58e1:6cf7 with SMTP id 5b1f17b1804b1-48e530bf915mr149803645e9.4.1778439260339;
        Sun, 10 May 2026 11:54:20 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6d8d69a0sm47271875e9.2.2026.05.10.11.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 11:54:19 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	puranjay@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v3] iio: accel: adxl355: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 16:38:52 +0500
Message-Id: <20260510113853.50019-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "at least 5ms" wait after software reset has no specific upper
bound. Use fsleep() with 5 * USEC_PER_MSEC to make the unit
explicit at the call site.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v3:
- Add this changelog (was missing in v2)

v2:
- Use 5 * USEC_PER_MSEC instead of raw 5000

 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 8f90c58f4..9d4421653 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -351,7 +351,7 @@ static int adxl355_setup(struct adxl355_data *data)
 			return ret;
 
 		/* Wait at least 5ms after software reset */
-		usleep_range(5000, 10000);
+		fsleep(5 * USEC_PER_MSEC);
 
 		/* Read shadow registers for comparison */
 		ret = regmap_bulk_read(data->regmap,
-- 
2.43.0

