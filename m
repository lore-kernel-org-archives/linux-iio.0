Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722CA3A783C
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 12:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778158065; cv=none; b=UGulIl0VLBlmwUqUeaQjaVPH/kU53KlrTbPqYkK+JCo+dPy81OpxCjJt/V3ttV2DtXJL/PPm0sQqbBHHYj9YsNqOutcBBgYPtsrpvYLFfhk0ZmsQ3MzE7e2FWxKWTMRK0XcAPsYGwE178GVIDd+ignJL94M1OX0Fu2qWHo6xU0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778158065; c=relaxed/simple;
	bh=eyd50cmuYyLr2wIaBreZG2Fb1acqfssCP8kcgHPtsK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzJ5VdsJ6k7HPeYYHV9+JgxCVuCiqFpLffcD1l8i4MrLv3l66o1KBD9NvE2q92ZVqUqcqODQ8jnerxr2XH2i/pIPosirtWX0MPijs59ICG4GGNGIoQm6l+3ce9KZgUCWFR1BgapeG/1hCzaS1UEgelFgUtkYAAGJOhassRzpMDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nOLQ4kBJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nOLQ4kBJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so7458395e9.2
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778158057; x=1778762857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ONViZRNlsNaxoC7NqpsyYL/lwLto2zHXbx8xCpboj00=;
        b=nOLQ4kBJZ+KRvt9BQ/Zr53/+tTJm5W8Ayo7ujTSzP4leYZBB5U4oHhnGyfSlDSAZMW
         5Efuyei+z6vWKk6eG8QSdF03p8F1usEfnJJqkzarJwG1ZT3oqokkSKDw4IIXOuRV2v/Y
         nUEVqjUc6m7CRW565kNH36sR+70eUI1GI81c+LpXkhiEQvEbSxdwntQyxwasatCryspQ
         /shUpxOAil8dZhob8hlyFlmXPKVw8wEW3RuTOKXW+x4rK8tYbgo/OuhWepwfRHYC4wiC
         1s3ydR5fR8TPY7W8XsaPE9mhSVufgNb6DOjn4hQN04zaI/5F6LRQeObiNCkGXyNbQ0ih
         ppVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778158057; x=1778762857;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONViZRNlsNaxoC7NqpsyYL/lwLto2zHXbx8xCpboj00=;
        b=AeKq4f4hfw5HC0BG2AJq2EiIJidlG+2lUmOOHR90Xv7OwX4AWxk0HCZhVOcu5fjOP1
         Uakc4cjM7hnylxrNqxpddebzn0scjolNpbGZD1EEW39uCari92H6+l4NTHOeHN+ghjAw
         Apsmb05o7KyYBXWmxPD44QltC9+Tg7OpE4a4ArYlsJ9S+sbaxBjV7v9BR07Ux78kB6uS
         uPrnLVg7NB4H31t+C9/BCqan84jXDR0rhMYaNkYLk7qNkfdMbngk8RKh7f10w+tShkDL
         r8F/UoEhjhR+U+KTcqOkVzhG3WTDB45CuUPTM/veqs2tMUt/jFjil1FzInOiLhxuosNg
         wcGA==
X-Gm-Message-State: AOJu0YzFHWgjaH0AKGaaMyeW6GB95IEr8e4SqRikfzjBeZ0cWEBfLB+m
	KzCxQgOQdlBMRsYr7bsVHjcV6LeqoCYxikWRrg46004jav1co9jurBxX
X-Gm-Gg: AeBDieuNb4b3CXns6QnFIDw6HK9a8oLdtFwQIwJbDAq66tjAgE4teDFqMHIlFW91/xN
	k1e5cwHlE8/meL7YjtoHw+L42HyJroRb9lcmEkjbJgfPS+/Wlv6lQf/bd9vGgLBNIa7EaKpPLNq
	/SpSIUK2R+rwBEeomOtRsqqRq8Dc6Wfhwt5Eux2lKLMMaZu7eYkuMovdVPRvBAt5EpuhY7qPoYm
	rQlN4H+SUn2S6+1SpYtI7XbeIRN4A7aIo8mnERdsqpcK5oxO35jfUEu+p82K7nHc5QZhFFUl456
	9izX5qywuUpHnikPY0gHo4wevCwPIgmGXzUDn1u7uK1SdOywDWNDKe+NKKS4jYPL6BYq4qKVQI3
	RlXUSBm4bc+z3h6BHJU3rFGyaO0k/CZtvy4K5S4G9X0JU41dFzlZwey2i/3n/ZuO/gPaQZe5Z1L
	4HvV98lq2qFfu0NquLQbGhOI3/SW/xqOKnNqTTEceLkpBq13OsxIUy2ID7VqtmF2giwl/WHbzEM
	efncKWJ4Uc5CCPfLmVmkVGMuJARow==
X-Received: by 2002:a05:600c:b8a:b0:48a:56de:d620 with SMTP id 5b1f17b1804b1-48e51f32ac3mr131868335e9.14.1778158056987;
        Thu, 07 May 2026 05:47:36 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e538b6e9bsm209228145e9.10.2026.05.07.05.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 05:47:36 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Subject: [PATCH 0/3] iio: magnetometer: add MEMSIC MMC5983MA driver
Date: Thu,  7 May 2026 12:47:21 +0000
Message-ID: <20260507124724.813043-1-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an IIO driver for the MEMSIC MMC5983MA 3-axis magnetometer over
I2C. The driver provides raw magnetic field readings with per-measurement
SET/RESET offset cancellation, giving 18-bit output with a full-scale
range of +/-8 Gauss.

Tested on a Raspberry Pi 2B with the sensor on I2C-1 at 0x30.

The following chip features are intentionally left out of the initial
driver because the public datasheet does not provide enough detail to
expose them confidently through stable IIO ABI, or because they still
need more validation:

- SPI transport: deferred because SET/RESET polarity behavior has been
  reported to differ between I2C and SPI, especially around SET/RESET
  timing and/or SPI mode.
- Temperature channel: deferred until the temperature output behavior is
  better validated.
- Continuous measurement mode and Auto SET/RESET: deferred because the
  datasheet does not clearly define the interaction between CMM, TM_M,
  Meas_M_Done, and SET/RESET sequencing.
- Saturation/self-test bits: deferred because the applied test field
  strength and bit lifetime are not specified.
- BW/decimation filter tuning: only the documented measurement timing is
  used; no filter response is exposed because the filter topology and
  coefficients are not documented.

The driver uses a conservative 500 us post-SET/RESET delay before
starting the following measurement. The datasheet describes a 500 ns
SET/RESET coil pulse, but existing sample code and practical testing
indicate that a longer software delay is needed before taking the next
measurement.

Vladislav Kulikov (3):
  dt-bindings: iio: magnetometer: add MEMSIC MMC5983MA
  iio: magnetometer: add driver for MEMSIC MMC5983MA
  MAINTAINERS: add entry for MEMSIC MMC5983MA magnetometer driver

 .../iio/magnetometer/memsic,mmc5983.yaml      |  38 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   1 +
 drivers/iio/magnetometer/mmc5983.c            | 330 ++++++++++++++++++
 5 files changed, 387 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
 create mode 100644 drivers/iio/magnetometer/mmc5983.c


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.43.0

