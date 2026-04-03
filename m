Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172EA221D96
	for <linux-iio@vger.kernel.org>; Fri,  3 Apr 2026 08:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775203588; cv=none; b=HPBZuM41DaWpzlpXnUGHs7REbZMkz3hbpAhXN8WQaM1DU6W/vNnwW1sd8fZkw2RQFsxAjY/vYdDRWlaXHzPnhuGZYGVmCHZStj348ZHDhU+MpDSbwUriYuKv7Id57dF21sFBCYhjhXriqd1pJx4V02ckuO7386psdCkQBrqeDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775203588; c=relaxed/simple;
	bh=zwN0pITfJ3lXWhub6l+a/FFuVTrdHCz3d2uLlnjEChI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QufgggRwR9Q3V4SrIz/GX5LVbBCP4KJr3aMPP27qfrc7pslyxQ63hNNXSDu0yfxWuQYvgWx0MtyTLn4Vz9HxPiF0mSHLOTHSCWDz6mj3gXCXOAebLCpSCc+Ul6WSb0APeG32OSlNdMCI0zj1pUgN0oDOy4DEhngV8FClXk0CT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaT4WWdg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaT4WWdg"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so665109a12.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Apr 2026 01:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775203586; x=1775808386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hzTUcR1aoj1iRziUThqWuq2YXuaZb/N4OL64yRf40Lg=;
        b=MaT4WWdgMbwHiy+XPH4qxv3PxlK2ZFAvZ/mKB1HclZNEdmW1U5BuBtVKMRGauh+ARV
         YurUPinzPmcMuWhOcKNk6W7HMGnJix20nsB8xWmKbsrpX3ovMuLepTzLmjqjGsgHL9ka
         2iFQMO+5s9iobDJflNEB5p/1+bki3xNyHyXx2XVmOuyc0kt8fSv/fhPOFzvwpOIA7KBD
         3YsPvdy2Ufvmvefd7d2ju4B9xZ9A/pCAgNyAlyZ9agbg/C5QVZAaVkDJx647sMHTdoLG
         0Vs/3gnSVmaIcGPctRAWBE6wRurCzpJnaCbHGfUIuTbuV9uYVSMZGOXTS9gYrcgavwqW
         5/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775203586; x=1775808386;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzTUcR1aoj1iRziUThqWuq2YXuaZb/N4OL64yRf40Lg=;
        b=IYyPvkL9TFXVoInPLBEtnhBch9ffRzttu89NvMu/Pv/ED4P4NXkGJ1Rs7LtBYfzVUE
         wv1OcSqLCsERmn74EW+GLrb9F8ow2CW4y2x8s+RrY8ljVkTAT+psfo5SsTYCDI6KYHqi
         lBVCMoU3bC4c4zB8h4LzPyoDGGCBpfaSo2SUBQl48rFlRb0v6cHqTK75Z6jrcoN7NbI6
         NXlpiz2Uu1VEqH9EOaBINxiRixznzQSUvbtIY7f48I3fT9SAlL4laoLDqNYi8NlhwfJf
         pHzC+gVDgoXNuuaPEMzelLva4Iip6dOY37cMWz5U0MfcBtam25rtw9I/pBI277DeAL42
         3uLg==
X-Forwarded-Encrypted: i=1; AJvYcCUO9UMo4yNsngvpk2+TVLiDNFwob9ZwU0w3Qiu/jm+qZBE+J3cYd1umCqogprBCBSLGwphpButrO28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIywL6KSxYitSz/cQcteglpvrXCZC2kxfl84iE1Mcxo/RIbKI9
	F0JL2PYdQA2OMonYEEtr0CrSnpCoqzI+BAor/oEWzy2oxA902fDNOHH2
X-Gm-Gg: ATEYQzyBVNmMTO3Aru8nBpH/dl7zf6ICUIDs4VnneD1zGIJb3VUdymfyAIibKCsSivy
	zn7h0gDKDOHRit4RX1mDMYRQrY0cB+HY9jzlvCdHJsME3ZtVNNV+17ZBgch/Ee0nGtHWjZM5y7A
	+EXu6sfgLg9ss5aj3kxlfQ+aIlQvpAV7g8wuVQPbs/BTJsQXggET3IWDbnJ5N6IMkwu9kEwee/Q
	SiLcigDls7hVSfAueFu8t4cxFYIuc8srSHczvXu70hczPvJv/m6r9SvtOCvOVn1C9yer86IvoQd
	Rha+eMBWJKm2lRFCeVpyACEbz301GIItLGStF4NJSCALY94gYw2hpc20JnYrLv2VxZL06GOO3O8
	ulM3gWjNfqzb5YHpYIYWrbMoBZwItyC6spMqydVP88B3IhM7QUJvw6V7bnXew1ImyqrNYre5Li2
	5MlFM8Oswn7s/ct0uGP2bbxpxByyzkKMRW8l9sV9HiU0IKJSJuF0zNoAqz8KZLhwSjdxBVixL6s
	A==
