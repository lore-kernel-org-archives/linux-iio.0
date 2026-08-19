Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3D381AE4
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139711; cv=none; b=n+3fXqpXWOOYMx3HSe4refd9MfRma+0wTcu4rKDx/WrcU4K8jsnLeyNeSWpQcLQhwtTsGlehhTHv4XvcZF3SnR1+kNH0cqv2I2dOnSk5OpjFtWzevkcNiKEcWLBnTSs07TnOE5PBLfwMy0ImtVTTGqqAkn6GRzTMxwAVyaRz9lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139711; c=relaxed/simple;
	bh=FNu8r7MvjrskHjFJ/tvmVL2DfoUJxitxTiZYFXu8ttA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJ0IB2Uv1saqDIX2j5ygC5WfsB0so17Ar85N9L7b4nWdbFRFW8gkRBXIyQdSsiNOt3ayo8/0ZzUKvjUbUAWDEJ1XhlHhrhpuTijgRah2e0TPcrsOW25eREO5N1OPuat9KM6mHzP2Gt4fFyszlGbkxwUN4fPq+7Sa7b11pg7qmM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QZZCsTla; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZZCsTla"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956242332dso8811295e9.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 04:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787139708; x=1787744508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=cYVMpgG+N2JrVPtpFPop3fFzb0WwUz5sl8ApG6xBBo0=;
        b=QZZCsTladfozzdejczU98TaEt/5Sfxsr4JPPZaWLmq9uwkafdlmFDl4U0KfmJhAhhB
         h2EmdYuFkJ6yADHjvJ9gnfUn8+CiTTmQ2+vJailAOnuNnOjiBOGuaNfgcPBh56i+i1IM
         kWSyige512Z3ixp2hTrvHYCc7+yjbG41GdrtQsyyqkhg+qZ7e6ye+J1tvK1klclRkNYy
         a24Mr3lZsN0TNSsjy49AABpirKj0UbabBuQ0xcaAVNZUFki1VHtV/Pe9xkveeNhd0OdR
         iZWhPuvlWsGdmx05d8IFGdLoWAAlzhM7dCogkB2PewF7Xv5+iUN4r6hJvY3N4B7+FHzZ
         qOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139708; x=1787744508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cYVMpgG+N2JrVPtpFPop3fFzb0WwUz5sl8ApG6xBBo0=;
        b=Pi/s0RTSkjY5cBnsjA2GbRf/2qeEEYRc20AE2HieN5PccSRh4EB1vqiP6G3vLB9FiI
         pjVQJju+0TDaCbgBQbNcq5Kolfg2NbQwnxO6cFJUMFg7AkIxxdB/Ne1SXkOXLn+Ye+Zw
         Qdp9mFKlYS/5PC6pWVn+h9pcY0d3j4PKRW9LkQ+1rl2PbuHRRgMuQmTk/q7ZAQRB3I3D
         8JOOXTwbuaghnS+3nrpx94zvhR15NSKJqFuCtNg87NBgGtVdA9JZH+UCQ4jyniYUAlrt
         BJisiaAtvc7P+0cvVmQtmablZXSCCohtQ27h3OjzBuE3FFhqwpwbqBNxRvLhVU4NuWdX
         AD3w==
X-Gm-Message-State: AOJu0Yz+UNTswsf2leskVNaKie0klRZmy/WBpcGniBnfBbRpWrDAKrMH
	kKFAflX6ZnPxtqxqdkhaRmWXP77YoI1ylUyg+FLunqfqUl940MFbacC+
X-Gm-Gg: AR+sD1251Y4ykVvoSUQMORk9joJAHSBy5aTApvPBZyLtqaHp/lqwNpnZpcb5091UloN
	vzEBaAsjr/6kAEnYfVhAxPT6hJKUAXKnXquV9I6fNkZBzw2cUpCIKCIw7lovp4y35htq2YupmEZ
	Zavz5WWABN+27CbGCMqhpSwNT4aHLs/Dg3fxvkXy8dFniMZExcE56Rdykbn7YqKri+mgw4RgAOM
	8RqreCJLYid0hKOhGalFEjMEH9C65tTy3+9/FnDmw2amU2RkWIaSrU86Em8cHOGZW90+OtDy5zF
	yqZOsmRMhbEjd7e1c6ceLmAbED3H6DOAVVnU2du8TewMsYZInuzwJHHRYxM0evrUGthAMYaXj6m
	EfzohxInYl2qlSqegOctp3bSlNnmtsMGqphckVV2h9JxJcHu0UwoWZ5EToFzcqvMRwqlLuBcGqk
	TG7Q0aWSWaUhoCc0AEA8ID5sqqsa49wCr11Fj70rzjIhjUiqapXiBU0gmotPQwBsWtGS6ptRqDl
	2ENaVstMF9mcQ==
X-Received: by 2002:a05:600c:524a:b0:499:737c:8a8b with SMTP id 5b1f17b1804b1-499aa1ce8f4mr63599395e9.12.1787139708045;
        Wed, 19 Aug 2026 04:41:48 -0700 (PDT)
Received: from localhost.localdomain ([165.51.108.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499ab2a8b34sm61183125e9.8.2026.08.19.04.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:41:47 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: accel: sca3000: fix frequency divider condition check
Date: Wed, 19 Aug 2026 12:41:01 +0100
Message-ID: <20260819114101.28232-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting the sampling frequency, the check for `base_freq / 2` is
followed by an independent `if` statement for `base_freq / 4`. If `val`
equals `base_freq / 2`, the second check fails and falls through to the
`else if (val != base_freq)` branch, returning `-EINVAL` erroneously.

Fix this by chaining the checks with `else if`.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/accel/sca3000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 573831199bba..cced5cd82b02 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -638,7 +638,7 @@ static int sca3000_write_raw_samp_freq(struct sca3000_state *st, int val)
 
 	if (val == base_freq / 2)
 		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_2;
-	if (val == base_freq / 4)
+	else if (val == base_freq / 4)
 		ctrlval |= SCA3000_REG_OUT_CTRL_BUF_DIV_4;
 	else if (val != base_freq)
 		return -EINVAL;
-- 
2.43.0

