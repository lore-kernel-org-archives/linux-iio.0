Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297493CEBAC
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773222020; cv=none; b=DsOxHs0Ay1ye6HKBF04l1jbuUV//7aZ9XbqTY5kwwFrTUCq03YedBDiWEq9oGyJR06JH3sN+3JYvHZ15mCinjqqx3otKyFMWiZBb1wCLnfpjC7rzxe8NBO/3/mQYcoTPhHZhJcXFyh5GzNkFgCVSluHWbq/BwXIV6UnNnSi+p8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773222020; c=relaxed/simple;
	bh=+rF906grBUMqXEtLjWJPbwrGuobRV0/ysTrlYgAiEEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5MSsY7zuCyV6iKd2o22miwGz1Z/tWRJnE2PwTd+FdZ869AhZuhIATczrjxOJib/WzAgtFLbFav1l5F6BvJfR1z/VO4Cs8Y5i5pP9kXiilWYsl0omFTJf66hgBlGcGSXlxVrRR+ESA1FC2qRaigp7P3N3zJuSDxwG8R8W02b8e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8/pyIyr; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8/pyIyr"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3598b2318c2so6249293a91.3
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773222018; x=1773826818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L67obzxqLQ8+SodZDt0lFd4mf8/HHc0V4ro3iP/r4RQ=;
        b=V8/pyIyrlZiinr0BA0Wht9GQSsGEydMC+ukD4VhqOX720KqSUoDnURHSRZTAIezTz7
         +E+rS5FAjoMQyozdGipN0opj6vw7Ccq4qcthsf3fYRjCtoS22jUeml6/hcWpFL/V/W9t
         xw+W4/s5fqItsj82GOh9LTqtfEiu7KKDZnQl/0103sQ9wc6cio15EBLPo4/36A4qFkpe
         dyIa8pEETYzFlkwBLIFB5Va+xURO1g1omjQ8I6d6xbcYC2nXSG0NeCiY3OWt4CWucR9m
         rY8txvRAoZEShPMvL8YMouAp/CHOwRRzw0VvHx9y0blphLidPlDR1rAo2WTOYE6rcbPC
         gDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773222018; x=1773826818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L67obzxqLQ8+SodZDt0lFd4mf8/HHc0V4ro3iP/r4RQ=;
        b=WlymYAQQi4IjUeo/ZTRMOsVFkhZCfpQayjR9FgBYNsW3MOzZXNHtaxdOX5Cc5aFsPS
         CCdnfy/AyE5Zsqs43rkSydj22kplbMQxovCBWN/GsXJyS94LtHHM+xtwOggB63d3HDpY
         mbJSEb86kKXMgwZDrR1hMCYhWYPLw8bjTJekkRb6q2l6kohoD1ENnDGc+jXE1+lS2rdi
         KCfQxkc4r8FX2BNO+vHBzBWNEjxVBnsdTfH4+/l5flotbZv0uklPpzVqYHlmOMQu20PE
         rl+++W0I5gu0PQYvEKY2NqcKp7LVFeojeIqVp0hQSECln7ZHnY+/HlqOCTAp1bjVjEAF
         WJ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBKRXVcGT4CBSDdye+SHUQ6QUZwxn0XYGbbg63IXGkxjEIa8f45+ZLMWagXyEzxRmkbv/N+tRFVdk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymnwf0KQwVPbuZeRtK0xk7Jjw1AcNw6FoYSUoxCm/F3dIlmZYj
	MkPaAnzuVVOiy1WJNpoiRFTw2h68uhIjFGeTfNu8RzsO/0vT4b+BGuCq
X-Gm-Gg: ATEYQzxrL4hw92zYN9OAJU4u7bMmCZfzNj6BsWLuAafJ8tioDDFdDMk6TrKMqXgV59Q
	x2orG4izi8o7IB8oqcOhs7Lj/6ezBg5KuB031l51IafKlfZB2/q4a0nSBFtFCA+yqNrPQmYAwJb
	w9w5D+qrrumfO7tkUDBBbD/7dyoq2lmlNFdjBCzgY8c/yLXbX27X+wjvNAhwiBLqYdZMBSan/jG
	ZzDXqnP7Vgp1J+WGvVhG0spfMyTfHdMFKnAgjH/Cr+BeP0zvkYw71PSaFEjMbp+B7MrOIHCfky9
	+/JSYdDzAcO2aB2CPk4eZ70SF/tPQndRzxbfNPnTJR4zRbMywKYNiM0Z96CLKmqt5Z0XLBEMsFG
	Cs9W6CVEeNDH7hyETUy09IvvqXzHFNiVnqZ4z0ex5Yilu3wJ+wVxidmpeuo8aENX3gKUvsgo6N0
	WqzunDupKJwAiFt348g10+L/Li
X-Received: by 2002:a17:90b:5745:b0:359:95c2:b3e with SMTP id 98e67ed59e1d1-35a0139b93fmr1902931a91.30.1773222018525;
        Wed, 11 Mar 2026 02:40:18 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:27e8:1c1d:af76:30f5:4937])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a022710edsm852623a91.5.2026.03.11.02.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:40:18 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	mazziesaccount@gmail.com,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com
Subject: [PATCH v4 4/6] iio: cdc: fix spelling mistakes in comments
Date: Wed, 11 Mar 2026 15:09:31 +0530
Message-ID: <20260311093933.21333-5-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311093933.21333-1-i.shihao.999@gmail.com>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling in comments

- becaue -> because
- reenable -> re-enable
- irq's -> IRQs

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/cdc/ad7150.c | 2 +-
 drivers/iio/cdc/ad7746.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 427d32e398b3..8106a6a83561 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -306,7 +306,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
						dir);
		if (ret)
			goto error_ret;
-		/* reenable any irq's we disabled whilst changing mode */
+		/* re-enable any IRQs we disabled whilst changing mode */
		enable_irq(chip->interrupts[0]);
		enable_irq(chip->interrupts[1]);
	}
diff --git a/drivers/iio/cdc/ad7746.c b/drivers/iio/cdc/ad7746.c
index 8a306d55c72a..cb97e3c978d8 100644
--- a/drivers/iio/cdc/ad7746.c
+++ b/drivers/iio/cdc/ad7746.c
@@ -606,7 +606,7 @@ static int ad7746_read_channel(struct iio_dev *indio_dev,
		return ret;

	/*
-	 * Offset applied internally becaue the _offset userspace interface is
+	 * Offset applied internally because the _offset userspace interface is
	 * needed for the CAP DACs which apply a controllable offset.
	 */
	*val = get_unaligned_be24(data) - 0x800000;
--
2.53.0
