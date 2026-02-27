Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8183E95A8
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 06:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172889; cv=none; b=j0ZvUaEw0/wWFsxGiqxHRl3r04Hj/bsGwOPj0xFyleKsLXEIJBT8rD0y1JE2a+ywpL7k/ICwBA9xjiJKY565tve6UGER4Af1BgXrSrSjY7auWg9mNiF/mgPHKlQXWM7J0rn08fr0A/wlY8apzUzZEF9+43/Q7n5D1YikXzzMM3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172889; c=relaxed/simple;
	bh=L4Ide4otMmuh82D/YTpixyERsDg5wcHyrdGjG5XeZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AssL8HmKrxBM9ieXMFCt/WJHfCshkA0010b89w8NGANYW6AJuUMNxu0xYCEtPN4k4rRle29YNCJg9LE1ECylv6vdDgW41QJfugS58STv4w3xpvaHHz1q4PPZX7FIFCH3R0Kw8BLMcUW9IEaT9MNuLigBRjgT9SBQxQrkRMQgC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VewKcL7Z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VewKcL7Z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7982c3b7da9so19568007b3.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 22:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772172886; x=1772777686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12VAYoqja87LYfXA9N2irRdh/f4qGYYdkwkwGsNdZYg=;
        b=VewKcL7ZSWDAeeIturpEvu7AlHhsx94s2VvIim3L+W7GLIzTjtYBJjqRRXRVm92rwC
         62ri20EbbTIj92KJa9eNyGbGb01bFlQPnrBtdy5493TBvI0U/wrau2pDsxwF66rLYRHi
         znhDrPr7juWz7rAR1cW//j7IOOsWNEMQ951SA+/x2K2SDADuiQ4tmHDUF7dhJ0EVqVI/
         ZQUbwGIS062/txXs4jMZYm89rrN7vU1NymFbB+yL76o3VzqxCmjyFiRgh/WlnwZrqvEB
         TIpLU+5PrnLj3WNP7I9HoJoGiF9IJ2EffS3OIyUovifh9Yz1HMwPM5TEjgfAyZirqw2y
         vrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172886; x=1772777686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=12VAYoqja87LYfXA9N2irRdh/f4qGYYdkwkwGsNdZYg=;
        b=rcxWxDLvCNM8krv+7LynJz8Uu4tbWFdVtQlqBxboZ+yrjRhVIzcEiSp2OPLh9HuYej
         6ttgiAyuTfGLBIDlNekTmqLyGRRFIEP4vtGQ7iMsnO2nP58KvgEvASWeXW5gYBjAND/o
         iP7OWtpzcSU47rL7C6cZ4C3uLZoG9jgJMuhjhEyONA8Nf3dcbPji/RD/+6EZCjnpgv20
         cBmGogK3jn3Uo0esyMMrzDN0HnV/MCjOaE7uK7ibj98PmqtHIqpJWI1la5BHGyuPEInC
         /3V44nUhLs0PdUeYdnhRBovudqND5TkXTvYzus9R58OxpvI9a8a2IIivfy4zNeS+y6Bt
         cjgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHWRHl1dui0dmTk+ONAWANmEuylQtosdt9u8VYqnUre+JiI8Swg7zBfnkegBNqFTrBG4gGcffWOWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuahdg5RaAUvz/NImkHWoqakHZC7Ik1atuPRKvEIOmQm5j2ymC
	tYohLAmwqo3q5LgpExyVYJm66KwuXkCHm5Pr2RB/Fk9ceGiu7oG6cBlT
X-Gm-Gg: ATEYQzyyWJMpof2H4A1vcSeOAz+Hsp/H8OJ1A/XPVm1ftf1FbwSnjcVV40lE6XZZVro
	UcLBWUw3b2tL1f3a5u8FKVK9+NGwOVCVOgtSIGEzNlCZ0SZ4n5tnNBqbUUq4hHLSmPecy0TrL6/
	Np/Cf+o9t4LJytIWn1b9T7wyN/82E5JwduLfVLFwytNG/eV7my1YJW0U3vvyIyLSbNN4EHU+HDU
	mWhnM29MBkS3EjFh7Q6F5e/RYo2OI0joDNP+pGCUVODlct2/sQ+sVl/epUyIl0OxrZeH/fgImBU
	+l8bkJdAFIQ9LAAMiv3m1gmHFzRdA7T1sDzh//IiADmfp2SQNR97hBXsva1MzVeHIvwRGkvTgEO
	bDsVgr1OHFElioYn5Jl71i34I6BZl2mb6a8URoUArLQInd2coJDqPL+49pHjfiXg0P/hOoyp9Wf
	c4RzLFWLePp6THTP9AnrQM2mmHFclZrE29Xy1DFCavXsKH8KKNEPyXpB8mMZalSqFCC37yBkzIG
	kuTwNDxsz2xLhCCCERaK6ih
X-Received: by 2002:a05:690c:2605:b0:798:7309:a427 with SMTP id 00721157ae682-798855c617fmr16288607b3.36.1772172885860;
        Thu, 26 Feb 2026 22:14:45 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ad0de6sm18149527b3.15.2026.02.26.22.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:14:45 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH 1/3] iio: filter: admv8818: Add missing error code
Date: Fri, 27 Feb 2026 00:14:22 -0600
Message-ID: <20260227061424.1135505-2-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227061424.1135505-1-ethantidmore06@gmail.com>
References: <20260227061424.1135505-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the macro FIELD_GET() returns an error code the function returns
with 0 because ret was just confirmed to be 0 a few lines above.

Add error code.

Detected by Smatch:
drivers/iio/filter/admv8818.c:335 __admv8818_read_hpf_freq() warn:
missing error code? 'ret'

drivers/iio/filter/admv8818.c:376 __admv8818_read_lpf_freq()
warn: missing error code? 'ret'

Fixes: f34fe888ad054 ("iio:filter:admv8818: add support for ADMV8818")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/filter/admv8818.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index e494fd33911b..4d5e7a9d806a 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -332,7 +332,7 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
 	hpf_band = FIELD_GET(ADMV8818_SW_IN_WR0_MSK, data);
 	if (!hpf_band || hpf_band > 4) {
 		*hpf_freq = 0;
-		return ret;
+		return -EINVAL;
 	}
 
 	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_FILTER, &data);
@@ -373,7 +373,7 @@ static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 	lpf_band = FIELD_GET(ADMV8818_SW_OUT_WR0_MSK, data);
 	if (!lpf_band || lpf_band > 4) {
 		*lpf_freq = 0;
-		return ret;
+		return -EINVAL;
 	}
 
 	ret = regmap_read(st->regmap, ADMV8818_REG_WR0_FILTER, &data);
-- 
2.53.0

