Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795333620;
	b=uceMCODn0biAfTKVqFSXgf+hrlTTwrAykV26pLBB6ol9N5IOq1Q9NM4H8xTYEr9gyvyB
	 9YV4EjHEuquPSKgwqgnKizTkVyvX4OSuW7M1XDBqsDt+EkxgnGgctSs960y4kQVlYfkDP
	 LfG55xnSLTO/ZxYwbMR40y+OpcsNSdWS2RguBpzaP5XlPztGw9jUeC3t0b/94YUzrC8O/
	 ihVH2vYg98geIOnNfhWEj8ktdGcKLKvINOa+ZLC0kn++haAXDIsnamK2DHpTmwMG5IZZe
	 isNB6OHcHMlYJbTT4qSejtUj2iHbq97OBu+eTU6CcqxlXGdLwq02lnxO5pLmEVwicMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795333620;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TMhXNQvSk1ZT1vxyOMFjrXM7IipagBQQHRtItyPgUsI=;
	b=PykpI19hvIgmGpJWuL6GpHG38TApenYia7P2pSfmhUBwjNhk1ePwQ1qSBAtlc4m2i5M5
	 saCDGWaOfkFPb/0UQ54uczPwmUnYlLXUfiTMF3rrk8RP7KRcFVA/fXM7bv4fWroymzXFa
	 5UVDMt7idAfyxV4Pmv9WmP1uv4lKccZ1hUq1rX0g4yz0vtY2PwQ1iuJ/h2VqAAQx5KEm9
	 p5W8Z2Mr8cPbRhQNixUnqFATmydErpLQgEbILg/g94R9pGmp6/KdB6ItZJ9+OD3Uw3/i0
	 JXcg9XKdaTaDykdVX658pfuTR353214dx5/6llXQ26A7ToFud4mJwNzUV4OiRe0+yvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iFsohZYl;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412DF606A320
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 07:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 412DF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iFsohZYl
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386ab9ab619so214513eec.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 23:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795333619; x=1795938419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TMhXNQvSk1ZT1vxyOMFjrXM7IipagBQQHRtItyPgUsI=;
        b=iFsohZYlRDBl+bsZdG33YJfLJmQLCNGocWJGiaA0HfuIUp/DT4/bbdmPStil+7F2yL
         44hqNK/+BBWJBwGmwuIP93Re4btz43WbSOXxL4ZOrrISZYI3veZRb0NKzIGaOp7+bR8O
         w8JZprLA0/6+nTi87P1d6704Emt8hv9o3+Xmfo1QsWeLIFVvt+kx94FuYU8pmZ0h2yot
         uU9nO5mCANWGG2hSoIYJZJ0ckOe6M2o4D57pWKJtazF7BXbAiaO31AufgXWyVi0cqFVu
         cof7RpfpB9P87bOfih8QU2cyMn8kDENJfgdcL1D849Rg+R0QjwSIlsX7cROCNfLSupL5
         3zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795333619; x=1795938419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TMhXNQvSk1ZT1vxyOMFjrXM7IipagBQQHRtItyPgUsI=;
        b=dmhMWeRSEoGR/SWZ2CYD+BMjn+cuhVIwV8U8IF91tyFpvw/IBj6dzh0weMDTlvyxHz
         5vp3XVjZ0ijBQkkhgB5k9LEaMrFZSOslqlyOEdu+YF4EO8dNNS0Yjc6rGBuLe2SB6QRR
         uBouY9q6fP/EGXlFhOIMxq5wIEWOqP6H/xhqieKOPoP34+II/1qFqflcFLqLiYx8V329
         KVG0mqrGFeXnDTW7pWHe6sO2RDt4mduElxpX+IZ1REC5BfoV3Pxif7+xMu0tcEUD4T/s
         hC4E2BNBjFlO1cgttFkhXvDxj8c6RMuJY4bRVcDQEFYRYfHac2L2OuFRwlkjZWa7Qt6t
         9Acw==
X-Forwarded-Encrypted: i=1; AL+hErF557k2qd1k4/CFwqApCnWFQeT6XtzBOG7HJpkXZa6OzwMXELQx3JKZJMPD87EVFTGk0BFjbNJyw8U=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wM1H/AiUJGyjJyTLVRhcWgXOJyHqd+u1fcCUx3iWIGX9ZeQiW
	Lp379zqR6Y4xA94ICfTrckNELWGsyT0M1Umke2bbwsKFsdh0bF5k51Po
