Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494A439F95
	for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124821; cv=none; b=BMQhl5LsbMce5TrKGnYvvUFq5CFU/h5Z9Wu0oNVV5kq6IZMpBBWlS0pk1/X/hak51vhXB0WCIMZ5JyiZ72Cbx2EtdDVe+VrEMEGR7UJ5hA28MpGnNvnwNoUTLZbDhzZlaKyFT1wLpUQbY+qNXllS7OuyRcO0LBCu5X0v584kvcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124821; c=relaxed/simple;
	bh=EzMqYzDCfAQK5VpIKxY1rBROjxfO+C/FptcZy2zwSMo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKOr5uwSkus24mjpa+TWIo2OwrrmIM1QRaGKY7ZvyQuWrt92LvpI4+YyUyrFciWASQebM/uB6wPU8FgSV+jV6YM0A70jfk3NuKSU0GlmkpNrAVixQINMwnDQKHp4CuVacaViOBdUcRlMaunjdXli7qaEpTCc4u1Itsy4HFTEqq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dnw5zctS; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnw5zctS"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso11942905e9.2
        for <linux-iio@vger.kernel.org>; Fri, 11 Sep 2026 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789124818; x=1789729618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3n3/zWk0l02hYrsGBXj2MvCkxdWvZK6d8q8d4YMlMfo=;
        b=dnw5zctS3rzEfTAY8YH4e1zkcEAhxnHPVzkL33y25FT2TSlJSH1RV9tL0QV/5fpwcr
         cGlLtu/z9IlNCCfI2gMzytHcWTAVRpFycP0VHzvwCfNN5hFbReX9cgA14SyGVz18T3FR
         zBwgdf5jempA8QA+nOVzhNC15OSu+HMYuPfLE6XcmUb23irqe4uCFK5oQZasY2vN8TAu
         RPcqnZK0ZpDSkCV5wiJ37rdfeecvgjjzn2xMHowB0p5KsLaxQuZVzH5zRDgURlEc/36j
         97NLudo+7YxjGN7zscIDu2EmJHNfuGkWRJmzOqoCrSCM5NLGOgLjTiWinfQUutaIz1Lk
         1mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789124818; x=1789729618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3n3/zWk0l02hYrsGBXj2MvCkxdWvZK6d8q8d4YMlMfo=;
        b=k9MlGHxqCM6Dz6UpRrQqVyBb5DiN8YDFlHQ4vSIAujBF6ZBv+bXOojxgVaRt7kyE0j
         XI8OTFxOiRdd30YLTisKmsqYyi8mxdRjtX14TSqydCKVYXayXKuSulDwGbLk5NvScyRg
         xMADcnVsEt9O6/JTp5bcS3IpkvS/tyUgxbZSS4Wthyi5gmU+LObhMl8iLDiMX2RNNjkP
         7NSWBqTywMtPzx8Jw96zCX5MjA7uCwyuUSKRMQY7orwezqAR7iIOfzh4KFxWr5mbkeIR
         J8MkgWOmty/IxZl6q+Xr3CioigYTxP3Mw+FmkQb5PJCHptEC25VFHkvCLIArrh3qXZfW
         Bn5A==
X-Forwarded-Encrypted: i=1; AKwUvBz6bkOrDwUnsLsOMtTHksiJBOJ7VAMbpY+QCtu6IHN1esp4O8Gjt93HjPVY8NQ4ARF7sGzTd14vdqE=@vger.kernel.org
X-Gm-Message-State: AFuF++lfiv1AH9U/GzrlW+kgtqWgN3FWMVa6lzxkVCZIG8Qa4KrxDh7C
	fupevwTb1/rqILy8/z7JzKLo8EQ09UqxEoycIDi+ELIN6YguGbrpez2z
X-Gm-Gg: AYBFou0PNmXRiK7yjzcpV8twL4lkxtT2Kh6yXjz87aBCMGiSII/oJ4pQtR00zU63lYm
	5NzykTHFFyYBg0sr3AnE8P0tlpmesBMqIvgk8C2mSFclqmO999eYfXoPUZdU/tMJRHkwzQ2M5HB
	1BZ+2KtvjgPYzZ07O+/rNFVP3JLgHejwwZANIQRYzBRVos8s8Md40BbRSf5kmsNddPM0do5WhF4
	W2PIR9Hg/jfFIjkz0Mfve93UzqPy4mvr13RXkvc1HN0Mat+5rvp2h9X2Yw7K0G/ivMhSglhNbiM
	SirmrMDPH4hYaA5G3g8iTuLJ3h1lG9OuYuih7Ik7Z6P9EMkVwGJOZ8kSZ1+9PlTw0mls0OO2oyZ
	RJD6QQLiXZrbxqxIZSvIGQKeEEpZnSdox98b01AlaiejY850AFMGbmwdxiMRpM4m7kb6C8M3eyt
	PjT0LNxPaowVCfCQdk2M5LnCGIEGKFRbnUN8PqCDUEecJ/Jrd8Px+eGYq+wc4RiLuJm6aKBebak
	HndlrA1KrAZpokqwrs=
X-Received: by 2002:a05:600c:c491:b0:49d:827:e5b6 with SMTP id 5b1f17b1804b1-49e619bb949mr43669075e9.20.1789124817713;
        Fri, 11 Sep 2026 04:06:57 -0700 (PDT)
Received: from fedora ([154.182.82.204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ac411asm66109065e9.8.2026.09.11.04.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 04:06:57 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 0/2] staging: iio: adc: ad7816: Fix SPI read race condition and DMA safety
Date: Fri, 11 Sep 2026 14:04:54 +0300
Message-ID: <20260911110456.24873-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two separate issues in the ad7816 driver:
1. A race condition during SPI reads where multiple threads could
   disrupt the GPIO state.
2. A DMA safety issue caused by using a stack-allocated buffer for
   SPI transfers.

Changes in v5:
- Split the changes into two separate patches for bisectability, as
  requested by reviewers.
- Patch 1 focuses only on serializing the SPI read operations using
  guard(mutex) and devm_mutex_init().
- Patch 2 focuses only on replacing the stack buffer with a dedicated
  rx_buf aligned with IIO_DMA_MINALIGN.
- Updated commit messages to better describe the architectural issues.

Abdelnasser Hussein (2):
  staging: iio: adc: ad7816: Serialize SPI read operations
  staging: iio: adc: ad7816: Use DMA-safe buffer for SPI read

 drivers/staging/iio/adc/ad7816.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

-- 
2.54.0

