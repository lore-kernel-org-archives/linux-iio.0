Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665303A782D
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781443155; cv=none; b=JNp72QacHkBLNgeeojqa5xw7JvdU22O+GfiLTvCvLXO2mKXwPnPqWYE2eSu8dkrZjxt41PcK2qSMQvHFqTLiSVc+ZBU1umV9EO07YVCvQF6YCyO4v+wBOHGWnzBQj4/xBWBfZnMC8196AWiHhMv7KizuCVZZC3XFOd6P3nWqDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781443155; c=relaxed/simple;
	bh=vGxzcUtV7pniE1iBjiD7iSKlGqvuDRRsBCNuQj3TloM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PYJxWY0J6TLRTU+vjwebGyFoIiEibgMKkceFO60dArxJRY9X5yo6AYDSQYHgNJeVWx9vnr+ZUOIHsPiteK2N4Wk25cr42X1rxN9Jf+9Q6cifR3XpPTQTJ6NtP/zhYg4AgWK9UiK1V0TzZNhtBwGkWITVCgk3ViOMiYP/LQjoRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbCaZ3mA; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbCaZ3mA"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490b9318997so17408425e9.2
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 06:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781443152; x=1782047952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rW8qCN/jlrzQD2r1BB+rWQwQthQ8O4Io6YDQAf2AQOw=;
        b=AbCaZ3mAqdtPafVmyYkPPHyCMVJNSDG5Zi5TaCh7XKnpjHTWty8YpA5XgtbcdsQjVR
         jL7ilUmLEhBsBhu2tjtlhNtAZPZwttNa8mxQDNrAAh33i0EGCvuV3KWahQQFL7pmtG+s
         h5IMsrsJ+5jMrbpTAYJAyAeMcWXuvBRe6TsxsLXjVEUoj6jwFNhinGD6sKpW0ruVyNsp
         XfPNkmCikg0atuIbpagyoltWPXY6FZQkcfnFfhWn2IAo1CkqO2yWbwxrdbk4lTU6Wiqb
         Omm7KZ5w2RRGx/ltzrRaDswnqAKOG2qlTR6+fQatNSliFbQSda+GZ1Buw8MeHb0sJLlo
         z6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781443152; x=1782047952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rW8qCN/jlrzQD2r1BB+rWQwQthQ8O4Io6YDQAf2AQOw=;
        b=LyamuqXq4bptRS37j8cCT73A9wiBUFkG/snJYOcXfygxxsHfyfofNo07pgvy5yHvpS
         Hsn75C9XdclS/Amtx3uR3b1QByNhkbUES7v1hX22D+AIJXWX2lyjmPKeCUMFpzsJ75pm
         qgdrvx8ZCbf4ONU8mFuX4+C8yfy22LX7A5T5PyaSUdyDzsDo2tCt34YUifVMM5ufkk+M
         GYZLPytyDVAI096B6cuk7dxO8/rfM3UoBTWAkC6knk1YBrxwPZ7dF0kub1frRr/N7MoX
         fVhs0/01GUKrVhO1z53VeddIY1AbW5a9ePh4GHuDJMZFWaqmZWthesH3xcYzmOUm98zu
         +3fg==
X-Gm-Message-State: AOJu0YzTtCyC2d3z1LevFIsVPTxKlYUxeGJxdRNRmvA3LL+/Y4Ksgmq3
	DqVodVjNZXvSbNVhciXhVSG3AGyhWCbDkXrW965tI82940h8iS86yFE5
X-Gm-Gg: Acq92OHGvniS7fREaLiHXpVA3YZdbs9fZZXBgGqz8KX2HqEM9YeDHiypITT8cK+Zd2m
	+b0t2maKzTCeqYk2ALAIh6Bc7md9cBz/2ckaJWwGW+PKphWESrF1lSufLkv0Wmrjdt69a2T2RXs
	Fyz20Xe1HhJ81gcPVOXPOMI1NvlI0ijJqGHx73Lm9N/QgGAUGBy8dJ3JWQbhXEeDFAauTiMP//i
	p7eCcyRv+jXvjPlNhqzlFMFoRqWoZSCGM8SXJFV/3IK/SycfiXuf/tBaLAJqzDjSmEeSr3dG9Gk
	R9Tchaxypcmhr0SNTMV5MtydClGc3Y8/06HhbavHkQVIZo3vqpWPMUGwXagVEqHDuF34/Y6oe5/
	HjQFxB2zELUGMWNFKgztkNErdeWICjHg+mXDZ0CB/Qa22CaZm1xp15DlDJvUOFpzSlrxQSlWcMM
	VqWSr2yopVhOJ7JKO6y+q4Zv+mvqFU+3U5BeLNo/sGN2avM9enbewGy01gInXHYy7YYL36L1u4U
	9ixJp9MpgFwJ6llfBEJ44OyTixTBFeUt2Tkx88mnUblKSvQMk+Lg55RXz7q3MC8gJ/rBVZfQiwf
	YlFxDN7Q96mx69jXAr57IoZVmSUNniIQpiklJp0y
X-Received: by 2002:a05:600c:5253:b0:490:be14:bfda with SMTP id 5b1f17b1804b1-492200851d9mr81913065e9.6.1781443151606;
        Sun, 14 Jun 2026 06:19:11 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0:c287:187e:fb7a:66a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922037055csm168406355e9.13.2026.06.14.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:19:11 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 14 Jun 2026 15:19:10 +0200
Subject: [PATCH v6 8/8] iio: light: opt3001: add comment to mutex
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-opt3001-cleanup-v6-8-e3f5901dcc26@gmail.com>
References: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
In-Reply-To: <20260614-opt3001-cleanup-v6-0-e3f5901dcc26@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781443145; l=895;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=vGxzcUtV7pniE1iBjiD7iSKlGqvuDRRsBCNuQj3TloM=;
 b=ZR/dbFdBefCTu02aImUV8R1Be3jzECk1sg4IoOzhEHDzL5+9Bd6X3chgygdqkOGCVSxCH9pxf
 WtEh/fz52M8BRPW0ERBY2ST1iSsT2T7cX8pwqD2igfPbIXntoBE4qPX
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Add comment to mutex per checkpatch.pl report. While we're at it, add
a comment to bool ok_to_ignore_lock.

No functional change.

Reviewed-by: Maxwell Doose <m32285159@gmail.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index b657aa88c1b4..7afa0a6c1948 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -103,7 +103,13 @@ struct opt3001_chip_info {
 struct opt3001 {
 	struct i2c_client	*client;
 
+	/*
+	 * Ensure data capture and read-modify-write sequences are
+	 * not interrupted.
+	 */
 	struct mutex		lock;
+
+	/* Allows for IRQs to bypass locking mechanism */
 	bool			ok_to_ignore_lock;
 	bool			result_ready;
 	wait_queue_head_t	result_ready_queue;

-- 
2.54.0

