Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B1E35DA49
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262143; cv=none; b=llc1S3mUFhwfOii+RVggmrbeLIy10Eg6KpwYl5AizdM/hAXvEo84w82yqvwnDWattW6cyZL7LFjpXEF2NFhKiKb+cz8r/40lELZaZ0j8WcJ2l2qqmau79h4SnHs/YTeVqI4GvHr527tKPpspSaeGn3ETj9zXRPkfwg/yYeV/1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262143; c=relaxed/simple;
	bh=mLWIjo5Mf0fC0ZEIMKv/YgqjtFFyvLeeu5kpLLlq2so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RoIWz87lLypsMQZcMbx8EUalqZnmyY4+p3cuzjTiE/EzS1sHw0irVVYWYfbzzsbd2YW1hTh1TIX/DVKN4Bt2Lq5wf2bJCWYYPQUzxVJJjLqCY7+bo7NjiQm80YeB11B52VrjMHfwAqqRdGXfIP4sQRmdpC9KJaYxm5DCSk/jRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pHPY3U6K; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pHPY3U6K"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2baef9f5ecdso35952395ad.1
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 00:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779262141; x=1779866941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zj0vx40UntDsD2TYK6nD+GW3q6EMQAvEH6QbIchZOP0=;
        b=pHPY3U6KVdXA/bd/wnZOJdGdxIpK857/62PPrjOBDf7aYPitGEoc/+KuZi0bwgRt4F
         N1f/lbSzG5ofFM8RJjfjI+kQPxNBhruWqTSaKaNyHpByN5doQX7HzNntfQwbcJyuxMDH
         q9e905dPlohTmaXW7iyOw97Jx6mQALAn+9VFJefBy0o8QQnsf/2GFptU7ziXn8E3gDcH
         x/U7Ikf3yGQMgUm0A5tkFC69w8KnLkjWV2RsZtrSz0iu8CR+lmSZAchtYhuhBWq/gHOW
         xhOckvU1CDI08FzCyrDNjRddiMJ9vLaMXEvtPS5TLOL2i9pddvJAqsH4p0s8ZYf7TF+3
         Mpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262141; x=1779866941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zj0vx40UntDsD2TYK6nD+GW3q6EMQAvEH6QbIchZOP0=;
        b=iRMnzGwDVITvRkEX2//hEoY+v58MUCn33+ErKLqoA/1R4rYUwjiTvwgzJMQ+sU3ctL
         SebDx8zrNfGhq+/8qUkKE7Vo85/+UI57sKyHk1gVE0g5Jx0aU4tzbD1BLRbEV+0mgRto
         WCD/zM73mI1WqSXd9sa1Wjxdr+v96Csg1v7RHKOx+pEtie7BVgK+9KcZDVCilbxFsVe5
         g1p35A9h7RfI84d0MGQhjVYIN2qjxmmxv24c9zZgTtohPmdUNIxK/cX4aKH4CA4Xoy5e
         D+sc1usvs6VJh8BR2ZqA7828meXI+hu+mZNvoY5TRaIp9ewXodnTKFEV1lTPVAhUC6TS
         ZWnA==
X-Forwarded-Encrypted: i=1; AFNElJ93TRnhuZ6A2ATD6bGiBppk0WDGZ5r+B93pgGCbqHhGTXnMS+KS3WMQAwoLwgHdTSKKvpKzKqZkEkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweKDd+k6rbuPwIImmJ+WkrJuFejorlSNLO5opxJN7Cf8Bzza8u
	2Gq2oqqU/nLBNoQpniqlHn9bk2kVMMsUPNVj8Cv7WJKNS0fKw2b66Wr4
X-Gm-Gg: Acq92OFD7AWJLRyFFu+TKvUxd0O9r3riMSNiq5npT9kUqXmB5piD7Vy54bkAREF/01m
	2D4drjfOo3WXHTWPu3+8KFWlBD2TOrZoSVebnqNekZXRGDlWM8KrfTgn2I+B4ul9w86nvwBVs34
	W92BKys31wfN69sf4Cy4x+p5GqpNjt00AfRuKmsuslUsM37Gx7gqDfD0zYf9X1yEqXYbQ7p9qy3
	+Mp8xGjOZ8JM3GlRYWEe3PzoquOrtGy2lV424UzJISqbQPhwH/0n1ERQ18qgo73Wte6/VRLiGcA
	EchECcC58xbWeQ3ncSfrkQfonAM1NvsHf1INNEltyIklnHdeU3GFre+Y4FGaTTB8bceI7YYbxX5
	oy6fcVDWApdkPYJxW2mmJ1Xp0e9u8g/n0wAMpcY6XoHI22jxqPkfuXt6l+hQfgtDJGvNS939zbT
	BXaqiLDALIPBe5/VmKnPMHCHCIrqQeWBpfQeUJCiB3lcpZ7722qrn2+rLBNeWedNG12HLzlC92G
	w2yAWB2LwzojT7WF5in/Gg/jQ2iM5qE4r82HQ==
