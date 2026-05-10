Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50636826E
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778401565; cv=none; b=G0TAz+oEMnfidgohCCHQskOMiD1bjWz+j6QjbZQh23kI2ROOGwR1JGu8z1b9efiOhKnsFoJ8//h2C44DD/3QuWjSX07fCUJHP3zwW2jKu0NF26T56rqBSVDBm2E0Iyi03sAQxjLK321GeE1Hrb3fDW7Cv2KQlKySizXHBqfJjp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778401565; c=relaxed/simple;
	bh=/x8yYbpJKuFACZr2NaIUxjohn8P9suLpI69BQXCqbko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ub5SF/07MLRCCZnA0ROl8mxGPOA79OMMuQEI8VamQwYiqFSneAn7Ml3zK0BX+4DGcMJX7B5MwloWR7iwMhAMwfV8HVPZLIFLO22vlCDg2Oszp6vLdJqw4AsKliCxH8UCtj+IppYFJitf5Zh/SOFX4/AtxCoo+ZJKml0vwSqpDos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ga1pONqy; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ga1pONqy"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-393800586aeso43123151fa.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778401562; x=1779006362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmcewcrX9GIgVhKItKjFv/3O69vRNyFoSMe5QXyQeZQ=;
        b=Ga1pONqywb8Gh+t7X/Z1hxhQ3k3srhCa0Sr0PW2mAzXp0onDW56/9fCL5Oci8Mj7Se
         gk9xuoOmOYvaaBnMyNTpJrHLNmNunQt2Y46V1/AP0LglnrbYMoYA1jNv1t2Z6YY4HniY
         EqjJAV165Kx4dylxAt3JwNdNE7Gdxqsc+/911yOInpWYl0nG0PXXcPWuHLa+ixtS7nhQ
         WfaSO/khdSJbIu8C0SnB5N+yURJ8/hJL7XeF41dZaASTznKk0rvP8Pa+O4HEuy0hrkmC
         vjLcFUstYn7olUd/6MGXxf3xtxezgta7aLVI3NVBpWjN8qWuKWyYCMpz9V5gX0VqqfOh
         mn3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778401562; x=1779006362;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmcewcrX9GIgVhKItKjFv/3O69vRNyFoSMe5QXyQeZQ=;
        b=VR95ATOTkoMyePK6onTckJ9f7jmSfZUb87lXH5AEOQZJ/iTrE1L1xY9djkw9J1ztaq
         12nsNF+F97ymKoNhePH7EC4guJ4rovxKSz1mNkC2rpzJvTeCQPAm/8ghpq2UIqcy0Mll
         0f2FTLtq7SS39AGEwB+al3624k0DN7TRmq169GElzoyFJmk6lpEEyvvmN5cek1Kwb3Wc
         Dwa2O1vDzkk9NT45b6czrfIGk1i2b2YtVcsbx7lTbehuVCCUrllvqmV2Hms30ScCI4Rj
         tjvmiS4AIJVsxwFQj+fUl7IQzqOdc7DHIl14gkoonV7FckTP/D3jgFpTKCiCBGKTt3VB
         lMvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9cLbdtVhA29+uvJd0DtEXvLej6ypgUi9fBlTVKtcSHV7UxSX+jJUPyzBV+kPgoV4kjXRYGK8u50Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD3pat/tri58w/JfI8aBlnxdA/cb1Awvti6+QO6/+R9HAa3JEE
	KU1A7EirVCroef6U+fOywtpVYbQuZLuFfMsdJ/3v73OEDORwB3dtNwDH
