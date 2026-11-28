Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866944;
	b=jcDazddffXvVUiN+0gKB8PFJK54ZdagBPTyKIzGpXjSrbdJJ5biOgnBux9PiiErooZGD
	 VGM5HV3EAS8veoLqKR9n+67YxgnC6Ch2U2ZJzwlxfwYiUrWevlNDFooHC4GZHaNvTXJzi
	 lt/+Ld/VxoBuuZZ5Ibf49aXZ773Dc0aP7kUzdajAXGKDweRvJJ0Bw4D7sE+bSaHp26BNq
	 YcHGpCSHbE66Fsbm7SmKHlNsk2nGEPPHxByo9LhlU2rLAKj0UpGGxFnxN3hMsX0vC51FS
	 KbJpA4l/uYF0n2VVHfGW5bMdwWaqq6H+ukAjZM3MSIq6FqdOzgHkeFuoqHUElHIdrcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866944;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aBocqZHKO1aySKuVEEUC815kdGRQLnhShgs9tyAzobU=;
	b=TMccPpemkSQJC4EHDsCczckbPoHYseqrH1mUc23m6SfU8hxTRb2aAEPWoDNaGYtc8niN
	 KNy7iBGHJ3DqebQDSg3f6fw4GZ+XoViYEtIYGHtqLYf8XMcy6iynQls2WH0bI7VDrcUCx
	 qlIHYv2IN8rvxImJtQ2p19JImq2ZAL/Ovhnxvchx0701TkTGMeNDgjRP1ygoaSR6485ha
	 nEO84Fbk+/tIFoVMuh8cWMeqj2UzOSiiT5hbEGel8VaiLturlpNl65rq+nG+GFIMC7qrN
	 M1JOmnqtmag3UL9HWcXU576Q2k6G6bMiVKsacxmlXZnwsb2CJUSCkBkQhf0HxfncmtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IF5ezen/";
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1F9606A31F
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E1F9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IF5ezen/
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3863db981d4so12624514eec.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866943; x=1796471743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBocqZHKO1aySKuVEEUC815kdGRQLnhShgs9tyAzobU=;
        b=IF5ezen/nqsSLknLEYkdekZ5Pdco8RqRH4evjEQKhXI6LF1OVqEje19hAL9PFKb0/s
         WZ0nS77AoygoIIMusuPnorZXI3PlitG6BTEIjO84gIKje9ngVmWr1ul84fviQfNxSUBw
         pICmaUrCUlWFzuJDBP+sP/hpdv5y6y6w7642jtVpKjsadBLLzcR5XS1BpqQ+Va90Xvcj
         wFtSUXDV+wzg6SAHKYcsdrULszp3i2s5eKty6tj/H8sODT4RWYJHuvPnvdcV7U/ZyYyk
         YNKXgFHfbFNoMvdaDfjymOMCqjalLLlzas8m8UgAxi0n2CbYtLnuoj7XEs+qKjmy9MTv
         4nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866943; x=1796471743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBocqZHKO1aySKuVEEUC815kdGRQLnhShgs9tyAzobU=;
        b=LHwy0cbQmfeat9S1P2/L/PjfCVEtFnl2zhjvkto7sr5tkZi076ycK2XbvlftxPRtJL
         e1PTEZJscpYTSoQ8FRhGKvbwlWvE2ZjnnbBT4uduccqp+xrUxuzIMmQSNboH3gDwR13h
         MQICqye24897MwuocJuagnzxRVGAQlXtGFRhPFKX+U3mR+hUoDbXiZnQYeTJXUtGgutR
         4PBEquSXcLa27XxWCLPKC+yoSQVbIiDvMbGc/5pO+I7gfoKScbjzEfFhvpbdpfoC16uP
         ns5WM/yy4ALjKLs+KeYFLAoiywGSZkWSpxjawq1OOUYw8fY6zvEOvIms6/xF/LjOCykb
         zZ0w==
X-Forwarded-Encrypted: i=1; AL+hErHJrauMq+HWFJ8IXjcw4zlovqlTcEO7hOLk0iYKx6XIldyIOTCLrUwzwPGTCZsbF52AtTDeG7Akr3s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Y80PPUez6jLJrJQcGDi50n8Q91rc9xMG6JBJPgvkardTwiUWI
	WNY7/EN3vj4NaAyHtE9pPo2iShVhC5UtEiBQT/vzimFHOS4GuIdDKwRB
