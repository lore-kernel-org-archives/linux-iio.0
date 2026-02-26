Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8F3EDAC5
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772147474; cv=none; b=aujWnBNrhQqe1HVJAU2Z3Rg8YZ+g3lVFb+CMLiivJr0Txh7/ywSZn0LghZH+5lUtZ+m6OOvEMbI0W4mCq6PfEpDOfKbampe+bZEWTzsUcLMplRZhultmZQoheGMZ5U8graYyLgqEeIBg/qpxp6OZPCpmvTefSS1woBnribrsirY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772147474; c=relaxed/simple;
	bh=hH6CDiMRNFddchoipK6ATY2qGAFrVRxTKkPTaNVfE0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fq8u9SV0m1zU1LgIsIRcMtqTW3TAO3O5vZhMiCQFoyrmpWSoBsuvdVoevo8lNbB8cxLWw9Cf6tO1l7XrLkxXLr/2JKAFp8Bm7JtBIPMmO4PrqhctpGpNDiK8bEpSCFD2ffG1XYXeELFMRmpbjAz1Qlr8b9up/zBradNmlgXHDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjrQLJr6; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjrQLJr6"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8272c559597so1476585b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772147473; x=1772752273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTvVwnEU/AtYKfH8y5LK/YN2IBNofpYxJTRKzbbZ8/w=;
        b=cjrQLJr6ZOih+PXFJinjbpYqtnmqSgKaFIWsKJ71WGEZTuImMgMq3a5l1XoXdPzGe1
         87h7PLs77iMFnSA+JCX8Wwh181/giWuYwupP05tADbN+kOHVKBwmBEFv9qXn84HPi/HO
         16/iBZ/rcSGX1ClO0WLBhl5EHoh6yAtgdD8/Rb60KhaF532Dj05I8p5Hc4VUa2XUijW7
         MMWwZjdNSn4Qz+Os/N2JDmLkuHMU0bxdPeSQyiMaM4dijkgn5HGATERz71rJHiT8nx4i
         JZESDPc4fLSt4uRNUPdXU0IMTPNS+KY6RXyOd3v1dKUv/6FmSOQnj2fSeoh/reNL5gjd
         /lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772147473; x=1772752273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTvVwnEU/AtYKfH8y5LK/YN2IBNofpYxJTRKzbbZ8/w=;
        b=CADY1QkjTsOWrvNhnNBKJtPxegFhy6rKhUN4vEh854OxEjNEnWDEhfR5VGBvsl0Mak
         bdwBo1plbZWlGP04whb+0g921H0C23hcK4V/QHEoGOveTfIrH3yhW5uUVqBih4bgsMDE
         Pi9+OqytS0utNWf0CCM8X30WHgToU//TJ96IMH8Uvii+ZfnSyN92PG74lxB84bnJluHP
         mOvpmYI/pLVF1O+54B15WgG0ipl92m+kOEABk88a9OWNkYyuHwTiGKwe7zrMSkKU+6QK
         1HNjnGdSMyaS8SDs40IXjIA6QT0pVQDC4LKr0agQYivepLeKkPGpVejfU3Mhuu4moUfe
         vzRA==
X-Forwarded-Encrypted: i=1; AJvYcCWSHg+6ygcSJUCrAajesHvmzz2cHTYkvK/GzewqfhsxYVFR7KhFP0tJ/b79SoEmdHvVexCUcMGPMKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSQNt175MSFT2l7S6NNAcvtUX+0L7maXFdMOAZEPtR8/9lE7bN
	R8i7BeylUrTcmaFn2E9yKuW0YfXhFHNtpHBz/hwMkW7UpWwO4zimzw97
X-Gm-Gg: ATEYQzxjObU02rmwW2ZNm5ObFsS5XsaPSBQ7/aTh68akbUqWBiqOB6T6c/S4sLheJ7f
	SvN9snQ4bOxYAUBW3fi3tFGR2KyJgCJrO4P6hFrQCZSNQKxl2Vgn6UeKSN8aJaCGMVJJRdco+vX
	qrOxdPetNQaUX+Y3JkcLKCS0WP/mGtoWhK9f1Hvokl2RoS0XcRPq+RIAQwDaCNXFC1uskjIfMr8
	N2KrhPlJJ6hJ/ipdd715b9KYKX3F5EnEYPYEMv6c4R0wdJMQ2yk4AcYbfJtyJRoAV+/EyZNgMyD
	O70/OfelxIPdDy0CG7avuRM6aNL5eC7gYLrfiPs35OtZuJICT8QSm4mIlVyv4KVpzm9A056N4Pm
	bwHpDnyra9N42i+UyYEL6u1FI3G95BVNDZLhv2lGh8Fox7jhFWZhq+zZryyXYq5aluZ3pFRp40c
	/SI4FRc5w5iLk25QLTXLyeymiy
X-Received: by 2002:a05:6a00:9283:b0:824:a635:4181 with SMTP id d2e1a72fcca58-8274d972aaamr807065b3a.15.1772147472780;
        Thu, 26 Feb 2026 15:11:12 -0800 (PST)
Received: from arch ([2409:40c2:5006:5b06:f9ff:5cdf:1c23:a906])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8273a01054dsm4238752b3a.43.2026.02.26.15.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 15:11:12 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v6 0/3] iio: frequency: ad9523: fix checkpatch warnings
Date: Fri, 27 Feb 2026 04:40:54 +0530
Message-ID: <20260226231057.20669-1-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches address several checkpatch warnings in the ad9523 driver.

Patch 1: Updated the macros to properly use their argument x.
Patch 2: Fixed the multi-line pointer dereferences.
Patch 3: Updated symbolic permissions to octal (0444/0200).

Changes in v6:
- Patch 1: Fixed grammar and shortened the long first line.
- Patch 2: No changes.
- Patch 3: No changes. Resending because something went wrong with v5.

Changes in v5:
- Reflowed all commit messages to properly wrap near 72 characters as
  requested.
- Collected Reviewed-by tags for patches 1 and 3.

Changes in v4:
- Used full name for SoB.

Changes in v3:
- Patch 1: updated macros to use '(x)' instead of 'x'.
- Patch 2: collected reviewed-by (no code changes).
- Patch 3: fixed vertical spacing and broken indentation.


bhargav (3):
  iio: frequency: ad9523: fix implicit variable macros
  iio: frequency: ad9523: fix multi-line pdata dereferences
  iio: frequency: ad9523: use octal device permissions

 drivers/iio/frequency/ad9523.c | 88 +++++++++++++---------------------
 1 file changed, 33 insertions(+), 55 deletions(-)

-- 
2.53.0

