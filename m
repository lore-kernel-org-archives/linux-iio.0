Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1803E1D07
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 10:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170958; cv=none; b=PXgEgNJVTNV4AWxssCoxE19VLC+AH45ZZU/Q58mHB293LIvqPrCJRTAZ5+qSyVT/6Ma690TvCalOlNbV9HI4TuCtJkxLZ2aq3IRF4WWXLP/BaJdzt3SjSMYTP2eu2QDaOvOoZBBlLrcFX3jyXCEMa0wOB3Q/3ZDsl4pGpWkXqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170958; c=relaxed/simple;
	bh=GETuGlx9YbsBvylfdCf1CXJH+H4woz4StNzG++rg8to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=TJOSGCeWaPILxQ82I2XQJXtXHfVhVbuGwDFLh5w1wYBLrcMr8CcKoruk7s9dTZj/n2fuMin1j58Y8sQGtw8RzfsC7IZz5ropVyXQmxt3/J2hosTyho9lZVTVSECMZ3H44l6ITZoRQ9ZCufs7zr9lfq2Dx12KYHLR82kK2FXsgkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=co8z/rZU; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="co8z/rZU"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b0dbfbf7bso23230675e9.2
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 03:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788170955; x=1788775755; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0b6snvUzL0C95PkbFwQuYpM+8m6QVzJMDdB66/XMz4k=;
        b=co8z/rZUlNitYFeIMXSjiDB03hXpaRy/Z8ZfHZrUiEFDtsIRKl0n/CR0F2qMIo6do3
         zmtvMDT6Qc6mnyrtxgimqT8WMIsdLq/cGRWGIbmYJbUVWyAoBDd3xRgNEqnyeME5tiDq
         RaAOsDfGEPYek/yCrbcXDTdrIFC3AVQPdYtUgh9YVGf1Pim23F/L/Nt8bit38ZE1bZiL
         K5VRvQFqk7ut9Ru7jF0D2MXVC9EbWfBEbFFfCYQHdkSyDoMzcaKql9h2D6i9vOQ1zhxS
         iPNkB86sxl86nE3ZvNSsaHynZlLb8VcVLspJz4JI2ZXX2L0Swvpc9JZ7tuJ1nrUgk7iI
         JvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788170955; x=1788775755;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=0b6snvUzL0C95PkbFwQuYpM+8m6QVzJMDdB66/XMz4k=;
        b=BAQjyz6h9Pu3UTyLxo2fueT7A7N58uxFA0D3/DOl/FExEVaLLoWxdGOFxXB/vdB8PL
         YuK08K+/nmZ6u6plMINo+9yII7kJiSY6RTVnY3eKlooaT8npUgAOWQegJqYxLE5nR352
         azPlVwi1BAgHFuJaUvEXPRopVkf8V7/GgFMSA8JVYonidJpSZvtsAInxuaHyHqscCatd
         GfZtrX8wXxRVUuFEakF++TnT4HIrjtfXFwPptioYkibFWyScHd+V4Kbz01pmIxFttX9j
         kanXATnxCSYfu8FLSgfeV9zJ4lXXsrYn/P7sG48wxHwja5cVKkUqzO9yWEpJeqc5Cz/D
         h3Dw==
X-Gm-Message-State: AFuF++lBG9aC3bgcsmWW3pVYMB28mz3Z7cx0J8xLG2yYz3149ipuQwjM
	rt9IFMVf9UHRnKGXBitxoaOAvUFOIc0t9D5l0z9OIgkePHH6nsyD0mDX/9PZeQ==
X-Gm-Gg: AR+sD11JJbICN0zRJSCDYAQj2xtsVQaS0aY+lp9iGvH6n6IinLP1Q7a21JUEUjc9WUF
	k+szXP1Oqys/hW3cnhYM1djwG0QlN4WK4Ft9nRYkIkyRsqKndmPJEch2x1z8U3O0Kh1p/bx5PZx
	qE9wxrq2FgTGVT27rAbsSxshyC6BzW1AtlXp8HKlmRTwAyhS5GhY3lJvGDnkQfEcGb05jUsqrFv
	dh4MTI63XHuxNA0DDHaN+8jIFsXhSfUXyc8eARIb+dMHXrmAPh+6+oMkQJUmnrLhbL7koXuCG8j
	lHHzK3Mw5SZ5Qcm8EVYu5DWfm3girjGDDxt4v3oB/roUrvGSaLicwGuY/wtzQ4pKYgUhptrXoKX
	logqP6yOvcvbNvb5KRgCNKKm1/WR91vfRmdyV/SJYXp/J1sQF3Pw+NyY4H8Ub2YNwk92ZZGGjiX
	/7C5aIc+6GDRG+yJz3f95/oevP8X+oE/eGm3bKSeMXnuJ12MyX5hIv0jw6Xo2iys/uoFhRv5JSz
	RM=
X-Received: by 2002:a05:600c:34cf:b0:499:593b:a15b with SMTP id 5b1f17b1804b1-49cd940c51fmr34622945e9.1.1788170954593;
        Mon, 31 Aug 2026 03:09:14 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:128:b749:8793:c76d:302:4caa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ccea87e1asm134097045e9.2.2026.08.31.03.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 03:09:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 31 Aug 2026 12:09:09 +0200
Subject: [PATCH] iio: rename stale IIO_DEV_ACQUIRE_ERR reference to
 IIO_DEV_ACQUIRE_FAILED
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-doc_acquire_failed-v1-1-3c8e59c07d18@gmail.com>
X-B4-Tracking: v=1; b=H4sIAMRSlWoC/x3MQQqAIBBA0avErBPULKqrRITpWAOhpRRBdPek5
 Vv8/0DCSJigLx6IeFGi4DNEWYBZtV+Qkc0GyWXD20owG8ykzXFSxMlp2tCy2XLXKSVqlA5yuEd
 0dP/TYXzfD5Jk6vBkAAAA
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788170952; l=1209;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=GETuGlx9YbsBvylfdCf1CXJH+H4woz4StNzG++rg8to=;
 b=HObEwJHbU0xLgmkAryyLWKuHTpJwywNuG9f4Do1zUVvwNqggOgew/7UeFzeBHPXVGv76r/3XM
 fgIuVcj3tziBP5jAY4Im8fbuXXdwxvfvoEye80rowhTAc3nK0CzBFS/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Update the kernel-doc reference left over from an earlier revision
of the series, before the macro was renamed to IIO_DEV_ACQUIRE_FAILED().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Trivial documentation stuff that I found while getting the next version
of the veml6031x00 driver ready.
---
 include/linux/iio/iio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 711c00f67371..989c1db8fb36 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -789,7 +789,7 @@ DEFINE_GUARD_COND(__priv__iio_dev_mode_lock, _try_direct,
  *
  * Tries to acquire the direct mode lock with cleanup ACQUIRE() semantics and
  * automatically releases it at the end of the scope. It most be always paired
- * with IIO_DEV_ACQUIRE_ERR(), for example (notice the scope braces)::
+ * with IIO_DEV_ACQUIRE_FAILED(), for example (notice the scope braces)::
  *
  *	switch() {
  *	case IIO_CHAN_INFO_RAW: {

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-doc_acquire_failed-bd0f94415e2f

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