X-Gm-Gg: AZFdTZe2oqLiHsomuq3v/mjzVGC6auckTaY8IxQlNXnEw7EZLAB/z9ZDxsBOvRWL0n7
	u8pIGAI48Qm85FOk688eLbW6DtQ11V9WPSrB2L1FX7r7BecQtM1V2NyXvmkcwXPx/7KZvTbzTLY
	MtOZDJEu0ejrG8nlzc8bTytbhGF4QoyPkceU5oqGe0CvRIdNPgpMPAqDkxMArHgoMsseKZ05cp1
	O5JR2UT2cTYQl7h81fZxKu1iqPnaA2wbyHxc/ZGs+FkrxZ9S1dY8QDhuNvbzSXbC1nDPJoG4IIr
	9fBYjRbjq6VIxBAkjv6o+ubboBSIbYRktKRxRYGuEOOMyTpspnHhBRsUVy2OlIEB9/YDyyF8U4V
	FtKTMvH6e+LkzSdGW0DkzGcLP65hyhAMDUF/fpvAG7YkoSKDw4kVgv5bhe/pPu1K8GUTizh6UJQ
	Y7b5FitOBJuw1kG1xAJIBuJ7ZtYX21qXMWYptZ3RxMgcey+BeH5StIgDsSazT9+LUKXXnF+otbE
	cncInIA/mrmYq0AqTM40M/ZDRvdtRrTHxEQrAAoKN5NsD/0wI5D72cU+CnCIX6Gj/GuNDvjrq9G
	1lSiISJWfAK9Iy2wk2ynewhTnTljLcpprDvdnjAjD93WS+7z6I5ek+EN1/jQeBP+2CS/miyUlgZ
	HJnFw/R30/61PBGVpuZqPsjraigBY7OgCgD8DTp1M1TpIjQrstVkPnO5jemxBGiyE6Hpgsa25YP
	0T3CcK6s54ckYn9sTByQG1vH0XrBNsa3P0jfJhqXKymA==
X-Received: by 2002:a05:7301:10c4:b0:386:d310:4c1c with SMTP id 5a478bee46e88-386d3104c52mr13030189eec.21.1795866943488;
        Sat, 28 Nov 2026 03:55:43 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385f68bc0adsm76783178eec.13.2026.11.28.03.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:55:43 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v3 0/6] iio: proximity: sx93xx: fix raw reads, thresholds, hysteresis and gain
Date: Sat, 28 Nov 2026 17:24:48 +0530
Message-ID: <20261128115534.558478-1-kapoorarnav43@gmail.com>
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

The remaining sx93xx fixes, grouped by driver.

1: sx_common: a raw read can return on a stale completion (left by an
   interrupted read, or by conversions while another device uses the
   sensor's trigger), and it then turns off the CONVDONE interrupt the
   trigger depends on.
2, 5: sx9324/sx9360 write_thresh() lowers the threshold by one register
   value when the value just read from an odd register value is
   written back, and lets some negative values through.
3, 6: sx9324/sx9360 write_hysteresis() turns negative values into the
   largest hysteresis.
4: sx9360 gain encoding, as in Semtech's own SX9360 driver and as
   sx9324 got in 108e4d4de2b5.

Changes in v3:
- 2: assign reg after the last validation, right before the guard()
  (Andy)
- Rebase on the current iio testing
- The negative value checks still test _val before the conversion
  (Andy: "the original < 0 check might be cleaner"); happy to switch
  all four to val > INT_MAX if preferred.

v2: https://lore.kernel.org/all/20261122074649.239441-1-kapoorarnav43@gmail.com/
v1: https://lore.kernel.org/all/20261116205320.26070-1-kapoorarnav43@gmail.com/

The threshold change was checked against a userspace copy of both
conversions for every val from 0 to 65535: all 256 register values
round-trip, and every write picks the largest register value whose
reported threshold doesn't exceed the request.
Compile-tested only (W=1 for every patch, checkpatch --strict clean); I
don't have SX93xx hardware.

Arnav Kapoor (6):
  iio: proximity: sx_common: fix raw reads while the trigger is in use
  iio: proximity: sx9324: fix proximity threshold writes
  iio: proximity: sx9324: reject negative hysteresis values
  iio: proximity: sx9360: fix hardware gain encoding
  iio: proximity: sx9360: fix proximity threshold writes
  iio: proximity: sx9360: reject negative hysteresis values

 drivers/iio/proximity/sx9324.c    | 21 +++++++++++++----
 drivers/iio/proximity/sx9360.c    | 39 +++++++++++++++++++++++--------
 drivers/iio/proximity/sx_common.c | 25 +++++++++++++++-----
 3 files changed, 64 insertions(+), 21 deletions(-)


base-commit: 8b5d2dd3cf0edac5171f40ca3d2fe69fedeb10a2
-- 
2.53.0

