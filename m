Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5AF390CB5
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 15:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780241169; cv=none; b=pbDLwhHEQ1dX+GgWX/sje6gX8XJMbHh6uIlTcR7O10fbInpx/2CbXWYURaQGDQG4dpD9WxFlVpgrZqgxKvO6XwyAzoWxvE6WHUHdxmURvfpCwM2aDsCsej+OEVEWZae6t0hyuWklYA2nikF7Gy8etKgXGUxs2Uu8VE5kkTo2k5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780241169; c=relaxed/simple;
	bh=0FPRuvNNSFiFkawKVCalHb3yLDUTC8vh4qdYQm7Z9t4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U7seTKk/lildUc9GHY0dfuXHGBatGrvkEqRW+ggl6uPtxRx94rKS4dGrCKDdVVM3ClMfqexCeoaRWXOdfjOOmgLpMYlLCvu5ZUzJtSaBaC5bkQIxJlpL77bH8LEUUHEWbEVHbQ6Uny7wWiOe/YFXMaT6d8KGoKO6umsl/Ad6NV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NxOgsIhf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NxOgsIhf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903d5c67bfso53319865e9.1
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1780241162; x=1780845962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=00ruy8kpQH+b21j+wCBZYocT5CVhNgJL2HRPgVpHHfE=;
        b=NxOgsIhf4Abd7eDkXdfTSFbkwfYexCptLZ1WYR93xPbCKXvlfkMf4Ko8vsiLxSeCqF
         sC8L244TZd0WrAE9QNrlrsL9NR3RY7bKKCDG7kg5iMGxqh/taN1y4OJa6YTxmcgBcUQu
         dApnUP0yayF6qS/0rAn+we6cnrhCGAmD2yoxlEl9Nh4l1lhWkybjCgl8CDcrAoGHYYAv
         mrMmC2XH6k8MC35K05cY0dVfbUVxuDR+9a/DK7w4kZDjjk4T0wJn17NeOvPUp/SHyNLZ
         50MhNKRfyCR9ke7yjT/W29airug8y1takNy4kOvSQ7YYBFTajKncbg5Y3tveFszo1aOT
         GOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780241162; x=1780845962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=00ruy8kpQH+b21j+wCBZYocT5CVhNgJL2HRPgVpHHfE=;
        b=Pt12Z0GnABsaihNs1ngGrP6A8AQ4aZqoljoEDRz9E9LvYWIc4jyCQSRDKSomlWPtom
         i+qccEMKRl+wy9VqdQeyAO9CnA4jlHGU1LmMXi47R6WInwm1A2+QOFvTKiww+l9VOkWe
         OxRU1Ht6WR/t0R5Nz02XbxbI6Ycc8jn9/Jw1vW5npxNw1egDR33NmTfy6Q39LkbYjcUq
         9Zr8zFfBebVNCTysRwm0oRyy/1afqWKQnReG2ooyQXJAsCBzcS3qIBWjYjo/PsCQeJA2
         VCSsvbB3wEy7nDL95assrl43zkIb59tUGfgm7As4XAKEjRwjB3oHYCIkV0VjyE04yz3q
         /vBA==
X-Forwarded-Encrypted: i=1; AFNElJ+G950j+bF1qZwnKGinMgR+MEh8+xE81ml4lhSkKd5XQATwfJ04+DnBmL02fKKF6NetUzRP8uXatK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkNRnO4BgBWH1DcKLv6alBGpAvUMmx4aMejDiUkrENikPOL/Zi
	nQmS8J/9eK9pS+dyjt7aaVZYj54fOgGuBy1QVARF5T1S3ctkJCdoRMim+RTOy/bcIuc=
X-Gm-Gg: Acq92OGm2josrexCQF8Rv3BGDNiE7mFdoTGB449+cmnrHey5+j/toMDVMEUEQaXwvrW
	EC8syQWIkQEbCsPkRr4YbxRGIFAd/hNzllOuwAWD3sGESvUuCHuG7zXWlVY5wuDcnMr8ENTTCvT
	JcO7nqmgcZMcdNgevaoQvxr4QefnOg3LdjH8fTL2+BS+zHEX89C8lJhVmJCj01AHNinbxwNM5+Z
	sDTd/QaI8vueQYutZrL0vg9L1ouEWrokHU/Oq9yj34R8YoyDcLJ9onIwpBtnnn/PIYhHVF+G63Y
	1M9kHEC9EIN/0ymAhc3BvrBAsqSMyukOvBLU0K2QnOORl+H2dz3IwjUeCGEcE0mUOINYADK2T1d
	k42AoGi65+2GHMDV5445ec4l37aeMxH5DLyBhO0rVnKonvhIS1aBZjThXSe2J7FbC5UVGcj2br2
	2ZVA/DRrZtugjCXpq0kcInMaBWJ+FkOzSo2SQHvkM9+w==
X-Received: by 2002:a05:600c:5395:b0:490:4b89:535d with SMTP id 5b1f17b1804b1-490a2904b29mr165959705e9.1.1780241162528;
        Sun, 31 May 2026 08:26:02 -0700 (PDT)
Received: from [192.168.0.2] ([2a07:7e81:7daa:0:202:c9ff:fe53:eda4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354cf0dsm18526622f8f.17.2026.05.31.08.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 08:26:02 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Sun, 31 May 2026 17:25:57 +0200
Subject: [PATCH v4 04/11] m68k: defconfig: update stmark2 defconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260531-wip-stmark2-dac-v4-4-7e65ab4215dd@baylibre.com>
References: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
In-Reply-To: <20260531-wip-stmark2-dac-v4-0-7e65ab4215dd@baylibre.com>
To: Greg Ungerer <gerg@linux-m68k.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Steven King <sfking@fdwdc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Greg Ungerer <gerg@uclinux.org>, linux-m68k@lists.linux-m68k.org, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.15.2

From: Angelo Dureghello <adureghello@baylibre.com>

Update stmark2 defconfig enabling MCF5441X DACs.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 arch/m68k/configs/stmark2_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/m68k/configs/stmark2_defconfig b/arch/m68k/configs/stmark2_defconfig
index b3fb95f73a95..3941113bc60b 100644
--- a/arch/m68k/configs/stmark2_defconfig
+++ b/arch/m68k/configs/stmark2_defconfig
@@ -76,6 +76,8 @@ CONFIG_DMADEVICES=y
 CONFIG_MCF_EDMA=y
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
+CONFIG_IIO=y
+CONFIG_MCF54415_DAC=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y

-- 
2.54.0

