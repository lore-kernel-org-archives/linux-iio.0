Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A5641A909
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769350; cv=none; b=eoqLx9TqVmYlXPMH8YxsOAlhrq/hpgNJI7/2Zs61DxALJ4lYfSwoXX3P+ugrtFk3/SvZwi8vToxOOsLaJxWbdvR6JUYuhXRBNC/PaXlsJlr5xlit+QCA3FB3CAl2kf8tDNyzjBDi5jKsxZtJomYwP6Wy033+bhQ1GHAnZTCJMgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769350; c=relaxed/simple;
	bh=SzFJP0jiUiQAnyIUqADYku5K5Hz/gi3DhoMO0xBKTaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JzfP7jcW+tKlbUou5W7tCYFUbBVGnawydpRlZkVTe4IksLbEzDQmmw4Ll/fUIUjDY9P1JlV0AA3A8jVwD23vKaAiM+8M36+skwdBJLecuC595vsYCH4Hk0TRdWVCRle+cbcOKM7vFAWTqE8bc7+p1+54lz4Ci9CbsOWoEhYB1fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTq9ZTN+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTq9ZTN+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48431648f33so3155382f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788769347; x=1789374147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsPWwpNpl6k7wrCmG7PQd50StcBQygwTK0Z6Y3sGKaY=;
        b=UTq9ZTN+nlqcMXh7euzK5Z2NwVgkFpRojepdP0Zy9/4mIMO5W2Xr8l0XDl/6Hha5JP
         SVdDWruXwiy/jS5DTCTKNXFrRptubY48qpYSF9c9ahA26+PKv/ZZSQQIUuiWHnDMIDKY
         Lb6Mm3N+RxjIxFOh4s2lws3qgpbS4Lji3eS9dJx7oig679eVY5ZGVIMjSF8Ps0/Bb3So
         VAJfQkUSAyuiOwHl1tRac0ctpo8ezzXJdR18ZO4PrWIe+L3stYV6kCuIBOX4o/NmLGQS
         4KSE9YuIfT0k4STkLG8XlBFwLbmTka7bILEXT5ehot3Mqh2I3a6B+balKspz8F615XKc
         dV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769347; x=1789374147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DsPWwpNpl6k7wrCmG7PQd50StcBQygwTK0Z6Y3sGKaY=;
        b=QdnvmQMHAB1xfft+HqfAxUzXJTdSapTO30gdeOIcBxtJFhivzgEKWtJvLCxtcZkkZe
         6gbzxF4U3SMaiOfXPJJ/WBIG45D9nOktf6WQkl142NSXCUoUQvDaxxDjXGZUIRYv4Da2
         D4yD2oEJ35b7qYbQwrQIr0K8yLG/MlzGbE1ZQ5SdoI6T1TYJzt40SivIjJj0kBaEdT68
         O9O+6NLLFSNdf5am88n3guDOYqsAL6uspvd3vVcP1aGGl0N3C6wwhjpflvyqR6NiEWhK
         H9ohomCIAF273NinnfcBzvYXQ8dsGn4YhvKZDXMsxqChsRxeOLkYYAgZuqQ2ffC1Nsz3
         SFCg==
X-Gm-Message-State: AFuF++lwrRzyAD5nJsPpM+kuTwTU0Ygj3zSTGV9uRpirV11l5rGDDdRM
	6FZPXUQR8spQmvmJNnbYEYQXn1K5cB+yQz3qVlWDtyTJK2BBsrUaC1Eo
X-Gm-Gg: AYBFou0a1/cTl2vN0qgkpC+wcp7jyCNVeWJGc99yvivvqVZNZIkcyQIp8egAiJ5QLJf
	DpsoYpe4tD2oZMHVmh7OMjE5ihkOp+AzeUiaNzu+ZKoZgYUKAyoJie1uxZhilCqV9tdkGLLNTnH
	nkl9a82ns6OBPzxbzLrNxcZh0ijpBdk6+0ftpi2TapR/8KMCdKLFLDefzoTqxMWDJ2OasncnoPw
	OpsGd+5KeT5KZuu/PNAQgAnZ2kM5mxnkKAr6yoMFoS+WmYDmnDc1Q7dI4pn/kz56Gv1zQd5BW1Y
	C87i1v/Gy5xaOhFfTjTZ799S/jQW5VcRcL+J+dZH8kNIx0c5z14zpyg6Vw8djk8xGyPWR2nCE9Q
	IGkonESFx3I+Bj70anC6HXg3DaxyeGlVoKcwc2HYEBucI4PzYy4CJBv8cCaCAwd91HmWAoyrj1E
	kNxQfvaTCfXtTs4O4K3NpaDRx5HmepTH1Ygmk5XWzErNmq1Hb5aYP9bvY7+H/LGrs+CNueYbnD
X-Received: by 2002:a05:600d:8497:10b0:49c:f13e:e4f with SMTP id 5b1f17b1804b1-49cf891bce9mr137013075e9.12.1788769346885;
        Mon, 07 Sep 2026 01:22:26 -0700 (PDT)
Received: from localhost.localdomain ([165.51.77.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d04fe7f9dsm191106465e9.0.2026.09.07.01.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 01:22:25 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: temperature: tmp006: Fix endianness byte swap in trigger handler
Date: Mon,  7 Sep 2026 09:22:15 +0100
Message-ID: <20260907082216.52821-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tmp006_trigger_handler(), i2c_smbus_read_word_data() is used to read
the VOBJECT and TAMBIENT registers. However, the TMP006 stores register
values in Big Endian byte order, while i2c_smbus_read_word_data() assumes
Little Endian.

This causes byte-swapped values to be pushed to the IIO buffer on Little
Endian architectures, leading to corrupted sensor readings when using
triggered buffers.

Fix this by switching to i2c_smbus_read_word_swapped() inside the trigger
handler.

Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
Assisted-by: LLM
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/temperature/tmp006.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index d9f6449ec0d8..f3b3de0bf221 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -256,12 +256,12 @@ static irqreturn_t tmp006_trigger_handler(int irq, void *p)
 	} scan = { };
 	s32 ret;
 
-	ret = i2c_smbus_read_word_data(data->client, TMP006_VOBJECT);
+	ret = i2c_smbus_read_word_swapped(data->client, TMP006_VOBJECT);
 	if (ret < 0)
 		goto err;
 	scan.channels[0] = ret;
 
-	ret = i2c_smbus_read_word_data(data->client, TMP006_TAMBIENT);
+	ret = i2c_smbus_read_word_swapped(data->client, TMP006_TAMBIENT);
 	if (ret < 0)
 		goto err;
 	scan.channels[1] = ret;
-- 
2.43.0

