Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD73E9F95
	for <linux-iio@vger.kernel.org>; Fri, 27 Feb 2026 06:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172890; cv=none; b=C/yDtauqOwBTVWWf0V32EZ/9vY1p4wbnHoyyjYGSMiV7IxQZ/WX4jYEK43hglFvsBBlIqwbJ1hALV2cYKKIujRsu3ls/uSzkHOGg1nkmtUMAqB1Bn0w59Vv355zHcXAX7LWCOW+FTEpriKn/sNAQsBe+c9+JztOlzZrPjLK5rHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172890; c=relaxed/simple;
	bh=m0A1LYSAug8YgjqXyIGlPGL4DtTehQPQM7D2gvX5ko8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W3fQrzXRlhuiw6vMhUW/iUQtvw2Ckr13YkBfokSXJpLw6VN11xXf6r90hvOmGY7PBJleofzn7UK8zNd69FD8iUKiEC0oKaUPZTLyJGhNOUMiQAgP9PKrdlleK7+kx3Cai2IU1LtYEnL+uSRsSeOotz8VbcJhcp6mdjBQXsOk9dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEQwXNF9; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEQwXNF9"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-798527f822cso18311957b3.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 22:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772172888; x=1772777688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J0eQA0+mqLsPCYgC0M5tS08RbplxdERLESEbNrqUaNE=;
        b=AEQwXNF9ng2hAb7tbX9QmheTgnmsv/8b82SVouL3icSHLayPa4fq5dkJ6ta3p3JbPx
         Kh2HHY2iAjJclF5VKyh8yBoBZesUehOKeYut1iMG++tl8HI0ybzpe8VeJSYhkVyoXGIk
         ton4AkUfwzaW3w+M6ihYWj2cG7NJdBPS/OAQrnHoLdQ9NAw/tuEdbtyBO/FWeZimOPXc
         Aln8Fie1VFz20/zfX2IvCXJPvsce11AknHx38soTnzJiuaqKzwwKuD71djiNaCMx6Ori
         JcJJ57rLs6RBDlWWWw7LJTqhxNEEraIxcNTz5nph9J24IBdtEXPULGXOU09ltVnI0ofR
         WHFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772172888; x=1772777688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J0eQA0+mqLsPCYgC0M5tS08RbplxdERLESEbNrqUaNE=;
        b=FZrHitrrtZgdQiOZX6FGJpoZfcggJ3ndpL4BiaS8wb1BmBZtRvLQlUiBpkiohaXuk0
         mLEkd6rcm6xvnG66gD2/Y2+0GuQlSXcaNj3EtRaN6qrByjNVsc40MijIDbPxqAWbV4Pz
         fPJ9crn46vfwMM4KZxbrNPiP039bWzrlfgp7Q736tfXWG4WYlugiukmrEa22xTudwudx
         xFdg1hAdlhTLAdvz+0wy80QIHJ16q+mM4AByG1++tMD7BXEhnQA4B5VrFMkMG5dSdmWd
         rQxoptbJZCyjWEmq3aHvpQfxZz7BOz3qObnarClkafl9p15Y0N5GYdYzzmvJcd983npR
         1xIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZNU8WSnjiMsr9XINAT2dH+u9K+fkt5lCO2+P8cbz75al/KIdyzZpbZc5OEQF4S2Q79YSA62tbPEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0eJLTvAjUFOg7PUYgKfZb+vW5DjEFfc7Lv+p8R5G7SHz1lydc
	HWBcu/VR2fGvHiALswv5wwXoWvpURP4hCiXAZSiQ5WQfpTIKNRglcOVE6KHqN0Eumfo=
X-Gm-Gg: ATEYQzwCelWRcOv+RT8bXvXnL9for2KXGpEBNK+9t8WI1XlCDu1Qwmkql+p/Y2OTZyV
	wMugY9nYlUYJ8uDEU1ria5BlmuTxPe6ZEdjNDte33nCMXZcP/Gvq9pE2cNdluiKJrDD+F4nke0A
	ls99ekmg+gM8nwvb0ALYvpv7n4r3qnJSW9hifDUyMQgboF8F9ld85xWh0G2R1oCZmDaO4scEA8o
	1dbWYdt8ld2KYvazhB0P8fP3Fi881jdiyMvSB6d3py6+6Fce0uFng+jCvsLVIajsdkccGN4G1m3
	4P+LYcEIhZRYO2S7c6/oyNVg6AaU7vMw5CnIR4ryE+Y9Mzo5RN9zJL9/BXiahJgUeHgWOuacjws
	OsBfOph1DIKCnyil4dQH6owdU0BBxgpqwNdc0VCva+2wb8GlAyBaQ4n0ZhqdIYOeXRxbvE0op2F
	d7v41mPjzU0Z6Q4JH9vvZelBECamGF6kr4/Hex8fHgmYYl/1kYSFWmA0/XJbVboojHISRozNpXa
	+kj7/b/CjXsbSQSsNtsMKFM
X-Received: by 2002:a05:690c:c24c:b0:798:509c:f79a with SMTP id 00721157ae682-7988559abd7mr16851457b3.36.1772172887631;
        Thu, 26 Feb 2026 22:14:47 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876ad0de6sm18149527b3.15.2026.02.26.22.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 22:14:47 -0800 (PST)
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
Subject: [PATCH 3/3] iio: filter: admv8818: Minor cleanups
Date: Fri, 27 Feb 2026 00:14:24 -0600
Message-ID: <20260227061424.1135505-4-ethantidmore06@gmail.com>
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

Resolve every checkpatch error in the driver.

Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/filter/admv8818.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/filter/admv8818.c b/drivers/iio/filter/admv8818.c
index 2d12700d717f..1af263007322 100644
--- a/drivers/iio/filter/admv8818.c
+++ b/drivers/iio/filter/admv8818.c
@@ -240,7 +240,6 @@ static int __admv8818_lpf_select(struct admv8818_state *st, u64 freq)
 		freq_step = div_u64(freq_step, ADMV8818_NUM_STATES - 1);
 
 		for (state = ADMV8818_STATE_MAX; state >= ADMV8818_STATE_MIN; --state) {
-
 			freq_corner = freq_range_lpf[band][ADMV8818_BAND_CORNER_LOW] +
 				      state * freq_step;
 
@@ -385,8 +384,8 @@ static int admv8818_read_lpf_freq(struct admv8818_state *st, u64 *lpf_freq)
 }
 
 static int admv8818_write_raw_get_fmt(struct iio_dev *indio_dev,
-								struct iio_chan_spec const *chan,
-								long mask)
+				      struct iio_chan_spec const *chan,
+				      long mask)
 {
 	switch (mask) {
 	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
@@ -722,7 +721,6 @@ static int admv8818_read_properties(struct admv8818_state *st)
 	else
 		return ret;
 
-
 	ret = device_property_read_u32(&spi->dev, "adi,hpf-margin-mhz", &mhz);
 	if (ret == 0)
 		st->hpf_margin_hz = (u64)mhz * HZ_PER_MHZ;
-- 
2.53.0

