Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796424ADD85
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 19:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526707; cv=none; b=h6c4IkVs7jzY4kGDg1vpw44yDXgefsARBYokCDrdpCBlMZPaGONAg3ybaikH8Lm+GuYudO900BfQgndxERWamOzxwC3bAHKBd6eEJB/38K+HHVQYZw6L2lD9znUGhtcy6ZwfzUtpcQs32rnbvXhaupGJb8xmY3M9CAomcYu41So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526707; c=relaxed/simple;
	bh=/bV64msSqSRcKdn5zUAfHwX3xqByCyEZfFcODECYZ5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p9AfuUKJeilT3xtEre++OPbJgPW5gGeYLhtvScz8eYV2bED8u7M7Ri+4V8nGZ5MazP0YaCQRDKb3lf61fheKECR97MBes3nMJPzYK3boIis70sqgMNmxBFTprrDweJQ08aom/VNDtkR2r62uxNvqdMf12JqLEjkjlo1ETmrqPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7bKWAC1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7bKWAC1"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45297094718so3755664f8f.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778526705; x=1779131505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YmHJticu6I9cJGzHOpTilWbp0zgjsUaADkfyTWFWIYU=;
        b=V7bKWAC18y0TpSw3qoSuRByWyygvI70FnIIGsNGixqZlBxuP6joMVrGxB9XibOZ1kU
         zSTpLuGA8MuiIpvj1/jvmZpKHt1kkjGL6fr3rYpL2c6HJtnpDPfcu83mJwVMoLgAtZxO
         GmE9NoI2CTXtW3VUfYNNZ1q88ae8s+JVR059abwUHUc3JhdY+RkFMOPbpiJqhfmHNAbG
         PszPQTnVfoS+VSh8qbBKXuKLqWTArVRDJk4/ZjUX4LjV/cMkT+hGi95FAGLqw+oQxcbI
         mHxBnUOYgTl6IyrNDgM/f39Ba8V2NLw/+fztt0a9zUaYGBofggeQSZOWgoCH9cFi2nkP
         y0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526705; x=1779131505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmHJticu6I9cJGzHOpTilWbp0zgjsUaADkfyTWFWIYU=;
        b=fIzADtIkfZdnAA80B/nbaiRRlRphWTd0K+mNGVMO/7bIgryUgbUZrd3OB+owBIGP77
         dsI0D+Oqm35SBiqEGyFt9PM9j6fLD6u9Hz5qZSJiTsqiFpQZ81zFZAE1uo9dJy0MU795
         RQE6hkO+UlHWkXTWLfUVQjDH4osSp/n/zcdZEtSh2P5Vn5IWikKox0ko9GR34EkUnB8k
         XKaa0n7NzoCTSJi49HoDLeT8z2yBSOywm4fSjPKG2dp+N/17ZXGhUPHrDrBkCzIJe+IT
         poLHL4n6xSzr7NRTA3yasJ2O2+WlLsFOCSaD07pKPdRkvR1Slycc4B3PcDcox4K+kVJK
         Lm4A==
X-Forwarded-Encrypted: i=1; AFNElJ+AKZGZo9zSlZ5WafWq4C0XXvQLvaCz6ZpvzzWJWq7sWkkOuKVJDtBaJo9HaUyNJOYZsMqSvVLBj8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLKs3oQDpCboCn7qb2j8uGvcYzBO9Jsq6hiNXqUGWlalMwSZcJ
	dFCknt84U0PFcRpRJ5X7grilXU3ttj7YmnC5XmfjTFDk7wHIcT0J9oah
X-Gm-Gg: Acq92OHLinKnnmfqhWn+ETS8YJKiuvI1ksYxt8dKymFYpN/HRwJWNsl6AEGvj6LYQgv
	1WkbrzqqSuapSmyEIw178arYJXynD3impWiaWfnBR0vZ6gcMEdRrQD8RVk2DdXEPM2CNQOOHJtL
	XJfPPcIRqTgX4Lh28Gkb1p9WZCEVX0yWOawqP8UgfgIYOU91DReD8FSquDSa1hK/mstDEYunGG2
	Pz2xRxcT3c+O9vgWlCtVeIbJQRQAqpmSEAh91SenZsM8EpP52jxVYy1SO35dWoGjV9bxiCPNUL2
	QaPMffDqY4jQi2RVuhaIX1DOcifntCrJ+7mlN/AiTtbk2FtpmpZwZwsk8WKCu6csQIWegsOPGo1
	5CCCJvjJRCbRlkWP7I4zhl5MRB78eTs7YebNZhN0TTygbc94s9IaakW9/5PuAud9djBEUfAvt6k
	7FJ0VxIFGxkallutY+t+jmwRQ/ig0hUsqrpdePLo75RhiN7RlXesaaekPs5xSFrhf8RRnG12XdA
	srp4HZO