X-Received: by 2002:a17:902:7892:b0:2ba:6518:a6d4 with SMTP id d9443c01a7336-2bd7e87d577mr181963515ad.20.1779262141029;
        Wed, 20 May 2026 00:29:01 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f27csm206258595ad.25.2026.05.20.00.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:29:00 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/3] iio: add Open Sensor Fusion UART driver
Date: Wed, 20 May 2026 16:28:40 +0900
Message-ID: <20260520072843.3593-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Open Sensor Fusion is a UART-attached sensor aggregation device. The current
prototype sends OSF protocol v0 frames over a host UART link. This RFC adds the
first Linux IIO receive path for that UART stream.

The first transport is serdev UART. USB, real sensor reads, fusion output, and
production timestamp correlation are intentionally left out of this series.

The driver code is kept in one patch for the first RFC to avoid intermediate
non-buildable states. The internal files are still split by protocol, stream,
core, transport, and IIO code.

Current validation coverage:

- STM32F405 test firmware OSF protocol v0 UART stream at 115200 8N1.
- Raspberry Pi 4 serdev probe and receive path to osf_core_receive_frame().
- CAPABILITY_REPORT-driven IIO device registration.
- IIO read_raw for accel, gyro, magn, and temp samples.
- IIO software kfifo buffer userspace read.
- scan decode helper for buffered samples.
- dt_binding_check pass for the binding.
- checkpatch.pl --strict with ERROR 0, WARNING 0, CHECK 0.
- W=1 source compile/link phase clean in the staging kernel tree.
- modpost unresolved symbol warnings came from the staging tree missing
  Module.symvers.

Known limits:

- The sample source is synthetic stream data, not real ICM-42688-P or MMC5983MA
  sensor reads.
- The IIO timestamp is Linux host receive time. Device time correlation is still
  open.
- Runtime capability removal is not implemented.
- The staging layout uses drivers/iio/opensensorfusion/. The final directory is
  open for review.

Review feedback wanted on the IIO device layout, timestamp policy, binding
shape, and driver directory.

Jinseob Kim (3):
  dt-bindings: iio: imu: add Open Sensor Fusion UART binding
  iio: osf: add Open Sensor Fusion UART IIO driver
  MAINTAINERS: add Open Sensor Fusion IIO driver entry

 .../iio/imu/opensensorfusion,osf-uart.yaml    |  33 ++
 MAINTAINERS                                   |   7 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/opensensorfusion/Kconfig          |  15 +
 drivers/iio/opensensorfusion/Makefile         |   6 +
 drivers/iio/opensensorfusion/osf_core.c       | 334 +++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h       |  81 ++++
 drivers/iio/opensensorfusion/osf_iio.c        | 268 +++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h        |  21 ++
 drivers/iio/opensensorfusion/osf_protocol.c   | 234 ++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h   | 100 +++++
 drivers/iio/opensensorfusion/osf_serdev.c     | 354 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_serdev.h     |   8 +
 drivers/iio/opensensorfusion/osf_stream.c     | 212 +++++++++++
 drivers/iio/opensensorfusion/osf_stream.h     |  31 ++
 16 files changed, 1706 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml
 create mode 100644 drivers/iio/opensensorfusion/Kconfig
 create mode 100644 drivers/iio/opensensorfusion/Makefile
 create mode 100644 drivers/iio/opensensorfusion/osf_core.c
 create mode 100644 drivers/iio/opensensorfusion/osf_core.h
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.c
 create mode 100644 drivers/iio/opensensorfusion/osf_iio.h
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.c
 create mode 100644 drivers/iio/opensensorfusion/osf_protocol.h
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.c
 create mode 100644 drivers/iio/opensensorfusion/osf_serdev.h
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.c
 create mode 100644 drivers/iio/opensensorfusion/osf_stream.h

-- 
2.43.0

