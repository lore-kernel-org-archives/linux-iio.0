Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1A83E3D91
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060596; cv=none; b=SKWmO+eDAOGInAKpqqmiLSLy+GehydfwZWAee6Q8AEbU7kOygtAuTNAdo9bBWql1EatoKROt2eTt2sqh/8HfzEZT/tm4NlujASfUQtTppWE6UP6PBYQ1V2Nw2qHbgGnep9XldsHyp1gI0chPPbIylUMomc5BrIfae6tadw+VCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060596; c=relaxed/simple;
	bh=Nv1xwcnvyqjs7pqTcxQ4zpMubfy5AOP7O2MfpHqK5jw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qxfG1OPh9TEhizWe1fLUG6b+O3NMaS08g4oBTa0bCHM/ia3HFwP7VI6GRZfsp809EAl5Srpy8GQZSfrllMC/Dic4sGKerBy1j9C/AQ63BJrB8s6HMU64J1K0Cj1WdtL+YQVhXU8dqQbXh2J84k1UJyO88zzWHXQ3kYs63BAAwOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXh1VEKP; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXh1VEKP"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44ce78ab5feso3212457f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060594; x=1778665394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAOl0kR6W7sAznR0JiC5Bm1rQ3NPZN/T/tRfS2z1WJo=;
        b=oXh1VEKPEMf/S0c+WlHTYYQOw5wHAl4UoSDwFt+k7JPAFm53G2lC8pkRf+CFI7Svph
         nZ4kR9OrkOeJNQ1eYt1NuT71tRhSLR5l18WMYzBN3PzmTBkoOP12jhZazlQDN1untb/q
         yd5yavzWRrkmQgBeIGVP1e5pNFfV5igp2wEojbzokDM42GKf4e+JMfWYMv7+5VaLMwqO
         6v/GL+ELEzyKNLL2XIBsaML1fW/OQOs0B+9DXEaLqfvfnQumngJVYVUTFkg22vjQLz/p
         /QgEG3HoCnFI56QvlYmNUiA7pdHjyAPLLBbVw0bhHz3OK16+XUFwUavhQOGUNccc4/FE
         CHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060594; x=1778665394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAOl0kR6W7sAznR0JiC5Bm1rQ3NPZN/T/tRfS2z1WJo=;
        b=pe8WCTGz/aeNXuVBL/YSH9W6Cg6PSUDKy+gaxVq5WsRiSyuwuITUc5IYtgz8RCW8kY
         ES//xCj7xkQj7pH0y1zlsYL1ofNjBiv4S3XCv9NaH/begpWuZCCH5L/dos7TRQBPSQ4H
         mR5caD81hN1+qVYKuDXcvyIz4XVpgce0jI+HOOpOFk/Zqi8Cl8EBGJUni3HLEdU50P6M
         Rbp943Z8PISXWo8ioOZUCpMa4FqOzfKYe64Klq2oJh57AnP8ypY7D0HaNwbed3lp29ka
         8dtYjyMGH9MkOFnYkTnfv4/VyCtSuNRn39J1locW2VejdNwkCXVPohKRgwAcp5MAmODo
         Pu+Q==
X-Forwarded-Encrypted: i=1; AFNElJ97USVN8EHePc1lbpkhH+M2tMvnP8zV/4gwYdUNlUvZQyhxcjwYyIO+qfiJzVPTFu3MiCbfAK9G4i0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO/AHbDg8OD/kdiqeiAlbl0rH1HOcJOLGihHU7N8tKjknKMlZg
	zam+p2Tfkua5TGxow4BUsdCQzw7W071jCoqnmL4FGTXkG3u4HtSotKzrhDRU5g==
X-Gm-Gg: AeBDieuJdeSjLB+c8zROBOKzPQM/iSN/Xs9Pj/w8dpd8CC5lMQKzkDce1kK2AiC7dId
	pjsEVlvF813XrRpc6NFd6CdC0xK0RpsncNZ2BZbRqt8uZuZC1rGZgGjUpcaVBgMm5St0p0cf7Hv
	MIowlclQ7kFKBwgHLgjLXmN0GZWk5j1lGMJcjQHcUDpyl9poUU7ZB0UaEqjtAQaBTQWYXIhPlN8
	nzl6SXUZ+k1ViIupc/BIhZtH2r0qEmNcs32R5f5mxdnsS4prOSek4wG3udhpVYTQlhp5onsN2X0
	Drz8NWak9MCVo+AbqTqeva+44Gs8kCGg+vrhuKZkCJ8kfUA6QNnQaQ6PN9NfZa0TJv+O6aqNKRC
	mupJeqKrWuCLpQSC0k+fOo5o3jWjD+1bg3JMI8EZbDIyMiP6ZMosLwb/JnldGdvrOmri/EO4Ggi
	xY+Y4Ku4ZJg86T52uuHIlx2+UFexgsvcJzrNcP0k6DuITuPivpM5LJrwwTskzOaUg=
X-Received: by 2002:a05:6000:2211:b0:43d:76d8:5794 with SMTP id ffacd0b85a97d-4515da95cbdmr4328563f8f.36.1778060593646;
        Wed, 06 May 2026 02:43:13 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-450524831cdsm12362230f8f.5.2026.05.06.02.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 02:43:13 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH 0/3] iio: light: tcs3472: devm conversion, wait time, locking cleanup
Date: Wed,  6 May 2026 11:43:08 +0200
Message-ID: <20260506094311.222500-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series of changes modernizes the tcs3472 driver by completing the
devm conversion and updating the locking style to use an automatic
guard (mutex). Furthermore, it implement control of the WAIT state,
resolving a TODO.

Patch1: Converts the driver to use device-managed resource allocation.
This removes the need for an explicit remove() callback, since cleanup
is now handled automatically. It also adds a new function called
tcs3472_powerdown_action() that powers down the chip when the driver is 
unloaded, removed or when probe fails after the chip has been enabled.

Patch2: adds support for the wait time resolving the old TODO comment.
The user can control the WTIME indirectly by writing to the
sampling_frequency attribute. Changing the sampling
frequency attribute results in a change to the wtime while preserving
the current integration time.
Similarly, if the user has previously set a sampling frequency and
then changes the integration time, the driver re-computes WTIME so the 
previous frequency is preserved. The patch also handles the deactivation
of wtime when the requested frequency is very high, as well as the
extension of wtime to its maximum values (by enabling the use of WLONG)
when the requested frequency is very low.

Patch3: converts the remaining mutex_lock()/mutex_unlock() pairs to
guard(mutex).

All patches have been tested on a Raspberry Pi 3B with a TCS3472
connected to I2C-1 at address 0x29. Sampling frequency and integration
time changes have been exercised checking the value of WTIME and
consequently WEN and WLONG. Raw RGBC reads, calibscale, integration_time
and threshold events continue to work as before.

Aldo Conte (3):
  iio: light: tcs3472: use devm for resource management
  iio: light: tcs3472: implement wait time and sampling frequency
  iio: light: tcs3472: Use guard(mutex)() family over manual locking

 drivers/iio/light/tcs3472.c | 287 ++++++++++++++++++++++++++----------
 1 file changed, 206 insertions(+), 81 deletions(-)

-- 
2.54.0

