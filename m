Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795866714;
	b=LwVaojMwXlPL7h1K0vvlxsp60p1ycN8B0W5DP8sQ/htUtasO30G/nuT6omG7KHR+VRYj
	 PkWs2g+MVTeLHc6i2JIsiVR1rrAFr2bLzZwN4VMYGtj4WEBSYnJz3F4uH5WuWWk2jcRsy
	 2X/dcTxfP/NduSRn40O5pqJzPFSz3DBcj3wICh0WJkjsXwMRCnLD37qXzVXMp76NbIq35
	 Vr7kkRS5bGviZ0EW5+HC5ar2fw8eh0fV8gouGQkd96OGiOt8pTNRGjAKRQTaMgmOwrcC0
	 0doMO2jKrfqRizFsoPTpIHa8UDsB/q315yW1/BFH24oSINXUtbrEeSQSiX8j2gK/9Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795866714;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=liuG+zrcpJhh/5ym3HDAfZpu0y4pt1z67EI0PqPuM4w=;
	b=Q8XnJD2uiAyZ11sBZAWxOG0BWvfAztFfdVNy65EnDXLqf5kY5MYScseKNbhPN+bcI5+p
	 gazxeqe1ylBGGWj/md000gxwWeEJY0ohwn3ggR963xJ+0JbVNDpPxEw/EtvU5BfwitgSg
	 NJY+4bwXPtDh9IO4mz9n40nsmZN1KwrqrsrYyXsDnnpB5KK/dz9kT+vJGlRCVyP9Q+X3h
	 a62we7+8ctME/ZRtxCbHCq3W8s/BkXRxIiUClbSz+GLQmVU25643U3xzP9yFRDf+hrBnJ
	 cGKbhcGb4Lu6wJej7QRKzAbiUrK/4rI729BSWAN5cfw8lYmLIW2JuTrd+hlo8NHLLYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEdJrAdR;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A88606A323
	for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 11:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A88606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VEdJrAdR
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3866a784546so12410765eec.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2026 03:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795866713; x=1796471513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=liuG+zrcpJhh/5ym3HDAfZpu0y4pt1z67EI0PqPuM4w=;
        b=VEdJrAdRSXS3H0I1Ws6jxU8Dge8z/jhZUYUuTUXFwYpoBlWLfCiIv/UWxB6AZv3nSb
         nlZ/MQMJnq67bmMW5pn/I2FvfFpJfFkZVfH+U2Cd/y8eYwqDgptBdtbC6UZzeT1QXo+e
         PSjsxtg1Ei0iDQYrQQsUyoo8pn8wTFSAW2JmfvdHJAuaZATJZ37syRZpSzRByPiz1HJ6
         6S89ICdRevUVdA5dfQ/0GHgV0VVE7a7y8nvYWCc0kAfoakkQMf010ibl1tTIhmvauq6j
         knFkH9nuKp300MKEuOhLGOYhDtE+B7nVwM+6e2Et8QRDhlv6KqFjYLF4Im2cOPuZwYAc
         R/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795866713; x=1796471513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=liuG+zrcpJhh/5ym3HDAfZpu0y4pt1z67EI0PqPuM4w=;
        b=JokGnLRz2QljHbUQsQ+0dmaKy1jSy+iWmwIXpDkf2R+iN9bSWmG/M+KVsX/bALZNtI
         6Fy6zA8SV0e3cmnkg+ci9u9SgKyTUqfn5m1gqigv91y4xLlgW6zY50DcP/8dznzV10ft
         JFq7dgWHPckPaPiySXuGKtmLX4HCc1etaDWZrEwdN9phZrT8sc99enD8g2kPLhp9ZWLi
         YsOQoFJ6cYXVLHx1HmaiNlAySvZ64LvbwM/MPbTqB45ZRPkHOWXTk6/PdFK7N4I+pAzR
         qNzfjqEQoYipsICkN8G4zWi+mEJ4p/tBq7TaPPqWG0j1P/m2L1PNOxf3EP8HOP5kscwN
         mV/Q==
X-Forwarded-Encrypted: i=1; AL+hErFtvZafoXzWgxDVOYkOyK0kDvHdBdi84tF+AkqZVLWstHAmve3b9U0px8M9deykNYtHTlCxcLY9lvk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DlOBut8WhPPqFAcz9I5rRVCQD6HAjvDqs2hFrQxM2EuZ94QmM
	8PCUUCpVdUhlwSSUZY41QEW9AaQu0M8Zy1uRgDD+ydaaL95xJLPzObiT
