Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9D45D1BA
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 17:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786986495; cv=none; b=M9Law1vFuXejimv9vkUvpqkzCif9o/MCXr7nGmyK5paXsIotPkVllB47rQoSAXDHrnaE5nuAnc0S/eHZcw+XZVLKYTwZB/WGZ9JUZObsZq/36ILYxIaWUPj4dqNgCwdG16Cz6v9Dv2K0795t8xSWkYSKJrNfYE6eIJdIRThGhQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786986495; c=relaxed/simple;
	bh=4YUnNkNc0kox0n7AAb+fEaKaolAfiEceLI9ZUsBYymk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Es4LYBiQPVJQob0nb7VVOTz2m0vdoUCx7VE34io43Zq7LUP2ke1PECW6bziQHFQzbKhEriOCQvhROAPSiRTVR5F44nj2I1y4mtO6egMQdKqfpfgfBRQJEylYH2sw56txypGDnaMcG7d7c7R2kr9qyFfiEfpQZzsdw894+KGdIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvOUCB1t; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvOUCB1t"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39c953950dfso28996691fa.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786986491; x=1787591291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LqtrMFmH/e3ZpTrAPQ6yVzzgKO96R80WGVqaLzpl7Jw=;
        b=GvOUCB1tuLfBISPT9HcGMA0oORHQnpgMfMTIVPVK980DNK2waSaJglbuW8W5ma3KhJ
         UVh3R+aTKGDkVVg3KFxJt01+5DlFnJq3Y9p23gr+231aG7EpfgIckX/Cy0ZipHyN5wF9
         Lb1mj0JB+GtXnd0rYUsG9hxjUC42flek92DL6BdSRkYqEKCFTo8FLa/RLBtQwlJTdAwn
         vFGQfwF2/5zdeStaG1QCSJosXoaTGQhPbGWtGEP3UDU4WJV5OqS5i9T4OnrBXpvGeT4A
         0CRzmT2j0GSeetiLNbB+sS4WexinxlYMs+6e0+iibA6hBKckf6lnEXRjf28OpQKLW8fq
         viVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786986491; x=1787591291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LqtrMFmH/e3ZpTrAPQ6yVzzgKO96R80WGVqaLzpl7Jw=;
        b=kzHjIEqbYFeEr4TFDkR5miRRri+BrJaMLfbG89ynozsJd0kTiYiMOLxjjWm8n/Swxp
         iZj3Cny5crT0LYbWA2jAjajTu12DNd7JbrKygWhwUHFXxTL1nNOkcKJRnkKu9asco5wI
         No0XoSPAQkRIPvY8KKA00X954Xv9vNRTvGlZ3aBUogni0EprHtXrUP19V0YToovAEfuL
         dlTZj/1ks1fLO+MQxUCS9aRWPCju1pNobFYNt7Y5Xz3NZeH1/f7Jbn4fsJzdRLgNWMOZ
         WgC+fVgWQKVrtdtOXooI8zqd1IDAaQsvoWaw4EHDXsqYcj3YrXDS3ypRU6scsE8k245o
         dulg==
X-Gm-Message-State: AOJu0YwfkdplyEUPnkHYEecpfM07k5r5hZT/dg0NqvL4yegTHRy+ApYW
	ToFbpsk7G0S3tqxhZrJ/O2QvF7V3FeSp7BuxlO8W5kTkv252e55q2Pgr
X-Gm-Gg: AR+sD10yNdWmZ92g4rvVa/QjAFooKUtFncyt6HHJfdf+NUxNp2D6FZag+//0c9Mdtu3
	EdbgMm+Gg3+OzBunCkeDCs4H7KkCmPE7GznKw2RqgM4Xj8UuIY7HbL8pZuUGtC5jHtJ0iJUPQyF
	5kMN2pEu9aNzB4EXySZBoOTynAEbSwyB3zCJaSf/EWVc5+roTn/Sum/iyQ7b7UbBJ09tctxEWES
	8NrPrRhI53gCfxE8tccqRFPPCVT1znrOfU051Bo/g1mOuDxVAExLdXKQ82vMzHsSwEQYvyFqUpt
	Teb0+XDFwvOQeyECvYqT6qwOh9HVpMitHWuRiaF8jIS6atMj/cCcv2MFKcYLZlRR9cD+azSzg6v
	4hLjSgIEEapa7uWTbSlVsZgq3nDnAg14CBXLA9ITqYY222GGMbf77nEJiVHIJ9V9/N3K78atdS4
	QQLP0zW7VMV8QxjvXl9yrSmeSvWYi1qM9iCOPJBwDANKKGJrlM+pzN2Ib5u/Kk5QdhtemQdLBAu
	NCH2ZoTw9f1HmLuSSIfG4izP/D47TDhC9v1FY4V6zTuAhgI81pLq/oNnpY=
