Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214635203C
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779234493; cv=none; b=r4Go0Eshb1cWibumxH+Pt0cU9jRdX53v/ZHx0cBfTZMJxFbVh4dk5epN14z32DyTYEuSlrPh/kxj4mehy25avulkAKiVAM+ridbJDqPirA0MpB5zgTIT/GW7MQTvZFyMTx66M+sM65cktMwwekIbJ2bT8PCZVlr4wzAUeIhS64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779234493; c=relaxed/simple;
	bh=Ta9WGER8ct7kczazZS/8V2rHje0U8Pio76nEzIUlIkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dvMvcatx56Pcza4tVTN4NZxn2lCY/U9lrK3NaRKwgD/7qw1a/o9fzheT3Wq3QdbyvaSbM6CpQa9L5fVOq5rG0IfC2d2u5gv/f6eIs7YelM3XlDs9UD4bW/cZvLZVjnt7HrIvXiuX82SftKPP54qe7TwWIyWUepv0BVyvFCvEg/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=jbqunUBG; arc=none smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="jbqunUBG"
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8b1f2b7f1bcso65127926d6.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 16:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779234489; x=1779839289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EoCyoqi9IVhXALA90XpIAUY04CE+61QR9mXxpS1jXWk=;
        b=jbqunUBG0NfEwnlT6E++nUj/lAieaM1pmLh8owu3cpFa6+acqz2WPEbpErosjRMLqP
         f2kP1GXVHLUddDVyLrTxs9+MPkW7pqCICztgLgCnJPNKhm+Jo++1eM470QIqBL84yofT
         sdcpJU3++mrIV/HVYLmJs/5de2UIwv37CYDF6RoVvwxHuUlLL7cn3azYzBjUXmIsRBpm
         66WWp9qmoS3aL4vFRfjBD5UdYIndJqkGtEykclnczM2x9CfxSApa2XPMhPodNdAwL9IF
         YWVlY/AR65Zc6ACcPJ8KvxAR6MUO+ZfKJ9shyvnQZo2PXE+TDwOAXetkQxIdfxvQ2aox
         OE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779234489; x=1779839289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EoCyoqi9IVhXALA90XpIAUY04CE+61QR9mXxpS1jXWk=;
        b=mHaIV3vHLTfzAMMZKcSpi+4MOF3EkopaSATIUt+3TiQ6fDlxLaZaMeRJMdj8I8PdAC
         +s3PQPpIstJZHnZ+eh8xMp7f5b+J8v+4CzoL0b3GfCFETn7JCc5Ir20XSJc0ShxeV7Pk
         Ne9Imtdn2a0GOSSIDzVNeJLEYcvEm8VlfcdmJkoLt9XGhbfsKRao2Sf3rVvHITwLIXXY
         z0igbmDXCnT/K+Ts8M+h7uQNVD8/+t5zMS5TvpkJSzQBPZoT8qDa7nQOqMGEvVczBXlJ
         JQinHe2oadzc/gZ7xkCcxCv9EiW3oYJBcyiI9aMWF2fddzuRr209sBd5DRFKvQg/qhYw
         VPbw==
X-Forwarded-Encrypted: i=1; AFNElJ/J/HA2DI1hyhfHf0TV3EgBzgCbDxBTTfNibEnyVKnUcAmh8DogGjgZRkk4ZOQOKeQh2rOCej8bRDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJKcUsCyuY8NuQiadjhb4aD4vySj0tvuN2mI+vrvUbAZ+PUIL
	vprK3lFX606i3Jx2dPIxXbI9+nkRK7I0W25FO+0+MOQs+amsG7+h1/ARRDtHy6cADps=
