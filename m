Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFFD37D100
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787089891; cv=none; b=XKN9I0sSCuqRdFfoc0fO+2c9mGXDs2q26+cqldBSfSXi18/GPoqyBfpDboJTp646DIBktV9svuCBMfmEUIlu/XotHyr1KQvKgkqufKQsECC0e9CiXfaqmu+6syDchAt1Mr0QADfneSVSNJj2w0/mBkE1aAQV5J6T1phdEPhUp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787089891; c=relaxed/simple;
	bh=OPrsjHCWeSiRHmnTVpu102yjiNFNGUCRUumgVkCu/Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMkGsEhtktS2C+PCC6pehkVZXWcebu7FQYF32HxHCLj3Szd5GVdTfv4V27SqxMXQuRN6qZD8dIGb/RNqELIc6VidsjlBnYtUGsmNlLs8NNUItpACkbfswgq8S/DGjWW2p0FMFATPAdDewoN+wkCrL6/MZNx7/MaOXujRWYdBOP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfGaUL0+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfGaUL0+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49800c6a846so3115275e9.3
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787089888; x=1787694688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HKg2edKlUweVvlHiOv4KUUr+ZHMtT14RNTgoZvceYp4=;
        b=mfGaUL0+ffUVeHj3jKYWjTl5Ti1JoPSYKprup93XL+B09i0NnVG3tFv7SG+qkK/Job
         l//0dLP5tbD6Qj3rRYEeHyjuBxZu5VzFJ1WVVIqy+BIPl6gLn+5om1ZL3xExBjJdQngG
         Yp41b6Iliu3BwxvB6iNLIP74jgR32icuv6daML+Dtgf4v3ZK2LLK+MtXK66w0sm5/nPu
         T2m1IWq7LLwUYdG4W83dlGN3svg3RKn+T7YrQYGJjfXZv9sKNerisIEo8IW9RtmTTVuw
         XxOxKr0m8cljijMx27lh9lAXvplHnxflmBCL1W9gPSfzmpJj2GPybEtEl/qCBE+1sCxX
         lmWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787089888; x=1787694688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HKg2edKlUweVvlHiOv4KUUr+ZHMtT14RNTgoZvceYp4=;
        b=qZPPaolG5eE6RVQ5T6fBjrER93B1dmBUgqMvUXjbXSoM3o3/5NA6tL44OjwFosmlDc
         ebcGw1fZTLmhZMLyty2JcJLJbySlEFlz7ydn+4qOD2tDUDifSUKKwuHV/mJ1BgCcJ1nH
         mvbkjCkC28D56tZXtmnZCzuzeuMYYv8DNdv+udsIk3MMhBJIBW6PxVXRUqkubvo4r6eM
         izQ3th6LKfGJ6CPqnvkrApbr//DzkG01Y1yUcMKB/sPadZgoSzDFDRhMklecewt0+ILZ
         IJNrOShSF00Wt52hzckcx4ZP2pnJx4h4W3FVSC0eWDlQwCJ/0I/2p7q56SO6WyELtWi+
         Pwcg==
X-Forwarded-Encrypted: i=1; AHgh+RrWlwQEuSV5MkX6pZlCfkMyF5sXXbi+Wo8qJqZR6zBh0YKgNFoXwA2JBypN0lwLSSmZS20hLeN3SrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAe2Xfrhg2fpYsKAgqSVE/ka7IzSKiWIjBBLu8oYC3tb8lWzSS
	1MbeNtoKoIGoagLdNtAmfEJckdBH75lPexwUApBhvLFom3Z+mcRnUs2x
X-Gm-Gg: AR+sD13P1L7Bu1fmk83qqtWrMvfmZVT2+gJPmZVdeBhZ1gaKfwXa/HXLRmBEa99qb4y
	CKe3OLyXeebSLBTIteavtbOpP7q0EXwOnAiO9SsbOpyAF+L3Bz8Y0Da14Ne+kNHe9JXIKU7KD/y
	ie8u6eTBV97UkEIxQ8p6lzrlAx4uQdpEh/m3YiMCOWZL0a+3jFulR8kUEGBFQX2AYu+so7JhYQc
	FzNlhqZYw//weITc0gPB5Xf/MeRTLtbGerlLhsiioRmEg2I/lSvg2EWyZLNVTMC10BYinh6ko88
	ow9rjiortlUZ4b3yukVsx8Lfv0etwzfyOa2RcNyfvCcitYbIfURW9HiQkIMCCquJL/pA7a+BPvw
	bA1fa+dYduKJS1Eg48ZMj5mN9Ya90umgCtL9Xl849MWr2Vs3NmXg8PFEQ74PbJbxTId/uRQqkxC
	NdsOdLrRuDxp4n16J56FTE4cYm9XzxGbIQmZ4RJ6IOIedL+7miQ/7W296MEWcDnwu5aYur5xWWo
	WTvhpLNt8Z+YGIeif3ULH9gWOBlcT+ASA==
X-Received: by 2002:a05:600c:1d28:b0:499:726b:7375 with SMTP id 5b1f17b1804b1-499aa1dc5abmr1847115e9.14.1787089888158;
        Tue, 18 Aug 2026 14:51:28 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14c33b3sm187546f8f.27.2026.08.18.14.51.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Aug 2026 14:51:27 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()
Date: Tue, 18 Aug 2026 22:51:22 +0100
Message-ID: <20260818215122.52715-3-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260818215122.52715-1-grondon@gmail.com>
References: <20260818215122.52715-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(), which takes the destination buffer size
and checks it against scan_bytes at runtime.

Both push sites now use data->scan ({ __le16 channels[3]; aligned_s64
ts; }, IIO_DMA_MINALIGN aligned), which is 16 bytes and matches
scan_bytes for the 3-axis plus s64 timestamp layout used by all
supported variants, so pass sizeof(data->scan).

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/kionix-kx022a.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index cf2cb751b4e8..86f17431aa23 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -863,7 +863,8 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 		for_each_set_bit(bit, idev->active_scan_mask, AXIS_MAX)
 			chs[bit] = sam[bit];
 
-		iio_push_to_buffers_with_timestamp(idev, &data->scan, tstamp);
+		iio_push_to_buffers_with_ts(idev, &data->scan,
+					    sizeof(data->scan), tstamp);
 
 		tstamp += sample_period;
 	}
@@ -1033,7 +1034,8 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	if (ret < 0)
 		goto err_read;
 
-	iio_push_to_buffers_with_timestamp(idev, &data->scan, data->timestamp);
+	iio_push_to_buffers_with_ts(idev, &data->scan, sizeof(data->scan),
+				    data->timestamp);
 err_read:
 	iio_trigger_notify_done(idev->trig);
 
-- 
2.50.1 (Apple Git-155)

