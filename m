Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024402D781B
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 05:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791695973; cv=none; b=lpESOV3KZvjmxLb9/XJPzWrQ9LRbL9EzFsE/pKtj9KAQaS0ioKNIAcVdCiR+L3JITVwptP8aYtD/UflqsPfhd3c/VeQtA3EH5nInryoBnhiZFs9Ob+b3W3+EEeqRq6ChWG1m9ClLHbWGbJpvBHJreRp8nesh6iz4YgvoaqKOcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791695973; c=relaxed/simple;
	bh=rMLJxJ8SnMqxXCZehmabyfHQqXJy/pxVRFCT9DNUloA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LbgDbTqwbx99X7tSL5zmp+mYEzdks2f3cCQmAnIQFrRAVHH67fkp6xhoveEleJQBC3JkQikQlUicGgRVEv6e9oGEOuG/IwkQYr8UySSKYqRopZ7BQafTif+jgeuhRKkwZdP/EjZRtNsd1Xtd+NxyGGADJfiCLPUo3bS+FZYBh8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4HV1E+X; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4HV1E+X"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-351767ef18cso3400561eec.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 22:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791695971; x=1792300771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eSdaIF5AoFzhQHRDv7nxKIsuYdrkXoDA2W4UfxebrhU=;
        b=L4HV1E+XJS4ytWzUKz1CEEQLOrGpQfdPEDBpK05cGZUouSIzL7PXfNf6HB3DGg1WIn
         eBhE1pjrn/aGcwPSbJENHp+/V2dQvr28LM5GvgAfMPi8MXn4DO2hrvKI3jRRGZ+NtsLj
         rd8qwZE19oFmrCR+mndj4QOg7Aj9b+hgfT9HeM1P/taKxArvHWp7lkyV4obdofgHV/DE
         pSftwaY2IbEGRxabCchR9CuLDkTY65qXc6EPpU2GZrauwEWVvaYO70j2yMRjU4Q1pSuS
         EkyO/JYvY/Wsrw0WKzoIrm8rpRd+Sz2WM3/MG/neGuP4h8kV8/aaFBIlFT/LZwLpaqTk
         ndOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791695971; x=1792300771;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eSdaIF5AoFzhQHRDv7nxKIsuYdrkXoDA2W4UfxebrhU=;
        b=Hez+erNnA3g8vaYzd1z4ZFQL1J/Eg+jpNA1SOEcp1SVdjMEAl4RA/VZECmW8n/RpVr
         cQqWGTKggWMmKt51ErCJuKFOG3UNR7BAh9g0A1I+aFf3xAnmJJIeviw6qsQ95dfKnpTG
         mNq+G/sIg+aHF973iWd5setwOPm6reQeA9h3/9msr/1iN/8sptnuGpQXCncGoJRi1DXg
         EPRJIFkFqvU2wABA4A7kV6CzdEL+U/ckC5x+Fku7vXcZA6PV1QQn0Y0WvQKVRJ1GkAZx
         9qHaUrltQsOLaCrONa/+glf4D1DWDUeDlkYVXFShv/wu/vWPObjpZ7IwHC2AmLU6N1qq
         vAyQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1S79MquQgmNh5sGfwEonZSzGacS3aGwGQobD6XhRIY4wYksyDiKobOjjckTfUbiv8o4favxjArWc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLipit0fgn3SALz/BFBceWHwf+ilNMA5svxGPAvQNdAuXtoPqtE
	HHcEZy8+M3sDnjHgcj5KLRidyW5n+BtTBRUZFmsqpk5bPtIW48d6nFdc
X-Gm-Gg: AYBFou1KCBMQIutrB6XCIRbHa5lZj6OymOOa6u1r1dsD6BxKjj8sg/LCCrJq7gyjDrV
	7Hxlw6lwB4APjGpuBSJ23wKZZST3qIHFD5NPO1cdmopiw/ehT9G1e9FC23GyRffZw64WtLaZS86
	TIjuXRB20bw6yGb81MqxSidHkHnS7kqZi4qgpBEQBBV69TemCU4I+4HHg57o/oyizhwfXOAKwBo
	F1yo7rUnBrFi9KC1D0hL7K3oakg4gz63IS0Ruvh+rx3mN2zmsBRkw66sap4ct0joGXxzMkmXGTU
	qd7u1HSVn2NGOX5ChmAC+tSQehDovSH0KhjDbgkkjEtvgOZslPo7U5+K/AxtI+TSSbFGmAbMrhz
	rjhgpj0XQ931Id+IebjK2IlTJvGo1zbEgF3FlpVHSImEEOyKcW04V7I/HMNazpJ4XRNMNJWJ8B3
	ZEzXzQRlOXTxRS2dcpprIGlVBtIMW5U1hcr1iPesmTA6HPrNXK4Vq/JxSsOPfIrQqLlw6G2aL4N
	MkekFJf9apU5Kv/hjZ5ErdwrygWQW/D+vR4UO0TDaMJ2ah7Ai5VWingOOQs5kvW5vIHZC7BRFaX
	V4mM10dnEhsHHZMFPTRY5w2iBfzRWLtQyGB4xCMXld7s2Wru//IdLCRcJFarWo1bQozg0FIj/vs
	9W1COKuFV4D/kD+yRzMJh/6YPBtg7qoIKgTY07rKqzkJhNp7DbkG9hquozHzoR5n7ow==
X-Received: by 2002:a05:7300:8806:b0:34e:9147:b862 with SMTP id 5a478bee46e88-3537e073ab1mr11321526eec.34.1791695970793;
        Sat, 10 Oct 2026 22:19:30 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358ee8a3387sm8502491eec.15.2026.10.10.22.19.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 22:19:30 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] iio: magnetometer: fix the register restore on resume in mmc35240 and mmc5633
Date: Sun, 11 Oct 2026 10:49:22 +0530
Message-ID: <20261011051924.60456-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resume callbacks of mmc35240 and mmc5633 call
regcache_sync_region() before they take the regmap out of cache-only
mode. Since v7.3-rc1 regmap refuses a sync in cache-only mode with a
WARN and -EINVAL (86fc3483a4d6 and afc8e3ee8307), so both drivers now
warn on every resume and no longer restore their control registers.

The kernel-doc added by 86fc3483a4d6 says that the caller has to
disable cache-only mode before the sync, so the two patches change the
order in the drivers.

The Fixes tags name the regcache commit, because that is where the
behaviour changed: the drivers have used this order since their resume
callbacks were added, and it worked until v7.2. Please tell me if you
would rather have the driver commits there.

I have no hardware for either chip. The patches were tested in qemu
with the drivers bound to an i2c-stub device and a suspend/resume
cycle through /sys/power/pm_test; the details are in the changelogs.
A scan of drivers/ and sound/ for other resume paths which sync before
leaving cache-only mode in the same function found only these two.

Based on mainline (a5ebb76233b7, v7.3-rc6+); the patches also apply
to next-20261009.

Shashank Mohan Jain (2):
  iio: magnetometer: mmc35240: leave cache-only mode before the cache
    sync
  iio: magnetometer: mmc5633: leave cache-only mode before the cache
    sync

 drivers/iio/magnetometer/mmc35240.c | 3 +--
 drivers/iio/magnetometer/mmc5633.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)


base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
-- 
2.43.0