X-Gm-Gg: AZFdTZeY4kKkfeqih5+X0Gq8c5S/mucCtvzHx6/tkUTvA+mFH/fPUvCsc188BdiimIw
	WC4FiWuUG3ub1wQ7MFPjwEsKX/hT4JAP9qzmWo0DI4WT01YTVCtEDbV1Dvx37134tqQkLx+T9CI
	bhBZtSCD+xvG5hpB48MSM+MGV3xoKm15EZA7Ri28wuMaKuqXY1hHaK1gXPOCmfbxrrbp/Bf5iCp
	fbLD/tHO3CXWCjWI1BY4TTQTQeEWp31UDx6aPOS53XFyl4yIeMS+xgWwWZoCrevw0LNo+poQBpI
	uuNnfNzRAP+7dCtPi/NQqgyGQ/6u4ON595g5/Uzqr1BIypISE1a+j3wu3iF7Gp6DwZLzpq6PR6Q
	/fIPrBa+ol7aAOeZuz/3i5DXJxvARSGGLQgYvM7NuJMHpEgnV+Ki1iUZcxbvwcBwKiU1ud1Fc+3
	+6r58E3/5Bfp0F20b78mM2QpE1LpW6MkmPyuVdCljScmwoqo6kB7I2EzsAAV3Cmp2ltIUIPVoY0
	b3FnFuDeZjGIfFRTF68IkP0PQwP4ychmUN8kJRJ4KATmvefs74+l4LQFTgcdTPX8uAhqGcFZmXT
	75UIa4zNsGilczL/BmNttR0Pw9UcrNfktBdXlo5McIJmToqLv+7UM0m5IUAEldpVQDBRdt4fHlS
	Jr/O+khEd5pLHsxAlVZ9zO2vD8LmZCsEXiSzA+HGucy//xO5UvlC9ILLrS0waXPfjjKtABzG0cO
	JIQ1pxD68xKTwRxqsEKgQCZ7puR2+ar9A1Lr91AWW71A==
X-Received: by 2002:a05:693c:6010:b0:385:849b:7899 with SMTP id 5a478bee46e88-385849b7adamr9485945eec.4.1795333619120;
        Sat, 21 Nov 2026 23:46:59 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385667decc2sm24898071eec.9.2026.11.21.23.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 23:46:58 -0800 (PST)
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
Subject: [PATCH v2 0/6] iio: proximity: sx93xx: fix raw reads, thresholds, hysteresis and gain
Date: Sun, 22 Nov 2026 13:16:40 +0530
Message-ID: <20261122074649.239441-1-kapoorarnav43@gmail.com>
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

Changes in v2:
- Rebase on the current iio testing, which now has all the patches v1
  depended on
- 2, 5: check _val before it is used, and before reg is assigned;
  val > 1 instead of val >= 1 (Andy)
- 2, 5: commit message rewritten as agreed with Andy: drop the
  (r * r - 1) / 2 formula, explain why int_sqrt(2 * val + 1) is right
  in integer arithmetic, and say that the negative value wrap happens
  on both 32-bit and 64-bit
- 3, 6: check _val before it is used (Andy); say in the commit message
  that it happens on both 32-bit and 64-bit (Andy)

v1: https://lore.kernel.org/all/20261116205320.26070-1-kapoorarnav43@gmail.com/

The threshold change was checked against a userspace copy of both
conversions for every val from 0 to 65535: all 256 register values
round-trip, and every write picks the largest register value whose
reported threshold doesn't exceed the request.
Compile-tested only (W=1, checkpatch --strict clean); I don't have
SX93xx hardware.

Arnav Kapoor (6):
  iio: proximity: sx_common: fix raw reads while the trigger is in use
  iio: proximity: sx9324: fix proximity threshold writes
  iio: proximity: sx9324: reject negative hysteresis values
  iio: proximity: sx9360: fix hardware gain encoding
  iio: proximity: sx9360: fix proximity threshold writes
  iio: proximity: sx9360: reject negative hysteresis values

 drivers/iio/proximity/sx9324.c    | 18 ++++++++++----
 drivers/iio/proximity/sx9360.c    | 39 +++++++++++++++++++++++--------
 drivers/iio/proximity/sx_common.c | 25 +++++++++++++++-----
 3 files changed, 62 insertions(+), 20 deletions(-)


base-commit: 42d25ad999bd60b96b227c2e54391c82cb03d00d
-- 
2.53.0

