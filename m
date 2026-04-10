Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACC28D8DA
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 10:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775815724; cv=none; b=IoXYGfCe75SPMBKetN+YKqFNLymnMO9T3ZpaD8WOXeG45aA23KlwWIgkFgCBUFPZaoNdWfTu6ztotRdF+pBUUkPGvgXtgswfzXy2tUkaLJz0TT2+6jTKO5KUAaawPhqLH6ct5Lrftf/bxrRyitQBHUNwikqtj5P/fxqxk5VJUls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775815724; c=relaxed/simple;
	bh=zTnHLQD2HNQS3TBUN35WzG70fp7XRFIXVsjGjAp3eAc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzLc1LA44j1Td7tgL+bZ135ONLML+TeOORioL+PqJ8tpTjQ0NzI2aAR2ON85zgjdtkbbnE+Tx7d9IavKnTQezqt+CB15I65cq6td+2Ldw99d0VeKZySWN0LySqI3l+Yxlot9kfm5kgmIWK8wvAHZGeD4O9O0we0FUU2If4UKFiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nWgJizWC; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nWgJizWC"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-670af4fc2f1so163237a12.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775815721; x=1776420521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEmRdRU8ohaMy0h7XL4yvnjYX1agG/OYKNFzIwdN3F4=;
        b=nWgJizWCdZApaEFugpctGuZeVdC+5XBK1pOXUyv6D/uZ5blbU8yQ9Zaww+pzCF3CHc
         bAPhbIwAatcVj7D7M6DSy4H6W/T6+T/bFBEt+dj9IORrq2K9uJClC6EvHSZkyhFRGvTU
         1miDDSIatRePABfd7FTdHVgqdmZCjUOFqi3UivrGw4ow5WOboyc5tepheHBseubScmVC
         doTyLXIOWmS22Iy/ZrEPn0xzRCoAefMKHwMTitOqrclEvbz+ZXnnMpZeMX/YfK2uhY59
         fab7AGeCrQIPHaL21hdGfSZ0pDjwhBpYqB1wBSWG/aRvINLmJzJYsL34PO6twLjbrGXO
         +Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775815721; x=1776420521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gEmRdRU8ohaMy0h7XL4yvnjYX1agG/OYKNFzIwdN3F4=;
        b=Dg7rjTldPh4FTatmqDeU9i7ubkC0z7h1JwARMyFtlVkyM4IKkCypjtnNyji4mshT+M
         Q/Z7ljNQo0ghMQ1HBNCAeBYpbpBQYgeht448JyfLFhWskwixUlAs2uMPX13GCMxQD08c
         mPSNZlyh0tp9obSoqDXYfcsiGtx/QLbszjxj8ukxgLIVk+9B3ep5Hx2ZWGb2KiBdBQq5
         /gPeWd/FfqHlXsrYzqUF2jXDrtXBwnAYVaCIp1WYTsZkfZIm8+iPUNqRDkaLqgvtTgpL
         Vzd0yBA8n5IzbHPJ6czoRfxAkhzq6ne6MK2mDvESutVK+gIw967rc3453Qy1XX7IU+LQ
         X8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWloYOCLGsrr3NTnSNjrPkBHIF2MjS/Aa2Kqx82fBYLJkxP+Z1aYr5sqhG4ggelX8RZZhKM07tR7SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSyjjr8P/G+IBjpxZ+HCP0RMbjiUSL63u/nqLDELVESsCtu3tI
	7sSTIr7X0vjaXaA8dl150cKC/xzLXXLLFPwdrEJ9sttbNHbhYOAwzjEm
X-Gm-Gg: AeBDiesjSxjmB8iGcbYkkpZwBibL0KegJBupZIGMf27pmUjsX1PlBvzNYr3MXx7VuuN
	VFiQubotI23K1Rvas5jA+ccTIgbxkwyU70fUsiHGaViTTVT0lO5+7BAWtOmp+Hb4gYoWCj8W+qp
	aVeIF5huH5MyFB/GAdghLTUGhleK++GdxYK1ZBvS2zD9QSaOwaOIS4UnuMkJnddygnaP0ybAtLS
	ufphfg/hRKd/raIGW8kfotfm+b/8ruENotwvmHri4KHtLV0XjrkLuLwfKtOcjugh75haalngwxz
	R6aCAwiPQoCFwe1UWoMX7H4oXE68Ej1HwfcXOQqMaJ64FkKVg2YKEk06HCiLWJE/+S1U39V02jY
	EOk3NVmA+2RF8d9foiO0M2+8/ZcU2zbpTHaYV0twdFkAxPCPFYyLQiy/lSmLh5TgshxzYESUr2s
	I4YMYOs7zaxDv6TEhy2XzwHk12VV81g6VWXtBrKGm+0fnba7xiQX/6HsAoL38hf4I7uBnyBYpa5
	5QueSsw9LTGXf0BfampyKHDg8vGTv0sV70A+E1C25Hl7qmX0Atmdvkb4DGKqCLlj/woyN6fGPwa
	GijtFxkWsELszdrSiH3Nnym3NIklOBx9MhZBItK1TCxN219lhHvrFM+8PxtB8BYI/34dQiDaV8A
	3JRzNIMaMcfh1qhWO6gY2tBP2YT4Xhg==
X-Received: by 2002:a05:6402:2486:b0:66f:9480:c1e6 with SMTP id 4fb4d7f45d1cf-6707b1066d4mr1095629a12.26.1775815721312;
        Fri, 10 Apr 2026 03:08:41 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (216.153.158.34.bc.googleusercontent.com. [34.158.153.216])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-670703f1340sm433488a12.10.2026.04.10.03.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 03:08:41 -0700 (PDT)
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
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 2/2] iio: frequency: ad9832: simplify bitwise math
Date: Fri, 10 Apr 2026 10:08:32 +0000
Message-ID: <20260410100832.1388-3-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260410100832.1388-1-joshua.crofts1@gmail.com>
References: <20260410100832.1388-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
macro instead of manual bit shifting for better
readability.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 1f6ece79b8..260c2e3a9b 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -113,8 +113,7 @@ struct ad9832_state {
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+	unsigned long long freqreg = (u64)fout * BIT_ULL(AD9832_FREQ_BITS);
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.47.3