X-Received: by 2002:a5d:5c84:0:b0:43f:e721:76bf with SMTP id ffacd0b85a97d-4515df66f27mr37344432f8f.41.1778526704678;
        Mon, 11 May 2026 12:11:44 -0700 (PDT)
Received: from ai-node.taila4f726.ts.net (89-139-15-25.bb.netvision.net.il. [89.139.15.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a5b65sm28541785f8f.8.2026.05.11.12.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:11:44 -0700 (PDT)
From: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
To: jic23@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Subject: [PATCH v3 0/2] iio: magnetometer: add MEMSIC MMC5983MA driver
Date: Mon, 11 May 2026 19:11:33 +0000
Message-ID: <20260511191135.36691-1-vlad.kulikov.c@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an IIO driver for the MEMSIC MMC5983MA 3-axis magnetometer over
I2C. The driver provides raw magnetic field readings with
per-measurement SET/RESET offset cancellation, giving 18-bit output
with a full-scale range of +/-8 Gauss.

MMC5983MA is not register-compatible with the existing MEMSIC
magnetometer drivers. It has a different register map, 18-bit output
data format, and I2C/SPI transport support.

Tested on a Raspberry Pi 2B with the sensor on I2C-1 at 0x30.

The initial driver implements the validated I2C single-measurement path.
Other chip features are left for future work:

- SPI transport: the binding describes SPI wiring, but driver support is
  left for follow-up validation of the SPI command and SET/RESET
  sequencing.
- Temperature channel: left until the temperature output behavior is
  better validated.
- Continuous measurement mode and Auto SET/RESET: left until the
  interaction between CMM, TM_M, Meas_M_Done, and SET/RESET sequencing
  is better understood.
- Saturation/self-test bits and BW/decimation tuning: not exposed until
  their behavior can be described reliably through stable IIO ABI.

The driver uses a conservative 500 us post-SET/RESET delay before
starting the following measurement. The datasheet describes a 500 ns
SET/RESET coil pulse, but testing showed that a longer software delay is
needed before taking the next measurement.

Changes since v2:
- Driver:
  - refactored SET/RESET coil pulse into mmc5983_pulse_coil() helper
  - used USEC_PER_MSEC for regmap_read_poll_timeout and fsleep constants
- DT binding:
  - removed redundant comments from examples
- Cover letter:
  - added "why a new driver" explanation
- Collected Reviewed-by and Acked-by tags

Changes since v1:
- DT binding:
  - added SPI bus support, interrupts, and vddio-supply
  - made vdd-supply required
  - switched to unevaluatedProperties with spi-peripheral-props ref
- Driver:
  - replaced scoped_guard() with guard(mutex) in a case block
  - added datasheet page references for timing values
  - changed product ID mismatch from probe failure to dev_info()
  - hardcoded the IIO device name
  - added trailing commas
  - added local struct device and regmap pointers in mmc5983_init()
- MAINTAINERS:
  - split binding and driver F: entries across the relevant patches

Vladislav Kulikov (2):
  dt-bindings: iio: magnetometer: add MEMSIC MMC5983MA
  iio: magnetometer: add driver for MEMSIC MMC5983MA

 .../iio/magnetometer/memsic,mmc5983.yaml      |  63 ++++
 MAINTAINERS                                   |   7 +
 drivers/iio/magnetometer/Kconfig              |  11 +
 drivers/iio/magnetometer/Makefile             |   1 +
 drivers/iio/magnetometer/mmc5983.c            | 345 ++++++++++++++++++
 5 files changed, 427 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
 create mode 100644 drivers/iio/magnetometer/mmc5983.c


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.43.0

