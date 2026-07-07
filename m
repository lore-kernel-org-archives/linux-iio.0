Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2083E1DB356
	for <linux-iio@vger.kernel.org>; Tue,  7 Jul 2026 01:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783388762; cv=none; b=ZWvH1OdrrRGsqIKjW8zgYlvjE6YXbisGalpvmz052UElEb9UZyDk5EO8KkvZsU/k4O6yYOdF9ytRaPakElGJ15vewEWitXTfet66eLQ91VgRS/RmsBNVyJKGp4pWjdPaHqRvjJ/Z1/nQIAGgOwM7eLIBH/0sqMDrwH93QUbIh4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783388762; c=relaxed/simple;
	bh=1WbiRvGwyZgI3p7Cq5tzLhqkz+2SDn51l3e2tAXChBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h7Sl+ETA8EdhTPCpuJAXjYdWYcvGPot5j5/neLB2GCce/amg2sI1S03HEPLgmL7lAaENkrbNIPPOdB3Z3HJoYnOZyORyTfYIrZnw6HXol8/4A+e6g5/n1YX1gA1gWuwrd1tAVREvZBRhLB+mJkMumaeDN2H1yh91eA3BB81tr/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce3G3lj1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce3G3lj1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-847aebc56b6so2855117b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 18:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783388759; x=1783993559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZusTVEKPqv6I6o1eJ+PWE9GvkUB2pmeD6248aHzWvcg=;
        b=Ce3G3lj1pr8Er04OG04zSRrK4Y8jFkdRlnxSWBXA5mTO7NWNOpyA7fK2eRfNMkyr/x
         A77JDbvAnxoqqRZAxZZmh0BEwCuGcS5f6w1DYCFT6v2S0c/dZZQK2cUK0rsaqeJT68y1
         h7VW6607aPVZCXTn0mqIN0v4PFXiiFAwH/kFrv3T3SszSf1nQWyuGNjwk8tG/WEhXKVR
         meQXo25scv/h12F5MGzknHRxLUFE34wFW8zcXraPpTYdyafVB6VbY8FiiUwLJRBDTncB
         DfSwROnxgCwmAvFoM6I9qVthEJ3dIPv7drgqCeBFXtChzhvpB20e9orIpLVcicke0xFT
         JAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783388759; x=1783993559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZusTVEKPqv6I6o1eJ+PWE9GvkUB2pmeD6248aHzWvcg=;
        b=LbqZ5gHCc2ENk0JWGpzzuWgcL/BC9+5z8j+Z8CazL6xnR39DW6+ZW8fLpoIXx66InA
         vvBhLOpw8mViR/zesiKTQhxhEXdZCPmz0sR2LMVlj1maalKNAu2r8tfieByryugPW5sC
         saiJmXVa2SsX1vXkqn9VRlesc+jlmgPo5TuLyJSDIvQbDsj5+qv/xPzqn/mlC4xZhw9+
         p0M51e14x3kCZBzyy+XJ+7UH1Uv7On0qP/RfeFL7GfWSwpU4Lm22YwgrPCD076EmDD5h
         kCsnVbZWU0p03OE6WCFdJnmx6CgzDfdVkQ6+wh2RUXJL1Vpma5qQtILqO/9yxBiBMyLu
         6yYA==
X-Forwarded-Encrypted: i=1; AHgh+RpaxL49PQcXVJa6+wzfIAGiK2OhKZDkNPExcUyrWZMtsZ92f7ElL6q/nuHmOeKyB7DMv7FqMXySFVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuAcGRJvd7q9KPgoDd5AsVLTB0vlCj/bN+QWhihFpRRIMewSIO
	i/NlzOJYHRLM2VP8Lxermh7PMIbdgQrQji13q4RLX/SqZOhmS4hXc37x
X-Gm-Gg: AfdE7cljCTc63eRME4dS2QdTcahD8U+ggTQQ42JUGcwjIReSXvgXEqvVRrS95316dyl
	uEpKEwSlUlxDCBs2uWOkKAkhkSlNzWE95S89U+QCh5UjauYGAKN19AxCGWQ2BmN32ZxZjb0qaUq
	8Zn/gkzt2XkzR3jZklROm+/8Qoyq1f/Bq7lFP2fUJWBN/hRJQZJPL5I+tYznp8KS9Lf587sSElK
	kZF21941KGRE4twD0EhavrOiaLOu7UnzzqL8toFAc6mQ7k6E/f6VAaQziKhSSIFuckhDs0jqIut
	K3kz25wiNu8pgjs2mJtx4Itr1bIh8exWiJXXa6V18e4oSjiGIq5ewrvK1l1GJMTYgwt7ozQrepE
	/LUoN6Nhid0cXmFpOckAAz2z2BbtRMNnd9Bpd2F7WljnV+pL9mXjzbAb8mS/cX/05m2H5LrM9Om
	BuDVyD297hBiSV840g18IXkxwxGfbWljAI59Pw4qEiE7nSOTG5iMhW+bLp8N0/93C33AznA9bx2
	UWK3d0ZgU3TXI8WmZVmVsWY4nzz97Xcztx0uu4=
