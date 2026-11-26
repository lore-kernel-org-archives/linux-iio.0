Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795671050;
	b=hWJbqYYu5V0pz32jDm+9zlqPr0q7AgGE6/G7nBTvtxfthLPUBpENr60GyuJ589GfKaYA
	 WfT9hZF5gPS4KIeBlvVH+XBwrPBQW0DQywEM/cukDoHtjKJcFlEnqZ37DdM342m6SDWUi
	 ZDkYrSj7bW4C2LhAkz1VH3GNZwM82iGecEJUv0B+7sIma3WuyWS2QtZCegQfs26KOCyvX
	 YHYLhzijZN345XS6TqXyd/AzgZDfJ5Py5gVTgc4pQm4mYyjQ/sEl7AgjRHEZWuku6kpyR
	 Amjwd2NiaIPmAhS2L3GHTTo8HJcB2k4TyWxCLWpyrh0Iv9nPReHiklLQWcoHr7yYshA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795671050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OxFT/2fpz2YMPKiAOVO24hA+jqmsHhv6SbZ/zvcocJ8=;
	b=MTxVQSVGqJRFmj0RSKCuBk/xr4DzksR0opc1h4c+ccxExWgxZKmWs5Sv8JOPuEaDmTZY
	 A36f3iJpREwKpB8ublpbTC++JIq8zo1erPYLh2fz4SWpgaUb0v/xsrwDzHSHizCGMNWzu
	 LZ0r21urIBh8c0dWuVCH3Nhk+8K3MM6ArlEUaam7ut1P7+mb0S9ulrPV6JnTZ9ZV0t72K
	 Rx/i6N8+usHipXfbqN+2POdWiNhqYhCwxrGKZcDB/iM18y/Q0XIy1pNEn3wNT2Zwz0K7N
	 HgR+/QjdTg1FO6zyBtEtpnUGSxP0srryEGSZr8+Jp6j/Tis5w0y4dSmzz8UTBaK3Lxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yyRDJ5my;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE49A606A321
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 05:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE49A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yyRDJ5my
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdab8873d9dso3170004a12.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 21:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795671049; x=1796275849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OxFT/2fpz2YMPKiAOVO24hA+jqmsHhv6SbZ/zvcocJ8=;
        b=yyRDJ5myRtX2h7ehwSgXDAFBSxBfQF+AWcDnI4uzx1BXhuGr84eK17JmxM7CXIz2u2
         jHJ1K+xzFJJAY75K3Q93YbiS+wG+EaA15CYtBR9rSTVZX09sZiDlMxynP87qOkUbpC4M
         DiBg3ubEa0+pLcYAUD+GAjdLF3QlnOg1reNxbBtamPRI6ZUnWS8K638Gk2sJ4Pl2AINU
         VxwU9f1xXZfheplgLEb8+yzTrHZq9I6rewemHBDuOPHxae/usRgd5OMRLn95Mx4vFXCV
         MkrAJqsfP9z25GgDrpii/xvRpFvRq53nkRXYiVjSc+KJ8FER57K09qpStYhYBjxmPcnc
         tD1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795671049; x=1796275849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OxFT/2fpz2YMPKiAOVO24hA+jqmsHhv6SbZ/zvcocJ8=;
        b=ApA/uSJRVtNMfLyt7hCeOzfC8ySjAur5IABNt6DNW32FHowdfI/DSFOwlRAklXIJsw
         HhqsX/RDNrnl3QpHMvYPj+7xY9smSz/4vp8Kh8/dnqWs92rZedmlBKIJdxFP7iwm3AdL
         +Evg4qMCdUyRiIvuyNbN5qzV9++KEc1A+3U7JfEjGA1VWym0ke+raikRz1avWxXa2fHK
         mo+yoI894GxMCoZ0wbp45e89+cvCFzMh4GzNqEGrQpO74MbDxrtYSiOodMO0/GTx/4Dm
         i/b+Os7D7GUGvIVWZVZS8kJN6DIDrI90FpTf6Yk1bCEMjJJzi1/LN6sBvOZpO70IYs0l
         TlXg==
