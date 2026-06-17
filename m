Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8583CC7CC
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683254; cv=none; b=m/JxGP1q4AX9Mi74Mlxa6tw45K2vQwlvo62Eo2eG1UXOjuATh5WN39bHp9H+5ybtZjdQ7dcF/UeK6AzjyMyW30w3VllzJlwUnaoTlsN0kks/Pxr801Yg4gq8OOt61s729TJWCtEolwZX1p91toMpg4v/sHTe7KkETM3ZIMsym2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683254; c=relaxed/simple;
	bh=HAi2lFG9zciTmNwzjiMeaJhfR/QYxc38dcz+eeM5v3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs0pEvFzOqhxpy733FofH8UcJSvauGgzfnUry5Pxc6E398devJpSZklKz5BRpbOEbpNGZz1d3lxVWZlmWH9KTzkNHJYMSYbFDG1yuSABbGSiXEnDxnT+zOa6qCCl5L0mUnh3sH1TTN9X5Vexm6IXrkHWrr3N8Q6p3jjQvS1xKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OUdfElxr; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUdfElxr"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso796480866b.0
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781683248; x=1782288048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unbaKaB/vtuL7mVbcw6i8cWTUClKXSp2jofrc/k4FUs=;
        b=OUdfElxrVRVvBJaKiqMN4D6jqwSn4vOV4hkds1oDsnPTwrGiG6i4lGtznIXXvn2bLl
         jQv5TalctKgzKPyUr7dVLp+49u8/U80PnsgOG0NmfmEKEut3WYdjXghOiYkcPNCHTJ9K
         HHZ2CJiIWsG3x/5FgON8LfF4Ph4nr46hMuF2+wyAG15e8qrj3EPuIPN+orwu9TYT90d/
         v3BPRci/SlVEOH4IqhaIXLfTsLuAak5aOPDSZhrVsVdfB3uYgCQq2ojsWvMISRnPU8f8
         J8J64VlIlmv13keHaqYDHJQvc4TKYgfGYjmbnzi+TtJ4mULpSTsXwAuuA5sEfZbxsooA
         xaew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781683248; x=1782288048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=unbaKaB/vtuL7mVbcw6i8cWTUClKXSp2jofrc/k4FUs=;
        b=jvppUVwrPdA84ecSBp3ZMWtDBEkEv69el3sss2PFnzFvLyY7iAZ885v0IsAsDIbhE4
         yi/KTEZAyWFl8VCIA7JI913ET11g5sDBesKdWfkqIr1Lu7QW+qFUW2cIqDuxAvflI+my
         dZL1DEn4rCKV7OF8w2dGZ0KlvFiHSTAYlfmOfAt/zVoAjlw/jFOGU9mXdQBEp5Nr3rHm
         uVQxMRvLZgXUwVCiQttQftH8R/HTcxrUJZe/jkiQUKl0C3r9f0LEdhGUA3Alqb0ZQ8Gc
         ZBZCad0zJ2VVlJyo7j0bYUI0qkdZmX4HwEB1leYLQFN1tZG9XleQCoNJTnGHTYHme+bC
         5Uag==
X-Forwarded-Encrypted: i=1; AFNElJ/GBKnaNBIAA31Li/Y8BBoKGvUF4jzWhK9CVlSNblmJYF8u9oZs969rh/jYuhWG6/ogH3rSZuSfgvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwobtGGQQitrQYKwV/aVJs/ExnNfOqF2FQsUiSEFvMe+/KN9tMt
	hIHNSf6d4Y4KnSjh5WMlbX2cpN7h8K30bLX6IowgdNqoliLLVQ6CaFfA
X-Gm-Gg: Acq92OFuAxbwggXZCTRrj04CHoT0ii1bigSvPWFPO0w+Hj7o22QUAe3NphAi+CZ4weW
	RJhbqFdb8qwBF/DdHFWI5Ah52T+vFQTSfGpvCDFuMf38JQ6tJPkXP7wSIZqwLJwpyDh7jk/OOyN
	lLxuL6gDR+nCjRHG3cFtFRpRzVGuDMOap46GQDJGMzr3o7sWcq4LLMnbmRNuaodl3Brqztgkm1e
	hT7ZQQHizhD2eqsdR5nnpuOYxY58oBIDGPb2sneIrmy0OB57kHF1LiDFZ8uybeet7SMlcBMdki3
	tXNFAslD9ERk5eQa3Z7gRya1TGpCzWP6PH+FVbs+Iv2apyh+EI5BoEYU57WBTiDReYJhP2HlP38
	y0/pfzRkbic7evhnwqvYgmfwMsSO1bn8B5Zt6Ky6/1/hRGCo8mbxn2sycv2wfpHxDI7+ZGlo8bx
	9qLw==
X-Received: by 2002:a17:907:97c6:b0:bee:ac9b:9abc with SMTP id a640c23a62f3a-c05a6ed1a53mr193361766b.22.1781683246256;
        Wed, 17 Jun 2026 01:00:46 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 01:00:45 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v5 03/14] mfd: lm3533: Remove extern from shared functions in the header
Date: Wed, 17 Jun 2026 11:00:20 +0300
Message-ID: <20260617080031.99156-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 'extern' is not required, drop them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 include/linux/mfd/lm3533.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3463b164d0c1..c4c38876c09b 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -82,13 +82,13 @@ struct lm3533_platform_data {
 	int num_leds;
 };
 
-extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
-extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
-
-extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
-extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
-extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
+int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
+
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u32 imax);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u32 val);
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

