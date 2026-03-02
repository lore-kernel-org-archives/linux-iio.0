Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B1B1AC44D
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 07:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772436040; cv=none; b=qS7TCbOHgGll3yaHp5FI+LyjQXLVVS65c4S1p5iV4Azd1JsB68e/FvEyRCHmSxeyTYzWHFWwe0lkOR7ePOLl6cqyiVFKA6mpQFea7n7kUxUD/9sAiB18B9fz+pmT8aeDgIfKpwFO6KRyTLi60rRbMa3ltVddNoTMgVCwQhXG5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772436040; c=relaxed/simple;
	bh=+QhDDqM0TcwUBQilYe1cV1aEXboFbNwLvFmlojMCJQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PxVkfTWsd3QcYXq1IEswq3Xrzg3wwWAMBs9eEWU4vubZYVwRFqr80pht6CIdMHojGxEtIMoxSMbxbtFJMo+e/9zehievCZER9v6PezkdwFbix9rFVzRKACrkKQV4pLiafMYWhq4VI9dC+JwvGLaxosiwICWC5X7VzF/42u/tLL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bsRV3o31; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bsRV3o31"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483708b697cso5282465e9.3
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 23:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772436037; x=1773040837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A7xcorigsUYDUhG14kf8ZiANUM0B0Rpyk3O9rAq+jxQ=;
        b=bsRV3o31FB7m7xCLYWSfTstzU2WdvMp5FatKj81PAeJcp6XnJlzFhs36zQFVHH/oj/
         zJ9aS3pSm/7WFK8Bip3ZoFE6636FyJauUUCMUNbxeN/UM+7RS/clI2+7Bk3cLg80pTXn
         I352X4t68pwQKqJl5c9vRcxYT0s7WZG8GFN9HN9MBEvL3suqQX0eb+yXm9W1uNbkeg6A
         /bUTQKKqxahKcK/QuP2b+ceUWJhhbGzKriaCDmKeff0H1MLD0UHZkUdG64k+8FHlaPKF
         PDQNXEEP9jiGNMuUahRbdqUZuRss+xSEQZws+aSXCkw3P1+w986aED9lgznZ9k2JEp9U
         s0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772436037; x=1773040837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A7xcorigsUYDUhG14kf8ZiANUM0B0Rpyk3O9rAq+jxQ=;
        b=rhpq2MqTD4GlwkIOjAZE31ozD59ggWNEN/tvmSRxtrkYfPAjAcwSzE0juzLGZYEbnq
         CGO3EXMcX/IqWdWDBuREeKJAxcN9twOiLhS/DDzsNR3Fo/LI2SQ5UkzJS9PfA1PNRdax
         N6vMC8ymWu2+tp4Ix9MVSAlGx6gOKJq8PAQGwXxn4CJB/sF6RW+RvsFRawILTRywFjVg
         mwiGmpBMwpOzVKW3O8FkzQAJuXIulrk+ZD/I525gffRIgJAbs1EZhN2nuEegtTGBNnaz
         Yx48hFbDlXt2rFTsISIQlo38RHPqrMpjpTc54mk2UpNPY/ak+kIUTb+Imgc0DuLtSIXg
         vkmg==
X-Forwarded-Encrypted: i=1; AJvYcCX7FzUC+Nd7Ua07j1Noa/tXmgf2rlSIAq8u4TFRV5Cd+b2H07/pfnj8tEPwyyL/mRFIWxqZT9puZQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxIWLMPY4HEvK8j4ZCaDjaUE/9DFNyrYDn2WjBF8Y9LvYljdaL
	CN6T30s5sgSs/1lv26SR8hcQMKjoJHTDBszz0wJ4U68D2ojzKwEMskeS
X-Gm-Gg: ATEYQzyMb05k0DhfnjlPj6vHUQTk18NCFRWUzq7EgeCkXGyA9S4FDE6MFXoZo6Fi1Il
	qmUuBBsfmst02BEh2zZEyZ73EYAjwMcFS1LUv7sTBfULmZQXMhWK+c8s9AyDvfBp6ruPqqtZ/Mo
	x8aQ5RaHu2as5Kr5iT/lp+65IQCJb/ryk6L9exWG+S7Mgm8nShcBP1Pv0zkWFK4MnqqvvrP7JK/
	lOY4HnoIdlfePuj8ZloinemvGeJ4w0Vw7VhN+Kyi7L1MqXZdgt/FHN5l1CgusyefiTVhvZM1Lhu
	5o3UWN0cKrKBgQUHXcnLepANxkqcCOpbP8BbxHgr4J/GMv5XyKAZsYrIoTrxleXt6gUm0OOVj9E
	phCje9WIYcsnl1F3HDXufcBNRS0hJXu5nUz2kVXn9Snh4vKJKKXOfu87jWl3WBPmB46qEvxQhKG
	nCo0YzoSxgrWJ43cuGUv6K88HUQhMbSXYlNJS/aFmxJgCuZmiKaMdHzPiJmhz17nUi8pbSs34tm
	6ypjle6INMoVDYb2kzsTAf+HxfybsVsKN1kBpMzjeOs2JRzfm2a
X-Received: by 2002:a05:600c:6989:b0:477:7bd8:8f2d with SMTP id 5b1f17b1804b1-483c9c32a06mr113589255e9.8.1772436037375;
        Sun, 01 Mar 2026 23:20:37 -0800 (PST)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb29715sm286026135e9.0.2026.03.01.23.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 23:20:36 -0800 (PST)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: antoniu.miclaus@analog.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Subject: [RFC PATCH] iio: adc: ade9000: fix stale data in waveform buffer read
Date: Mon,  2 Mar 2026 11:20:02 +0400
Message-ID: <20260302072001.55737-2-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ade9000_configure_scan() always sets the SPI transfer length to half
the waveform buffer:

  st->xfer[1].len = (st->wfb_nr_samples / 2) * 4;

However, ade9000_iio_push_buffer() iterates over the full
wfb_nr_samples, pushing twice as many samples as were actually read
via SPI. The second half contains stale or uninitialized data from
the rx buffer.

Fix by setting the SPI transfer length to the full waveform buffer
size in ade9000_iio_push_buffer(), since the trigger mode fills the
entire buffer before firing the interrupt.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
---
 drivers/iio/adc/ade9000.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index db085dc5e526..c6eb06ef8d37 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -804,6 +804,8 @@ static int ade9000_iio_push_buffer(struct iio_dev *indio_dev)
 
 	guard(mutex)(&st->lock);
 
+	st->xfer[1].len = st->wfb_nr_samples * 4;
+
 	ret = spi_sync(st->spi, &st->spi_msg);
 	if (ret) {
 		dev_err_ratelimited(&st->spi->dev,
-- 
2.52.0

