Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6372226CE05
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777238332; cv=none; b=sHQJaFCc1SNWz5IzQxGaXD3JSsautAEw/RfZ6vnv7es9DdG03erEHLNyr4L3e9OYfMoNnjTxvk7lTNcqRpfvOjKegZlc2gqA79wX5S6k+UVrLsllsidGVBhz+LPgKUXgUaoaIyB1GtKnSkU8WMnisVzlBuUbFh+/Ra+UUZ2KxKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777238332; c=relaxed/simple;
	bh=CPy2Vs8f8zbll4GAc3dH1op3Gpt+Q5/tPNFN2OkDhSE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9NJDC6vvc6jhdPCu3K5Cg7zkdaJ93l7g4LXj9c+/VCkOydZItG0av67PY+rK94r6XF8g12ef6iJZ1aaMaN1ErdEUK8jIPEzYegydnTlfQ4hnn1rqvfn8oYO4dqs+wZZN6dSPu+MZNohoEeaVRF33a+dDYZazjzYCWx0a/zSVFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=V1NJMTyO; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="V1NJMTyO"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12713e56abdso6821294c88.1
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777238328; x=1777843128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2f/xxCVhn8u14pobySK1w6AYfG4EprPsl+SY3WJGODc=;
        b=V1NJMTyOsBpvsnxYy2G02xwBzqrGLGqJ0wTTgtLch+KqCN8VIwF4SZ8ruGaL8p8TVw
         fAlT64EQr1tIasK6Bo74hemrvp6sbd4h3+H1DPjkoI2pJpRG4PV6UDVc7/6aMJPRSOHn
         qhJFPTUv9+2qvTsgfQ00O5Tq84PeJWu5eyZ8i4tjMGCQTJcqP9RW27zWaxDiezXtTFl6
         nkkdE7tJRY4T3VS/W4CtiwYFq81FsN4NwJHueELej6a8FBQfmz7Bh2d9o6hpNTUzP7Su
         PETEXzZ/SE/9nohXwASIY65XPW0FXuU5MXThXO4UWOSb9Eau6NXqKXgEaGWthAcfBq51
         iq1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777238328; x=1777843128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f/xxCVhn8u14pobySK1w6AYfG4EprPsl+SY3WJGODc=;
        b=hZaxkNu4+NZjnY+AfB1pGkZfYQMiuV+/OxKOdk94ff9FHeX7N6azdEJ7qND8JjFm6a
         9fXnSlSOpwiKUOrJfI2SXjR4w9NbxPMlIMwS075n6xTfACOgUUDit7T43LaJNKEG7L1x
         zysLCIaSNUziWdWKR47rhDm6atc4/PFkWR081n5NxGTWX0+cpcGkNkUGuGp0kySnICeG
         0lWZhyUiuF4uQ2DIc/paWzVY3vPTSeQ4vlQfWuaXFe7xO0QzyzE9bGf6Dpc97yNCtios
         ldW6CEsTy7HP7u5A2XB6hO/qQTwiJg/AsgJQkgtPTXRm0lsKCtYFWpRqqaXZG/uvm8mY
         Myyg==
X-Forwarded-Encrypted: i=1; AFNElJ+ac7P73fa3m22E8vmvBRxvNphyuHA352xpkp24ZcY9pjVExfT92pnKmOmMIV4+KvvElkX85StturM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRIngCwHWBZhiNNEAzvWTgby9/vPn2nb/q0Bdxkz1qstnD3Gkp
	+1n/PQk8MmrNtUtvaPujHopnZ0tlws1hd4PW4K4y3CD0IvPXFrn3J48mxnTAXXSV9w0vgVapAxb
	aeowfIW/dig==
X-Gm-Gg: AeBDietkMwVzyNhepBc1KyGVNUeW0tfF5F8VxoUkNaXL++51u5LkbcrNYa+YlbSby3y
	nle8Lmggi6uSPElpNxEVokM7BF1gcd212syRFl17MXD5KSwFtAgTqy74a7dpqmr3EpGV1cBs/2d
	zR31zyuLT2xQkmtVCUMHmh1d3xwbHMMH/62rqY4eztJRP0NDuSaCZsbgvQnDVWFHoVnOnBkrw7s
	yBecOFUUjd47HHaDth+3T4ApVZaOI6eurgNZ3N5vRb38DZKz2aCxh2P4NKre0vhhe6vYUsoGT6Q
	AOzmfk1as4lH32vbyTWCoFTX9cP4XSkFiFxULMrPAU2bjJyk5HpMCPuvObGnolGZ0edmTJzRFMy
	Dw1w8DFNHiK07T0W30Pkp06dwNzextxXOzNYQoHPbtu2LpGj0sC2K+yBl3OYQohPevHfu3aA+Mk
	lnaK2cGBuPxyUGrQiGAkpVxiHYut4o5zc=
X-Received: by 2002:a05:701a:c941:b0:12c:87f2:90af with SMTP id a92af1059eb24-12c87f2925dmr9336512c88.12.1777238328189;
        Sun, 26 Apr 2026 14:18:48 -0700 (PDT)
Received: from eileen ([38.10.153.31])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm40799122eec.17.2026.04.26.14.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 14:18:47 -0700 (PDT)
From: Caio Morais <caiomorais@usp.br>
X-Google-Original-From: Caio Morais
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	michal.simek@amd.com,
	nuno.sa@analog.com
Cc: Caio Morais <caiomorais@usp.br>,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 0/3]: fix unnecessary includes and add missing ones across multiple drivers
Date: Sun, 26 Apr 2026 18:17:59 -0300
Message-ID: <20260426211834.3318306-1-caiomorais@usp.br>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caio Morais <caiomorais@usp.br>

This series removes unnecessary includes and adds missing ones as reported
by the include-what-you-use (IWYU) tool across different IIO drivers.

Caio Morais (3):
  iio: adc: xilinx-xadc: remove unnecessary includes and add missing
    ones
  iio: buffer: industrialio-triggered-buffer: fix includes with IWYU
  iio: common: st_sensors: fix includes with IWYU

 drivers/iio/adc/xilinx-xadc-events.c               | 6 +++++-
 drivers/iio/buffer/industrialio-triggered-buffer.c | 6 ++++--
 drivers/iio/common/st_sensors/st_sensors_i2c.c     | 7 +++++--
 drivers/iio/common/st_sensors/st_sensors_spi.c     | 9 +++++++--
 4 files changed, 21 insertions(+), 7 deletions(-)

-- 
2.54.0

