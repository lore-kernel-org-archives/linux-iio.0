Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9596947ECD9
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787161891; cv=none; b=ZRPSxgoh+j/apx3muqXPBQts/bYHXCtT/XaZjxTpR9MZFo8LaK9Hmb41oazIUSchOT3A2UVYqoofLJalXvXfj/XRigYdp+qsoNJxgOxtTEm9EefcWSTLud3hVb/8odqEFDP8l9Njwu6mZbUCHA/kWSPvYeDE4HRA0+l0LY/m9PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787161891; c=relaxed/simple;
	bh=Soo8oe3J7AFA6oj6G+skotNR2awzsKlDGT8J932ZjJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNkwU0HkjCJ19CUgwD1Y0NwJlWSeVF9YfkI3zhQWlHIRp+zpoV5pA5hj3N56bj1+Eej72CWJhJlKxyQfEbpGLH5XSMqoH8UkvHg52pvMirmbLtTxZj6qZWHIxg1axPNyV5gHeU0koCdqrHHFlsu4fiDdqn7geNIB2LwuJXu9qzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cgem1xkK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cgem1xkK"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso211570266b.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 10:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787161888; x=1787766688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Cj9RQcolWEoew7IEYyQVrf8OU6NrQl3Vo0NlQLDW8U=;
        b=Cgem1xkKAZ4lVOVTo2mlCppv6Ds6aPDUC4ZZknuR7gy2Cj8N/i63Jg8CNUYDm0lBsq
         Yj/X138NOcAR86OAj5g+3VN79d+XVxcxsRG+MaRHarmF55anYzH30+lWGsW8O/EYW4Sl
         pK6pgtqw1YOGFzMwR4Wr5eIOS1uleEshtDyP6oIv74qijAvzU4hgGyhKOyFYg1MdvHI7
         JY4mS4m9OWuzZWQys3W0l+XfZNdem7Bp7SAgZPtkCMmpaZamdQXtE2ZBqodGTHPKepo4
         Hr+6lj+IofVFyluuufq2OXoiPrUWx2hNgL2tMlNgrseCPOKz5M/MUCaQzf1egNw2XxQL
         wAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787161888; x=1787766688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Cj9RQcolWEoew7IEYyQVrf8OU6NrQl3Vo0NlQLDW8U=;
        b=bfaNVEWWXAv56zua0yT4J0kdZp69Vs5G+sgwPEr7BN7blgKAIBdpf+JjQ/tuhs9O0w
         auIV4Ynoab1W7rj4V4rTrX3JpnrceSVr6JKq/DEerOyOxKEV7wYQ+6x5fdsSuGqvIW7U
         nN2MAMOeBabLXctdSyjbxgKhJIHCSvFGKD3Vj7IiusPh013TFD9EVDNnG9KMvVBcvtiX
         /1/HhLFM7wVJZMFw75jxy9fhmB5W1aHcSPMNHPBOYZw/NCtXDZ3AkwiBHS8IwrBoD091
         nl7SRKCjXjYbzLs//6XKAH7z7wgJaiLa9F+e3pWP+j+0/YoOudaT3S/pF8X8IK+/GmVy
         n5NA==
X-Forwarded-Encrypted: i=1; AHgh+RpauLcZykngo8GYgKGHO7fSJ8wQtoxcBpX3sLE7dLVk+TvIv2EzLbjT/OYFDIQ3Gwd5Z67u1AGA2T0=@vger.kernel.org
X-Gm-Message-State: AOJu0YysvTwXDJFBYbj5A1C2lUTlxSAPsIo9Q1vdjxtrEV7C1kWCD3yq
	CjdxKctwAXhuR6Erm5FHSEMCyp9jmB+NXNdDdhJghuXcUT2J1PYRvfiV
X-Gm-Gg: AR+sD10LR3fw7bZjPVeZIu1ZeZkwzyl7osp9wynSjDGI6oZjuhN0bJ+sBQ3bhglZrWf
	Wu2UNoMd9rXRDPOw1HfC+5IdlYqBJQqhK1M8z6Fgcwn7/qiwkVGAEyfeWw2cq8rpv1Wci/23buz
	KGqMIWuCEb4G/39BIYgiwDDgUxbkyEJA/E1Rplk3kq+9nB+Pb7iOPNdlloLDmHYchemM/UeN+I9
	Qau+YniCAoD1wKuuWuc3Q9VyU/anxlUTb2p1XbjLw/i4fZ6GS0RLF632lw2hdn4Eh7at1/Vmpd0
	lBWEYarRwWxjalFmGqAOWTY0eq+C8BtVPQolST8qIfYueUgust66bKjKcu9O1eo0yTORh/3Sq8Z
	+5wQcp6K6O+RaWGBwVM1ukYoh8S0UhNzESJluPSyh3DaS8uBWVx2qD/n1+Le46aK17nv1vJ6R6R
	/w7mS04QDPaoCr2no+Oe4ELe3gCQRRx5tOboW2SKAO/9BjYk8ul0+CKNsfAPfjxbAYITF9bude0
	w==
X-Received: by 2002:a17:907:7247:b0:c21:74ad:8b7a with SMTP id a640c23a62f3a-c23f92d53damr467518566b.9.1787161887573;
        Wed, 19 Aug 2026 10:51:27 -0700 (PDT)
Received: from localhost.localdomain ([165.51.35.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c243c38d532sm110631366b.38.2026.08.19.10.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 10:51:25 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: frequency: admv1013: fix wrong channel field used in admv1013_read_raw()
Date: Wed, 19 Aug 2026 18:51:19 +0100
Message-ID: <20260819175119.6235-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

admv1013_read_raw() switches on chan->channel instead of
chan->channel2 when handling IIO_CHAN_INFO_CALIBBIAS. The channel
field only ever holds 0 or 1 (see ADMV1013_CHAN_CALIB()), while the
IIO_MOD_I / IIO_MOD_Q modifiers are stored in channel2. As a result,
the switch always falls through to the default case and calibbias
reads always fail with -EINVAL, even though the corresponding
admv1013_write_raw() path correctly uses channel2 and works as
expected.

Fix the read path to switch on chan->channel2, matching the write
path and the actual channel_spec definition.

Fixes: da35a7b526d9 ("iio: frequency: admv1013: add support for ADMV1013")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/frequency/admv1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/admv1013.c b/drivers/iio/frequency/admv1013.c
index b823adfb0f70..bb06a94ccc50 100644
--- a/drivers/iio/frequency/admv1013.c
+++ b/drivers/iio/frequency/admv1013.c
@@ -195,7 +195,7 @@ static int admv1013_read_raw(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_CHAN_INFO_CALIBBIAS:
-		switch (chan->channel) {
+		switch (chan->channel2) {
 		case IIO_MOD_I:
 			addr = ADMV1013_REG_OFFSET_ADJUST_I;
 			break;
-- 
2.43.0

