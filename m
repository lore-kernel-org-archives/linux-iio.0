Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371B13A5442
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778625140; cv=none; b=q+v7udAsFRqKbXR0/oQboBG6g4NkmkQpJwKWx8ITAHHMdwduJRcxJ/HEsNgZU0n2riZsgDfMk6JG6UQ6q4aC9/exak5paSJXZhmiMSledq5mJgHkJ0AOucR2aIIiXcfH5DWKS3JmbNEN2ene/stjDJg0ZYdlQhOhN34gQZmyt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778625140; c=relaxed/simple;
	bh=NzPSdUf6T+ORUNm6PzVWnjy3jXA+qpDxvB4jvR8BSlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdTinMkTfCzwwK7OAot5y9s0jstPlMkkTEIAj6q4Ox6gfjFNG9XiNMUQulOKusjCurdWR+IedX8Ydj6J8pFWn2OYD8M5/Zdz3fAmEwtK+v6M7EISdojjBfDuvW0+0/ccowWiqZQG8mnDQ8rpOdoehZQuSfFasBsZ5bxCZ6Jvcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5ZRjnOw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5ZRjnOw"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so41507195e9.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778625138; x=1779229938; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gld2CLWnRnPqjxg7OzSmNjNiyBF8uhbwEKKeGB5tZE0=;
        b=C5ZRjnOwaHjt2IrNdvcZwuH/dWpi2qeYpA82LUV2AbhVqp6uwu5qS7Qi0IeH6fDu0j
         YHlKBSWA18/GgAtQAhEfh9EfrWekYMcvlx7Q+QpyNbqIEOaQOnRvCvSesq2viYvxD01W
         XTSGINWoZUnlVKlQB8BG0LR9Yokh7fmWpxj/Og7qv8aYEY1m1Wy9AbIrIUMP9IbLQ5Qk
         ADgrONyQEkAcagFaw+2I6WAgecNkchKvXExpfqLhyWH1s08iT2Upu5WjddxUUwX6xkmJ
         s+g/yaZ/4gcwuPE1jyahBIZDETk/0AFQIxUoJI190cFz+qrG/bYKHeawghKZxivwQbjk
         vT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778625138; x=1779229938;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gld2CLWnRnPqjxg7OzSmNjNiyBF8uhbwEKKeGB5tZE0=;
        b=mNqnnAkDxZd/GXi9AuAmGAl+w3l6f4XZKIHqOUSN39X07JjLuVoYyiqyIcEpTjXs2c
         VDxOZH58KrI15rV4q/6fCdhSJbSvk7Xth8WP7mmWu+ybNTm9b6ZYnUx0+d27F3NyfXbi
         pxyaCVjbA7DRRdXLUuXt0Swb2zhS2AYmiNtyGT2IDLJdSwO+11ucYvFUU7CnMmQqDVs3
         UQtGkVecUZ+Jfl37HGeE7tkS8htwI09IRS4HjLgu+n0h/pdYx9cQcAzkNZ95fb9z3wIM
         835wrD4OXNlX55DCW2nlCep3uY1A0mRDonG4OvqLyVx30wcs8NWTZopl967ZbH7BJ4a2
         1qNg==
X-Forwarded-Encrypted: i=1; AFNElJ9QAjGW21d2j7rO2A2prsoota3/NdMws3rD9x0qXO+Dgrf/4RPVE9pPkzBK07GoroOeS8mWIXy5bGU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBkGIENOO3pkdicWekSNPrY4YsQqwZh/16tvp81EpWOUeHtXv
	HZBqxN+4Qg17Fz86qB4JCgh2pVDy7gcds5xZ0zfNRYdg+Ls/3hNytLx2
X-Gm-Gg: Acq92OHVT+yNUyDeKRmBk8ms3eJ3Oauqv9zIwrL+KVw6PDtR8V9J8WM2pWy+AtFO+yl
	U9YZRonjocHAVuTh4JUQDV2WKPDRUzNoqlxD58USRuRvQ/X0TdljD2e/gRTYMD2UDYsJ/OryEcu
	bX44LoH3CjLcPihUXfQ0fq5U1s52YhO09lGjyNeJsu+8drmSF9Z5TeQyqC6m1TqsatmdjZ4+K43
	V+YH9H1ZLSIi3U5RefzMZqiPyRh5D2+I7Dv+VKVBcBo/aVP9vvm81v+ws1H637fDqsmIhhkQJlM
	oMN2gprInAUQV+X0ngCvjOFeUAfetM6X4EPHe3m/c8NupJeti/SCQAiNlnps0686xvnoEJVorms
	M+j3EJJf8iescGamN3hP3k0tmo/2QR8brLcD2fSao2u/sKURdvoFX/cj2yiepRSbKyYh8qrbx3Y
	n3wdhWc0ppgQ60UUeSAcSqAiAh6Mz53dWbahwwcu+HnEU2MRn02BSkYBY=