X-Received: by 2002:a05:6a21:6d9f:b0:39b:e837:5565 with SMTP id adf61e73a8af0-39f2f139280mr2236533637.28.1775203586235;
        Fri, 03 Apr 2026 01:06:26 -0700 (PDT)
Received: from debian.ari ([152.58.181.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ad8asm5481093b3a.40.2026.04.03.01.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 01:06:25 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v7 0/5] iio: adc: ad799x: modernize resource management
Date: Fri,  3 Apr 2026 13:36:09 +0530
Message-Id: <20260403080614.14213-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ad799x driver by converting resource 
management to the devm_ infrastructure. This results in cleaner 
probe error handling, the removal of the ad799x_remove() function, 
and improved overall code maintainability and safety.

Key changes in this series include:
- A prerequisite cleanup to sort headers alphabetically.
- Static allocation of the rx_buf using IIO_DECLARE_BUFFER_WITH_TS()
  to avoid dynamic memory leaks during scan mode updates.
- Caching of VCC and VREF regulator voltages during probe() to 
  optimize read_raw() performance and simplify power management logic.
- Migration of regulators and mutex initialization to device-managed 
  resources (devm).
- Fixing a potential race condition by moving mutex initialization 
  before IRQ registration.
- Removal of the manual ad799x_remove() function and all goto-based 
  error cleanup labels in ad799x_probe().

These changes ensure the teardown sequence is always correct, 
following the reverse order of allocation, and remove unnecessary 
boilerplate code from the driver.

Changes in v7:
- Added a prerequisite patch (Patch 1/5) to sort the header includes
  alphabetically as requested by Andy Shevchenko.
- Moved devm_mutex_init() to the very beginning of probe() (before IRQ
  request) to prevent a race condition where an interrupt could fire
  and attempt to take an uninitialized lock.

Changes in v6:
- Addressed style feedback from Andy Shevchenko: used '(MICRO / MILLI)'
  for clearer unit conversion and refactored the optional VREF error
  path for better readability.
- Removed the phrase "Reading the regulator voltage via
  regulator_get_voltage() can be a slow operation" from the commit
  message of patch 3/4 as requested by Jonathan Cameron.
- Confirmed with maintainers that the devm_add_action_or_reset() pattern
  must remain to preserve PM functionality.

Changes in v5:
- Used devm_add_action_or_reset() for regulator disabling instead of
  devm_regulator_get_enable_read_voltage() as suggested by Jonathan 
  Cameron. This was necessary to preserve the regulator pointers (st->reg 
  and st->vref) required by the driver's suspend/resume power management 
  callbacks.
- Simplified voltage caching to use a single 'vref_uV' variable.
- Converted mutex_init() to devm_mutex_init().
- Resolved error path ordering issues by using devm_* exclusively, 
  allowing for the complete removal of the ad799x_remove() function.

Changes in v4:
- Simplified voltage caching to use a single 'vref_uV' variable as
suggested by David Lechner.
- Capitalized 'uV' in variable names as suggested by Andy Shevchenko.
- Removed redundant 'if (ret < 0)' check in read_raw() (dead check).
- Used devm_mutex_init() to replace manual mutex handling.
- Introduced a local 'dev' pointer in probe() to simplify function calls.
- Switched to IIO_DECLARE_BUFFER_WITH_TS() for the buffer declaration.
- Moved goto removals into the respective patches where devm conversion
occurs.

Changes in v3:
- Split the monolithic v2 patch into 4 logical commits as requested by
  Andy Shevchenko.

Changes in v2:
- Eliminated dynamic buffer allocation (feedback from David Lechner).
- Cached voltages to prevent devm/manual ordering hazards (feedback 
  from Jonathan Cameron).

Archit Anant (5):
  iio: adc: ad799x: sort headers alphabetically
  iio: adc: ad799x: use local device pointer in probe
  iio: adc: ad799x: use a static buffer for scan data
  iio: adc: ad799x: cache regulator voltages during probe
  iio: adc: ad799x: convert to fully managed resources and drop remove()

 drivers/iio/adc/ad799x.c | 132 ++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 70 deletions(-)

-- 
2.39.5

