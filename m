Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AB1F91D6
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897080; cv=none; b=I3gfe7p8G7fHLnluVHsZV7L1bBIGrbbkyFjjgYYV8XorZgK6LkJhCrY8Qt8/1Yq+cZUAYzOYNBiyq1Q5V9tXdiz4gGlVf6bq7kt9VwaDDXDXLfs6UzwfBASpkQIcPIuPWrGRVaFe3gNL35OQgzRsPHN3nw1CrS2nDHvCH3pbsj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897080; c=relaxed/simple;
	bh=I1DFw56XzaYS+/IMODBWvSKw1MhTzngvQJsdObURv0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ClJuBjamfgyXkAZZLNGfzpIyJFn4rLB1ZbbTKx0lI7jjfpPpNxsfD1d8GEJTbs/9bkv3Ca8ajxioJ6ZeQLAzsv4XFpjlefDEzOysO0aEfneDS+c43B74DlAOVkt1VeTXE0vuOSdzj/L0tjXG+g0Dzh0Y7QEXxPL8r1NHIG1z4Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri8TRwtf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri8TRwtf"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so303535e9.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775897077; x=1776501877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YaNaagkyjxS7E5qu8B+EIA3WGbepoXDll7+Ce8YfdCQ=;
        b=Ri8TRwtfa8uXi3xoBm0CEOOB7re+ld/GOOx6QtILlOgoOm6PZ/mDunKpTSoALkw9zl
         tRXrc/GDZvYQZxOqt2cHkLa7D8LX3D3dtFL8AIhfKFfh+TEN0e2uByeIe8w4uN2B7BdD
         SHW6UDBaapTr+pl4kv6zMQ35bccgcmCmQFzh8brrALbMEXSqxgvUwRL3h/3TQFH6AVBz
         0UUiK/CttC+U5qHsxhRnZpf6Jt90iWov6THFgKg4vt3IND25p4DUB8KVWJv3EMGzBWQk
         NeBMlCbwzrOZ8qnJ+WRvu8F3g38qbiCZgHe59pTMdE+aqXzssmCnO24Wrjkc+24ljCsy
         46cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775897077; x=1776501877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaNaagkyjxS7E5qu8B+EIA3WGbepoXDll7+Ce8YfdCQ=;
        b=QYDw3aUzk8OSh5rN0AUnzF/535U+n5w8mdfxAHUIK2TfjX9NTVbwcz2GJEcLBnFrpm
         zyEE0YpSdG9wx4+p3DgpnXNcGPdVCS9SpNOLEzLBHhmhaC1JQT8fEIzNqmxUauXLjpld
         j9qelfwGkCPZRSDBggpmuVZ0jyGUThI6BgQSu7Ayhs+TIEaUNisOGkLlONDjDjZs25cr
         TJrMC7FN/twezmWuXcFML/8O1SMz1wN5UQw4WAo7fybtWMwZptFaaTxKGYH+QpS0O1Tq
         CdAMm+zHe4IdApRQbfMZYlfRry/MZ1WpUnxlpl6EkjWRIUYYtPALFm1VEv0P4r3CBjLR
         EBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4v8v+DAUoukYS0RVbw+kHoe2KmCrf9JT7zBsKVGvV5Nn/QnjCzOHCiyiq+gjq+dciKWEn6K+vcOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrMNaPkZ9KJj4S2lai+RUoNKhOKf6z0lqmBgM9k9XnGk9trUYJ
	JKf4Q5h1m/SxRWS/pG37MgjSlnVmFOZdOTrXnSAqhhxHlzAOyuTQ+JjG
X-Gm-Gg: AeBDieuPyQ0lH9F2zgaZBOufcqWQix1zmx6Vr0lu25vEO4z8fMMFsOWe5GdPIkaR7uY
	JBfYQb/Ee7ntZKI7bD2xdlY06G2kACcDI+oc96qJ8co/+lDGYSlmzaDV0vr1pFzrhaeNfIobeZs
	x5Ntt+nWko0+roM5BqyITqxCcT//kVIEMac0g7cHQxxKzAv6COcb748OHggFfm0nukmKG5kHT+B
	v3WkPKiLmtrT+iEb0mFdBqom8NRt2Eo9dTFMinY6ye0H4THjeuzXSBQyPqGOy/dS4krohoKGbqr
	wn7OqJ+M2DV67qOxfo53gOCasfltXosNzwsmJsvRbX/4MjthWsfI+U8jhsY5HnTTMSECbzkKR83
	1NB3x4pGD2fmR3caUCvqL2/S9J4OA1cZxUrRI7f4jkI286m7fZ0cciGa+GEnbuJeQPEVa96oHfT
	YXZQ3CjnGlhsRtBbfsYtiVl9LdWW+zrxhNKTQCNW2YSFaOND11CzWohLwKygCq7LXJylNuGrU/x
	6VB1A3mXfpsXrP7u3+l+6YhBSE2dhp6bVDg2DNBEOEDZrChjZFQCZgjZlJ7uzYdWNuBLt6rbVoF
	Dpadt3eAsln3+xmOmNw=
X-Received: by 2002:a05:600c:3546:b0:488:a82f:bbb6 with SMTP id 5b1f17b1804b1-488d6890a46mr80994185e9.27.1775897077295;
        Sat, 11 Apr 2026 01:44:37 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d689110asm41117715e9.35.2026.04.11.01.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:44:36 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 0/2] iio: frequency: ad9832: cleanups
Date: Sat, 11 Apr 2026 10:44:00 +0200
Message-Id: <20260411084402.71837-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up issues in the AD9832 driver,
including proxy header removal and bit math
simplification.

v2:
 - PATCH 1: removed redundant bits.h include as it
   is implied in bitops.h
 - PATCH 2: changed ull to u64 type

Joshua Crofts (2):
  iio: frequency: ad9832: remove kernel.h proxy header.
  iio: frequency: ad9832: simplify bitwise math

 drivers/staging/iio/frequency/ad9832.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

-- 
2.34.1

