Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0814570E8
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786698489; cv=none; b=IxeScnWAZpZa4cALx34md5v0TPa+mGwlL/Wc8inc28OG/mnDQl6AsDqQ/5XohwvybwEkDDUCZD2F8DbI4HHpfN2DZViIydwz8NG5SUp2OwgigYs1B+p9q16WRTi27wY/R2s1ot1w8WFJ46tEcQIdz0lMTple/Qkni6tcPd5ed/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786698489; c=relaxed/simple;
	bh=pH6jzKgwrH1zv2mw2pomaAmWb6Kxr53NPHaNTX/EXng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Unw1gR1XiGW0tn5u9KLBzjo3/bAoLKxFgQEQyY4qC3RmBESMN4MLT82UoljiMwew9GILxj19aN0zyxplsnF9vzHLXAIv/FOkb2DTpOekZC9LDSK3GuIlgsx4LQZGSX/VHgzWrLeuSKv4w8NHpMfpTTwriV3J47pKS/IotL/MHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXIJWXF9; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXIJWXF9"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8111c0c7561so10026727b3.3
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 02:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786698487; x=1787303287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvJK/3OxQwOhIHM8EH6WtO8ZWdbRyYbnysOx2i6lxyA=;
        b=XXIJWXF96D1Oo3Aw/iZbct9PeGvAkQ1uLjZmetM6BCCUgqzAxSrejMtrMyfAxrPRk1
         rGMAJKVsr3pbeQHU4EyTA2HoEFprFsgzYlkis9SQMSYJr+PZe7SlgEhMEvYhBJ2xwYRQ
         djMMZeN9EUofJryXCXroEkZ9fbKnfTp5biGQRHaTcVf1LticYuhqSQIodawc/6QyHe5m
         Ib66FjATr73vUJ6ew3SkStGYg9wbbjwwtmgkZn/aH34aa59mxsw/4pR4e9XKM80BjL+C
         r9IG/vkeK4NNxc+Ol3/qTZ13BFg42JLrIBrELcJz/WGS9zBzV6pk334JB5TdEYL1sYvR
         DJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786698487; x=1787303287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvJK/3OxQwOhIHM8EH6WtO8ZWdbRyYbnysOx2i6lxyA=;
        b=A2sPLlMp8adIgBWxEkki19RyomDLGgajklPeg8NE/r7NQl7oXlXK8GUsYBisibXXKH
         GHrOVWdlWB5lyDpOBSB0bANhmiVAxY1EUeB7xwpmvR8TNB92lYoT1Lpk/sN7ZCRYufSI
         9VfL3k02YM2BClc4ZiM8Tty8oxL33TtMtI2h9M0h+3yR6yWmLhfT/LMOVB/ReIruSYcE
         +FNy2BncFwQAI+6uuOOQiNZfYKxbVF5DGa+CsM1VYqjtZaaHWvV1tMmehhQrQCYNfpWw
         vUz3Rw/ll378sJeGloH5ZSM7WrNgLpGCUJxuNk91N5lbrprcidNGht3jimBsUyxwMIsQ
         Rn5g==
X-Forwarded-Encrypted: i=1; AHgh+RqlSKKJh+z0bT/qNHTYkSUsoRirMvhV4n5e+ggv55DMMZ3U9J06+2PbWp2Tu7Km/Dm7QksxWMmr6go=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRFdzZ7jsqanmrgkcm+LolLdZfMLEmj+Qd1lp+RnGzK9inx6H
	L/7o15hX66pAcjM8RKLYr+900axcwL4C/Kseyd1evvdKr+cR4UAu5Ak=
X-Gm-Gg: AR+sD12iNSWZm2gEqdu5CZN/RUnbBzGooYPSpGGGg183dGaHc+uFAhPAM6tubZM9Bo2
	svz7kX+HeXCCs1MZwZ3I9FvjLj2fOlnec0oewVqVRJrLkslVnGM2D6yBn4Zig66aqk0KT91TZTz
	tC5ky1n38lWy8a9uIOHwGl7XxzzvxRmBwCCdxK5aymvt/JdgzVT6ncpi5V8ra//mZ5ryGhYEx8W
	aVfrU/o+QaCH3hd1BhF6hzoicV7K6fcGrBbZFa+vM4vvrJaDj8/G07hNtlkmDpnHNGj9tsZlOrr
	9qkSnr1f+pi5k6HFUP26wWVXAkohAqLjGqlrb2sCxLA9NgOItCBbdafwY2C9dkla6D1+RHcGquj
	qQqRTLhK+DLZfpUVNipQS0ofTXTgmPIQ1kG4+z6Pxp5SA1Sn48A+fma4crg7U8BCFFwcIVRyjFm
	10xrIAa8O417oZMyNe1D3/Y+YrKUg/m20VgA4uNLSTNHZmQvtkEAIcdvY9vFZotfibEYJ5iFZFH
	9LE4tPE23DJ3qoFtVs=
X-Received: by 2002:a05:690c:605:b0:826:8d41:897a with SMTP id 00721157ae682-8370e5946ffmr20523157b3.13.1786698486682;
        Fri, 14 Aug 2026 02:08:06 -0700 (PDT)
Received: from daffodil.tailc06997.ts.net ([163.152.162.75])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bb3ecef9sm10801267b3.4.2026.08.14.02.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:08:05 -0700 (PDT)
From: Arka Mondal <arkamondalofficial@gmail.com>
To: nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	venkat.prashanth2498@gmail.com,
	rohitsarkar5398@gmail.com,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arka Mondal <arkamondalofficial@gmail.com>
Subject: [PATCH 3/3] iio: gyro: adis16136: fix unprotected debugfs reads
Date: Fri, 14 Aug 2026 18:07:28 +0900
Message-ID: <20260814090728.965922-3-arkamondalofficial@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814090728.965922-1-arkamondalofficial@gmail.com>
References: <20260814090728.965922-1-arkamondalofficial@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The serial_number file operations are open coded and never call
debugfs_file_get(), which debugfs_create_file_unsafe() requires.
debugfs_remove_recursive() therefore does not wait for a read in
progress, and unbind frees the iio_dev underneath it.

Use debugfs_create_file() instead.

Fixes: 9aaea09b4cbd ("gyro:adis16136: fix debugfs_simple_attr.cocci warnings")
Signed-off-by: Arka Mondal <arkamondalofficial@gmail.com>
---
Compile tested only; no relevant hardware available.

 drivers/iio/gyro/adis16136.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/adis16136.c b/drivers/iio/gyro/adis16136.c
index 369c7428e1ef..adcf54b67a28 100644
--- a/drivers/iio/gyro/adis16136.c
+++ b/drivers/iio/gyro/adis16136.c
@@ -145,7 +145,7 @@ static int adis16136_debugfs_init(struct iio_dev *indio_dev)
 	struct adis16136 *adis16136 = iio_priv(indio_dev);
 	struct dentry *d = iio_get_debugfs_dentry(indio_dev);
 
-	debugfs_create_file_unsafe("serial_number", 0400,
+	debugfs_create_file("serial_number", 0400,
 		d, adis16136, &adis16136_serial_fops);
 	debugfs_create_file_unsafe("product_id", 0400,
 		d, adis16136, &adis16136_product_id_fops);
-- 
2.55.0