X-Received: by 2002:a05:600c:4e55:b0:48a:761:5816 with SMTP id 5b1f17b1804b1-48fc99275d3mr10977985e9.8.1778625137467;
        Tue, 12 May 2026 15:32:17 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([2a01:e11:5402:d840:f1ee:c5d:74e4:6e19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e8f3c65f2sm47377375e9.1.2026.05.12.15.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:32:17 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v2 0/5] devm conversion, wait time, locking cleanup
Date: Wed, 13 May 2026 00:32:10 +0200
Message-ID: <20260512223215.25596-1-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the TCS3472 series, addressing the review comments from
Andy Shevchenko on v1. The series modernizes the tcs3472 driver by
converting it to use devm for resource management, switching to
guard(mutex) for locking, implementing wait time support exposed
through sampling_frequency (which was a long-standing TODO).

Patch 1: sorts the #include block alphabetically.
         v2:
         - New in v2 (suggested by Andy).

Patch 2: converts the remaining mutex_lock/unlock pairs to
         guard(mutex).
         v2: (suggested by Andy).
         - Moved earlier in the series; dropped "Found by code inspection".

Patch 3: converts the driver to devm for resource allocation, drops
         the explicit remove() callback, and adds 
         tcs3472_powerdown_action()
         to power down the chip on cleanup or probe failure.
         v2: (suggested by Andy).
         - Read-modify-write in powerdown/resume rewritten as 
           "compute, write, commit on success".
         - Use local 'struct device *dev = &client->dev' in probe.

Patch 4: implements wait time support, closing a long-standing TODO.
         The user controls WTIME indirectly via sampling_frequency.
         WTIME is recomputed when integration_time changes, preserving 
         the requested frequency.
         WEN is disabled when the frequency is too high; WLONG is
         enabled when the period exceeds the WTIME range.
         v2: (suggested by Andy).
         - validation tightened (rejects val > 0 with val2 < 0).
         - target_freq_uhz uses div_u64() for 32-bit portability.
         - TCS3472_ENABLE_RUN introduced here with AEN | PON | WEN,
           no longer redefined between patches.

Patch 5: moves the trailing return -EINVAL in tcs3472_read_raw() and
         tcs3472_write_raw() into explicit default: cases.
         v2:
         - New in v2 (suggested by Andy).

Testing:

All five patches were tested individually on a Raspberry Pi 3B with
an Adafruit TCS3472 breakout connected to I2C-1 at address 0x29.
Each patch was checked out and built separately to ensure the driver
remains functional in every intermediate state of the series.

Patch 1 (sort headers):
  - Driver loads cleanly; RGBC channel reads return reasonable values.
  - No warnings in dmesg.

Patch 2 (guard(mutex)):
  - Threshold value writes (RISING=1000, FALLING=200) read back
    correctly; AIHT/AILT registers on the chip mirror the values.
  - Threshold enable toggles the AIEN bit in ENABLE
    (sysfs '1' -> 0x13, sysfs '0' -> 0x03).
  - rmmod completes with no lock leak in dmesg.

Patch 3 (devm conversion):
  - Probe completes with ENABLE = 0x03 (PON|AEN, WEN not yet
    introduced).
  - RGBC reads return sensible values (e.g. clear=525, red=269,
    green=151, blue=97).
  - calibscale, integration_time, threshold value/period, and
    threshold enable all work as before.
  - After echo 0x29 to delete_device, ENABLE reads back as 0x00,
    confirming that devm_add_action_or_reset() invokes
    tcs3472_powerdown() on cleanup.
  - rmmod completes with no warning.

Patch 4 (wait time / sampling_frequency):
  - Initial state after probe: ATIME=0x00, WTIME=0xff, CONFIG=0x00,
    ENABLE=0x0b (PON|AEN|WEN), sampling_frequency=1.614987 Hz.
  - Write 1 Hz: WTIME=0x60, CONFIG=0x00, ENABLE=0x0b,
    sampling_frequency reads back 0.999200 Hz.
  - Write 5 Hz (too high for any wait time): WEN cleared,
    ENABLE=0x03, sampling_frequency reads back 1.621271 Hz (cycle
    with ATIME alone).
  - Write 0.5 Hz (period exceeds WTIME range): WLONG enabled,
    CONFIG=0x02, WTIME=0xd0, WEN re-enabled, ENABLE=0x0b,
    sampling_frequency reads back 0.500200 Hz.
  - After setting 0.5 Hz, changing integration_time to 0.024000 s:
    WTIME automatically recomputed to 0xbb, sampling_frequency reads
    back 0.496622 Hz (closest achievable to 0.5 Hz at the new ATIME).
  - Invalid inputs (-1.0, 0.0) rejected with -EINVAL; chip state
    unchanged.
  - After rmmod, ENABLE reads back as 0x00 (PON, AEN and WEN all
    cleared by powerdown via devm).

Patch 5 (default case):
  - All read_raw and write_raw cases (raw RGBC, calibscale,
    integration_time, sampling_frequency) handle attributes
    identically to the previous patch.
  - Invalid inputs still rejected with -EINVAL through the explicit
    default: case.
  - rmmod completes cleanly with ENABLE = 0x00

Aldo Conte (5):
  iio: light: tcs3472: sort headers alphabetically
  iio: light: tcs3472: convert remaining locking to guard(mutex)
  iio: light: tcs3472: use devm for resource management
  iio: light: tcs3472: implement wait time and sampling frequency
  iio: light: tcs3472: move standalone return to default case

 drivers/iio/light/tcs3472.c | 357 +++++++++++++++++++++++++-----------
 1 file changed, 249 insertions(+), 108 deletions(-)

-- 
2.54.0

