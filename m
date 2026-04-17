Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F373B635A
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421013; cv=none; b=IjQoC4qVXbVfNWwopZ9ZCYyqiN3hiwKZEYj0TR2GaFVIHl5GgtdAr+B9QHZA+rnaa1XDegqHEPsizFbIl0cgo0Rd89sdh7Hs7TlAX76eP0iPB7yWKa5GKfUwvjX4Xnm8ReG/7UmCYb8+4n5OI+++PewyckPsaSwWwtxjBMVazwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421013; c=relaxed/simple;
	bh=Vw7D17ioAHMpV0rVIr2m8wJ9QnCWiT84kXKCxVydXYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bc9xgya65XVYpuPjwkYgqmrLa4abxpCD68yK/DN3kELeZhQ5OG1vnXhwoTl01jjS8L5FUl9+F1YNdKG8a+2jW/m3Mh9fIB3jQLoGXw8oSeF1hEPDdVa/KIAZ/dsymheBV/lqHI71tAfhOYMvmpDRAuGMTSOBXt7UITV1i8kUKT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quN85OIl; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quN85OIl"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c01854477so105123666b.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 03:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776421010; x=1777025810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ptfzQti2l8j30duqTHZefI9tN8DiTkDmOYqUjk7fx4=;
        b=quN85OIlOKuPUXAPzOzDxbL7jqac0KVJ00+vj9y2iR3+K10PV8CJmhHL/dLq0BIqAJ
         otn8ADcVoZWV4QPkr2coDrRF1BEsN0XVXMBKphz+g+0kU61ZiUwfGdlLTv5gIDM9u4d1
         ioGYfBCXJJvgZ5dGDaYkiY63kODfUJPwhgaUEG+duLBYgLZs952KAvsJnTzhSSPHoXmj
         A8plKhAiJdp3txpPHCwWa19xCw/zD0ScU3oGK7QyXMWjm1zj82A+HNCvUGoJWqiRZhK6
         P2xESOg/gZBIZpv/fedOwx4rb6TFVofi/nG6RWABpi4Uo95TBcBwYHP3KWjTMFsD+z9Y
         VY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776421010; x=1777025810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6ptfzQti2l8j30duqTHZefI9tN8DiTkDmOYqUjk7fx4=;
        b=aeyTpMI0oFlFL7J3ZpgQTjszEG21R/UmK1BRxoYvMjU7BGMGP/4C5iN7jiKNSjhT5m
         YwV0fM9Ff1uc5terPPDn5CkgbtYsJGc7ONqG6xwjLMlpkhlO51adSfVQmlzhhFdCWaWS
         S4cvs7K6OG4L9qedKdACPPECwYB3GFmHGwjHzVH70QrJNEJww4K+aYPhXf//zi4pTHS9
         f7FY05nAY/7r8THQz21+POGjOdy2lHL1KspdaLSu8ZAFyJjK5fZdV6h+/FCTErpxVaQT
         s6ykLum7hio/oGp7oSBsDmCkBOKY6G2JKy1Nqhcjo3UTyxMQLJ8f/6ODRe2ZE5FMBzYV
         PSiw==
X-Forwarded-Encrypted: i=1; AFNElJ/GqQIDxJtWNiFsEJRlg6MbAqPTYgPWQVBrfHEyWMbHBL7ldFeqDW7gmhc2vl0cFD+zOUdhsUtQ2yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzftoCn2Bw12v4wiAA0axT67CV+uYdpCwHbm+XiNbyTefoYkWbI
	zu4761OvKQ42z2jb0klLaOGSSs9xGySxKZHaBhcb/EtrgcRN2ySfvp2m
X-Gm-Gg: AeBDieuQspHOK/3S7k8sXOF/Qg7qk8bX5qHdaNUgza6mHwSgS7/X3UD9FNatXaIDdbU
	8jJrQJ2Gq99pHlOKKyGURMsWFzL4rTOTvGdQi8CNYa2atxU2s3P3ShMhbPrUSmEWGp2cXYigas1
	nfCfqz2oF/E4rOIuoidz2C9mRQ+muY484clh9+wgaFuJGHdzCWO6SKGf9aGY0anIzoXTNWj5nw3
	3byYlM4Gql92iXWLY0nnPHVg6n+NX+9dI/kkquVzWeP1KA+vrYV0C2Rkpy1wRa9asR0hu0ydpGd
	6tIOsjJpn7+zevKFse2uVyinZfeJFLPfFsLSJMtA5UGWGy9MoeUKIvBuZEkBFt6+aYkxJp6xCXC
	tyGMzsJosqFVaANZ3tFoabWfU+8lGeEVQMBpFTtwOcItVN/GKj37sE1t/YY93DyG1FezT2Sdy7D
	eQAgqAPax8uqmEAOqCb2iNB0TOedI5byjQRrt9seLof1Kzq16RNo11mwcF1CBn8a1RpFLAxcFSF
	dgHpxL71jTDYdjsJgR5R5Le7KNHzLU92exGe7xxxx2rcYhZ3Z6jRzgNNjg3RcZlrMaXtW/XtXMs
	miysileIGaSmXS2jOF90kRhjjGPKhA3xCl+5GXDQYXWnL1ghLKrJFWS+OO/8kcqjWkWLgcmv1+l
	r/1krIZgaiEBZihv0jdzEU1bTNsBJexeblqO8uk3huUYBaNTLUJg4cV2lFl8ZSAR030SmypilJk
	hYnpu9mubM75sxljauAg==
X-Received: by 2002:a17:907:94d1:b0:b97:cf49:efb8 with SMTP id a640c23a62f3a-ba41f0bc286mr108172166b.49.1776421009732;
        Fri, 17 Apr 2026 03:16:49 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (125.133.90.34.bc.googleusercontent.com. [34.90.133.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455926c61sm38937066b.63.2026.04.17.03.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:16:49 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v6 2/2] iio: frequency: ad9832: simplify bitwise math
Date: Fri, 17 Apr 2026 10:16:23 +0000
Message-ID: <20260417101623.1281-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417101623.1281-1-joshua.crofts1@gmail.com>
References: <20260417101623.1281-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the ad9832_calc_freqreg by adding a BIT_ULL() macro instead of
manual bit shifting for better readability.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index c0b7852f1c..6ce9651542 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -117,8 +117,8 @@ struct ad9832_state {
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+	u64 freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS);
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.47.3

