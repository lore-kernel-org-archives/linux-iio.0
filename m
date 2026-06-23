Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FD36A36A
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782223281; cv=none; b=SrusBcsPfoIJbqoloAGQcChPH9P6kBR3XvtfwbPVJDLB8AyHeNj7LPHSwnd4fXAlUXdk3ruCR9uFQ4dKvALqjp26qLTrimLwfPcwnvu2awI6+KUM5hqjcbe36wftPjxrVborCwytnYqpi9Bt9eS18vckycvjDG961iIG9Mxo2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782223281; c=relaxed/simple;
	bh=fMVBqccmwp/luWcEuPsDmZ2zWK4sKAf+ovBgWOeG4TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GssZqlbypBF9J++tVXYsK0IikTMbMUGtw8QBAImw3uLiq5rWtSYr1PJei27jpVOZwtkGwyacay0LJhlJVLeaIlmGfQOuWnG7ude2S56h30aP48FIbgqbfNFECg+8BlTU5D0tUHx537UbB3RaV8Cg5+TFoXOd5djY4+aklCxOJak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDgH9vCd; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDgH9vCd"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39977ab0562so52683931fa.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 07:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782223278; x=1782828078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAoG+I0VeboZcfZOa9yLZ2YB71By/3o7AaSCl8pHZgU=;
        b=gDgH9vCd1kntXUDa0Aq1Zub+XqRkbjlglCZ6rbnDWJbT+nM2VxwZ5lGHgbmef1jc4Y
         QsSuIagTSF6t4kYBIfqWbZvYJG1hyCKSfh/fPhskaDsMI2MOEwho8SlUWmS8rvl3Gy82
         r5elEAnZi0/3rUxSHK5LVTJhKxWCqFvx9an+eLSYB1NzuEejwsFbWvLfXx2AHlcjBesj
         sw6fuSddrGWCbUuX2neHqKkUDzM+vGHoOaiIc0zhceWrb81j+0Y0K6NOBjpykyMnpc6g
         MrOeWylEaGU5l0Pmmsb5FiKeQGObp9NWLhS9q7f0PmRMby5xjYkvRThpIe1mn3GavpC4
         Q9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782223278; x=1782828078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAoG+I0VeboZcfZOa9yLZ2YB71By/3o7AaSCl8pHZgU=;
        b=NBdRd3LyhHXdxNg7QnjdpppnNQCPqfbGeihktaJqMKjxPEyU3WF2V3QJPK/gxNv2Zv
         Rv8ux3QJ8VME1fXnmRgGFPJTLCnu7q1ObZp37GywoDa0bdfRzv/2tZ3STb/QXvW0WC08
         v9pGcQaOcvovfB3/UcgPgNsWOYvVe7WeCuXDPuuHM/yI5htxB/iCHaBNShwgbf9Btuys
         7sP/08zsQVwpcZ87zApIw7kS26InhNNNyDfT4DKcNpUTfYHh6TNl/B1HnVL0psU4Dtbw
         tZOi6ig6uVBtwL7KvHeucClu8yEr7P9k6OZ/VgCpuwTceGaNr2vDAVeO65rvq1GZdpH4
         iqwQ==
X-Gm-Message-State: AOJu0YxgQ9PzNOT/pIL8z4soHhQWVBFy3Qrj3M3pNyjXNzY1mIRNP9BL
	pbbRWrOQlJsbaVd6J1GzN8z9KGfcSU5qkx8R12/KgkmxhEUUgXbVEOZtN0HQvk0s7x06MA==
X-Gm-Gg: AfdE7cmNRg7ibGtSj8NN/6W90R9NYiaJ/OZIIYsyPephpC9Dlu1uaFQooxtlsY/+ztB
	RbB0ki94s3ZLF8xViqdK74/3Wb6l1TtPcGXy6YWaqV1hQRWTZwfJf4rhHyINz4RFHrX1643ibeY
	olay5WYdnaoDr3b7ckF2vS2NeYiRynzUPpM1A3MunZiQujvizRJcymALmB+ixq9FndU18dk3yQ8
	SGowh6UhqIO2+DGc4ry3V/lWE3vLZompJneK5+hb0i5gG9XQcIIF1iqd1NU5GQGlGe706n3XVMo
	TGQ/xjyL0Uio3pM3e/zNFHoN2VEzgF8Nk27mSoo6siuR9P+l/vt2fsBkED+cJDBGiS9pFmiKpCz
	zGFRVBj5mMRKAGZ2hFMLCtF9COF0vEWGJ7PSXVGwwd5IFlKOqhWOMNOVFlzFc0eo44ubAHWgn1o
	cEXpOq2ivgzCiBVPPMI+woV2B1jNcx3uqJFm3GAMdRgAdXL5NhtddEbwdo
X-Received: by 2002:ac2:51c9:0:b0:5ad:4da9:7330 with SMTP id 2adb3069b0e04-5ad576da87cmr6211327e87.11.1782223277734;
        Tue, 23 Jun 2026 07:01:17 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6958216fsm832663e87.70.2026.06.23.07.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 07:01:16 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH 0/1] iio: health: add MAX86150 ECG and PPG biosensor driver
Date: Tue, 23 Jun 2026 17:01:12 +0300
Message-ID: <20260623140113.12574-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MAX86150 (Maxim/Analog Devices) combines two PPG optical channels
(Red/IR LED) and one ECG biopotential channel in a single I2C device.
Data is produced at up to 3200 Hz and buffered in a 32-entry hardware
FIFO with a configurable almost-full interrupt.

This patch adds an IIO driver that exposes three channels:

  in_intensity_red_raw   -- PPG Red LED, 19-bit unsigned
  in_intensity_ir_raw    -- PPG IR LED, 19-bit unsigned
  in_voltage0_raw        -- ECG biopotential, 18-bit signed

Key implementation choices:

  - regmap_noinc_read() for FIFO access: reads 9 bytes (3 slots x 3
    bytes) from the streaming FIFO_DATA register in a single I2C
    burst without address auto-increment.

  - IIO hardware trigger backed by the device interrupt (active-low,
    FIFO almost-full). When an interrupt GPIO is provided in the device
    tree, a trigger is registered and wired to the IIO triggered buffer
    path for continuous low-overhead capture.

  - All resource management uses devm_* APIs.

Known limitations to be addressed in v2:
  - IIO_CHAN_INFO_SCALE not yet implemented.
  - Runtime PM (SYS_CTRL SHDN bit) not yet implemented.
  - Not yet tested on physical hardware.

Md Shofiqul Islam (1):
  iio: health: add MAX86150 ECG and PPG biosensor driver

 .../bindings/iio/health/maxim,max86150.yaml   |  67 +++
 drivers/iio/health/Kconfig                    |  23 +
 drivers/iio/health/Makefile                   |   1 +
 drivers/iio/health/max86150.c                 | 512 ++++++++++++++++++
 4 files changed, 603 insertions(+)
 create mode 100755 Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
 create mode 100755 drivers/iio/health/max86150.c

-- 
2.51.1

