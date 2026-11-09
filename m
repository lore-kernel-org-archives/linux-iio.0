Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243189;
	b=aqBS56jTN8mE3wOnn1oyrX396eOLKyn+R0RKwmiKMyOvJr0P78gtag5J9hN7jul30cqt
	 4hs0SKeeaYXHyM1kopkgJnwTP1GYHa+V2B64D2sg+UoucVfsP3hETvfw0wqVO1C+SfwLv
	 sTs5DQLLyiq4DV+6qF4HrAa457ycahflMjy06bLgMHd+v0iEt98tTZrP04f5YtHEeLCYP
	 hsdbwugvhgdqc+PzBZe31djCK8ojSQ0V9K7U2O2mt4rHfPumVwQKKT8NgwOwbq5EcwPSZ
	 gVZeMkp52eAIpyX8XgMAgaQot5OeJfc6+RcEH+PWnlWLl4b8RA/lAYYMU4Sy/LdS7Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z7vOdYC1HqFK8JixxA84vEBBAbwDaoWom/YZ8hiImMk=;
	b=t7kVL3/0+zLlPiHN574jrjPI+RBIibsLupxfiv3L6p0qXTowVeJirtQdaLZOjwvxwfKq
	 D3zLXJ80pdfiaHhTGGhVlRIKrC536nn7E1DQsrjh9IDBa7WytbKj68F9wDevDoZqE2sgk
	 BfyIMrYUyix8av8Ep6wjyg2VdA0r8xdG2mfUjTGKgU0t1vE4bKTDGWU6ttX/2ki36Ejjf
	 xiBVMe35G/YaNAgyz3+wdMI8x3UjsIfnivqvUc+iIRjB/RWY0cJwZjhofM7WgBSvoY4QT
	 veDYrdd6nzmQV8/gcypwjmdwtClkBDfGVK9/IxuJQvMIhto9cVwKKm4ppaGJ4iWJHDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPjpfpa3;
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3112606A333
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3112606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPjpfpa3
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso551391a91.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243188; x=1794847988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z7vOdYC1HqFK8JixxA84vEBBAbwDaoWom/YZ8hiImMk=;
        b=TPjpfpa3a4JgJaOvtDHt5n8VroAk7b3Y1sSBp7zORaF6eQZt6aofksUZ6jVxk7dUQ2
         nZJbathGaa3Paf8pNkn4BS2iweMyUm/4KEAh/3phM1Xc88scV9XchMReJPvCpgqHij6/
         vdi3SE83aFnnpcxHZZsqwgu+WG5JuWULDTNb42iIipydm43/pMLODFmjTUZfNO0jcVsW
         phGLaZDxPpNXMyl0Sx0eFXiYsw/3zRJMCTYmSkMXRnBO+t19AiHDG4NSTIa6s/19kZkT
         +VeGb4uBfwMf7UiTsF09uMAC/ETbhfwmj8qp/wZ4nw8I+rX6XDplelwj3+2nLoQnMZn/
         vt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243188; x=1794847988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7vOdYC1HqFK8JixxA84vEBBAbwDaoWom/YZ8hiImMk=;
        b=rOxN9cRkNDmhAaRMKjg0iIZqJih8Bs4kR90e1Ar6tcaG+3G0YuR3+puFr4rGlaPCpw
         j1OzWdayq7xO/I6WBP0+c70WjbYJn6IFwbMpEUlz8vQ+kmj6kJJi8KW4COHF/3Ac2mJT
         Uy0+5um38A0SOsIdGzwIQmj8XwraRBAErVFHZWikHbzQA+loxZIuGLPDG+Hr1i5ezLyq
         MM3rPwsVTY66/ncWmnn1VFPVpcDKDtZy6MGvJXGa5eOv7NzyaS9cbeOI6YzHRLCmNBdI
         vFTYAYRMKSsgucZmWCMXGmeoI++G1RuiIaDEgEtAltG1/AQ+vvJYNxk4LldcdRijdx0x
         t6KA==
X-Forwarded-Encrypted: i=1; AL+hErHGDZm1D7FaIeRcAF88MVqpvxAjRTlrdLhrD3xIoDRmugSPHPkacmltKthpre8TitE3v3sPe6d2KMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8pQahVG2WObYzFoPC1MF8jUgIy/duLvxWDydJ13H1iCuvuaVps
	MrymK3MQpd8L4gpJOlSv/S39rDnAorDOF2Q5MRQD7U9m79Q3TYhoAckJbaVZtCBx