X-Received: by 2002:a2e:a9a4:0:b0:39b:2757:c1d3 with SMTP id 38308e7fff4ca-3a175183c54mr1326171fa.9.1786986490987;
        Mon, 17 Aug 2026 10:08:10 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a16b0e54casm6053841fa.15.2026.08.17.10.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:08:10 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v5 0/3] iio: pressure: dps310: FIFO and triggered buffer support
Date: Mon, 17 Aug 2026 20:07:22 +0300
Message-ID: <20260817170725.1074078-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dps310 has no buffer support today. This series adds it, with the
hardware FIFO used when no external trigger is attached and the FIFO
left disabled in favor of the trigger when one is, so the switch between
the two modes can be reviewed together rather than in two submissions.

Patch 1 fixes the CFG_REG bit definitions and replaces the standalone
fix I sent on 27 July, which Jonathan asked me to fold in here instead:

  Link: https://lore.kernel.org/linux-iio/20260728223009.0cb86996@jic23-huawei/

All three of those defines have been wrong since the driver was added,
but only P_SHIFT has a user and only that one misbehaves, so the patch
carries a Fixes tag for the original driver and one for the commit that
added the first user of P_SHIFT, along with Cc: stable. The FIFO enable
is needed by patch 3.

The three INT_SEL interrupt enables at bits 6 to 4 are still not
defined. Nothing uses them, the driver has no interrupt path, and the
binding has no interrupts property, so adding unused defines to a fix
did not seem worth it. David also asked for the register defines to be
sorted low to high. That is a cleanup series of its own once this lands.

Patch 2 adds the triggered buffer path.

Patch 3 adds the hardware FIFO and the selection between it and an
attached trigger. Those started out as separate patches, but the branch
on iio_device_get_current_mode() is four lines and the FIFO patch is
wrong without it, since postenable would otherwise start the FIFO while
a trigger was driving the buffer. Splitting them would only have left a
broken commit in between, so they are one patch.

Verified on an Infineon DPS310 breakout wired to a BeagleBone Black,
running this series on 7.2.0-rc2. Two modules built from the same tree,
differing only in the three CFG_REG defines corrected here, loaded
seconds apart. Three reads of in_pressure_input per oversampling ratio,
ambient 98.4 kPa and 27.2 degC:

  OSR    before              after
    1    98.433  98.428      98.445  98.446
    8    98.460  98.460      98.477  98.479
   16    -ERANGE             98.566  98.564
   32    -ERANGE             98.428  98.427
   64    -ERANGE             98.464  98.463
  128    98.439  98.440      98.434  98.434

Pressure oversampling 16, 32 and 64 return -ERANGE before the fix.
P_SHIFT is never enabled, so the result register no longer matches the
scale factor the compensation divides by, and
dps310_calculate_pressure() ends up negative. 128 is not affected in
practice. Temperature is unaffected throughout, since TMP_SHIFT_EN was
already defined correctly.

Everything else was checked with checkpatch --strict and a W=1 build,
plus an arm build for aspeed_g5 and a boot under qemu-system-arm -M
rainier-bmc, which covers probe, the sysfs values, raw times scale
matching processed, EBUSY on sysfs reads while the buffer is enabled,
and all three scan mask combinations. QEMU's dps310 model implements
neither the FIFO nor the interrupt, so patch 3 was tested on the
BeagleBone Black above only.

On hardware, patch 3 was checked with both channels enabled, temperature
only and pressure only, at 8 Hz and at 128 Hz. A blocking read returns
in every case, which is the part that needs the timer: with no
interrupt, hwfifo_flush_to_buffer alone would leave a reader asleep on
rb->pollq. At 128 Hz, 100 scans arrive in 0.81 s, so the batching is
real. Timestamps are monotonic throughout and land on the configured
period, 125.0000 ms at 8 Hz, except where a drain collected more than
the rate accounts for and the batch is compressed to stay ordered. With
a sysfs trigger attached the FIFO stays disabled and the trigger drives
the buffer, at the rate trigger_now is written.

Changes since v3 (no v4 was posted):
- the series now includes the FIFO, not just a triggered buffer
- CFG_REG bit fix folded in as patch 1
- scan buffer is a stack local instead of living in struct dps310_data
- available_scan_masks dropped, only enabled channels are pushed
- claim_direct and the mutex use ACQUIRE() scoping
- shared helper for the raw and processed reads
- comment on the pressure channel spec warning against copying the
  raw plus scale approach
- the stale file header claiming only a single temperature read is
  supported goes with patch 3, which is what finally disproves it

Rupesh Majhi (3):
  iio: pressure: dps310: fix CFG_REG bit definitions
  iio: pressure: dps310: add triggered buffer support
  iio: pressure: dps310: add hardware FIFO support

 drivers/iio/pressure/Kconfig  |   2 +
 drivers/iio/pressure/dps310.c | 718 ++++++++++++++++++++++++++++++----
 2 files changed, 646 insertions(+), 74 deletions(-)

-- 
2.43.0

