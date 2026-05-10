Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BA538228C
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778416772; cv=none; b=jzZOKDnvXy/tjk4s6rc8Llw8afa4gAwxYsFPP43w4jUOdTZQm1GT1yN7P/dsSab8OZSW1dLBrhDF69HyYxy2fHJc26LD1mifUwt/S+z3lFf8dulNeIqoW9RsbT5IukZmded1VTeqDXazV7rOUgjICGG392YT6CHeaJw3oA8z2wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778416772; c=relaxed/simple;
	bh=tiInRFXw0ChFtLG5uCZ8/at2VeXzGBG5juJLF6ywvqg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DLEJRszPKHgP9zJPslPwFBRIxHv1BQld15t+taAHxUrryT/WIPL+fDr/dXFSKXcLCAWAV4xWp9CIkBr1v9ghsVMNKnZUNox69Fr0I9ShK+/aUHAOe0EPGq+gYbYpNmLmk/T9QW8M5wiPjK7UnsXOu9J+h06TR2eB8XgXW935zRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZvOXDEr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZvOXDEr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48910865133so2389395e9.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 05:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778416767; x=1779021567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0MUjPS+klZ1lXoqWs8dy0+W7ygtu66uAdX5gWliSBmM=;
        b=LZvOXDErmqAnDguVapI53BTExfbjpwbdO/k8Qpwfv81BJxrLsT6R3Vvgy29yyFeKo2
         6DA9IcWMnWOwDEr3FNAnPzSki7jrf7XmGVaMUTo98UG9y7ddJX8f9uNEqJkktGoJ5rHv
         kFlOEmHGV2oqpdjmP+5KnWsYJ9h+wLeNXT/E64sAfwEApWvx2PxLVbMXYKcpp84a4MvI
         2JsDvJKJmTumvKy2AnXeeB7bBLeY0kvwHRFQUu2BsuSmhlWHztEmLdlmBoiWS7tHDU2i
         EHemiM5OULQNniA71yc8MatAvMQI7Sn7Tu28VwVblh3XoZMcKvrnHfUR9qliQtnfpRRi
         kg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778416767; x=1779021567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MUjPS+klZ1lXoqWs8dy0+W7ygtu66uAdX5gWliSBmM=;
        b=Q+J/een6CY3e4pMJoAb1C7FjfRPGHylZhZUbAceJlfFPqykqRXMa8BzJ4ko+LWv2P3
         8bmSiyfCs36F12u2HhSRr1rzY1sdWGdjp/j0VgXlAscdgujd2+BGYhTFAHX4qpYRk/Wf
         2XEwZFVVxlfAS3CtgoNrIEfCvw5rU8AObSJQZngv+LyMKppxqUOPTm/obSsr9nwGEwgz
         iIKaGdha4WjrGa8iuM4LHV6cKQwdRmpC8g0x3/yyeRDCjZyslyaJR71EdXaT337Pjd2c
         HMMGSbG8KJw32lHYxXitu7sH7dvnrKEAdhFXq7YTgWAet7UWycx8AoDLAxpPpFiqFZQP
         2jsA==
X-Forwarded-Encrypted: i=1; AFNElJ89nG2hYqiuIdCbU+BGx8h50/FwwebeW1+dLNAD477AkERC0a0o9NG7OSNMbu50K8ZSxWjv6Ri1ekw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqTXpe4Hs/0ko9Nke3Omb+K1pxfeJ4gg8yuRtNCEF5wqaYS4TK
	jEVprJn4n124yY97+Gqwc8lRi6dk7AaHqLJYemgDv6WBpSc1r4EcfKeC
X-Gm-Gg: Acq92OEbiQs0sal2nNoNqgjYHHnlk1zu/0FZDvWz8RFr1PGurbdqlv3z4zSLThTnbJZ
	/y/lnqS0np0EW7pvb7wef5QI6+3mr9DjrLZlOaHAWjsgCm6gaRGs6OCJvCyExQ5Zf+/B1S/XVGn
	f94R2WF+5VH3xXj3ee0uiKQ6w1zwlfKO9q5Ramh+cZve9hkrMHpcQk947zzqwft0eLfUCZIVYeO
	E5/Nk7DucPx+Iqhw8YwCr/TXphFWtvLlUfIBM4fc42LCTRe1MxoinJ0xzo4l/ZnomeKJLNm54SJ
	yRfI31qommPNZfvna1GzloYY4QABPApX/xXI+Ktu8EQ54uo7sO2/ZeI37wCDiauZj+QZB+lUSps
	VsJopUWBj72RX68N0fxQqvs8Rblh0uUSPZyZXi0Tt5VimcDQElJnzxcsjsq93tRtVccCSpfmXNJ
	EhKgJ6JcUpWZESmlJ5WnXFHaDpNa2oJqKY9jt8XtPpzoCt
X-Received: by 2002:a05:600c:524a:b0:489:6c28:dbb4 with SMTP id 5b1f17b1804b1-48e5329e323mr145369685e9.5.1778416766695;
        Sun, 10 May 2026 05:39:26 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm17628703f8f.17.2026.05.10.05.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 05:39:26 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	alisa.roman@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: adc: ad7192: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 10:24:01 +0500
Message-Id: <20260510052401.31057-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "at least 500us" wait after serial interface reset has no specific
upper bound. fsleep(500) expands to the same usleep_range(500, 1000)
internally and is the kernel helper for plain "about N microseconds"
delays.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index 8b1664f6b..712004ab5 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -576,7 +576,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device *dev)
 	ret = ad_sd_reset(&st->sd);
 	if (ret < 0)
 		return ret;
-	usleep_range(500, 1000); /* Wait for at least 500us */
+	fsleep(500); /* Wait for at least 500us */
 
 	/* write/read test for device presence */
 	ret = ad_sd_read_reg(&st->sd, AD7192_REG_ID, 1, &id);
-- 
2.43.0