X-Gm-Gg: AYBFou04f6qrfwAM5q5ppRTrL2yE7WjnGLEarModEjn5bicRNrs3hh2uVmgPRziSUq+
	8XVScu5K/z3r+jrWJBXLRcbMCB+K9PaZPJoV+UpKgkcjdGdEypqHtI5+9N7dD0NdGKLsC/k8AUD
	zZm5wE88/DQpltbKuel/7A26cDLm1fFCzKtFNt19e24mMY2FDcAh9Q7krEFMsyRI9wSJcEU9vin
	B/BGpnFJSRiMbP+KtdDYxsD5uPm9OgHFQla+7lOXGVMtmXVmjFLetQUdQ+1vYPCUe1QObI0QaPI
	LN633zJT1zptDi/XW2mPsv7MbiomWCZPWKOc4hcGnkAOzl2d2nDxErDr4c21IxMibzil/Ip2Mzl
	tX3q1K+F1bWun6YunTdQe1Ui6tqZtzFmrFD2KBWFvkL2sP6ZklG0WGbF3yEih1mKfhLSanFFnFt
	zWg2L5jn2ir2ASG2RqhVmxZfnu6CI4tcedTIo8Ja+IYer92fNTrZXUhTKvlJhNo45SA26qDJt+v
	U/7QbcsH+s+RyhCdP5UiT3Aa9puG7GcsPfRiVRDg1B9Op4T+/CMWYPw/oY5yM9tnETj/5aDlYpZ
	U0xBSW+xCDgMtNnXhRsjC75sm4k1HsH2jlWRLvEz3ZdtoIEEFj0In0+OLKfStFlyWovPz+fyp7y
	bKe4V0F4hw5zvrWOo1P4vvQj8KQ==
X-Received: by 2002:a17:90b:4ac8:b0:3b0:9a1b:b709 with SMTP id 98e67ed59e1d1-3b166ce98e9mr249063a91.54.1794243187918;
        Mon, 09 Nov 2026 08:53:07 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm6455688a91.4.2026.11.09.08.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:53:05 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 00/11] iio: adc: ti-ads1015: modernize resource management and driver setup
Date: Mon,  9 Nov 2026 22:21:28 +0530
Message-Id: <20261109165139.30803-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
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

This series modernizes the ti-ads1015 driver by updating its runtime PM
handling, error handling, resource management, and register bitfield
operations.

This series builds on top of Stepan Ionichev's devm error path fix [1] and:

- Replaces SET_RUNTIME_PM_OPS() with DEFINE_RUNTIME_DEV_PM_OPS().
- Sorts the driver headers alphabetically.
- Returns -ENODATA when match data is missing.
- Uses a local device pointer in probe.
- Converts suitable error paths to dev_err_probe().
- Drops unnecessary '< 0' error checks for functions returning 0 or an
error.
- Converts mutex initialization to devm_mutex_init().
- Transitions runtime PM setup to devm_pm_runtime_set_active_enabled().
- Removes the unnecessary ads1015_set_power_state() helper and uses
runtime PM helpers directly at the call sites.
- Inlines the redundant ads1015_set_conv_mode() helper.
- Replaces custom shift macros with FIELD_PREP()/FIELD_GET().

[1] https://lore.kernel.org/all/20260529183708.17819-1-sozdayvek@gmail.com/

---

Changes in v6:
- Added a patch to remove the unnecessary ads1015_set_power_state() helper.
- Incorporated review feedback into the existing patches, including the FIELD_PREP()/FIELD_GET() conversion.

Changes in v5:
https://lore.kernel.org/linux-iio/20260827172100.39176-1-architanant5@gmail.com/

Archit Anant (11):
  iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
  iio: adc: ti-ads1015: Sort headers alphabetically
  iio: adc: ti-ads1015: use local device pointer in probe
  iio: adc: ti-ads1015: return -ENODATA when match data is missing
  iio: adc: ti-ads1015: use dev_err_probe() for error handling
  iio: adc: ti-ads1015: Remove ads1015_set_power_state()
  iio: adc: ti-ads1015: drop unneeded < 0 error checks
  iio: adc: ti-ads1015: use devm_mutex_init()
  iio: adc: ti-ads1015: use managed runtime PM setup
  iio: adc: ti-ads1015: inline ads1015_set_conv_mode()
  iio: adc: ti-ads1015: Replace custom shift macros with FIELD_PREP/GET

 drivers/iio/adc/ti-ads1015.c | 237 +++++++++++++++++------------------
 1 file changed, 115 insertions(+), 122 deletions(-)

-- 
2.39.5

