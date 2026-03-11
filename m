Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E233A7592
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 07:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773213796; cv=none; b=rEEEjo/3TMS6BGBS9KUDCAAoUw0PpeLeV5ZxG8qvnKk4WmwhpOWyfWgE1wXr+6Jav/OYRFOWxgqyN+xCeAaGWkPzHUXDjsDE9PE6nafK5YrmvvbaKzasNoOt3Sock+1GBvCPJIpIPsQMbdrfOoa+HtEj763sTvVK/LNBGx1ybNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773213796; c=relaxed/simple;
	bh=k8rz1SI/iu18xVsuv9AvC01u3jy55XY3qSnSKKjJHjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f1+Mwdi09DozOUhDs7wJ6b6+zVdAjQRm3lRsxwAGBruDMFygOXasrp3MW0JWsRN9Bk9aY3EN1Iij7C4k6wNPmkgcnEq3ie3M6FcLud5w8q+511xo9UNpzWhIJbzPWFhS2bVk7B7QRUbPNlUbZVjl+lRnZGmyWK9reFlRXb4iIR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwUFmmQG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwUFmmQG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4836fc075d2so11849805e9.0
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 00:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773213786; x=1773818586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=86aRCi8i7mN6Pgruptnj4oyN+hhEXKOO9Bvzbg+MT14=;
        b=PwUFmmQGFh+j+AC+cW6hdklGyiEJnzFgXAyB/jf+YqhxCSzhkU2c5kRyc85keI3BHG
         8zHa8v2MYk10UhFpE3i9aaJCOkoXkdvPEAe1KfkftT7wE1D53HonXMer5z7zKwDUNSQj
         IfALvRLn5KWY/QfaN+0BC5u6Dv8WsX0oqg13M1pjsAj+mJENkv+DpVlhl2avvfsn6GtV
         y+BWcBCAGLIqig5XweR1SGTxxJxjFxQP4NPfW4z/EUnIcIpomgPb9Mt2kfzcMcajaeuN
         b42gIASrUHDt/ohliFVFT+DFXuxXGys7CLdFYs6gqgDB3ag9LpU63wIk8Jz9vHjcQ6pT
         0o0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773213786; x=1773818586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=86aRCi8i7mN6Pgruptnj4oyN+hhEXKOO9Bvzbg+MT14=;
        b=XSoKZg5kqfSh+KqSDvDnbVkBgS/ytT59XWl8ud1ypTgUCHXkMuOrZbPDR70B4xgvYT
         cHGr3zg15CG3GDR0EP4dJWTyp59EKyxR4+/8rFMgPw2eLdn7LKni9ZH11mMRLEwmKJ9J
         v4AS2wzjfi7tFb2hLCrDllIF9DbAvdwbys7G2Vs9ACrbcFrX/okAUYJ4SJ1S/PN9Ds3L
         bD0A06PeynI0THusO/ekANj/97OrJqnusAVom0Bss2aVTHC6c2xQ/dA4W7BZEXdBHTHl
         ILZQ58q3Sy1KsRjx0bfmzCC1U6USSs/NJ2Ipti0cqfO2B+r3HglLqt2OdvXamQoz5yx5
         1exw==
X-Forwarded-Encrypted: i=1; AJvYcCVzyxqgcU9rkRgkDF2d/RTDRi6NzCl3hH+/cH+xARFdHJZdu7tMCg0qhFVgeXsJgEbpxxhLACfsrYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1259v+KM0nvaau5hzL/7l1mUS5BdpyWVr6cTvgSnHkSbhnpf
	OQsx26ZM64ctzclNw/KwVGxkwZT//HbV2/AUViqJkK1Z6154O+qARFGIgmAN33ELqHQ=
X-Gm-Gg: ATEYQzwespMbqDK+sbk0dVwdhbcm7P3ehoxokivYX9xmmPFIF5PCvr+gux32Iy5pVLw
	HN6jDEZ9+dLaaVg35HOWiul/ZSD9ZhcUwn6ehLR5XsnH9nJ4tdyxLhgpS+ey/J/WFCcAdBBeFrN
	e3xYoJl5OeEndRXNvIuXKD4PHHeSiCCzzzjT0HrKOl7qoysQL5sIWB3OZc5eAEoal67aIdgmB/p
	ESIG8iprzWlixDjS0jn5sen889Mc4XhZJ98AeeH7my3tE3qtQeML3pecryahxunJnMEGEmHWkGY
	2YhGepqHJLzK/VwysAxIssVW0BsD/5Mn3AMuMXjltHyGAKL2/0SN1x1xF+ZsSykAASCZ2qLA0AD
	gyfqMZp4PvrYHvSt+BplDzDSet1pUShE1Pz3gFHitfiCbvGRgb2DoSV0myIXx5LAM0cJ8MbkkmM
	TfGzBmHOTTeKNu6ZEITZmc8MHR+SfMM0emkJXIYIKEoVX6xkVovsWoLdP5jfbw4RbTRmFj57PqC
	IF11sXpE2WBYk99AqUFdoZjqUbRs8CDevNrx+hYEQRkrmHye8A47v9qBKIKGDg=
X-Received: by 2002:a05:600c:35c6:b0:485:2af3:3f89 with SMTP id 5b1f17b1804b1-4854b0abbcfmr16031965e9.2.1773213785875;
        Wed, 11 Mar 2026 00:23:05 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0c3d66sm10785915e9.17.2026.03.11.00.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 00:23:05 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [PATCH] iio: adc: ad4130: Adjust indentation so statements start on tabstop
Date: Wed, 11 Mar 2026 11:21:58 +0400
Message-ID: <20260311072156.35057-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace spaces used for alignment in the struct inside
static_assert() with tabs so that statements start on a tabstop.

This addresses all checkpatch warnings about statements not starting
on a tabstop in this file.

No functional change.

Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ad4130.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 5567ae5dee88..f90b2dbf501d 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -605,15 +605,15 @@ static bool ad4130_setup_info_eq(struct ad4130_setup_info *a,
 	 */
 	static_assert(sizeof(*a) ==
 		      sizeof(struct {
-				     unsigned int iout0_val;
-				     unsigned int iout1_val;
-				     unsigned int burnout;
-				     unsigned int pga;
-				     unsigned int fs;
-				     u32 ref_sel;
-				     enum ad4130_filter_type filter_type;
-				     bool ref_bufp;
-				     bool ref_bufm;
+				unsigned int iout0_val;
+				unsigned int iout1_val;
+				unsigned int burnout;
+				unsigned int pga;
+				unsigned int fs;
+				u32 ref_sel;
+				enum ad4130_filter_type filter_type;
+				bool ref_bufp;
+				bool ref_bufm;
 			     }));
 
 	if (a->iout0_val != b->iout0_val ||
-- 
2.52.0

