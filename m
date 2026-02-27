Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9C53E9F80
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172889; cv=none; b=DxDHVOFD7Yjlqn03GWpylEvjuU2IFVQqU74lgEYqVyQkEUm+/jRScxbSQfVLr0z+NGQ1P3t78phIKWoHqk/6KzO4dSV9Qz2KZHXZOlg3ncNwjlkSP1uWSQljcxx8xAeW92EuTQN4HWCAqDhrJRc07VnLlVRCBjRYct9VQyxhRug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172889; c=relaxed/simple;
	bh=E/ZD1dgTfN9GELfDVgcd77soj3hxro0RxUDwR0iNADI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPpsKtVXtiO6pNU1VLm4tRx8fkodcCySkMhvcCRp24vkhuwv+E+MKtJYcykaNwriSALbhuEc3wMrMO6R5Q31KZuk6KwUqLmLelgQZfCy8nw9KCbNu+dDOOUE4H1pM0jEpGqVmwsvnAaCAZ1F3GRgWmI8ZB1J5gbXSF0xr3s2zVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aTFP8Hd2; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aTFP8Hd2"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7986a347d4bso17333017b3.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 22:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772172887; x=1772777687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zzfxima+2vAKmrCI20smUZW6Vmlg524ON+pU5T6MXTM=;
        b=aTFP8Hd2wOlTad6IG4+Fd/OTcANokpq4F62gMlF2UHef6qa80hQTpZkHTGjEHQkxEb
         io1PgrtKbF2M6sbVcOL83IyGFQJ3g9kSiJ0mo5d3q5MutaXXDcTSE6qlFw6bQVVcv4Dj
         tgMzvrrOY7LyUyTBjKF2PAx6pjyftFVBtK3mPW1ahLNz2zrK9JbvE5YzvnjFvE2FM6M0
         Wx5NLWBto2H97/2oO/uOV3BeuKDEl/s666+zoitEDWExXF4xjqTZaOezgUm9rrpi4WKi
         xacOUgchzoy0qya/BiCfjiiWd+YiSW9+EGh+g09AZm5yXTJHsQgAxzteUDjXTGprvyQG
         uptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172887; x=1772777687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zzfxima+2vAKmrCI20smUZW6Vmlg524ON+pU5T6MXTM=;
        b=a3YJMo4qGdtK3XkN4vkp1g7eTI90hvfWxz3Fko6Lt4fRB7xpBuVxJoOcZcoRJxWvBE
         s26wmBaYWQGd5gm7kCs1OHkBE5QyiNUbHVDiRyzt2gO8vTC7+hqoNt/koIKJO0BNQkAe
         vs9jZmTAUcgvAfuIHAkqOH5wl3IHW1TZDI0L43PHqi9h+tCOJrMKlvXg2YEHC4lmSLoE
         Kgxa+nJJkbD9TeYQn3ulnF2Ih17l8PRoz12snmT8o7N3Bf5rAgQJwatclUi7HKKmfiI5
         gwEWd/njv7dqCmwtW698FjWC5JT2fp82KoUBfSOXfUwzKHn6EpyzPTKpOv45065Tlif6
         FFog==
X-Forwarded-Encrypted: i=1; AJvYcCVfuWuCGfmMxDuWnXC+NcExLlMcVKlNIR49zsyMA0GSaK33dzoa6H/jCWYnlxZarO9o2Vo1lB2n2E0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVjBHK93N3GP13QJCbvjDe1UG64oZhEjF9p9skYEeXWKFoAXv
	N851P6p65iLIoPLw6N+3ORdYeIeh/nIxoTReaEFqwBZjMm5f7hxvEOgg
X-Gm-Gg: ATEYQzzhnpAnnuP6yNNp682/0WyVU5dKMHfbCCMJe0MhfXd/RG3obW88Eoiizie8PEb
	jZN5d9iSXu9waUeFNHSBpMkqn6pfPSEQ16H4M1mOnmFFJ3DncPglWeMinbH0rLFlLZZJg6EXkSw
	snjsiQ6i56Of+vNZiHebBAB8KTi/cL+GtLKv/DeI/7ayOpbTVHRfFsmmPJcfaEs3oEaJIPm1cA8
	sGFG5KaLpC1Yxeu2t/5klgxorTD/KbNoDcMeJN1Hk0wsRgPEG8QW1ujgrXagUCVJFJ3gBCddk13
	4RY91BAPS2AGY6CAcB7GRC4Nlbns7OyK0XBURZCuh3/BAKUzAkQqul6S6oe8mKsByh7lCfgG7Fd
	OhrHEOloL2YjZzMfj2IJ5m79XhIO7Le7t2CHbSbhVRI3DYlkpbk5BKeSHlKGHT+a7Mj+qNgMyEV
	AxZFhHXrVKbdJ6nyqdgcFlXKc3hn6vLrZjDoeWUKT/I2UI8nX6agnlkWlZxWtnjN1fKFMtNKhCw
	CLw7dtX8QERKwuNoJLW00yG