X-Forwarded-Encrypted: i=1; AL+hErFoq7xyTe8N08l2/5tsbp7LdiSggI2l/dyZVl9r+1jUWv96sbqH3LGrc0rFV/aAkmU+VTFyphNYUz4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9QQBuMYCfXUN4JTHH9r97dlCMRCm8S8FM6Y0lkL/yka9Xa/eNn
	vvF4f2JdB4TNVZs6xzHfxQUkYwvv/eWzZ/eq8yjALHHzB237/EEJqM8i
X-Gm-Gg: AZFdTZdsfWPLv6U/75+/f4AYYiQBWAjDNdsmkDhOf/qbiRO2Qf15roMAbcwKq/7UrUA
	+/vX89pp9Qq1SnYNAVJx31AimAArDEO/HibdVUd6PRd3B3LO57oJg4YWLj0ajuxf+AEg7kbFdwi
	Vh5jMPrVTWARO0TOGUYbegRIDOkY4qfcC+aDBrRsxZPbJ/ZXdQ9hsTxIR6yK7cJB9BQ86QWKXKB
	G5cFMeswdVCBz3o00v5F9SCruS9yiJHyJVRxbGnWBFkv8R2Cp7y7vi0oPFNEVrVZiaICyHB3TsL
	tANQPMuZcy9X9fWO3gp1IhxlL3OuUlZRsRLSOhu13dcMxXA8fHzSzz0BMC7nSMerbuAUN7sllyM
	lXb7eVGKJ7NwteFDrg2eQ43kBlxe+ah8pVgDnNMGgVpCk+nH/LBAktRjAixmzKr+iv8q/biqClF
	0So7vFhD/Tbm50uPYr1EKRvJ8/MGg9cjjiMSbnly58onGu2P6MpnoVofK2VReexZjTbVVfPOCMj
	SioChDGUF4MBw5HA31Zv6RvaIUBMO1PASpQE2roRCBnpg7+M26sr5zLAFce76P6ubcoINFPmNXD
	1wIqjeMyxS3gFBS4weGpLm2DKXt2oqd3oZcSOuGAj66th1GvSodgk9MRFyMRqxHZ+Syuy4djpKN
	g+DgMQa3YcuOpvINrAIRRsKe11P94vGQ87hfSHlje2IaPty36uTNqz4dQvNPJFZc5Oj62BfVG2G
	ySuLfD4Zf7o/X/T9TykpHAmnM=
X-Received: by 2002:a17:90b:4d11:b0:3b4:d00b:d0b3 with SMTP id 98e67ed59e1d1-3b4d00bd2cemr8675206a91.51.1795671049096;
        Wed, 25 Nov 2026 21:30:49 -0800 (PST)
Received: from kapoor ([149.40.62.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm33700520a91.7.2026.11.25.21.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 21:30:48 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Wang Shuaijie <wangshuaijie@awinic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 0/4] iio: proximity: aw96103: fix diff sign, missing config, async config lifetime and event values
Date: Thu, 26 Nov 2026 11:00:24 +0530
Message-ID: <20261126053033.603086-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four fixes for the AW96103/AW96105 capacitive proximity driver.

1: the DIFF registers are signed S21.10 (as documented in Awinic's
   aw_sar driver), but are divided as u32, so negative diffs read back
   as about 4 million.
2: without aw96103_0.bin the driver never loads its built-in defaults,
   so the scan and the interrupts are never enabled.
3: nothing waits for the request_firmware_nowait() callback, which
   uses the devm-allocated driver data; a probe failure after the
   request (e.g. no interrupt) or an early unbind frees it first.
4: out-of-range debounce and hysteresis values are masked into their
   2-bit fields instead of being rejected.

Patch 3 makes unbind wait for the callback, which can take as long as
the firmware loader's fallback timeout if a user-mode helper fallback
is configured.

Applies to both fixes-togreg and testing.
Compile-tested only (W=1 for every patch, checkpatch --strict clean); I
don't have AW96103 hardware.

Arnav Kapoor (4):
  iio: proximity: aw96103: report negative proximity diff values
  iio: proximity: aw96103: use the default configuration without
    firmware
  iio: proximity: aw96103: wait for the configuration load before
    freeing
  iio: proximity: aw96103: reject out-of-range debounce and hysteresis
    values

 drivers/iio/proximity/aw96103.c | 41 +++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 7 deletions(-)


base-commit: 793d80b04b6c4f7f896c273567f94eccd0fac54d
-- 
2.53.0