X-Received: by 2002:a05:6a00:348b:b0:846:7507:4e07 with SMTP id d2e1a72fcca58-84826df3cbcmr2955880b3a.39.1783388759380;
        Mon, 06 Jul 2026 18:45:59 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4e741sm4645653b3a.28.2026.07.06.18.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 18:45:58 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Jinseob Kim <kimjinseob88@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/5] iio: add Open Sensor Fusion IIO driver
Date: Tue,  7 Jul 2026 10:45:20 +0900
Message-ID: <20260707014525.1015-1-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a Linux IIO driver for Open Sensor Fusion devices
exposed over a UART/serdev host interface. The driver parses OSF frames
and creates IIO devices at runtime from capability reports. Expected IIO
devices are accel, gyro, magnetometer, and temperature when those
capabilities are reported.

The binding, supported protocol subset, runtime discovery model, and
driver-facing ABI remain review-relevant, but this revision drops the RFC
tag because there are no specific open questions being asked in the cover
letter.

v7 was prepared after auditing earlier review comments and either
addressing them in code/docs or answering them on-list.

Previous versions:

v1:
https://lore.kernel.org/r/20260520072843.3593-1-kimjinseob88@gmail.com

v2:
https://lore.kernel.org/r/20260524085312.15369-1-kimjinseob88@gmail.com

v3:
https://lore.kernel.org/r/20260529121005.1470-1-kimjinseob88@gmail.com

v4:
https://lore.kernel.org/r/20260607234343.22109-1-kimjinseob88@gmail.com

v5:
https://lore.kernel.org/r/20260616072242.3942-1-kimjinseob88@gmail.com

v6:
https://lore.kernel.org/r/20260628191337.937-1-kimjinseob88@gmail.com

Changes in v7:
- Dropped the RFC tag; no specific open questions remain in the cover
  letter.
- Added previous-version lore links.
- Removed the confusing compatible/OSF GREEN/OSF0 explanatory sentence
  from the binding.
- Removed "initial" wording from the IIO documentation.
- Reused the common OSF_FRAME_MAGIC definition in the stream parser.
- Fixed OSF_FRAME_MAGIC comment wording.
- Removed dead overflow checks for u16 protocol counts.
- Removed the unused partial_frames statistic.
- Fixed remaining loop-local variable issues.
- Reworked the stream/core contract so CRC-valid/authenticated frames are
  consumed as full frames even when ignored or rejected at application
  level.
- Preserved one-byte resync only for unauthenticated/framing failures.
- Preserved IIO buffer synchronization and zeroed scan storage.
- Removed the duplicate IIO dependency from the OSF Kconfig entry.

Validation:
- git diff --check: pass.
- checkpatch --strict: pass, 0 errors, 0 warnings, 0 checks.
- dt_binding_check: pass with dtschema 2026.4.
- GCC W=1 module build: pass, no OSF compiler warnings.
- clang W=1 module build with LLVM=1 external build: pass, no OSF
  compiler warnings.
- local stream parser semantic tests: pass, including CRC-valid bad
  protocol_major and nonzero reserved frames with embedded OSF frames.
- static IIO scan layout/padding checks: pass.

Jinseob Kim (5):
  dt-bindings: iio: add Open Sensor Fusion device
  Documentation: iio: add Open Sensor Fusion driver overview
  iio: osf: add protocol decoding
  iio: osf: add authenticated stream parser
  iio: osf: add UART IIO driver

 .../bindings/iio/opensensorfusion,osf.yaml    |  52 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 Documentation/iio/index.rst                   |   1 +
 Documentation/iio/open-sensor-fusion.rst      |  72 ++++
 MAINTAINERS                                   |  14 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/opensensorfusion/Kconfig          |  15 +
 drivers/iio/opensensorfusion/Makefile         |   6 +
 drivers/iio/opensensorfusion/osf_core.c       | 320 ++++++++++++++++++
 drivers/iio/opensensorfusion/osf_core.h       |  70 ++++
 drivers/iio/opensensorfusion/osf_iio.c        | 308 +++++++++++++++++
 drivers/iio/opensensorfusion/osf_iio.h        |  22 ++
 drivers/iio/opensensorfusion/osf_protocol.c   | 242 +++++++++++++
 drivers/iio/opensensorfusion/osf_protocol.h   | 100 ++++++
 drivers/iio/opensensorfusion/osf_serdev.c     | 114 +++++++
 drivers/iio/opensensorfusion/osf_stream.c     | 189 +++++++++++
 drivers/iio/opensensorfusion/osf_stream.h     |  30 ++
 18 files changed, 1559 insertions(+)


base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
-- 
2.43.0