X-Gm-Gg: Acq92OEJHN9Wqzzsl+Scee/IbEJ+w+scCXEIbqDaOhJukLOxWB52enh7lA9hMx9qBZr
	9I28zCjmGQncOaKqmRQ9w0q65dhyDMSjB3k/zC9L00gVvanr92YsFL1PsNVkL1hUVFO0FaPvVlN
	IBEIvqFP61ASQzOHfQ6iQhnS1R/ZJjNo82U9EOI86drfYyyzrz2/5suKi3x3CHunT/VYe0QD0Rn
	VlnnKmyDZXN2IZfzqHA54DiHgqf65N1pRdpNqftMhJ9ZAXpRnl1Uw5ignswOfMaOINvwSZ3Myl9
	3KHPbmBsiGtHw7MN1QqKWzTo693oZtwduNFa0XBxwzJ2Iibx/ECp2MhSmT2CdZHLV3srDer1hsG
	EqUQWa23ySgefkUOG2q/Ofi26hf78YdePcGiRaOxO9046SL/uOLVXuqqx1qSz1yhLONvIYViGa6
	gLF+13k8b6PnFDVAmKL7GDg+7d65cQ3WP35u5f8ywHTyK4BNYg5eqpmIalklNc8y33AxAhNg6bW
	upQDbKU2LNeOQ==
X-Received: by 2002:a05:651c:1141:b0:394:46f:ef18 with SMTP id 38308e7fff4ca-3940470583emr19268251fa.12.1778401561674;
        Sun, 10 May 2026 01:26:01 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f60db4dasm17810681fa.20.2026.05.10.01.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 01:26:00 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 0/5] iio: accel: adxl3xx: Add timestamps to FIFO data
Date: Sun, 10 May 2026 11:25:51 +0300
Message-ID: <20260510082556.3867-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Five ADXL-family accelerometer drivers (ADXL313, ADXL345, ADXL367,
ADXL372, ADXL380) push buffered samples using iio_push_to_buffers(),
which does not attach a hardware timestamp to the scan data.
Userspace consumers therefore receive samples with no timing
information.

This series adds timestamp support uniformly across the family:

  - A scan buffer struct with an aligned_s64 ts field is added to each
    driver's state struct.  The struct layout ensures the timestamp
    field sits at an 8-byte aligned offset as required by
    iio_push_to_buffers_with_timestamp().

  - In the FIFO push loop, FIFO data is copied into scan.channels via
    memcpy(), then iio_push_to_buffers_with_timestamp() is called with
    a single timestamp captured once per interrupt with
    iio_get_time_ns().  Using one timestamp per IRQ is consistent with
    the existing approach in the same handlers for event timestamps.

  - For ADXL367, the helper adxl367_push_fifo_data() gains a s64 ts
    parameter so the timestamp captured in the IRQ handler is passed
    through instead of calling iio_get_time_ns() a second time.

  - For ADXL372 and ADXL380, where the IRQ handler already called
    iio_get_time_ns() for the event push, the same captured timestamp
    is now also passed to the FIFO push, removing the duplicate call.

The ADXL313 and ADXL345 drivers always scan all three axes together
(available_scan_masks contains only the full X|Y|Z mask), so their
scan buffer layout is fixed.  The ADXL367, ADXL372, and ADXL380
drivers support variable scan masks; fifo_set_size tracks the number
of enabled channels per sample set and is used as the memcpy length.

Md Shofiqul Islam (5):
  iio: accel: adxl372: Add timestamp to FIFO data
  iio: accel: adxl380: Add timestamp to FIFO data
  iio: accel: adxl367: Add timestamp to FIFO data
  iio: accel: adxl313: Add timestamp to FIFO data
  iio: accel: adxl345: Add timestamp to FIFO data

 drivers/iio/accel/adxl313.h      |  4 ++++
 drivers/iio/accel/adxl313_core.c |  8 ++++++--
 drivers/iio/accel/adxl345_core.c | 12 ++++++++++--
 drivers/iio/accel/adxl367.c      | 17 +++++++++++++----
 drivers/iio/accel/adxl372.c      | 13 +++++++++++--
 drivers/iio/accel/adxl380.c      | 15 ++++++++++++---
 6 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.54.0.windows.1