X-Gm-Gg: Acq92OHC7xne3DQU7odpIVUWo0/iWYlYxzQi9UkR7XeZ3bwMhF1ux4emQ5rwjJY2Odc
	kB20SamFiM69pY6uP7tADL3BYac/5FU4efMTZ6J9dsqcJQxjTd8TsvCf4a5PBcKlEbwl3Kl3l+k
	iLt1Yt7rkRoZJ/TgUYvAluWiZEzJLtG3JXuohHOlm1SDBN88u8x5sg7GDLp+VmHz5IyK2JQhcNp
	1S/xA75KT04jUvEkAEOfr5ZIoBhHtMd/Doyfx9t9tmgPWpngZv3bhr6u6ko+48C+aEBBcnh5IHS
	nQnI8NDQtpLlRQacwrX2uPbYxI5t68EM++QttOxqJWrUVUL1kWJOK970HGiCuaj/KhhVspsUCVY
	VP/wn/vqO9tISd7O9K7pqunKktUZS1LyoRtQhADd+dSIOQ6UfAQDq/PALZ6PWNLZeu6DtzufxwZ
	jNG8NlXcj6zZyfYz4syMj9ROCPtXeLXCzpi+4tt0I=
X-Received: by 2002:a05:6214:21c8:b0:8ca:1102:3e3d with SMTP id 6a1803df08f44-8ca11023eebmr290921806d6.13.1779234489091;
        Tue, 19 May 2026 16:48:09 -0700 (PDT)
Received: from natalia-pc ([179.162.246.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36095326sm107301896d6.14.2026.05.19.16.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 16:48:08 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v4 0/6] iio: hid-sensor: standardize scan_type initialization
Date: Tue, 19 May 2026 20:40:42 -0300
Message-ID: <20260519234752.23911-1-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series refactors the HID sensor drivers to standardize the
initialization of the iio_chan_spec scan_type structure using compound
literals.

This change improves code readability and ensures that all fields of
the scan_type structure are properly zero-initialized, allowing the
removal of local helper functions.

Additionally, the channel initialization loops for hid-sensor-accel-3d
and hid-sensor-gyro-3d were cleaned up to iterate directly over the
scan indices, eliminating redundant index-offset logic.

---

Changes in v4:

- Fixed a bug in the sensor_hub_input_get_attribute_info()
call where passing the raw loop index 'ch' broke the HID report
field lookup in hid-sensor-accel-3d. Restored the proper HID
usage ID offset calculation using HID_USAGE_SENSOR_ACCEL_X_AXIS + ch
- Cleaned up the channel initialization loop to iterate
directly over the scan indices in hid-sensor-gyro-3d for consistency

Changes in v3:

- Dropped the global helper function implementation from
hid-sensor-attributes.c following maintainer feedback.
- Shifted to local refactoring inside the drivers using compound
literals and the  macros BYTES_TO_BITS() and BITS_PER_TYPE()
- Refactored the channel initialization loop in hid-sensor-accel-3d to
iterate directly over the scan enums instead of using 0-based
index offsets
- v3 link: https://lore.kernel.org/linux-iio/89a2e6775e3c922a4848a4b4730aab8d32097454.camel@linux.intel.com/T/#t

Changes in v2:

- Modified the helper function to use the BITS_PER_BYTE macro instead of
magic numbers for bit calculations
- Updated the scan_type structure field assignment from '.sign'
to '.format' based on recent subsystem renaming feedback

Natália Salvino André (6):
  iio: accel: HID: hid-sensor-accel-3d: Refactor channel initialization
  iio: gyro: HID: hid-sensor-gyro-3d: Refactor channel initialization
  iio: light: HID: hid-sensor-als: Refactor channel initialization
  iio: light: HID: hid-sensor-prox: Refactor channel initialization
  iio: magnetometer: HID: hid-sensor-magn-3d: Refactor channel
    initialization
  iio: pressure: HID: hid-sensor-press: Refactor channel initialization

 drivers/iio/accel/hid-sensor-accel-3d.c       | 27 +++++++------------
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 27 +++++++------------
 drivers/iio/light/hid-sensor-als.c            | 18 +++++--------
 drivers/iio/light/hid-sensor-prox.c           | 19 +++++--------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 20 +++++---------
 drivers/iio/pressure/hid-sensor-press.c       | 19 +++++--------
 6 files changed, 42 insertions(+), 88 deletions(-)

-- 
2.51.0