X-Gm-Gg: AZFdTZeNimAGA1nwjktNRqIoR1xxJidPXt0ZzCuYJqFuCHRTtr03qokw1VGdKVrtE6i
	OwQtxN1bQmHvNdD2z1DMehfWyQC2KZ6zfrI4yQRg0hxsfbyrX/eCkByDpb6L8hZnv/TBJHkAZA8
	Dq9mggC6D5wc4SvjGf32RKJl0REeehPuOTnU4fq0g2pju2guPmlJfCSlrt8mVONCmxrM8JwV2ze
	G3LWc6ZpxzvgoCKvg3wnIsa+/hcKC+vnTIgi+tCgXNzTVOYhHCqfkRedzJHuTcsPCeMuRCkhHBc
	2qIIj5vHK3rmQ/A88X02QjGTosFI4QLNBYjKHjlvVdCm+n7UmeKi51tkItd1w4Dn6OLrHlFsNi3
	6iuzWBnRjsXRNBoAv9Z6inowelkOjwXUb7xQmsT+Mx2fTBvC4XMmGtiRYwp+UAtw9X44edpZkX4
	wM/TrILi/qxFeFFt81q6DvjD9sDBoRfSaL9SJ5HqQOeKQHaiBfIPTz1/ohwfYaB0IQOmJkfWBfu
	kJhnnG2YC/k1+Dqmxt7zLzt1slZ/kUq7wtxONEu2neoQxFTk+7GZ9UiYkE5XvAlwkojfH0cHh8Y
	o6MOVZxRCQdUxZi0v1tKnqe05ACWBmTzJLbZDqeF/2mlrxuuk+bF3irjM3C0UP3c/7f3HPZvtTB
	8NbnE3DBS8WuT6zihSxqCyTFd5/EUD0QsMnlxh1ta/dyoNdDWPriOZMrptQPJhRQUXy6onERO9D
	VpGt9dEJ0qIBe3dVch6fg3ad/CdqTVg8QZAFOdNkpypw==
X-Received: by 2002:a05:7301:6908:b0:382:f0d4:1e77 with SMTP id 5a478bee46e88-38571219f03mr27167572eec.36.1795866713303;
        Sat, 28 Nov 2026 03:51:53 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm74256544eec.20.2026.11.28.03.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 03:51:52 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 0/4] iio: proximity: aw96103: fix diff sign, missing config, async config lifetime and event values
Date: Sat, 28 Nov 2026 17:21:37 +0530
Message-ID: <20261128115144.557411-1-kapoorarnav43@gmail.com>
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
   aw_sar driver), but are divided as unsigned, so negative diffs read
   back as about 4 million.
2: without aw96103_0.bin the driver never loads its built-in defaults,
   so the scan and the interrupts are never enabled.
3: nothing waits for the request_firmware_nowait() callback, which
   uses the devm-allocated driver data; a probe failure after the
   request (e.g. no interrupt) or an early unbind frees it first.
4: out-of-range debounce and hysteresis values are masked into their
   2-bit fields instead of being rejected.

Changes in v2:
- 1: declare data as unsigned int (the regmap_read() type) and keep the
  (int) cast, now before the division (Andy)
- 4: kept the explicit range check rather than FIELD_FIT() (Jonathan):
  on 32-bit, FIELD_FIT() shifts the value in a 32-bit unsigned long, so
  high bits fall off and e.g. 16777216 or INT_MIN pass as fitting the
  OUTDEB field and are written as 0 (1020 such int values for
  GENMASK(9, 8), 16380 for GENMASK(13, 12)); on 64-bit it is exact.
- Dropped the Cc to Wang Shuaijie: the MAINTAINERS address bounces
  (554, recipient doesn't exist).

v1: https://lore.kernel.org/all/20261126053033.603086-1-kapoorarnav43@gmail.com/

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

 drivers/iio/proximity/aw96103.c | 43 +++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 8 deletions(-)


base-commit: 69bf7489f01ffa3c3269d09eb8a0668b1bdfa053
-- 
2.53.0