X-Received: by 2002:a05:690c:c4e8:b0:798:244:1b07 with SMTP id 00721157ae682-7988549ee94mr17049017b3.11.1772172886888;
        Thu, 26 Feb 2026 22:14:46 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ad0de6sm18149527b3.15.2026.02.26.22.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:14:46 -0800 (PST)
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
Subject: [PATCH 2/3] iio: filter: admv8818: Simplify locking with guard()
Date: Fri, 27 Feb 2026 00:14:23 -0600
Message-ID: <20260227061424.1135505-3-ethantidmore06@gmail.com>
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

Use guard() instead of manual locking to simplify code.

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/filter/admv8818.c | 59 ++++++++++++-----------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 4d5e7a9d806a..2d12700d717f 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -7,6 +7,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/iio/iio.h>
@@ -205,13 +206,8 @@ static int __admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 
 static int admv8818_hpf_select(struct admv8818_state *st, u64 freq)
 {
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = __admv8818_hpf_select(st, freq);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return __admv8818_hpf_select(st, freq);
 }
 
 static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
@@ -281,13 +277,8 @@ static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 
 static int admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 {
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = __admv8818_lpf_select(st, freq);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return __admv8818_lpf_select(st, freq);
 }
 
 static int admv8818_rfin_band_select(struct admv8818_state *st)
@@ -308,16 +299,17 @@ static int admv8818_rfin_band_select(struct admv8818_state *st)
 	if (lpf_corner_target < st->cf_hz)
 		lpf_corner_target = U64_MAX;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = __admv8818_hpf_select(st, hpf_corner_target);
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = __admv8818_lpf_select(st, lpf_corner_target);
-exit:
-	mutex_unlock(&st->lock);
-	return ret;
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
@@ -352,13 +344,8 @@ static int __admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
 
 static int admv8818_read_hpf_freq(struct admv8818_state *st, u64 *hpf_freq)
 {
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = __admv8818_read_hpf_freq(st, hpf_freq);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return __admv8818_read_hpf_freq(st, hpf_freq);
 }
 
 static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
@@ -393,13 +380,8 @@ static int __admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 
 static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 {
-	int ret;
-
-	mutex_lock(&st->lock);
-	ret = __admv8818_read_lpf_freq(st, lpf_freq);
-	mutex_unlock(&st->lock);
-
-	return ret;
+	guard(mutex)(&st->lock);
+	return __admv8818_read_lpf_freq(st, lpf_freq);
 }
 
 static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
@@ -485,7 +467,7 @@ static int admv8818_filter_bypass(struct admv8818_state *st)
 {
 	int ret;
 
-	mutex_lock(&st->lock);
+	guard(mutex)(&st->lock);
 
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_SW,
 				 ADMV8818_SW_IN_SET_WR0_MSK |
@@ -497,18 +479,17 @@ static int admv8818_filter_bypass(struct admv8818_state *st)
 				 FIELD_PREP(ADMV8818_SW_OUT_SET_WR0_MSK, 1) |
 				 FIELD_PREP(ADMV8818_SW_OUT_WR0_MSK, 0));
 	if (ret)
-		goto exit;
+		return ret;
 
 	ret = regmap_update_bits(st->regmap, ADMV8818_REG_WR0_FILTER,
 				 ADMV8818_HPF_WR0_MSK |
 				 ADMV8818_LPF_WR0_MSK,
 				 FIELD_PREP(ADMV8818_HPF_WR0_MSK, 0) |
 				 FIELD_PREP(ADMV8818_LPF_WR0_MSK, 0));
+	if (ret)
+		return ret;
 
-exit:
-	mutex_unlock(&st->lock);
-
-	return ret;
+	return 0;
 }
 
 static int admv8818_get_mode(struct iio_dev *indio_dev,
-- 
2.53.0

