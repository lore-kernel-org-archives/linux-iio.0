Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBF8493625
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 02:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787365185; cv=none; b=KAIhYU70Sz+iGTjEw9kdDI2RBZRl3GIGgYl5o/ccxJxZgUGbvo3DcQFEyFcIOYzsCz5X0YR5pKlolghG7vfWBoDDaL2lN5h7NIqwIdad0CDyP+fXN0LitHD0rC7FCszpBrGUvwbvhxPiqVnIjlm9lbUDYQj6Crsqfe/E629LDVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787365185; c=relaxed/simple;
	bh=+3IrxbU2OFpkP2P2cp+e8PVSNHataW9AC9TlUBMVCOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qv7gDdh3bG2G/IpdvHh0jD6VADF/ILJElz6xvohwdJ1lCQ6bFCM8VyPvmrzuJyZNKGXJVexdu2Nv2hRUyoAsW+57P136mB3JDDKN3oTCTOVmp+H3SmRRcTtPKmNNZ2dLqnU2/bFrtR1QcpDVv/eqVn6lh/slhUc00ZmTmL9/6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hbvd0d5P; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hbvd0d5P"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a41191c9a9so3386652a12.3
        for <linux-iio@vger.kernel.org>; Fri, 21 Aug 2026 19:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787365182; x=1787969982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mwRH3/vEudD1r7EhMg9G6KfbEKZWIU1Zh3PgLptr0xc=;
        b=Hbvd0d5PuZljp+gDemjgBEf/0RZi8Y2p2thKXDfIlcvIDOOff+lVId+Z0t+vQAaMo7
         XzPsenFqtCXd8BkspzVgg1b4PskbRuNLeqtmnnBUydtbyeqtWf0bM2omIiGFWvGeVHKU
         JfT6IrrpZODsMYXlENqpYQ8rhPsmQonccYoNa4+lAY2xPgiWwEdSRd1dyD6/Z2k/k345
         Y9iFjOxa7ImzodlYAF+8XKrQtRex8gyjY4Hq1SgRSZIwjRakvCdtxRQPFWSR9vgkDCqg
         wo4/mtKLxYth+ZZc+V10bWXMmkqebFKFL9WRB/HU07MBpUa4fWcD3tdhT/JGaa0yLV7m
         JwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787365182; x=1787969982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mwRH3/vEudD1r7EhMg9G6KfbEKZWIU1Zh3PgLptr0xc=;
        b=j3NhemUN5ARM9zhS/HooxFON2p9+nPKsLIZmptzTUwS6cgjCDkHwRc0PM48bsEiRV3
         tUOxLyomxSRcaeevV5892OL0UtWK3gtqA+R/2LFMsS6tXOQJ8bMT+xQQWascH1CqYOHG
         wQ8EvYL6nhgMeujywiGxzbLptQB0rptUiHYPQTqc3wclyrOEnVspzzeeN78PQ+9By+B6
         xZ+gpZ8YwGoMLavoI3xgnccRvOBsDUuMa6rrkkuTUZ/gXOuAXyJMVnviFscFhAQOJ28t
         JA2Xb2PY1brxxMSIm7wDqxQEUmxvuEIy6LRsOSqIOWd8isKEHi3iK4d5D7uSk1nYgudx
         ZW3A==
X-Forwarded-Encrypted: i=1; AHgh+RqJMkvbjQ36si1gHi9A17Y2bGiVEj7XyrsJrall5CSVww0Puhh94TC5NLdZybzVnVSKM3teSv8fZPc=@vger.kernel.org
X-Gm-Message-State: AFuF++nNHj2YO6DwtiDIP2bMYJqGW20yiusPW13zzWYiDQ5+y+ZlNW8E
	1R0snWCuWenDEnuR13ZctJVoFgN6OrGSqDmh0WbalN7OmlpPJIvizeD1
X-Gm-Gg: AR+sD13t5oYXqonF2c6k8CFkCgThmv85h9vVMLn4hFykpccOvHe8Xjh5Jyt1DFKK9sK
	JDnlIDkltg009F6mJdE49aZ979AMKU7tB6zl2jdafFEzyko5BhMFOGgsGFyM51Jezb0W0vwk5Vz
	BKsHUZzPYfF4Iaga9ogH03osblqZWW1FVtKYZ19uIDBLRXPEVgPUQ8x+cdLNvAS5qFyUoRv+56/
	T3FRnDo51Eoln2O6Yn7ebzenkhYzg3/4DH6Xwgw0u59o+A08nILYrVpsKKPPe8nTr8FhDGZnipv
	mxyYP3FSk4eRh3B1zl1OnNvXwrWlHndatW0y3erOlZs+oNHl8oSDZpRKauPILwb/y4NCbXL0S53
	3mXyJemzQ+VXFvDg+1+tIQQaTZ8XIV6ZQ8Sn8KwWLlJVXvfizq5rrKMgAFnyojv1RijQeo0yf/N
	88pSE60vaDgTUtbU3Nj9vnxDW3pVqmqLmhm8cB+VKyIvevZusR1BgUhAFGpADCKsRmZV2HP1vNV
	zrLdCPl4h5u
X-Received: by 2002:a05:6402:428e:b0:6a1:fd14:8835 with SMTP id 4fb4d7f45d1cf-6a42eea5ed7mr6025591a12.0.1787365181645;
        Fri, 21 Aug 2026 19:19:41 -0700 (PDT)
Received: from localhost.localdomain ([196.235.229.7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm9845924a12.6.2026.08.21.19.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 19:19:41 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: adc: ad4030: fix invalid oversampling_ratio validation
Date: Sat, 22 Aug 2026 03:19:35 +0100
Message-ID: <20260822021935.17058-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
validating avg_val, and the subsequent range check only rejects
negative values or values above the maximum supported OSR. It does
not reject avg_val == 0, nor values that are not exact powers of 2.

- avg_val == 0 passes the check (0 is not < 0 and not > max), so
  ilog2(0) is called with an undefined/garbage result.

- Non-power-of-2 values (e.g. avg_val == 3) also pass the check and
  silently get rounded down by ilog2() to the nearest lower power of
  2, so userspace can write a value to the oversampling_ratio sysfs
  attribute that does not match what actually gets programmed into
  hardware, without any error being reported.

Only powers of 2 in [1, 65536] are valid OSR values, as listed in
ad4030_average_modes[]. Validate avg_val fully before computing its
log2, using is_power_of_2() and requiring avg_val > 0.

Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/adc/ad4030.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 9c5f19321e3b..93d9f143cc91 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -751,9 +751,11 @@ static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 	int freq_hz;
 	int ret;
 
-	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx] || !is_power_of_2(avg_val))
 		return -EINVAL;
 
+	avg_log2 = ilog2(avg_val);
+
 	if (st->offload_trigger) {
 		/*
 		 * The sample averaging and sampling frequency configurations
-- 
2.43.0

